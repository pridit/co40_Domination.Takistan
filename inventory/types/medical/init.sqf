/**
 * Inventory - Medical Module
 */

#define THIS_MODULE inventory_medical
#include "x_macros.sqf"

// Type of item
GVAR(inventory_medical_type) = [
    "Medkit",
    "medical",
    ["HMMWV_Ambulance_DES_EP1", "M113Ambul_TK_EP1"]
];

// Visibility in the dialog
GVAR(inventory_medical_visible) = [
    QUOTE(THIS_MODULE),
    "ca\ui\data\cursor_firstaid_ca"
];

[GVAR(inventory_types), GVAR(inventory_medical_type)] call BIS_fnc_arrayPush;
[GVAR(inventory_type_visible), GVAR(inventory_medical_visible)] call BIS_fnc_arrayPush;

__cppfln(FUNC(THIS_MODULE,valid),inventory\types\medical\functions\fn_valid.sqf);

MODULE(THIS_MODULE) = true;