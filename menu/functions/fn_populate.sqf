#include "x_macros.sqf"
private ["_name", "_key", "_menu"];

PARAMS_2(_name, _key);

disableSerialization;

_menu = DIALOG("X_MENU_DIALOG", 1500);
_menu lbSetData [_menu lbAdd _name, _key];

true