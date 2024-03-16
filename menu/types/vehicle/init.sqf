/**
 * Menu - Vehicle Module
 */

#define THIS_MODULE menu_vehicle
#include "x_macros.sqf"

__cppfln(FUNC(THIS_MODULE,action),menu\types\vehicle\functions\fn_action.sqf);
__cppfln(FUNC(THIS_MODULE,show),menu\types\vehicle\functions\fn_show.sqf);
__cppfln(FUNC(THIS_MODULE,valid),menu\types\vehicle\functions\fn_valid.sqf);

MODULE(THIS_MODULE) = true;