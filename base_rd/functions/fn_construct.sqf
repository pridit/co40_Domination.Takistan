#define THIS_MODULE base_rd
#include "x_macros.sqf"
private ["_type", "_vehicle", "_time"];

PARAMS_1(_type);

if (hasInterface) then {
    private ["_name", "_checks"];

    _name = "R&D point";
    _checks = [
        [
            [_name, "used to construct"],
            player getVariable QGVAR(base_rd_cooldown)
        ] call FUNC(helper,timeExceeded),

        [
            _name,
            GVAR(base_rd) getVariable QGVAR(processing),
            true
        ] call FUNC(helper,inProgress),

        [
            _name,
            position GVAR(base_rd)
        ] call FUNC(helper,nearAny)
    ];

    {
        if (typeName _x == "STRING") exitWith {
            hint _x;
        };
    } forEach _checks;

    if ({str (_x) == "true"} count _checks < count _checks) exitWith {};

    player setVariable [
        QGVAR(base_rd_cooldown),
        time + (([_type, "time"] call FUNC(THIS_MODULE,item)) select 0) + GVAR(base_rd_time_cooldown)
    ];

    GVAR(base_rd) setVariable [QGVAR(build), true, true];

    if !(isServer) then {
        [gameLogic, "execVM", [_this, __function(construct)]] call FUNC(network,mp);
    };
};

if (isServer && {!(GVAR(base_rd) getVariable QGVAR(processing))} && {GVAR(base_rd) getVariable QGVAR(build)}) then {
    private ["_vehicle", "_time"];

    GVAR(base_rd) setVariable [QGVAR(processing), true, true];
    GVAR(base_rd) setVariable [QGVAR(build), false, true];

    _vehicle = _type createVehicle (position GVAR(base_rd));
    _vehicle setDir (getDir GVAR(base_rd));
    _vehicle setPos (position GVAR(base_rd));
    _vehicle setVelocity [0, 0, 0];
    _vehicle setVectorUp surfaceNormal (position GVAR(base_rd));

    _vehicle lock true;
    _vehicle allowDamage false;

    sleep 2;

    [true, "enableSimulation", [_vehicle, false]] call FUNC(network,mp);

    __log format ["Constructing %1", [typeOf _vehicle] call FUNC(vehicle,name)]];

    _time = ([_type, "time"] call FUNC(THIS_MODULE,item)) select 0;

    if !(isNil QMODULE(conversation)) then {
        [
            [GVAR(crossroad), GVAR(crossroad2)],
            [QUOTE(THIS_MODULE), "Construct"],
            [
                ["1", {}, [typeOf _vehicle] call FUNC(vehicle,name), []],
                ["2", {}, str floor(_time / 60), []]
            ]
        ] call FUNC(conversation,radio);
    };

    if (!isNil QMODULE(3d)) then {
        [true, "spawn", [[_time], {
            private ["_time"];
            
            PARAMS_1(_time);
            
            [GVAR(base_rd), _time] call FUNC(3d,time);
        }]] call FUNC(network,mp);
    };

    _vehicle setVariable [QGVAR(built), true, true];

    if !(isNil QMODULE(menu) && {isNil QMODULE(menu_vehicle)}) then {
        _vehicle setVariable [QGVAR(menu), false, true];
    };

    if (!isNil QMODULE(vehicle_respawn)) then {
        _vehicle setVariable [QGVAR(respawnable), false, true];
    };

    if (!isNil QMODULE(vehicle_wreck)) then {
        _vehicle setVariable [QGVAR(wreckable), false, true];
    };

    [true, "execVM", [[_vehicle], FUNCTION(vehicle,handle)]] call FUNC(network,mp);

    __addDead(_vehicle);

    ["Construct", _vehicle, _time, call FUNC(THIS_MODULE,max)] call FUNC(vehicle,stall);

    _vehicle lock false;
    _vehicle allowDamage true;

    if (!isNil QMODULE(menu_vehicle)) then {
        _vehicle setVariable [QGVAR(menu), true, true];
    };

    [true, "enableSimulation", [_vehicle, true]] call FUNC(network,mp);

    if !(isNil QMODULE(conversation)) then {
        [
            [GVAR(crossroad), GVAR(crossroad2)],
            [QUOTE(THIS_MODULE), "Ready"],
            [
                ["1", {}, [typeOf _vehicle] call FUNC(vehicle,name), []]
            ]
        ] call FUNC(conversation,radio);
    };

    GVAR(base_rd) setVariable [QGVAR(processing), false, true];
};