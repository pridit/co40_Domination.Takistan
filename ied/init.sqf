/**
 * IED Module
 *
 * Description: This module enables the seeding of improvised explosives along
 * roads, as well as facilitating their disarm.
 */

#define THIS_MODULE ied
#include "x_macros.sqf"

// Set possible object types
GVAR(ied_type_objects) = [
    "Land_IED_v1_PMC",
    "Land_IED_v2_PMC"
];

// Set the explosion type
GVAR(ied_type_explosion) = "Bo_GBU12_LGB";

// Set amount of score to reward for disarming.
GVAR(ied_amount_score) = 4;

// Set the maximum unit speed before triggering
GVAR(ied_trigger_speed) = 5;

// Set minimum and maximum distance thresholds before triggering
GVAR(ied_trigger_distances) = [2, 6];

if (hasInterface) then {
    player setVariable [QGVAR(ied), false];
};

__cppfln(FUNC(THIS_MODULE,create),THIS_MODULE\functions\fn_create.sqf);
__cppfln(FUNC(THIS_MODULE,detonate),THIS_MODULE\functions\fn_detonate.sqf);
__cppfln(FUNC(THIS_MODULE,disarm),THIS_MODULE\functions\fn_disarm.sqf);
__cppfln(FUNC(THIS_MODULE,near),THIS_MODULE\functions\fn_near.sqf);
__cppfln(FUNC(THIS_MODULE,valid),THIS_MODULE\functions\fn_valid.sqf);

MODULE(THIS_MODULE) = true;