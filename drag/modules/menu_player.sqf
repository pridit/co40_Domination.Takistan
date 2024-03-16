/**
 * Drag Module - Menu Player Submodule
 */

#define THIS_MODULE drag
#include "x_macros.sqf"
private ["_unit"];

PARAMS_1(_unit);

if !([_unit] call FUNC(THIS_MODULE,valid)) exitWith {false};

["Aid: Drag", "drag"] call FUNC(menu,populate);

true