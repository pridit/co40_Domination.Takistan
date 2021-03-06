#define THIS_MODULE vehicle_create
#include "x_macros.sqf"
private ["_vehicle", "_type", "_offset", "_occupied", "_deployer", "_position", "_atv"];

PARAMS_2(_vehicle, _type);

_offset = [_type] call FUNC(vehicle,offsetCreate);
_occupied = (_vehicle modelToWorld _offset) nearEntities [["Air", "LandVehicle"], 7];

if (count _occupied > 0) then {
    _deployer = _occupied find _vehicle;
    
    if (_deployer != -1) then {
        _occupied = [_occupied, _deployer] call FUNC(common,deleteAt);
    };
};

if (count _occupied > 0) exitWith {
    hint "Deploy point is already occupied by a vehicle";

    closeDialog 0;
    
    [_vehicle] call FUNC(vehicle_menu,show);
};

_position = _vehicle modelToWorld _offset;

_atv = createVehicle [_type, [_position select 0, _position select 1, 0], [], 0, "NONE"];
_atv setDir ((direction _vehicle) - 180);
_atv setVectorUp (vectorUp _vehicle);
_atv setPos [_position select 0, _position select 1, 0];

if (!isNil QMODULE(vehicle_respawn)) then {
    _atv setVariable [QGVAR(respawnable), false, true];
};

player reveal _atv;

[true, "say", [_atv, QGVAR(sound_build), 20]] call FUNC(network,mp);
[true, "execVM", [[_atv], FUNCTION(vehicle,handle)]] call FUNC(network,mp);

_atv spawn {
    sleep 10;
    
    while {true} do {
        _far = {_x distance _this < GVAR(vehicle_distance)} count (call FUNC(common,players)) < 1;
        
        if (_far && {_this call FUNC(common,empty)}) exitWith {
            deleteVehicle _this;
        };
        
        sleep 5;
    };
};

closeDialog 0;