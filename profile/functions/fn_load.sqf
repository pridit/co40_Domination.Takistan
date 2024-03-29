#define THIS_MODULE profile
#include "x_macros.sqf"
private ["_key", "_value", "_variable"];

PARAMS_2(_key, _value);

if !([_key] call FUNC(THIS_MODULE,valid)) exitWith {};

_variable = profileNamespace getVariable _key;

if (isNil "_variable" || {!([_key, _variable] call FUNC(THIS_MODULE,sanitized))}) then {
    _variable = [_key, _value] call FUNC(THIS_MODULE,set);
};

_variable