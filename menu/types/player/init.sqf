/**
 * Menu - Player Module
 */

#define THIS_MODULE menu_player
#include "x_macros.sqf"

/*
Aid: Drag
Aid: Revive
Inventory: Give Medkit
Inventory: Give Repair Kit
Squad: Join (Bravo)
*/

GVAR(menu_player_action) = [
    format [
        "[%1] %2",
        "Menu" call FUNC(common,BlueText),
        name player
    ] call FUNC(common,GreyText),
    FUNCTION(menu,show),
    player,
    -3,
    false,
    true,
    "",
    "!([[_target] call d_fnc_menu_type, []] call BIS_fnc_areEqual) && {[_target] call d_fnc_menu_player_valid}"
];

__cppfln(FUNC(THIS_MODULE,action),menu\types\player\functions\fn_action.sqf);
__cppfln(FUNC(THIS_MODULE,show),menu\types\player\functions\fn_show.sqf);
__cppfln(FUNC(THIS_MODULE,valid),menu\types\player\functions\fn_valid.sqf);

MODULE(THIS_MODULE) = true;