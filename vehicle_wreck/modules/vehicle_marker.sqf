/**
 * Vehicle Wreck - Vehicle Marker Submodule
 */

#include "x_macros.sqf"
private ["_vehicle", "_marker"];

PARAMS_1(_vehicle);

if (alive _vehicle) exitWith {};

if (_vehicle getVariable QGVAR(wreckable)) then {
    _marker = str ((_vehicle getVariable QGVAR(position)) select 0);
    _marker setMarkerPosLocal (position _vehicle);
    _marker setMarkerTextLocal (format ["%1 Wreck", [typeOf (_vehicle)] call FUNC(vehicle,name)]);
    _marker setMarkerTypeLocal "DOT";
};

if (faction _vehicle == "BIS_TK") then {
    _marker setMarkerColorLocal "ColorRed";
};