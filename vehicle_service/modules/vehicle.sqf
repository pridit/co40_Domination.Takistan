/**
 * Vehicle Service Module - Vehicle Submodule
 */

#include "x_macros.sqf"
private ["_vehicle"];

PARAMS_1(_vehicle);

_vehicle setVariable [QGVAR(servicing), false, true];