/**
 * Vehicle MHQ Module - Respawn Submodule
 */

#include "x_macros.sqf"

// Set distance within deployed MHQ to be able to respawn.
GVAR(vehicle_mhq_distance_respawn) = 2000;

if (!isNil QMODULE(setting)) then {    
    player setVariable [QGVAR(respawn_types), (player getVariable QGVAR(respawn_types)) + [
        [format ["Mobile HQ (%1km)", GVAR(vehicle_mhq_distance_respawn) / 1000], "mhq"]
    ]];
};