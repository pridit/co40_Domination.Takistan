#define THIS_MODULE perk
#include "x_macros.sqf"
private ["_tier", "_perk"];
PARAMS_2(_tier,_perk);

switch (_tier) do {
    case 0: {
        switch (_perk) do {
            case 1: {
                if (!isNil QMODULE(medical)) then {
                    player setVariable [QGVAR(medkits), (player getVariable QGVAR(medkits)) + 1, true];
                    player setVariable [QGVAR(medkits_max), (player getVariable QGVAR(medkits_max)) + 1, true];
                };
            };
            
            case 2: {
                if (!isNil QMODULE(vehicle_service)) then {
                    player setVariable [QGVAR(repair_kits), (player getVariable QGVAR(repair_kits)) + 1, true];
                    player setVariable [QGVAR(repair_kits_max), (player getVariable QGVAR(repair_kits_max)) + 1, true];
                };
            };
            
            case 3: {
                if (!isNil QMODULE(vehicle_bonus)) then {
                    player setVariable [QGVAR(pilot), true];
                };
            };
            
            case 4: {
                if (!isNil QMODULE(airdrop)) then {
                    player setVariable [QGVAR(airdrop), true];
                    
                    1 setRadioMsg "Call Airdrop";
                };
            };
            
            case 5: {
                if (!isNil QMODULE(backpack)) then {
                    player setVariable [QGVAR(backpack), true];
                };
            };
            
            case 6: {
                if (!isNil QMODULE(vehicle_teleport)) then {
                    player setVariable [QGVAR(teleport), true];
                };
            };
            
            case 7: {
                if (!isNil QMODULE(loadout)) then {
                    player setVariable [QGVAR(loadout), true];
                };
            };
            
            case 8: {
                if (!isNil QMODULE(halo)) then {
                    player setVariable [QGVAR(halo), true];
                };
            };
            
            case 9: {
                if (!isNil QMODULE(vehicle_flip)) then {
                    player setVariable [QGVAR(flip), true];
                };
            };
        };
    };
    
    case 1: {
        switch (_perk) do {
            case 1: {
                if (!isNil QMODULE(artillery)) then {
                    player setVariable [QGVAR(artillery), true];
                    player setVariable [QGVAR(artillery_salvoes), 1];
                    
                    2 setRadioMsg "Call Artillery Strike";
                };
            };
            
            case 2: {
                if (!isNil QMODULE(artillery)) then {
                    player setVariable [QGVAR(artillery_salvoes), 2];
                };
            };
            
            case 3: {
                if (!isNil QMODULE(artillery)) then {
                    player setVariable [QGVAR(artillery_range), GVAR(artillery_range) + 1000];
                };
            };
            
            case 4: {
                if (!isNil QMODULE(artillery)) then {
                    player setVariable [QGVAR(artillery_cooldown), GVAR(artillery_cooldown) - 300];
                };
            };
            
            case 5: {
                if (!isNil QMODULE(artillery)) then {
                    player setVariable [QGVAR(artillery_salvoes), 3];
                };
            };
        };
    };
    
    case 2: {
        switch (_perk) do {
            case 1: {
                if (!isNil QMODULE(vehicle_service)) then {
                    player setVariable [QGVAR(repair_kits), (player getVariable QGVAR(repair_kits)) + 1, true];
                    player setVariable [QGVAR(repair_kits_max), (player getVariable QGVAR(repair_kits_max)) + 1, true];
                };
            };
            
            case 2: {
                if (!isNil QMODULE(vehicle_service)) then {
                    player setVariable [QGVAR(repair_full), true];
                };
            };
            
            case 4: {
                if (!isNil QMODULE(vehicle_service)) then {
                    player setVariable [QGVAR(repair_kits), (player getVariable QGVAR(repair_kits)) + 1, true];
                    player setVariable [QGVAR(repair_kits_max), (player getVariable QGVAR(repair_kits_max)) + 1, true];
                };
            };
        };
    };
    
    case 3: {
        switch (_perk) do {
            case 1: {
                if (!isNil QMODULE(nest)) then {
                    player setVariable [QGVAR(nest), 1];
                    player setVariable [QGVAR(nest_max), 1];
                };
            };
            
            case 2: {
                if (!isNil QMODULE(nest)) then {
                    player setVariable [QGVAR(nest), (player getVariable QGVAR(nest)) + 1];
                    player setVariable [QGVAR(nest_max), (player getVariable QGVAR(nest_max)) + 1];
                };
            };
            
            case 3: {
                if (!isNil QMODULE(nest)) then {
                    player setVariable [QGVAR(nest_cooldown), GVAR(nest_cooldown) - 300];
                };
            };
            
            case 4: {
                if (!isNil QMODULE(nest)) then {
                    player setVariable [QGVAR(nest), (player getVariable QGVAR(nest)) + 1];
                    player setVariable [QGVAR(nest_max), (player getVariable QGVAR(nest_max)) + 1];
                };
            };
            
            case 5: {
                if (!isNil QMODULE(airdrop)) then {
                    player setVariable [QGVAR(airdrop_cooldown), GVAR(airdrop_cooldown) + 900];
                    player setVariable [QGVAR(airdrop_type), "M1A1_US_DES_EP1"];
                };
            };
        };
    };
    
    case 4: {
        switch (_perk) do {
            case 1: {
                if (!isNil QMODULE(trench)) then {
                    player setVariable [QGVAR(trench), 1];
                    player setVariable [QGVAR(trench_max), 1];
                };
            };
            
            case 2: {
                if (!isNil QMODULE(trench)) then {
                    player setVariable [QGVAR(trench), (player getVariable QGVAR(trench)) + 1];
                    player setVariable [QGVAR(trench_max), (player getVariable QGVAR(trench_max)) + 1];
                };
            };
            
            case 3: {
                if (!isNil QMODULE(trench)) then {
                    player setVariable [QGVAR(trench_cooldown), GVAR(trench_cooldown) - 300];
                };
            };
            
            case 4: {
                if (!isNil QMODULE(trench)) then {
                    player setVariable [QGVAR(trench), (player getVariable QGVAR(trench)) + 1];
                    player setVariable [QGVAR(trench_max), (player getVariable QGVAR(trench_max)) + 1];
                };
            };
            
            case 5: {
                if (!isNil QMODULE(airdrop)) then {
                    player setVariable [QGVAR(airdrop_cooldown), GVAR(airdrop_cooldown) + 900];
                    player setVariable [QGVAR(airdrop_type), "M2A2_EP1"];
                };
            };
        };
    };
    
    case 5: {
        switch (_perk) do {
            case 1: {
                if (!isNil QMODULE(mash)) then {
                    player setVariable [QGVAR(mash), 1];
                    player setVariable [QGVAR(mash_max), 1];
                };
            };
            
            case 2: {
                if (!isNil QMODULE(medical)) then {
                    player setVariable [QGVAR(medkits), (player getVariable QGVAR(medkits)) + 1, true];
                    player setVariable [QGVAR(medkits_max), (player getVariable QGVAR(medkits_max)) + 1, true];
                };
            };
            
            case 3: {
                if (!isNil QMODULE(medical)) then {
                    player setVariable [QGVAR(medkits_trade_max), (player getVariable QGVAR(medkits_trade_max)) + 1];
                };
            };
            
            case 4: {
                if (!isNil QMODULE(mash)) then {
                    player setVariable [QGVAR(mash), (player getVariable QGVAR(mash)) + 1];
                    player setVariable [QGVAR(mash_max), (player getVariable QGVAR(mash_max)) + 1];
                };
            };
            
            case 5: {
                if (!isNil QMODULE(medical)) then {
                    player setVariable [QGVAR(medkits), (player getVariable QGVAR(medkits)) + 1, true];
                    player setVariable [QGVAR(medkits_max), (player getVariable QGVAR(medkits_max)) + 1, true];
                };
            };
        };
    };
    
    case 6: {
        switch (_perk) do {
            case 1: {
                if (!isNil QMODULE(airtaxi)) then {
                    player setVariable [QGVAR(air_taxi), true];
                    
                    3 setRadioMsg "Call Air Taxi";
                };
            };
            
            case 5: {
                if (!isNil QMODULE(airdrop)) then {
                    player setVariable [QGVAR(airdrop_cooldown), GVAR(airdrop_cooldown) + 900];
                    player setVariable [QGVAR(airdrop_type), "AH6J_EP1"];
                };
            };
        };
    };
};