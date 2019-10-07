#define THIS_MODULE vehicle
#include "x_macros.sqf"
private ["_vehicle", "_helper"];

PARAMS_1(_vehicle);

if (alive _vehicle) exitWith {};
if (_vehicle isKindOf "LandVehicle") exitWith {};

while {((position _vehicle) select 2) > 1.5} do {
    sleep 1;
};

_position = [(position _vehicle) select 0, (position _vehicle) select 1, 0];

_helper = createVehicle ["RoadCone", _position, [], 0, "CAN_COLLIDE"];
_helper setDir (getDir _vehicle);
_helper setPos _position;

[true, "hideObject", [_helper, true]] call FUNC(network,mp);

_vehicle attachTo [_helper, [0, 0, [_vehicle] call FUNC(THIS_MODULE,offset)]];

sleep 1;

_helper setPos [(position _vehicle) select 0, (position _vehicle) select 1, 0];
_helper setVectorUp surfaceNormal position _vehicle;

[true, "enableSimulation", [_helper, false]] call FUNC(network,mp);