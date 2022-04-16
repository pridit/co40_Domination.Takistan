#define THIS_MODULE ammobox
#include "x_macros.sqf"
private ["_faction", "_position", "_direction", "_local", "_type", "_ammobox"];

PARAMS_4(_faction, _position, _direction, _local);

_type = [_faction] call FUNC(THIS_MODULE,type);

switch (_local) do {
    case true: {
        _ammobox = (_type select 1) createVehicleLocal _position;
    };
    
    case false: {
        _ammobox = createVehicle [_type select 1, _position, [], 0, "CAN_COLLIDE"];

        if (_type select 2) then {
            [true, "execVM", [[_ammobox], __function(handle)]] call FUNC(network,mp);
        };

        [true, "reveal", _ammobox] call FUNC(network,mp);
    };
};

if (_type select 2) then {
    [_ammobox, _local] spawn FUNC(THIS_MODULE,replenish);
};

_ammobox setDir _direction;
_ammobox setPos _position;

_ammobox