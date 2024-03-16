#include "x_macros.sqf"
private ["_entity"];

_entity = [_this, 0, GVAR(menu_entity)] call FUNC(common,param);

switch (true) do {
    case (_entity isKindOf "CAManBase" && {isPlayer _entity && {alive _entity}}): {
        [
            "player",
            name _entity,
            getText (configFile >> "CfgVehicles" >> (typeOf _entity) >> "portrait")
        ]
    };

    case (_entity isKindOf "Air");
    case (_entity isKindOf "Car");
    case (_entity isKindOf "StaticWeapon"): {
        [
            "vehicle",
            getText (configFile >> "CfgVehicles" >> (typeOf _entity) >> "displayName"),
            getText (configFile >> "CfgVehicles" >> (typeOf _entity) >> "picture")
        ]
    };

    default {[]};
};