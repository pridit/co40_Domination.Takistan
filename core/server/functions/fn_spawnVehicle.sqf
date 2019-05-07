#include "x_macros.sqf"
private ["_position", "_type", "_distance", "_spawn", "_direction", "_group", "_vehicle"];

PARAMS_3(_position, _type, _distance);

_spawn = [_position, _distance, random 360] call BIS_fnc_relPos;
_spawn = [_spawn select 0, _spawn select 1, 400];

_direction = [_spawn, _position] call BIS_fnc_dirTo;

_group = createGroup west;
_vehicle = [_spawn, _direction, _type, _group] call BIS_fnc_spawnVehicle;

[_vehicle select 0] spawn {
    private ["_vehicle"];
    
    PARAMS_1(_vehicle);
    
    sleep 3;
    
    if (!isNil QMODULE(vehicle_respawn)) then {
        _vehicle setVariable [QGVAR(respawnable), false, true];
    };
    
    [nil, nil, rExecVM, __handlerRE(vehicle), _vehicle] call RE;
};

_vehicle