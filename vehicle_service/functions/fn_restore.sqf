/**
 * Original authors: =7Cav=CW2.Iher.I & Xeno
 */

#define THIS_MODULE vehicle_service
#include "x_macros.sqf"
private ["_service", "_time"];

PARAMS_1(_service);

_vehicle = _service getVariable QGVAR(vehicle);

_service setVariable [QGVAR(vehicle), objNull];
_vehicle setVariable [QGVAR(servicing), true, true];

[_vehicle, "lock", true] call FUNC(network,mp);
[_vehicle, "setFuel", 0] call FUNC(network,mp);

if !(isNil QMODULE(menu_vehicle)) then {
    _vehicle setVariable [QGVAR(menu), false, true];
};

sleep 1;

if (!isNil QMODULE(vehicle_loadout) && {!isNil {_vehicle getVariable QGVAR(loadout)}}) then {
    private ["_handle"];
    
    _handle = [_vehicle] __submoduleVM(vehicle_loadout);

    waitUntil {sleep 0.5; scriptDone _handle};
} else {
    [true, "setVehicleAmmo", [_vehicle, 1]] call FUNC(network,mp);

    _magazines = getArray (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "magazines");

    if (count _magazines > 0) then {
        {
            [_vehicle, _x] call FUNC(THIS_MODULE,rearm);
        } forEach _magazines;
    };

    _turrets = count (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "turrets");

    for "_i" from 0 to (_turrets - 1) do {
        _config = (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "turrets") select _i;
        _magazines = getArray (_config >> "magazines");
        
        {
            [_vehicle, _x] call FUNC(THIS_MODULE,rearm);
        } forEach _magazines;
    };
};

[true, "vehicleChat", [_vehicle, "Repairing"]] call FUNC(network,mp);

sleep 2;

[_vehicle, "setDamage", 0] call FUNC(network,mp);

[true, "vehicleChat", [_vehicle, "Refuelling"]] call FUNC(network,mp);

sleep 2;

[_vehicle, "setFuel", 1] call FUNC(network,mp);
[_vehicle, "lock", false] call FUNC(network,mp);

if !(isNil QMODULE(menu_vehicle)) then {
    _vehicle setVariable [QGVAR(menu), true, true];
};

if !(_vehicle call FUNC(common,empty)) then {
    [_vehicle, "engineOn", true] call FUNC(network,mp);
};

if (!isNil QMODULE(3d)) then {
    [true, "execVM", [
        [_service, GVAR(vehicle_service_time_cooldown)],
        FUNCTION(3d,time)
    ]] call FUNC(network,mp);
};

_service setVariable [QGVAR(time), GVAR(vehicle_service_time_cooldown) + call FUNC(common,time)];
_vehicle setVariable [QGVAR(servicing), false, true];