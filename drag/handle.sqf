/**
 * Drag Module (Handler)
 */

#include "x_macros.sqf"

if (hasInterface) then {
    [true, "addAction", [player, GVAR(drag_player_action)]] call FUNC(network,mp);
};