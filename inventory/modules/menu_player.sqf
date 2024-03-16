/**
 * Inventory - Menu Player Submodule
 */

#define THIS_MODULE inventory
#include "x_macros.sqf"
private ["_unit"];

PARAMS_1(_unit);

{
    private ["_name", "_key"];

    _name = _x select 0;
    _key = _x select 1;

    if ([_key, GVAR(menu_entity)] call FUNC(THIS_MODULE,valid)) then {
        format ["Inventory: Give %1", _name] call FUNC(menu,populate);
    };
} forEach GVAR(inventory_types);

true