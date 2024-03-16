#define THIS_MODULE menu
#include "x_macros.sqf"
private ["_type", "_valid"];

disableSerialization;

createDialog "XD_MenuDialog";

DIALOG("X_MENU_DIALOG", 1700) ctrlEnable false;
DIALOG("X_MENU_DIALOG", 1500) ctrlShow false;

GVAR(menu_entity) = [_this, 3, _this select 0] call FUNC(common,param);

_type = [] call FUNC(THIS_MODULE,type);

if ([_type, []] call BIS_fnc_areEqual) exitWith {};

_valid = call (call compile format ["d_fnc_menu_%1_show", _type select 0]);

DIALOG("X_MENU_DIALOG", 1000) ctrlSetText (_type select 1);
DIALOG("X_MENU_DIALOG", 1201) ctrlSetText (_type select 2);

if ([{[_x, false] call BIS_fnc_areEqual} count _valid, count _valid] call BIS_fnc_areEqual) exitWith {
    DIALOG("X_MENU_DIALOG", 1100) ctrlSetStructuredText parseText format [
        "<t size='0.9'>&#160;</t><br/><t size='1' align='left' valign='bottom'>%1</t>",
        "No options available"
    ];
};

lbSort (DIALOG("X_MENU_DIALOG", 1500));

DIALOG("X_MENU_DIALOG", 1500) ctrlShow true;