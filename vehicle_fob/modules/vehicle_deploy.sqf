/**
 * Vehicle FOB Module - Vehicle Deploy Submodule
 */

#include "x_macros.sqf"
private ["_vehicle", "_state"];

PARAMS_2(_vehicle, _state);

switch (_state) do {
    case true: {
        _vehicle setVariable [QGVAR(cleanup), []];
        
        _vehicle spawn {
            {
                _this animate [_x, 1]
            } forEach [
                "door_1",
                "door_2_1",
                "door_2_2",
                "ramp_top",
                "ramp_bottom"
            ];
            
            sleep 3;
            
            [true, "enableSimulation", [_this, false]] call FUNC(network,mp);
            
            if (!isNil QMODULE(ammobox)) then {
                _box = [
                    _this modelToWorld [0, -5.5, -4.95],
                    direction _this,
                    false
                ] call FUNC(ammobox,create);
                
                _pitchBank = _this call BIS_fnc_getPitchBank;
                
                [_box, (_pitchBank select 0) + 10, _pitchBank select 1] call BIS_fnc_setPitchBank;
                
                _this setVariable [QGVAR(cleanup), (_this getVariable QGVAR(cleanup)) + [_box]];
            };
            
            _heli = createVehicle ["HeliH", _this modelToWorld [-18, 15, 0], [], 0, "CAN_COLLIDE"];
            _heli setDir ((getDir _this) - 180);
            _heli setPos (_this modelToWorld [-18, 15, 0]);
            
            _objects = [
                _this modelToWorld [-7.2, 2, 0],
                (direction _this) - 90,
                "SmallBase_EP1",
                [
                    ["Land_CamoNetVar_NATO_EP1", "MtvrRepair_DES_EP1"],
                    ["Paleta2", "FlagCarrierUSA_EP1"]
                ]
            ] call FUNC(server,objectMapper);
            
            _group = [
                position _this,
                west,
                (configFile >> "CfgGroups" >> "West" >> "BIS_US" >> "Infantry" >> "US_TeamSupport")
            ] call FUNC(server,spawnGroup);
            
            if (!isNil QMODULE(unit)) then {
                [_group, position _this] call FUNC(unit,defend);
            };
            
            _this setVariable [QGVAR(cleanup), (_this getVariable QGVAR(cleanup)) + [_heli] + _objects + (units _group)];
        };
    };

    case false: {
        _vehicle spawn {
            [_this] call FUNC(vehicle_deploy,cleanup);
            
            waitUntil {{!isNull _x} count (_this getVariable QGVAR(cleanup)) < 1};
            
            [true, "enableSimulation", [_this, true]] call FUNC(network,mp);
            
            {
                _this animate [_x, 0]
            } forEach [
                "door_1",
                "door_2_1",
                "door_2_2",
                "ramp_top",
                "ramp_bottom"
            ];
        };
    };
};