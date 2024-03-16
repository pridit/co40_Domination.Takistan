/**
 * Vehicle Ammobox Module - Vehicle Menu Submodule
 */

#include "x_macros.sqf"
private ["_vehicle", "_ammobox", "_string"];

PARAMS_1(_vehicle);

if (GVAR(vehicle_ammobox_types) find (typeOf _vehicle) == -1) exitWith {false};

disableSerialization;

_ammobox = _vehicle getVariable QGVAR(ammobox);

if (!isNil "_ammobox" && {_ammobox}) then {
    _string = "Unload";
} else {
    _string = "Load";

    DIALOG("X_MENU_DIALOG", 1100) ctrlSetStructuredText parseText format [
        "<t size='0.9'>&#160;</t><br/><t color='#c54a30' size='1' align='left' valign='bottom'>%1</t>",
        "(!) No ammobox loaded"
    ];
};

[
    format [
        "Ammobox: %1",
        _string
    ],
    "ammobox"
] call FUNC(menu,populate);

true