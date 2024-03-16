/**
 * Menu Module - Vehicle Submodule
 */

#define THIS_MODULE menu
#include "x_macros.sqf"
private ["_vehicle"];

PARAMS_1(_vehicle);

_vehicle addAction [
    format [
        "[%1] %2",
        "Menu" call FUNC(common,YellowText),
        [typeOf _vehicle] call FUNC(vehicle,name)
    ] call FUNC(common,GreyText),
    __function(show),
    _vehicle,
    -3,
    false,
    true,
    "",
    "!([[_target] call d_fnc_menu_type, []] call BIS_fnc_areEqual) && {[_target] call d_fnc_menu_vehicle_valid}"
];