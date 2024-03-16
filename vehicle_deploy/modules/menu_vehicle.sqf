/**
 * Vehicle Deploy Module - Vehicle Menu Submodule
 */

#define THIS_MODULE vehicle_deploy
#include "x_macros.sqf"
private ["_vehicle", "_type", "_deployed"];

PARAMS_1(_vehicle);

_type = [_vehicle] call FUNC(THIS_MODULE,type);

if (typeName _type == "SCALAR") exitWith {false};

_deployed = (_vehicle getVariable QGVAR(deployed)) select 0;

[
    format [
        "%1: %2",
        _type select 1,
        if (!isNil "_deployed" && {_deployed}) then {"Undeploy"} else {"Deploy"}
    ],
    format ["[""deploy"", ""%1""]", toLower (_type select 1)]
] call FUNC(menu,populate);

true