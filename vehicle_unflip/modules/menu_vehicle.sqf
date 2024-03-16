/**
 * Vehicle Unflip Module - Vehicle Menu Submodule
 */

#define THIS_MODULE vehicle_unflip
#include "x_macros.sqf"
private ["_vehicle"];

PARAMS_1(_vehicle);

if !([_vehicle] call FUNC(THIS_MODULE,valid)) exitWith {false};

[
    format ["%1Unflip", if !(isNil QMODULE(perk)) then {"Perk: "} else {""}],
    "unflip"
] call FUNC(menu,populate);

true