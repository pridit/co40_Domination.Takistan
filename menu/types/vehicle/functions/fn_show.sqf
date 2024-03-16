#define THIS_MODULE menu_vehicle
#include "x_macros.sqf"
private ["_valid"];

_valid = [];

if !(isNil QMODULE(inventory)) then {
    [_valid, [GVAR(menu_entity)] __submodulePP(inventory)] call BIS_fnc_arrayPush;
};

if !(isNil QMODULE(setting)) then {
    if ((GVAR(menu_entity) getVariable QGVAR(deployed)) select 0) then {
        [_valid, [GVAR(menu_entity)] __submodulePP(setting)] call BIS_fnc_arrayPush;
    };
};

if !(isNil QMODULE(vehicle_ammobox)) then {
    [_valid, [GVAR(menu_entity)] __submodulePP(vehicle_ammobox)] call BIS_fnc_arrayPush;
};

if !(isNil QMODULE(vehicle_bomber)) then {
    [_valid, [GVAR(menu_entity)] __submodulePP(vehicle_bomber)] call BIS_fnc_arrayPush;
};

if !(isNil QMODULE(vehicle_create)) then {
    if ((GVAR(menu_entity) getVariable QGVAR(deployed)) select 0) then {
        [_valid, [GVAR(menu_entity)] __submodulePP(vehicle_create)] call BIS_fnc_arrayPush;
    };
};

if !(isNil QMODULE(vehicle_deploy)) then {
    [_valid, [GVAR(menu_entity)] __submodulePP(vehicle_deploy)] call BIS_fnc_arrayPush;
};

if !(isNil QMODULE(vehicle_loadout)) then {
    [_valid, [GVAR(menu_entity)] __submodulePP(vehicle_loadout)] call BIS_fnc_arrayPush;
};

if !(isNil QMODULE(vehicle_pack)) then {
    [_valid, [GVAR(menu_entity)] __submodulePP(vehicle_pack)] call BIS_fnc_arrayPush;
};

if !(isNil QMODULE(vehicle_ramp)) then {
    [_valid, [GVAR(menu_entity)] __submodulePP(vehicle_ramp)] call BIS_fnc_arrayPush;
};

if !(isNil QMODULE(vehicle_teleport)) then {
    if ((GVAR(menu_entity) getVariable QGVAR(deployed)) select 0) then {
        [_valid, [GVAR(menu_entity)] __submodulePP(vehicle_teleport)] call BIS_fnc_arrayPush;
    };
};

if !(isNil QMODULE(vehicle_texture)) then {
    [_valid, [GVAR(menu_entity)] __submodulePP(vehicle_texture)] call BIS_fnc_arrayPush;
};

if !(isNil QMODULE(vehicle_unflip)) then {
    [_valid, [GVAR(menu_entity)] __submodulePP(vehicle_unflip)] call BIS_fnc_arrayPush;
};

_valid