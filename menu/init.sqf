/**
 * Menu Module
 */

#define THIS_MODULE menu
#include "x_macros.sqf"

if (hasInterface) then {
    GVAR(menu_entity) = objNull;
};

__cppfln(FUNC(THIS_MODULE,action),THIS_MODULE\functions\fn_action.sqf);
__cppfln(FUNC(THIS_MODULE,populate),THIS_MODULE\functions\fn_populate.sqf);
__cppfln(FUNC(THIS_MODULE,show),THIS_MODULE\functions\fn_show.sqf);
__cppfln(FUNC(THIS_MODULE,type),THIS_MODULE\functions\fn_type.sqf);

MODULE(THIS_MODULE) = true;