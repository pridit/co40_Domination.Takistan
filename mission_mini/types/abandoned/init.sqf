/**
 * Mission Mini - Abandoned Module
 *
 * Description: This module is responsible for handling the mini mission to
 * recover an abandoned light vehicle.
 */

#define THIS_MODULE mission_mini_abandoned
#include "x_macros.sqf"

if !(isServer) exitWith {};

// Type of mini mission
GVAR(mission_mini_abandoned) = ["abandoned", "Abandoned Light Vehicle"];

// Possible types of vehicles to be picked to recover
GVAR(mission_mini_abandoned_types_vehicle) = [
    "BAF_Jackal2_GMG_D",
    "BAF_Jackal2_L2A1_D",
    "HMMWV_M1151_M2_DES_EP1"
];

// Chance the vehicle will be flipped
GVAR(mission_mini_abandoned_chance_flip) = 40;

// Chance an IED will accompany the abandoned vehicle
GVAR(mission_mini_abandoned_chance_ied) = 65;

[GVAR(mission_mini_types), GVAR(mission_mini_abandoned)] call BIS_fnc_arrayPush;

__cppfln(FUNC(THIS_MODULE,create),mission_mini\types\abandoned\functions\fn_create.sqf);

MODULE(THIS_MODULE) = true;