#include "x_macros.sqf"
private ["_sound", "_perk"];

GVAR(healing) = true;

player setVariable [QGVAR(medkits), (player getVariable QGVAR(medkits)) - 1, true];
player playMove "AinvPknlMstpSlayWrflDnon_medic";

sleep 6;

player setDamage 0;

GVAR(healing) = false;