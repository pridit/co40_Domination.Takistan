/**
 * Vehicle Menu Module - Vehicle Submodule
 */

#define THIS_MODULE vehicle_menu
#include "x_macros.sqf"
private ["_vehicle", "_valid"];

PARAMS_1(_vehicle);

_valid = [];

if (!isNil QMODULE(vehicle_ammobox)) then {
    _valid = _valid + GVAR(vehicle_ammobox_types);
};

if (!isNil QMODULE(vehicle_pack)) then {
    _valid = _valid + GVAR(vehicle_pack_types);
};

if (!isNil QMODULE(vehicle_deploy)) then {
    _valid = _valid + ([0, call FUNC(vehicle_deploy,types)] call FUNC(common,arrayValues));
};

if (_valid find (typeOf _vehicle) == -1) exitWith {};

_vehicle addAction [
    format ["%1 Menu" call FUNC(common,YellowText),
    [typeOf (_vehicle)] call FUNC(vehicle,name)],
    __function(show),
    _vehicle,
    -3,
    false,
    true,
    "",
    "alive _target && {!(player in _target)} && {_target getVariable 'd_menu'}"
];