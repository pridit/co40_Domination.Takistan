/**
 * Core Module - Common (client & server)
 */

#include "x_macros.sqf"
private ["_modules"];

_modules = [
    "weather",
    "airdrop",
    "airtaxi",
    "ammobox",
    "artillery",
    "backpack",
    "base",
    "base_ammobox",
    "base_backpack",
    "base_halo",
    "base_service",
    "base_shield",
    "base_teleport",
    "base_wreck",
    "board",
    "communication",
    "crossroad",
    "halo",
    "inventory",
    "loadout",
    "marker",
    "medical",
    "option",
    "perk",
    "squad",
    "teleport",
    "vehicle",
    "vehicle_ammobox",
    "vehicle_bonus",
    "vehicle_create",
    "vehicle_flip",
    "vehicle_lift",
    "vehicle_menu",
    "vehicle_mhq",
    "vehicle_protection",
    "vehicle_respawn",
    "vehicle_service",
    "vehicle_teleport",
    "vehicle_welcome",
    "vehicle_wreck"
];

{
    __module(_x);
} forEach _modules;