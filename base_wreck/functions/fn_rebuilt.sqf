#define THIS_MODULE base_wreck
#include "x_macros.sqf"
private ["_vehicle", "_hangars", "_hangar", "_full"];

PARAMS_1(_vehicle);

_hangars = X_JIPH getVariable QGVAR(wreck_hangars);

{
    if (!triggerActivated _x) then {
        _hangar = _hangars select _forEachIndex;
        
        _vehicle setDir ((getDir _hangar) - 180);
        _vehicle setPosATL (getPosATL _hangar);
    };
} forEach GVAR(wreck_hangar_triggers);

[true, "enableSimulation", [_vehicle, true]] call FUNC(network,mp);

_vehicle lock false;
_vehicle allowDamage true;

if (!isNil QMODULE(menu_vehicle)) then {
    _vehicle setVariable [QGVAR(menu), true, true];
};

if (!isNil QMODULE(vehicle_tow)) then {
    _vehicle setVariable [QGVAR(towed), false, true];
};

if (GVAR(wreck_hangars_occupied) == (count _hangars - 1)) then {
    _full = " Free up a hangar to continue rebuilding wrecks.";
} else {
    _full = "";
};

if !(isNil QMODULE(conversation)) then {
    [
        [GVAR(crossroad), GVAR(crossroad2)],
        [QUOTE(THIS_MODULE), "Rebuilt"],
        [
            ["1", {}, [typeOf _vehicle] call FUNC(vehicle,name), []],
            ["2", {}, _full, []]
        ]
    ] call FUNC(conversation,radio);
};

GVAR(base_wreck) setVariable [QGVAR(time), 0, true];

GVAR(rebuilding) = false;
GVAR(wreck) = nil;