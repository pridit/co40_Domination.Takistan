/**
 * Vehicle Module (Handler)
 */

#define THIS_MODULE vehicle
#include "x_macros.sqf"
PARAMS_1(_vehicle);

if (!isNil QUOTE(MODULE(client,perk))) then {
    [_vehicle] __submodule(perk);
};