/**
 * Vehicle Texture Module
 *
 * Description: This module enables players to switch textures of vehicles.
 */

#define THIS_MODULE vehicle_texture
#include "x_macros.sqf"

// Set valid types of vehicles as well as possible textures.
GVAR(vehicle_texture_types) = [
    ["A10_US_EP1", [
        ["Black Shark", [
            "vehicle_texture\textures\a10_01_co_black_shark",
            "vehicle_texture\textures\a10_02_co_black"
        ]]
    ]]
];

// Set maximum distance from base the texture can be changed.
GVAR(vehicle_texture_distance_base) = 450;

__cppfln(FUNC(THIS_MODULE,default),THIS_MODULE\functions\fn_default.sqf);
__cppfln(FUNC(THIS_MODULE,find),THIS_MODULE\functions\fn_find.sqf);
__cppfln(FUNC(THIS_MODULE,set),THIS_MODULE\functions\fn_set.sqf);
__cppfln(FUNC(THIS_MODULE,type),THIS_MODULE\functions\fn_type.sqf);

MODULE(THIS_MODULE) = true;