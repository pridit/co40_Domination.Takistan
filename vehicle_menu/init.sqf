/**
 * Vehicle Menu Module
 */

#define THIS_MODULE vehicle_menu
#include "x_macros.sqf"

// Valid types of vehicles that can have a menu
GVAR(vehicle_menu_types) = [];

__cppfln(FUNC(THIS_MODULE,action),THIS_MODULE\functions\fn_action.sqf);
__cppfln(FUNC(THIS_MODULE,populate),THIS_MODULE\functions\fn_populate.sqf);
__cppfln(FUNC(THIS_MODULE,show),THIS_MODULE\functions\fn_show.sqf);

MODULE(THIS_MODULE) = true;