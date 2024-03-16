/**
 * Setting Module - Menu Submodule
 */

#include "x_macros.sqf"
private ["_vehicle", "_types", "_type", "_respawn"];

PARAMS_1(_vehicle);

_types = [];

{
    if ([_x, "vehicle_"] call KRON_StrInStr) then {
        [_types, [[_forEachIndex, _x], call compile format ["d_%1_types", _x]]] call BIS_fnc_arrayPush;
    };
} forEach ([1, player getVariable QGVAR(respawn_types)] call FUNC(common,arrayValues));

// Vehicle we are using is of eligible type
_type = [_types, typeOf _vehicle] call BIS_fnc_findNestedElement;

if ([_type, []] call BIS_fnc_areEqual) exitWith {false};

// Vehicle not already selected as respawn setting
_respawn = (_types select (_type select 0)) select 0;

if ([_respawn select 1, (player getVariable QGVAR(respawn_type)) select 1] call BIS_fnc_areEqual) exitWith {false};

[
    "Setting: Set Respawn",
    format ["[""respawn"", %1]", _respawn]
] call FUNC(menu,populate);

true