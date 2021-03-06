#define THIS_MODULE vehicle_ammobox
#include "x_macros.sqf"
private ["_vehicle", "_position", "_box"];

PARAMS_1(_vehicle);

if (GVAR(vehicle_ammobox_types) find (typeOf _vehicle) == -1) exitWith {};

_position = _vehicle modelToWorld [4,0,0];

if (!isNil QMODULE(ammobox)) then {
    _box = [
        [_position select 0, _position select 1, 0],
        direction _vehicle,
        false
    ] call FUNC(ammobox,create);
    
    [true, "say", [_box, QGVAR(sound_box), 20]] call FUNC(network,mp);
};

_vehicle setVariable [QGVAR(ammobox), false, true];