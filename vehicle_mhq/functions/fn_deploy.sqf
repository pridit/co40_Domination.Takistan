#define THIS_MODULE vehicle_mhq
#include "x_macros.sqf"
private ["_vehicle"];

PARAMS_1(_vehicle);

_position = position _vehicle;
_city = nearestLocation [_position, "nameCity"];

_checks = [
    [
        [[typeOf _vehicle] call FUNC(vehicle,name), "deployed"],
        _position,
        markerPos QGVAR(base_south),
        [GVAR(vehicle_mhq_distance_base), "in excess of", "from base"]
    ] call FUNC(helper,distanceFrom),
    
    [
        [[typeOf _vehicle] call FUNC(vehicle,name), "deployed"],
        _vehicle
    ] call FUNC(helper,isOccupied)
];

{
    if (typeName _x == "STRING") exitWith {
        hint _x;
    };
} forEach _checks;

if ({str (_x) == "true"} count _checks < count _checks) exitWith {};

_camo = createVehicle ["Land_CamoNetB_NATO_EP1", [_position select 0, _position select 1, 0], [], 0, "NONE"];
_camo setDir direction _vehicle;
_camo setVectorUp (vectorUp _vehicle);
_camo setPos [_position select 0, _position select 1, 0];
_camo addEventHandler ["HandleDamage", {0}];

[_vehicle, true] call FUNC(network,lock);
[_vehicle, false] call FUNC(network,engineOn);

_vehicle setVariable [QGVAR(camo), _camo, true];
_vehicle setVariable [QGVAR(deployed), true, true];

if (!isNil QMODULE(vehicle_marker)) then {
    [nil, nil, rExecVM, __submoduleRE(vehicle_marker), _vehicle, true] call RE;
};

if (!isNil QMODULE(crossroad) && call FUNC(common,time) > player getVariable QGVAR(cooldown)) then {
    [player, GVAR(crossroad), "vehicle_mhq", "Deployed", ["1", {}, [typeOf _vehicle] call FUNC(vehicle,name), []], ["2", {}, text (_city), []], true] call FUNC(network,kbTell);

    player setVariable [QGVAR(cooldown), call FUNC(common,time) + GVAR(crossroad_time_cooldown)];
};