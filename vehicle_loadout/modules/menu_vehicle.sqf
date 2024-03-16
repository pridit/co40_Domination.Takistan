/**
 * Vehicle Loadout Module - Vehicle Menu Submodule
 */

#define THIS_MODULE vehicle_loadout
#include "x_macros.sqf"
private ["_vehicle", "_type", "_loadouts", "_name"];

PARAMS_1(_vehicle);

_type = [_vehicle] call FUNC(THIS_MODULE,type);

if (typeName _type == "SCALAR") exitWith {false};

_loadouts = ([_vehicle] call FUNC(THIS_MODULE,find)) select 0;

if (count _loadouts < 2) exitWith {false};

_name = (_vehicle getVariable QGVAR(loadout)) select 0;

[
    format [
        "Loadout: %1 (%2/%3)",
        _name,
        (_loadouts find _name) + 1,
        count _loadouts
    ],
    "loadout"
] call FUNC(menu,populate);

true