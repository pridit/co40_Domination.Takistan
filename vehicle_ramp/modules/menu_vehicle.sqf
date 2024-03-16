/**
 * Vehicle Ramp Module - Vehicle Menu Submodule
 */

#include "x_macros.sqf"
private ["_vehicle"];

PARAMS_1(_vehicle);

if !(typeOf _vehicle in GVAR(vehicle_ramp_types)) exitWith {false};

["Ramp: Lower/Raise", "ramp"] call FUNC(menu,populate);

true