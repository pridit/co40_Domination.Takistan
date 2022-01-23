/**
 * Core Module - Common (client & server)
 */

#define THIS_MODULE common
#include "x_macros.sqf"

GVAR(modules) = [
    "3d",
    "admin",
    "airdrop",
    "airtaxi",
    "ammobox",
    "artillery",
    "backpack",
    "base",
    "base_ammobox",
    "base_bonus",
    "base_halo",
    "base_protect",
    "base_rd",
    "base_wreck",
    "cleanup",
    "communication",
    "construction",
    "crossroad",
    // "debug",
    "diary",
    "drag",
    "farp",
    "fortification",
    "gesture",
    "halo",
    "heap",
    // "idle",
    "ied",
    "intel",
    "inventory",
    "loadout",
    "marker",
    "mash",
    "medical",
    "mission_main",
    "mission_mini",
    "mission_mini\missions\abandoned",
    "mission_mini\missions\encampment",
    // "mission_side",
    // "mission_side\missions\crash",
    "name",
    "nest",
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
    "spectate",
    "squad",
    "task",
    "teleport",
    "uav",
    "unit",
    "vehicle",
    "vehicle_3d",
    "vehicle_abandon",
    "vehicle_ammobox",
    "vehicle_bonus",
    "vehicle_create",
    "vehicle_deploy",
    "vehicle_flip",
    "vehicle_fob",
    "vehicle_lift",
    "vehicle_load",
    "vehicle_loadout",
    "vehicle_marker",
    "vehicle_pack",
    "vehicle_menu",
    "vehicle_mhq",
    "vehicle_protection",
    "vehicle_repair",
    "vehicle_respawn",
    "vehicle_service",
    "vehicle_teleport",
    // "vehicle_tow",
    "vehicle_welcome",
    "vehicle_wreck",
    // "video",
    "weather"
];

{
    __module(_x);
} forEach GVAR(modules);

__log format ["%1 modules initialized", count GVAR(modules)]];