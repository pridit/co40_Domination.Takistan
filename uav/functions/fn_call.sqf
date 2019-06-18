#define THIS_MODULE uav
#include "x_macros.sqf"
private ["_unit", "_position", "_name", "_checks"];

PARAMS_2(_unit, _position);

if (hasInterface) then {
    _name = "UAV";
    _checks = [
        [
            _name,
            QGVAR(uav_progress)
        ] call FUNC(helper,inProgress),
        
        [
            [_name, "called"],
            player getVariable QGVAR(uav_cooldown)
        ] call FUNC(helper,timeExceeded),
        
        [
            [_name, "called"],
            _position,
            player,
            [GVAR(uav_distance_player), "within", "of your location"]
        ] call FUNC(helper,distanceFrom),
        
        [
            [_name, "called"]
        ] call FUNC(helper,inVehicle)
    ];
    
    {
        if (typeName _x == "STRING") exitWith {
            hint _x;
        };
    } forEach _checks;

    if ({str (_x) == "true"} count _checks < count _checks) exitWith {};
    
    X_JIPH setVariable [QGVAR(uav_call), true, true];
    player setVariable [QGVAR(uav_cooldown), time + GVAR(uav_time_cooldown)];
    
    if (!isServer) then {
        uav = _this;
        publicVariableServer "uav";
    };
};

if (isServer && {X_JIPH getVariable QGVAR(uav_call)}) then {
    X_JIPH setVariable [QGVAR(uav_call), false, true];
    X_JIPH setVariable [QGVAR(uav_progress), true, true];
    
    if (!isNil QMODULE(crossroad)) then {
        [_unit, _position, "UAV"] call FUNC(crossroad,request);
    };
    
    _vehicle = [_position, GVAR(uav_type_aircraft), GVAR(uav_distance_spawn), 400, west] call FUNC(server,spawnVehicle);
    
    _aircraft = _vehicle select 0;
    _crew = _vehicle select 1;
    
    _aircraft flyInHeight 700;
    _aircraft limitSpeed 40;
    _aircraft lock true;
    _aircraft setVehicleAmmo 0;
    
    _aircraft setVariable [QGVAR(uav_range), false];
    _aircraft setVariable [QGVAR(uav_airborne), time + GVAR(uav_time_airborne)];
    
    [_aircraft, _position] spawn FUNC(THIS_MODULE,patrol);

    while {alive _aircraft && {canMove _aircraft}} do {
        if (time > _aircraft getVariable QGVAR(uav_airborne)) exitWith {
            _aircraft limitSpeed 0;
            
            if (!isNil QMODULE(crossroad)) then {
                GVAR(crossroad) kbTell [GVAR(crossroad2), "uav", "LowFuel", true];
            };
            
            [_aircraft] call FUNC(server,exitMap);
        };
        
        if (_aircraft getVariable QGVAR(uav_range)) then {
            [_position, GVAR(uav_distance_scan)] spawn FUNC(THIS_MODULE,ping);
            
            sleep GVAR(uav_time_ping);
        };
        
        sleep 2;
    };
    
    while {alive _aircraft && {canMove _aircraft}} do {
        sleep 5;
    };
    
    if (!canMove _aircraft) then {
        {
            deleteVehicle _x;
        } forEach _crew;
        
        _aircraft setDamage 1;
    };
    
    X_JIPH setVariable [QGVAR(uav_progress), false, true];
};