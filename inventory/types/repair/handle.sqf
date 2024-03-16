/**
 * Inventory - Repair Module (Handler)
 */

#include "x_macros.sqf"

if (hasInterface) then {
    player setVariable [QGVAR(inventory_repair), 0, true];
    player setVariable [QGVAR(inventory_repair_max), 0, true];
};