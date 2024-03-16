#include "x_macros.sqf"
private ["_type", "_target", "_kits", "_max"];

PARAMS_2(_type, _target);

if !([] call FUNC(common,ready)) exitWith {false};
if !([_target] call FUNC(common,ready)) exitWith {false};

_type = format ["d_inventory_%1", _type];

if (player getVariable _type < 1) exitWith {false};
if ([player, _target] call BIS_fnc_areEqual) exitWith {false};
if !([player, vehicle player] call BIS_fnc_areEqual) exitWith {false};

_kits = _target getVariable _type;
_max = _target getVariable (_type + "_max");

if (_kits > 0) exitWith {false}; // target already has item
if (_max > 0 && {(_kits + 1) > _max}) exitWith {false}; // giving item would exceed maximum capacity

true