/**
 * Vehicle Service Module (Handle)
 */

#define THIS_MODULE vehicle_service
#include "x_macros.sqf"

if (!isNil QMODULE(inventory)) then {
    __submoduleVM(inventory);
};