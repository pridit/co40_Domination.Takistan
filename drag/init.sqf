/**
 * Medical Drag Module
 *
 * Description: This module facilitates a physical dragging mechanic of
 * incapacitated players.
 */

#define THIS_MODULE drag
#include "x_macros.sqf"

if (hasInterface) then {
    player setVariable [QGVAR(dragging), false, true];
};

__cppfln(FUNC(THIS_MODULE,drag),THIS_MODULE\functions\fn_drag.sqf);
__cppfln(FUNC(THIS_MODULE,drop),THIS_MODULE\functions\fn_drop.sqf);
__cppfln(FUNC(THIS_MODULE,valid),THIS_MODULE\functions\fn_valid.sqf);

MODULE(THIS_MODULE) = true;