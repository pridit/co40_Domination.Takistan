/**
 * Core Module - Client (Handler)
 */

#define THIS_MODULE client
#include "x_macros.sqf"

0 spawn {
    sleep 0.01;
    
    player disableConversation true;
    
    player addWeapon "Binocular";
    player addWeapon "NVGoggles";
    
    if (sunOrMoon == 0) then {
        player action ["NVGoggles", player];
    };
    
    enableRadio true;
    enableSentences true;
    enableEngineArtillery true;
    
    [100] call FUNC(THIS_MODULE,reveal);
    
    {
        {
            if !(_x isKindOf "Wreck") then {
                _x addEventHandler ["HandleDamage", {0}];
                _x enableSimulation false;
            };
        } forEach _x;
    } forEach [
        (allMissionObjects "Thing")
    ];
};

onEachFrame {call d_fnc_client_perFrame};

if (!isNil QMODULE(vehicle)) then {
    0 spawn {
        if (!isNil QMODULE(base_bonus)) then {
            waitUntil {X_JIPH getVariable QGVAR(vehicle_bonus) == GVAR(base_bonus_amount)};
        };
        
        ["init_vehicles", {
            {
                [_x] spawn FUNC(vehicle,handle);
            } forEach vehicles;

            ["init_vehicles"] call FUNC(THIS_MODULE,removePerFrame)
        }, 0] call FUNC(THIS_MODULE,addPerFrame);
    };
};

if (isMultiplayer) then {
    ["init_actions", {
        {
            if (_x != player) then {
                if (!isNil QMODULE(inventory)) then {
                    if (!isNil QMODULE(medical)) then {
                        _x addAction GVAR(medical_player_action);
                    };
                    
                    if (!isNil QMODULE(vehicle_repair)) then {
                        _x addAction GVAR(vehicle_repair_player_action);
                    };
                };
                
                if (!isNil QMODULE(drag)) then {
                    _x addAction GVAR(drag_player_action);
                };
                
                if (!isNil QMODULE(revive)) then {
                    _x addAction GVAR(revive_player_action);
                    
                    _x addAction [
                        "Debug" call FUNC(common,GreyText),
                        FUNCTION(revive,debug),
                        [],
                        10,
                        false,
                        true,
                        "",
                        "_this != _target && {serverCommandAvailable '#logout'}"
                    ];
                };
            };
        } forEach playableUnits;

        ["init_actions"] call FUNC(THIS_MODULE,removePerFrame)
    }, 0] call FUNC(THIS_MODULE,addPerFrame);
};

if (!isNil QMODULE(ammobox)) then {
    ["init_ammobox", {
        {
            [_x] spawn FUNC(ammobox,handle);
            
            // Server will have a disparity between clients which results in not
            // being able to take anything despite there being sufficient 
            // quantity. Since the global variants for these functions can't be 
            // used due to desync and keeping these in line between client &
            // server by tracking amounts isn't very feasible let's just ensure
            // that the server has more (or as much) as the amount the client
            // will when they join. Existing players are kinda out of luck if
            // there becomes insufficient quantity.
            [gameLogic, "execVM", [[_x], FUNCTION(ammobox,replenish)]] call FUNC(network,mp);
        } forEach (allMissionObjects GVAR(ammobox_type));

        ["init_ammobox"] call FUNC(THIS_MODULE,removePerFrame)
    }, 0] call FUNC(THIS_MODULE,addPerFrame);
};

["player", {
    private ["_rating"];
    
    _rating = rating player;

    if (_rating < 0) then {
        player addRating (abs (_rating));
    };
    
    if (!isNil QMODULE(perk)) then {
        [false] call FUNC(perk,calculate);
    };
}, 5] call FUNC(THIS_MODULE,addPerFrame);

player addEventHandler ["HandleDamage", {
    private ["_unit", "_part", "_damage", "_injurer", "_projectile"];

    PARAMS_5(_unit, _part, _damage, _injurer, _projectile);
    
    if (!alive _unit) exitWith {0};
    if (_unit getVariable QGVAR(unconscious)) exitWith {0};
    if (_part == "" && {(vehicle _unit) != _unit} && {alive (vehicle _unit)}) exitWith {0};
    if ((vehicle _unit) != (vehicle _injurer) && {!local _injurer} && {side (group _injurer) == side (group _unit)}) exitWith {0};
    
    if (!isNil QMODULE(revive)) then {
        _limbs = 1;
        _incurred = 0;
        _new_damage = 0;
        _damage = _damage * 0.85;
        
        _config = configFile >> "cfgVehicles" >> (typeOf _unit);
        
        switch (_part) do {
            case "head_hit": {
                _armor = getNumber (_config >> "hitpoints" >> "HitHead" >> "armor");
                _incurred = (_damage * (0.6 + (1 - _armor))) min 0.89;
                _new_damage = ((_unit getVariable QGVAR(head_hit)) + _incurred) min 0.89;
                
                _unit setVariable [QGVAR(head_hit), _new_damage];
            };
            
            case "body": {
                _armor = getNumber (_config >> "hitpoints" >> "HitBody" >> "armor");
                _pass_through = getNumber (_config >> "hitpoints" >> "HitBody" >> "passThrough");
                
                _incurred = if (_pass_through < 1 && _armor == 1) then {
                    (_damage * 0.5) min 0.89
                } else {
                    (_damage * (0.6 + (1 - _armor))) min 0.89
                };
                
                _new_damage = ((_unit getVariable QGVAR(body)) + _incurred) min 0.89;

                _unit setVariable [QGVAR(body), _new_damage];
            };
            
            case "hands": {
                _limbs = 2;
                _incurred = _damage min 15;
                _new_damage = ((_unit getVariable QGVAR(hands)) + _incurred) min 15;
                
                _unit setVariable [QGVAR(hands), _new_damage];
            };
            
            case "legs": {
                _limbs = 2;
                _incurred = _damage min 15;
                _new_damage = ((_unit getVariable QGVAR(legs)) + _incurred) min 15;

                _unit setVariable [QGVAR(legs), _new_damage];
            };
            
            case "": {
                _incurred = _damage min 0.89;
                _new_damage = ((_unit getVariable QGVAR(overall)) + _incurred) min 0.89;

                _unit setVariable [QGVAR(overall), _new_damage];
            };
        };
        
        39671 cutRsc [GVAR(revive_type_blood) call BIS_fnc_selectRandom, "PLAIN"];
        
        _damage = _new_damage;
        
        if (_limbs != 0 && {!(_unit getVariable QGVAR(unconscious))}) then {
            if ((_limbs == 1 && {_damage >= 0.89}) || {(_limbs == 2 && {_damage >= 15})}) then {
                [_unit] call FUNC(revive,unconscious);
            };
        };
    };
    
    _damage
}];

player addEventHandler ["respawn", {
    private ["_unit", "_corpse", "_respawn", "_handlers"];
    
    PARAMS_2(_unit, _corpse);
    
    titleText ["", "BLACK FADED"];
    
    _unit spawn {
        _this allowDamage false;
        
        sleep GVAR(client_time_invulnerable);
        
        _this allowDamage true;
    };
    
    if (!isNil QMODULE(respawn)) then {
        [_unit, position _corpse] call FUNC(respawn,spawn);
    };
    
    _unit switchCamera "EXTERNAL";
    
    _handlers = [
        "backpack",
        "drag",
        "medical",
        "perk",
        "option",
        "revive",
        "vehicle_repair"
    ];

    {
        if (!isNil (format [QMODULE(%1), _x])) then {
            __handler(_x);
        };
    } forEach _handlers;
    
    if (!isNil QMODULE(revive)) then {
        [_unit] call FUNC(revive,reset);
    };
    
    if (!isNil QMODULE(perk)) then {
        [true] call FUNC(perk,calculate);
    };
    
    if (!isNil QMODULE(backpack) && {_unit getVariable QGVAR(backpack)} && {count GVAR(backpack) > 0}) then {
        call FUNC(backpack,action);
    };
    
    removeAllWeapons _unit;
    removeBackpack _unit;
    
    [_unit, _corpse] spawn {
        private ["_unit", "_corpse", "_backpack"];
        
        PARAMS_2(_unit, _corpse);
        
        _backpack = unitBackpack _corpse;
        
        if (!isNull _backpack) then {
            _unit action ["AddBag", _corpse, typeOf _backpack];
            
            sleep 2;
            
            _unit switchMove "";
        };
        
        titleText ["", "BLACK IN", 2];
    };
    
    if (!isNil QMODULE(loadout) && {_unit getVariable QGVAR(loadout)} && {count GVAR(loadout) > 0}) exitWith {
        call FUNC(loadout,restore);
    };
    
    {
        _unit addMagazine _x;
    } forEach magazines _corpse;
    
    {
        _unit addWeapon _x;
    } forEach weapons _corpse;
    
    _unit selectWeapon (primaryWeapon _unit);
}];

player addEventHandler ["killed", {
    private ["_unit"];
    
    PARAMS_1(_unit);
    
    _unit spawn {
        waitUntil {_this != player};
        
        hideBody _this;
    };
}];

deleteVehicle GVAR(client_init_trig);

GVAR(client_init_trig) = nil;