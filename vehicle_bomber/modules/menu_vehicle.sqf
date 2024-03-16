/**
 * Vehicle Bomber Module - Vehicle Menu Submodule
 */

#define THIS_MODULE vehicle_bomber
#include "x_macros.sqf"
private ["_vehicle", "_bomber"];

PARAMS_1(_vehicle);

if ([GVAR(vehicle_bomber_type_vehicles) find (typeOf _vehicle), -1] call BIS_fnc_areEqual) exitWith {false};

_bomber = _vehicle getVariable QGVAR(bomber);

if (isNil "_bomber" || {!_bomber}) exitWith {false};

if !([_vehicle] call FUNC(THIS_MODULE,valid)) exitWith {false};

[
    switch (true) do {
        case (!isNil QMODULE(item) && {!isNil QMODULE(item_money) && {[GVAR(item_money_type) select 1] call FUNC(item,valid)}}): {"Talk: Intel [Give Money]"};
        default {"Talk: Intel"}
    },
    "bomber"
] call FUNC(menu,populate);

true