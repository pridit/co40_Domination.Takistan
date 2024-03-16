/**
 * Vehicle Teleport Module - Vehicle Menu Submodule
 */

#include "x_macros.sqf"
private ["_vehicle"];

PARAMS_1(_vehicle);

if (!isNil QMODULE(perk) && {!(player getVariable QGVAR(teleport))}) exitWith {false};

[
    format ["%1Fast Travel", if !(isNil QMODULE(perk)) then {"Perk: "} else {""}],
    "teleport"
] call FUNC(menu,populate);

true