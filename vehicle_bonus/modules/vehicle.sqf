/**
 * Vehicle Bonus Module - Vehicle Submodule
 */

#define THIS_MODULE vehicle_bonus
#include "x_macros.sqf"
private ["_vehicle"];

PARAMS_1(_vehicle);

if (GVAR(vehicle_bonus_types) find (typeOf _vehicle) == -1) exitWith {};

if (hasInterface) then {
    if (!isNil QMODULE(perk)) then {
        [_vehicle] __submoduleVM(perk);
    };
};