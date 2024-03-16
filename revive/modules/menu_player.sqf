/**
 * Revive Module - Menu Submodule
 */

#define THIS_MODULE revive
#include "x_macros.sqf"
private ["_unit"];

PARAMS_1(_unit);

if !([_unit] call FUNC(THIS_MODULE,valid)) exitWith {false};

["Aid: Revive", "revive"] call FUNC(menu,populate);

true