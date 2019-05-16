/**
 * Vehicle Tow Module
 *
 * Description: This module enables players to physically tow aircraft.
 */

#define THIS_MODULE vehicle_tow
#include "x_macros.sqf"

// Set vehicle that can initiate a tow
GVAR(vehicle_tow_type) = "ATV_US_EP1";

// Set types that can be towed
GVAR(vehicle_tow_type_towable) = [
    "Air"
];

// Set vehicle speed during a tow
GVAR(vehicle_tow_amount_speed) = 15;

__cppfln(FUNC(THIS_MODULE,action),THIS_MODULE\functions\fn_action.sqf);
__cppfln(FUNC(THIS_MODULE,detach),THIS_MODULE\functions\fn_detach.sqf);
__cppfln(FUNC(THIS_MODULE,offset),THIS_MODULE\functions\fn_offset.sqf);
__cppfln(FUNC(THIS_MODULE,tow),THIS_MODULE\functions\fn_tow.sqf);
__cppfln(FUNC(THIS_MODULE,valid),THIS_MODULE\functions\fn_valid.sqf);

MODULE(THIS_MODULE) = true;