/*
    File: objectMapper.sqf
    Author: Joris-Jan van 't Land

    Description:
    Takes an array of data about a dynamic object template and creates the objects.

    Parameter(s):
    _this select 0: position of the template - Array [X, Y, Z]
    _this select 1: azimuth of the template in degrees - Number 
    _this select 2: objects for the template - Array / composition class - String / tag list - Array
    _this select 3: (optional) randomizer value (how much chance each object has of being created. 0.0 is 100% chance) - Number

    Returns:
    Created objects (Array)
*/

#define THIS_MODULE server
#include "x_macros.sqf"
private ["_pos", "_azi", "_objs", "_replace"];

if !(isServer) exitWith {};

_pos = [_this, 0, [0, 0]] call FUNC(common,param);
_azi = [_this, 1, 0] call FUNC(common,param);
_objs = _this select 2;

_replace = if (count _this > 3) then {_this select 3} else {[[]]};

private ["_newObjs"];

// See if an object array, specific composition class or tag array was given
private ["_cfgObjectComps", "_script"];

_cfgObjectComps = configFile >> "CfgObjectCompositions";

if ([typeName _objs, "STRING"] call BIS_fnc_areEqual) then {
    //Composition class was given
    _script = getText(_cfgObjectComps >> _objs >> "objectScript");
    
    _objs = [];
} else {
    private ["_testSample"];
    
    _testSample = _objs select 0;

    if !([typeName _testSample, "ARRAY"] call BIS_fnc_areEqual) then {
        // Tag list was given
        private ["_queryTags"];
        
        _queryTags = +_objs;
        _objs = [];
        
        // Make a list of candidates which match all given tags
        private ["_candidates"];
        
        _candidates = [];
        
        for "_i" from 0 to ((count _cfgObjectComps) - 1) do {
            private ["_candidate", "_candidateTags"];
            
            _candidate = _cfgObjectComps select _i;
            _candidateTags = getArray (_candidate >> "tags");
            
            // Are all tags in this candidate?
            if ([{_x in _candidateTags} count _queryTags, count _queryTags] call BIS_fnc_areEqual) then {
                _candidates = _candidates + [getText (_candidate >> "objectScript")];
            };
        };
        
        // Select a random candidate
        _script = _candidates select (floor (random (count _candidates)));
    };
};

// If the object array is in a script, call it
if !(isNil "_script") then {
    _objs = call (compile (preprocessFileLineNumbers _script));
};

// Make sure there are definitions in the final object array
if ([count _objs, 0] call BIS_fnc_areEqual) exitWith {[]};

if (count _replace > 0) then {
    {
        private ["_new"];

        _new = _x;
        
        {
            if ([_x select 0, _new select 0] call BIS_fnc_areEqual) then {
                _x set [0, if (count _new > 1) then {_new select 1} else {""}];

                if ([count _new, 3] call BIS_fnc_areEqual) then {
                    _x set [2, (_x select 2) + (_new select 2)];
                };
            };
        } forEach _objs;
    } forEach _replace;
};

_newObjs = [];

private ["_posX", "_posY"];

_posX = _pos select 0;
_posY = _pos select 1;

// Function to multiply a [2, 2] matrix by a [2, 1] matrix
private ["_multiplyMatrixFunc"];

_multiplyMatrixFunc = {
    private ["_array1", "_array2", "_result"];
    
    _array1 = _this select 0;
    _array2 = _this select 1;

    _result = [
        (((_array1 select 0) select 0) * (_array2 select 0)) + (((_array1 select 0) select 1) * (_array2 select 1)),
        (((_array1 select 1) select 0) * (_array2 select 0)) + (((_array1 select 1) select 1) * (_array2 select 1))
    ];

    _result
};

if !(isNil QMODULE(tent)) then {
    {
        private ["_tent"];

        _tent = _x call FUNC(tent,handle);

        if (count _tent > 0) then {
            [_objs, _tent] call BIS_fnc_arrayPushStack;
        };
    } forEach _objs;
};

{
    private ["_type", "_relPos", "_azimuth", "_fuel", "_damage", "_newObj"];
    
    _type = _x select 0;
    _relPos = _x select 1;
    _azimuth = _x select 2;
    
    if !(_type in GVAR(server_objects_banned) || {[_x select 0, ""] call BIS_fnc_areEqual}) then {
        if ((count _x) > 3) then {_fuel = _x select 3};
        if ((count _x) > 4) then {_damage = _x select 4};

        // Rotate the relative position using a rotation matrix
        private ["_rotMatrix", "_newRelPos", "_newPos"];
        
        _rotMatrix = [
            [cos _azi, sin _azi],
            [-(sin _azi), cos _azi]
        ];

        if (_relPos select 2 > 0.5 && {[_type, "Fort_Crate_wood"] call BIS_fnc_areEqual}) exitWith {};
        
        _newRelPos = [_rotMatrix, _relPos] call _multiplyMatrixFunc;
        _newPos = [_posX + (_newRelPos select 0), _posY + (_newRelPos select 1), 0];

        // Create the object and make sure it's in the correct location
        _newObj = createVehicle [_type, _newPos, [], 0, "CAN_COLLIDE"];
        _newObj setDir (_azi + _azimuth);
        _newObj setPos _newPos;

        switch (true) do {
            case (_newObj isKindOf "StaticWeapon"): {
                _newObj addMPEventHandler ["MPKilled", {
                    private ["_unit", "_killer"];

                    PARAMS_2(_unit, _killer);

                    if !(isServer) exitWith {};
                    if !(isPlayer _killer) exitWith {};
                    if ([side _unit, west] call BIS_fnc_areEqual) exitWith {};

                    _killer addScore -2;
                }];
            };

            case (_newObj isKindOf "Thing"): {
                [true, "enableSimulation", [_newObj, false], false] call FUNC(network,mp);
            };

            case ([typeOf _newObj, "ZavoraAnim"] call BIS_fnc_areEqual): {
                _newObj animate ["bargate", 1];
            };
        };

        if !(isNil QMODULE(item)) then {
            {
                [_newObjs, _x] call BIS_fnc_arrayPush;
            } forEach ([_newObj] call FUNC(item,create));
        };
        
        // If fuel and damage were grabbed, map them
        if (!isNil "_fuel") then {_newObj setFuel _fuel};
        if (!isNil "_damage") then {_newObj setDamage _damage;};

        if (_newObj isKindOf "LandVehicle") then {
            if ([faction _newObj, "BIS_US"] call BIS_fnc_areEqual) then {
                _newObj lock true;

                if !(_newObj isKindOf "StaticWeapon") then {
                    _newObj allowCrewInImmobile true;

                    _newObj addEventHandler ["Fired", {(_this select 0) setVehicleAmmo 1}];
                };

                _newObj addEventHandler ["HandleDamage", {0}];

                if !(isNil QMODULE(menu_vehicle)) then {
                    _newObj setVariable [QGVAR(menu), false, true];
                };
            };

            [true, "execVM", [[_newObj], FUNCTION(vehicle,handle)], false] call FUNC(network,mp);

            __addDead(_newObj);
        };

        [_newObjs, _newObj] call BIS_fnc_arrayPush;
    };
} forEach _objs;

_newObjs