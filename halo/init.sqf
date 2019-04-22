/**
 * Halo Module
 *
 * Description: This module enables players to be able to perform a HALO jump
 * from a position of their choosing.
 */

#define THIS_MODULE halo
#include "x_macros.sqf"

if (hasInterface) then {
    player setVariable [QGVAR(halo), false];
};

BIS_fnc_halo = compile preprocessFile "halo\functions\bis\fn_halo.sqf"; // override BIS function

__cppfln(FUNC(THIS_MODULE,jump),THIS_MODULE\functions\fn_jump.sqf);
__cppfln(FUNC(THIS_MODULE,show),THIS_MODULE\functions\fn_show.sqf);

MODULE(THIS_MODULE) = true;