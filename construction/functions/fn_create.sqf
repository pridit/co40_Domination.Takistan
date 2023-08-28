#define THIS_MODULE construction
#include "x_macros.sqf"
private ["_name", "_type", "_amount", "_cooldown", "_checks", "_position", "_object"];

PARAMS_1(_name);

_type = call FUNC(THIS_MODULE,type);
_amount = format ["d_%1_%2", QUOTE(THIS_MODULE), toLower (_name)];
_cooldown = format ["d_%1_%2_time_cooldown", QUOTE(THIS_MODULE), toLower (_name)];

_checks = [
    [
        [_name, "constructed", "as you have none left"],
        player getVariable (format [QUOTE(%1), _amount]),
        1
    ] call FUNC(helper,greaterThan),
    
    [
        [_name, "constructed"],
        player getVariable (format [QUOTE(%1), _cooldown])
    ] call FUNC(helper,timeExceeded),
    
    [
        [_name, "constructed"],
        position player,
        markerPos QGVAR(base_south),
        [GVAR(construction_distance_base), "in excess of", "from base"]
    ] call FUNC(helper,distanceFrom),
    
    [
        [_name, "constructed"],
        position player,
        _type,
        [GVAR(construction_distance_identical), "in excess of", "from another"]
    ] call FUNC(helper,nearObject),
    
    [
        [_name, "constructed"]
    ] call FUNC(helper,inAir),

    [
        [_name, "constructed"]
    ] call FUNC(helper,inVehicle)
];

{
    if (typeName _x == "STRING") exitWith {
        hint _x;
    };
} forEach _checks;

if ({str (_x) == "true"} count _checks < count _checks) exitWith {};

_position = player modelToWorld [0, 7, 0];

_object = createVehicle [_type, [_position select 0, _position select 1, -30], [], 0, "CAN_COLLIDE"];
_object setDir ((getDir player) - (call compile (format [QUOTE(%1), format ["d_%1_%2_amount_rotation", QUOTE(THIS_MODULE), toLower (_name)]])));

if !([] call FUNC(client,stall)) exitWith {
    deleteVehicle _object;
};

_object setPos [_position select 0, _position select 1, 0];
_object setVectorUp surfaceNormal _position;

_object setVariable [QGVAR(deconstructing), false];

_object addEventHandler ["HandleDamage", {0}];
_object addAction ["Deconstruct" call FUNC(common,RedText), __function(deconstruct), [_amount, _cooldown], 10, false, true, "", "player == vehicle player && {!(_target getVariable 'd_deconstructing')}"];

if ([typeOf _object, "US_WarfareBVehicleServicePoint_Base_EP1"] call BIS_fnc_areEqual) then {
    [true, "setAmmoCargo", [_object, 0]] call FUNC(network,mp);
};

[gameLogic, "spawn", [[_object], {
    private ["_object"];

    PARAMS_1(_object);

    gameLogic setVariable [
        QGVAR(constructed),
        (gameLogic getVariable QGVAR(constructed)) + [[_object, call FUNC(common,time) + GVAR(construction_time_lifetime)]]
    ];
}]] call FUNC(network,mp);

[_amount, _cooldown] call FUNC(THIS_MODULE,consume);