/**
 * Task Module
 *
 * Description: This module handles the creation & persistence of tasks for
 * connected & JIP clients.
 */

#define THIS_MODULE task
#include "x_macros.sqf"

if (isServer) then {
    X_JIPH setVariable [QGVAR(tasks), [], true];
};

__cppfln(FUNC(THIS_MODULE,create),THIS_MODULE\functions\fn_create.sqf);
__cppfln(FUNC(THIS_MODULE,delete),THIS_MODULE\functions\fn_delete.sqf);
__cppfln(FUNC(THIS_MODULE,get),THIS_MODULE\functions\fn_get.sqf);
__cppfln(FUNC(THIS_MODULE,hint),THIS_MODULE\functions\fn_hint.sqf);
__cppfln(FUNC(THIS_MODULE,state),THIS_MODULE\functions\fn_state.sqf);

MODULE(THIS_MODULE) = true;