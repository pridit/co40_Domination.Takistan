#include "x_macros.sqf"

if !(isNil QMODULE(vehicle_ammobox)) then {
    case "ammobox": {
        private ["_ammobox"];

        _ammobox = _entity getVariable QGVAR(ammobox);

        closeDialog 0;

        if (!isNil "_ammobox" && {_ammobox}) exitWith {
            [_entity] call FUNC(vehicle_ammobox,unload);

            false
        };

        !([_entity] call FUNC(vehicle_ammobox,load));
    };
};

if !(isNil QMODULE(vehicle_bomber)) then {
    case "bomber": {
        closeDialog 0;

        [_entity] spawn FUNC(vehicle_bomber,intel);

        false
    };
};

if !(isNil QMODULE(vehicle_create)) then {
    case "create": {
        if !([_entity, _lbData select 1] call FUNC(vehicle_create,spawn)) exitWith {
            true
        };

        closeDialog 0;

        false
    };
};

if !(isNil QMODULE(vehicle_deploy)) then {
    case "deploy": {
        private ["_deployed"];

        _deployed = (_entity getVariable QGVAR(deployed)) select 0;
        
        if (!isNil "_deployed" && {_deployed}) exitWith {
            [_entity, _lbData select 1, false] call FUNC(vehicle_deploy,deploy);
        };
        
        [_entity, _lbData select 1, true] call FUNC(vehicle_deploy,deploy);
        
        true
    };
};

if !(isNil QMODULE(inventory) && {isNil QMODULE(inventory_medical)}) then {
    case "inventory_medical": {
        ["medical"] call FUNC(inventory,replenish);

        true
    };
};

if !(isNil QMODULE(inventory) && {isNil QMODULE(inventory_refuel)}) then {
    case "inventory_refuel": {
        ["refuel"] call FUNC(inventory,replenish);

        true
    };
};

if !(isNil QMODULE(inventory) && {isNil QMODULE(inventory_repair)}) then {
    case "inventory_repair": {
        ["repair"] call FUNC(inventory,replenish);

        true
    };
};

if !(isNil QMODULE(vehicle_loadout)) then {
    case "loadout": {
        if (count ([_entity] call FUNC(vehicle_loadout,find) select 0) > 1) then {
            [_entity] call FUNC(vehicle_loadout,set);
        };

        true
    };
};

if !(isNil QMODULE(vehicle_pack)) then {
    case "pack": {
        private ["_packed"];

        if !(isEngineOn _entity) then {
            _packed = _entity getVariable QGVAR(packed);
            
            if (!isNil "_packed" && {_packed}) exitWith {
                [_entity, 0] call FUNC(vehicle_pack,fold);

                true
            };
            
            [_entity, 1] call FUNC(vehicle_pack,fold);

            true
        };
    };
};

if !(isNil QMODULE(vehicle_ramp)) then {
    case "ramp": {
        [_entity] call FUNC(vehicle_ramp,toggle);

        true
    };
};

if !(isNil QMODULE(vehicle_refuel)) then {
    case "refuel": {
        closeDialog 0;
        
        [_entity] spawn FUNC(vehicle_refuel,refuel);

        false
    };
};

if !(isNil QMODULE(vehicle_repair)) then {
    case "repair": {
        closeDialog 0;
        
        [_entity] spawn FUNC(vehicle_repair,repair);

        false
    };
};

if !(isNil QMODULE(setting)) then {
    case "respawn": {
        player setVariable [QGVAR(respawn_type), _lbData select 1];

        true
    };
};

if !(isNil QMODULE(vehicle_teleport)) then {
    case "teleport": {
        closeDialog 0;

        [_entity] call FUNC(teleport,show);

        false
    };
};

if !(isNil QMODULE(vehicle_texture)) then {
    case "texture": {
        [_entity] call FUNC(vehicle_texture,set);

        true
    };
};

if !(isNil QMODULE(vehicle_unflip)) then {
    case "unflip": {
        [_entity] call FUNC(vehicle_unflip,unflip);

        true
    };
};