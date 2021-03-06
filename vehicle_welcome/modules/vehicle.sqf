/**
 * Vehicle Welcome Module - Vehicle Submodule
 */

#define THIS_MODULE vehicle_welcome
#include "x_macros.sqf"
private ["_vehicle"];

PARAMS_1(_vehicle);

if (!(_vehicle isKindOf "Helicopter") && {typeOf _vehicle != "MV22"}) exitWith {};

_vehicle addEventHandler ["getin", {
    if ((_this select 1) != "driver" || {(_this select 2) != player}) exitWith {};
    if ((player getVariable QGVAR(vehicle_welcome)) select 1 == "false") exitWith {};
    
    67322 cutRsc ["XD_VehicleWelcomeDialog", "PLAIN"];
    
    if (!isNil QMODULE(vehicle_ammobox)) then {
        [(_this select 0)] __submoduleVM(vehicle_ammobox);
    };
    
    if (!isNil QMODULE(vehicle_lift)) then {
        [(_this select 0)] __submoduleVM(vehicle_lift);
    };
    
    if (!isNil QMODULE(vehicle_wreck)) then {
        [(_this select 0)] __submoduleVM(vehicle_wreck);
    };
}];

_vehicle addEventHandler ["getout", {
    if ((_this select 1) != "driver" || {(_this select 2) != player}) exitWith {};
    
    67322 cutRsc ["Default", "PLAIN"];
}];