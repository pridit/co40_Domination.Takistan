/**
 * Core Module - Server
 */

#define THIS_MODULE server
#include "x_macros.sqf"

__cppfln(FUNC(THIS_MODULE,exitMap),core\THIS_MODULE\functions\fn_exitMap.sqf);
__cppfln(FUNC(THIS_MODULE,spawnVehicle),core\THIS_MODULE\functions\fn_spawnVehicle.sqf);

createCenter west;
createCenter east;
createCenter civilian;
createCenter resistance;

west setFriend [east, 0.1];
west setFriend [resistance, 1];

east setFriend [west, 0.1];
east setFriend [resistance, 0.1];

resistance setFriend [west, 1];
resistance setFriend [east, 0.1];