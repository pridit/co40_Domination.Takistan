#define THIS_MODULE menu_player
#include "x_macros.sqf"
private ["_valid"];

_valid = [];

if !(isNil QMODULE(drag)) then {
    [_valid, [GVAR(menu_entity)] __submodulePP(drag)] call BIS_fnc_arrayPush;
};

if !(isNil QMODULE(inventory)) then {
    [_valid, [GVAR(menu_entity)] __submodulePP(inventory)] call BIS_fnc_arrayPush;
};

if !(isNil QMODULE(revive)) then {
    [_valid, [GVAR(menu_entity)] __submodulePP(revive)] call BIS_fnc_arrayPush;
};

if !(isNil QMODULE(squad)) then {
    [_valid, [GVAR(menu_entity)] __submodulePP(squad)] call BIS_fnc_arrayPush;
};

_valid