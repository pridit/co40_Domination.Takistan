#define THIS_MODULE vehicle_menu
#include "x_macros.sqf"
private ["_vehicle"];

PARAMS_1(_vehicle);

disableSerialization;

createDialog "XD_VehicleMenuDialog";

GVAR(vehicle_dialog) = _vehicle;

DIALOG("X_VEHICLE_MENU_DIALOG", 1000) ctrlSetText (getText (configFile >> "cfgVehicles" >> (typeOf _vehicle) >> "displayName"));
DIALOG("X_VEHICLE_MENU_DIALOG", 1201) ctrlSetText (getText (configFile >> "cfgVehicles" >> (typeOf _vehicle) >> "picture"));
DIALOG("X_VEHICLE_MENU_DIALOG", 1202) ctrlSetText (getText (configFile >> "cfgVehicles" >> "USVehicleBox_EP1" >> "icon"));

if (!isNil QMODULE(vehicle_deploy)) then {
    [_vehicle] __submodulePP(vehicle_deploy);
};

if (!isNil QMODULE(vehicle_ammobox)) then {
    [_vehicle] __submodulePP(vehicle_ammobox);
};

if (!isNil QMODULE(vehicle_pack)) then {
    [_vehicle] __submodulePP(vehicle_pack);
};

if (!isNil QMODULE(vehicle_create)) then {
    if ((_vehicle getVariable QGVAR(deployed)) select 0) then {
        [_vehicle] __submodulePP(vehicle_create);
    };
};

if (!isNil QMODULE(vehicle_teleport)) then {
    if ((_vehicle getVariable QGVAR(deployed)) select 0) then {
        [_vehicle] __submodulePP(vehicle_teleport);
    };
};