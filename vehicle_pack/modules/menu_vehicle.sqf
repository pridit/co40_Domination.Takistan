/**
 * Vehicle Pack Module - Vehicle Menu Submodule
 */

#include "x_macros.sqf"
private ["_vehicle", "_packed"];

PARAMS_1(_vehicle);

if (GVAR(vehicle_pack_types) find (typeOf _vehicle) == -1) exitWith {false};

_packed = _vehicle getVariable QGVAR(packed);

[
    format [
        "%1: %2",
        if (_vehicle isKindOf "Plane") then {"Wings"} else {"Main Rotor"},
        if (!isNil "_packed" && {_packed}) then {"Unfold"} else {"Fold"}
    ],
    "pack"
] call FUNC(menu,populate);

true