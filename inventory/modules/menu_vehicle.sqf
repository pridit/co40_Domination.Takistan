/**
 * Inventory - Menu Vehicle Submodule
 */

#define THIS_MODULE inventory
#include "x_macros.sqf"
private ["_vehicle", "_types"];

PARAMS_1(_vehicle);

_types = [];

{
    private ["_name", "_key"];

    _name = _x select 0;
    _key = _x select 1;

    if ([_vehicle] call (call compile format ["d_fnc_%1_%2_valid", QUOTE(THIS_MODULE), _key])) then {
        [
            _types,
            [
                format [
                    "%1: Take (%2)",
                    _name,
                    (player getVariable (format ["d_inventory_%1_max", _key])) - (player getVariable (format ["d_inventory_%1", _key]))
                ],
                format ["%1_%2", QUOTE(THIS_MODULE), _key]
            ] call FUNC(menu,populate)
        ] call BIS_fnc_arrayPush;
    };

    if (!isNil (format [QMODULE(vehicle_%1), _key]) && {[_vehicle] call (call compile format ["d_fnc_vehicle_%1_valid", _key])}) then {
        [
            _types,
            [
                format ["%1: Use", _name],
                _key
            ] call FUNC(menu,populate)
        ] call BIS_fnc_arrayPush;
    };
} forEach GVAR(inventory_types);

if ([count _types, 0] call BIS_fnc_areEqual) exitWith {false};

true