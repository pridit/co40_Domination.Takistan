/**
 * Core Module - Common (client & server)
 */

#define THIS_MODULE common
#include "x_macros.sqf"

GVAR(modules) = [
    "3d",
    "admin",
    "admin_spectate",
    "airdrop",
    "airtaxi",
    "ammobox",
    "artillery",
    "backpack",
    "base_ammobox",
    "base_bonus",
    "base_defense",
    "base_halo",
    "base_protection",
    "base_rd",
    "base_wreck",
    "cleanup",
    "communication",
    "construction",
    ["construction_farp", "construction\types\farp"],
    ["construction_fortification", "construction\types\fortification"],
    ["construction_mash", "construction\types\mash"],
    ["construction_nest", "construction\types\nest"],
    "conversation",
    "damage",
    "debug",
    "diary",
    "drag", // TODO: Refactor (just slight cleanup, re-check #34)
    "event",
    ["event_checkpoint", "event\types\checkpoint"],
    ["event_tower", "event\types\tower"],
    "gear",
    "gesture",
    "halo",
    "heap",
    // "idle",
    "ied",
    "inventory",
    ["inventory_medical", "inventory\types\medical"],
    ["inventory_refuel", "inventory\types\refuel"],
    ["inventory_repair", "inventory\types\repair"],
    "item",
    ["item_evidence", "item\types\evidence"],
    ["item_money", "item\types\money"],
    "loadout",
    "marker",
    "medical",
    "menu",
    ["menu_player", "menu\types\player"],
    ["menu_vehicle", "menu\types\vehicle"],
    // "mission_main",
    "mission_mini",
    ["mission_mini_abandoned", "mission_mini\types\abandoned"],
    ["mission_mini_cache", "mission_mini\types\cache"],
    ["mission_mini_encampment", "mission_mini\types\encampment"],
    "name",
    "option",
    "perimiter",
    "perk",
    "profile",
    "rd",
    "respawn",
    "revive",
    "reward",
    "setting",
    "shield",
    "squad",
    "task",
    "teleport",
    "tent",
    "tutorial",
    "uav",
    "unit",
    "vehicle",
    "vehicle_3d",
    "vehicle_abandon",
    "vehicle_ammobox",
    // "vehicle_bomber",
    "vehicle_bonus",
    // "vehicle_cargo", // TODO: Refactor (legacy RE use, possible dupe vector, tie with vehicle menu)
    "vehicle_create",
    "vehicle_deploy",
    "vehicle_fob",
    "vehicle_lift",
    "vehicle_loadout",
    "vehicle_marker",
    "vehicle_pack",
    "vehicle_mhq",
    "vehicle_ramp",
    "vehicle_refuel",
    "vehicle_repair",
    "vehicle_respawn",
    "vehicle_service",
    "vehicle_teleport",
    "vehicle_texture",
    // "vehicle_tow", // TODO: Refactor (legacy RE use, buggy actions)
    "vehicle_unflip",
    "vehicle_wreck",
    "vote",
    "weather"
];

{
    if ([typeName _x, "ARRAY"] call BIS_fnc_areEqual) then {
        _x = _x select 1;
    };

    __module(_x);
} forEach GVAR(modules);

__log format ["%1 modules initialized", count GVAR(modules)]];