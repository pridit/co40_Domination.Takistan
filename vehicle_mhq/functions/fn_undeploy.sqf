#define THIS_MODULE vehicle_mhq
#include "x_macros.sqf"
private ["_vehicle"];

PARAMS_1(_vehicle);

_camo = _vehicle getVariable QGVAR(camo);

// just in case it might be destroyed
if (isNil "_camo") then {
    _camo = objNull;
};

if (!isNull _camo) then {
    deleteVehicle _camo;
};

[_vehicle, false] call FUNC(network,lock);

_vehicle setVariable [QGVAR(deployed), false, true];

if (!isNil QMODULE(vehicle_marker)) then {
    [_vehicle, false] __submoduleVM(vehicle_marker);
};