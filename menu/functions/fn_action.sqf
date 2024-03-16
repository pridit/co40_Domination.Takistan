#define THIS_MODULE menu
#include "x_macros.sqf"
private ["_entity", "_type", "_menu", "_lbCurSel", "_lbData", "_refresh"];

disableSerialization;

_entity = GVAR(menu_entity);

_type = [] call FUNC(THIS_MODULE,type);

if ([_type, []] call BIS_fnc_areEqual) exitWith {closeDialog 0};
if !([_entity] call (call compile format ["d_fnc_menu_%1_valid", _type select 0])) exitWith {closeDialog 0};

_menu = DIALOG("X_MENU_DIALOG", 1500);

_lbCurSel = lbCurSel _menu;

if ([_lbCurSel, -1] call BIS_fnc_areEqual) exitWith {closeDialog 0};

_lbData = _menu lbData _lbCurSel;
_lbData = if ([_lbData, "["] call KRON_StrInStr) then {call compile _lbData} else {_lbData};

_refresh = switch (if ([typeName _lbData, "ARRAY"] call BIS_fnc_areEqual) then {_lbData select 0} else {_lbData}) do {
    call (call compile format ["d_fnc_menu_%1_action", _type select 0])
};

// Refresh dialog for all clients (except actioning player) with it open
[true, "spawn", [[player, _entity], {
    private ["_unit", "_entity"];

    PARAMS_2(_unit, _entity);

    if (isDedicated && {!hasInterface}) exitWith {};
    if ([_unit, player] call BIS_fnc_areEqual) exitWith {};
    if !([typeName (uiNamespace getVariable "X_MENU_DIALOG"), "DISPLAY"] call BIS_fnc_areEqual) exitWith {};
    if !([_entity, GVAR(menu_entity)] call BIS_fnc_areEqual) exitWith {};

    closeDialog 0;

    [_entity] call FUNC(THIS_MODULE,show);
}]] call FUNC(network,mp);

if !(_refresh) exitWith {};

closeDialog 0;

[_entity] call FUNC(THIS_MODULE,show);