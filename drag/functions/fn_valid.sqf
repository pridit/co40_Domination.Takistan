#include "x_macros.sqf"
private ["_unit"];

PARAMS_1(_unit);

if !(_unit distance player < 4) exitWith {false};
if (_unit getVariable QGVAR(dragging)) exitWith {false};
if !([_unit, vehicle _unit] call BIS_fnc_areEqual) exitWith {false};
if (!isNil QMODULE(revive) && {_unit getVariable QGVAR(reviving)}) exitWith {false};
if (!isNil QMODULE(revive) && {!(_unit getVariable QGVAR(unconscious))}) exitWith {false};

true