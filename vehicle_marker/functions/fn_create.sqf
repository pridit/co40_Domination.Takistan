#define THIS_MODULE vehicle_marker
#include "x_macros.sqf"
private ["_spawn", "_name", "_position"];

PARAMS_1(_vehicle);

if (!alive _vehicle && {!(_vehicle getVariable QGVAR(wreckable))}) exitWith {};
if (count crew _vehicle > 0 && {{!isPlayer _x} count crew _vehicle > 0}) exitWith {};

_marker = createMarkerLocal [str ((_vehicle getVariable QGVAR(position)) select 0), position _vehicle];
_marker setMarkerColorLocal "ColorBlue";
_marker setMarkerTextLocal ([typeOf (_vehicle)] call FUNC(vehicle,name));
_marker setMarkerAlphaLocal 0;

if (_vehicle isKindOf "Tank") then {
    _marker setMarkerTypeLocal "o_armor";
} else {
    _marker setMarkerTypeLocal "o_air";
};

_vehicle addMPEventHandler ["MPKilled", {
    private ["_vehicle"];
    
    PARAMS_1(_vehicle);
    
    _wreckable = _vehicle getVariable QGVAR(wreckable);
    
    if (!isNil QMODULE(vehicle_wreck) && {_wreckable}) exitWith {        
        [_vehicle] __submoduleVM(vehicle_wreck);
    };
    
    deleteMarkerLocal (str (((_this select 0) getVariable QGVAR(position)) select 0));
}];

_vehicle setVariable [QGVAR(hidden), false, true];

_marker