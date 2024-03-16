/**
 * Revive Module (Handler)
 */

#define THIS_MODULE revive
#include "x_macros.sqf"

if (hasInterface) then {
    if !(isNil QMODULE(conversation)) then {
        player kbAddTopic ["Medic", format ["conversation\speech\%1.bikb", QUOTE(THIS_MODULE)]];
    };

    [true, "addAction", [player, [
        "Debug" call FUNC(common,GreyText),
        FUNCTION(THIS_MODULE,debug),
        [],
        10,
        false,
        true,
        "",
        "_this != _target && {serverCommandAvailable '#logout'}"
    ]]] call FUNC(network,mp);
};