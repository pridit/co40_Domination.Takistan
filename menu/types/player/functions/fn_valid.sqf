#include "x_macros.sqf"
private ["_unit"];

PARAMS_1(_unit);

if !(alive _unit) exitWith {false};
if !(isPlayer _unit) exitWith {false};
if (player distance _unit > 4) exitWith {false};
if !([] call FUNC(common,ready)) exitWith {false};
if ([player, _unit] call BIS_fnc_areEqual) exitWith {false};

true