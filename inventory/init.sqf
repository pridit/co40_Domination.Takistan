/**
 * Inventory Module
 *
 * Description: This module provides the player with basic inventory capability
 * to be able to perform transfers with other players (such as repair kits &
 * medkits).
 */

#define THIS_MODULE inventory
#include "x_macros.sqf"

// Valid types
GVAR(inventory_types) = [];

// Types of items visible within the inventory dialog
GVAR(inventory_type_visible) = [];

// Amount of visual (dialog) slots that can be occupied
GVAR(inventory_amount_slots) = 24;

__cppfln(FUNC(THIS_MODULE,name),THIS_MODULE\functions\fn_name.sqf);
__cppfln(FUNC(THIS_MODULE,replenish),THIS_MODULE\functions\fn_replenish.sqf);
__cppfln(FUNC(THIS_MODULE,show),THIS_MODULE\functions\fn_show.sqf);
__cppfln(FUNC(THIS_MODULE,transfer),THIS_MODULE\functions\fn_transfer.sqf);
__cppfln(FUNC(THIS_MODULE,valid),THIS_MODULE\functions\fn_valid.sqf);

MODULE(THIS_MODULE) = true;