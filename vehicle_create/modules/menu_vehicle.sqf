/**
 * Vehicle Create Module - Vehicle Menu Submodule
 */

#include "x_macros.sqf"
private ["_vehicle", "_types", "_type", "_vehicles"];

PARAMS_1(_vehicle);

_types = GVAR(vehicle_create_types);

_type = ([0, _types] call FUNC(common,arrayValues)) find (typeOf _vehicle);

if (_type == -1) exitWith {false};

_vehicles = ([1, _types] call FUNC(common,arrayValues)) select _type;

{
    [
        format ["Create: %1", [_x] call FUNC(vehicle,name)],
        format ["[""create"", ""%1""]", _x]
    ] call FUNC(menu,populate);
} forEach _vehicles;

true