/**
 * Inventory - Repair Module
 */

#define THIS_MODULE inventory_repair
#include "x_macros.sqf"

// Type of item
GVAR(inventory_repair_type) = [
    "Repair Kit",
    "repair",
    ["MtvrRepair_DES_EP1", "UralRepair_TK_EP1"]
];

// Visibility in the dialog
GVAR(inventory_repair_visible) = [
    QUOTE(THIS_MODULE),
    "ca\ui\data\ui_action_repair_ca"
];

[GVAR(inventory_types), GVAR(inventory_repair_type)] call BIS_fnc_arrayPush;
[GVAR(inventory_type_visible), GVAR(inventory_repair_visible)] call BIS_fnc_arrayPush;

__cppfln(FUNC(THIS_MODULE,valid),inventory\types\repair\functions\fn_valid.sqf);

MODULE(THIS_MODULE) = true;