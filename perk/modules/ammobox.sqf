/**
 * Perk Module - Ammobox Submodule
 */

#define THIS_MODULE perk
#include "x_macros.sqf"
private ["_box"];

PARAMS_1(_box);

if (!isNil QMODULE(loadout)) then {
    _box addAction ["Save loadout" call FUNC(common,YellowText), FUNCTION(loadout,save), [], 10, false, true, "", "player getVariable 'd_loadout' && {primaryWeapon player != ''}"];
    _box addAction ["Clear loadout" call FUNC(common,YellowText), FUNCTION(loadout,clear), [], 9, false, true, "", "player getVariable 'd_loadout' && {!isNil 'd_loadout' && {count d_loadout > 0}}"];
};