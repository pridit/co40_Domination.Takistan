/**
 * Vehicle Repair Module
 *
 * Description: This module enables players to repair vehicles.
 */

#define THIS_MODULE vehicle_repair
#include "x_macros.sqf"

// Set minimum damage to initiate repair
GVAR(vehicle_repair_amount_damage) = 0.4;

// Set maximum fuel level to initiate repair
GVAR(vehicle_repair_amount_fuel) = 0.10;

// Set addAction parameters that need to apply to existing clients & JIP
GVAR(vehicle_repair_player_action) = [
    "Give Repair Kit" call FUNC(common,BlueText),
    FUNCTION(inventory,transfer),
    "repair_kits",
    8,
    false,
    true,
    "",
    "['repair_kits', _target] call d_fnc_inventory_valid && {!(_target getVariable 'd_unconscious')}"
];

if (hasInterface) then {
    GVAR(repairing) = false;
    
    player setVariable [QGVAR(repair_full), false];
    player setVariable [QGVAR(repair_kits), 0, true];
    player setVariable [QGVAR(repair_kits_max), 0, true];
};

__cppfln(FUNC(THIS_MODULE,repair),THIS_MODULE\functions\fn_repair.sqf);
__cppfln(FUNC(THIS_MODULE,replenish),THIS_MODULE\functions\fn_replenish.sqf);

MODULE(THIS_MODULE) = true;