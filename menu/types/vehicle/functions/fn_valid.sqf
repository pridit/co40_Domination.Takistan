#include "x_macros.sqf"
private ["_vehicle"];

PARAMS_1(_vehicle);

if !(alive _vehicle) exitWith {false};
if (player in _vehicle) exitWith {false};
if !([] call FUNC(common,ready)) exitWith {false};
if !(simulationEnabled _vehicle) exitWith {false};
if (player distance _vehicle > 10) exitWith {false};
if (_vehicle isKindOf "StaticWeapon") exitWith {false};
if !(_vehicle getVariable QGVAR(menu)) exitWith {false};
if ({alive _x && {[side _x, east] call BIS_fnc_areEqual}} count crew _vehicle > 0) exitWith {false};

true