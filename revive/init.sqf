/**
 * Revive Module
 *
 * Description: This module facilitates revival of incapacitated players.
 */

#define THIS_MODULE revive
#include "x_macros.sqf"

if !(isMultiplayer) exitWith {};

// Amount of damage a revived player will have (medics revive full health)
GVAR(revive_amount_damage) = 0.4;

// Maximum distance to a capable player before an incapacitated player will call for help
GVAR(revive_distance_exclaim) = 400;

// Amount of time before respawning a player that is unconscious
GVAR(revive_time_respawn) = 240;

if (hasInterface) then {
    player setVariable [QGVAR(unconscious), false, true];
    player setVariable [QGVAR(reviving), false, true];
};

__cppfln(FUNC(THIS_MODULE,countdown),THIS_MODULE\functions\fn_countdown.sqf);
__cppfln(FUNC(THIS_MODULE,debug),THIS_MODULE\functions\fn_debug.sqf);
__cppfln(FUNC(THIS_MODULE,nearest),THIS_MODULE\functions\fn_nearest.sqf);
__cppfln(FUNC(THIS_MODULE,reset),THIS_MODULE\functions\fn_reset.sqf);
__cppfln(FUNC(THIS_MODULE,revive),THIS_MODULE\functions\fn_revive.sqf);
__cppfln(FUNC(THIS_MODULE,unconscious),THIS_MODULE\functions\fn_unconscious.sqf);
__cppfln(FUNC(THIS_MODULE,valid),THIS_MODULE\functions\fn_valid.sqf);

MODULE(THIS_MODULE) = true;