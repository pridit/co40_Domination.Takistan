/**
 * Vehicle Bonus Module (Handler)
 */

#define THIS_MODULE vehicle_bonus
#include "x_macros.sqf"
private ["_marker", "_vehicle"];

if (isServer) then {
    X_JIPH setVariable [QGVAR(vehicle_bonus), 0, true];
    
    for "_i" from 1 to GVAR(vehicle_bonus_amount_max) do {
        _marker = format [QGVAR(bonus_air_%1), _i];
        
        if (str (markerPos _marker) == "[0,0,0]") exitWith {};

        _vehicle = createVehicle [markerText _marker, markerPos _marker, [], 0, "NONE"];
        _vehicle setDir (markerDir _marker);
        _vehicle setPos (markerPos _marker);
        
        _vehicle setVariable [QGVAR(bonus), true, true];
        
        if (!isNil QMODULE(vehicle_respawn)) then {
            _vehicle setVariable [QGVAR(respawnable), false, true];
        };
        
        if (!isNil QMODULE(vehicle_service)) then {
            _vehicle setVariable [QGVAR(servicing), false, true];
        };
        
        if (!isNil QMODULE(vehicle_wreck)) then {
            _vehicle setVariable [QGVAR(wreckable), true, true];
        };
        
        _vehicle setVehicleAmmo GVAR(vehicle_bonus_capacity_ammo);
        
        X_JIPH setVariable [QGVAR(vehicle_bonus), (X_JIPH getVariable QGVAR(vehicle_bonus)) + 1, true];
    };
};