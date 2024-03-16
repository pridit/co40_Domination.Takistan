/**
 * Vehicle Texture Module - Vehicle Menu Submodule
 */

#define THIS_MODULE vehicle_texture
#include "x_macros.sqf"
private ["_vehicle", "_type", "_textures", "_options", "_name", "_texture", "_addon"];

PARAMS_1(_vehicle);

_type = [GVAR(vehicle_texture_types), typeOf _vehicle] call BIS_fnc_findNestedElement;

if ([_type, []] call BIS_fnc_areEqual) exitWith {false};

_textures = [_vehicle] call FUNC(THIS_MODULE,textures);

if (count _textures < 2) exitWith {false};

_options = [_textures select 1] call FUNC(THIS_MODULE,options);

_name = _vehicle getVariable QGVAR(texture);

_texture = ((GVAR(vehicle_texture_types) select (_textures select 0)) select 1) select (_options find (_name select 0));

_addon = [_texture select 0] call FUNC(THIS_MODULE,addon);

[
    format [
        "Texture: %1%2 (%3/%4)",
        _name select 0,
        if !(_addon) then {"*"} else {""},
        (_options find (_name select 0)) + 1,
        count (_textures select 1)
    ],
    "texture"
] call FUNC(menu,populate);

if !(_addon) then {
    DIALOG("X_MENU_DIALOG", 1100) ctrlSetStructuredText parseText format [
        "<t size='0.9'>&#160;</t><br/><t size='1' align='left' valign='bottom'>%1</t>",
        format ["* Requires missing addon: @%1", _name select 1]
    ];
};

true