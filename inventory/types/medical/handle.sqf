/**
 * Inventory - Medical Module (Handler)
 */

#include "x_macros.sqf"

if (hasInterface) then {
    player setVariable [QGVAR(inventory_medical), 0, true];
    player setVariable [QGVAR(inventory_medical_max), 0, true];
};