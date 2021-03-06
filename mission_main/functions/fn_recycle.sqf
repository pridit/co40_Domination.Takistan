#define THIS_MODULE mission_main
#include "x_macros.sqf"
private ["_target"];

PARAMS_1(_target);

_time = GVAR(mission_main_time_recycle) + call FUNC(common,time);

waitUntil {sleep 5; _time < call FUNC(common,time)};

[_target] call FUNC(THIS_MODULE,cleanup);

[true, "spawn", [[_target], {
    private ["_target", "_name", "_description"];

    PARAMS_1(_target);

    if (!isNil QMODULE(task)) then {
        {
            player removeSimpleTask ([_x select 0] call FUNC(task,get));
        } forEach (_target getVariable QGVAR(tasks));
    };
}]] call FUNC(network,mp);

if (!isNil QMODULE(task)) then {
    {
        [_x select 0] call FUNC(task,delete);
    } forEach (_target getVariable QGVAR(tasks));
};

if (!isNil QMODULE(marker)) then {
    [format ["mission_main_%1", _target getVariable "name"]] call FUNC(marker,delete);
    
    if (!isNil QMODULE(teleport)) then {
        _name = format ["teleport_%1", _target getVariable "name"];
        
        [_name] call FUNC(marker,delete);
    };
};

GVAR(mission_main_targets) = GVAR(mission_main_targets) + [_target];

__log format ["Recycled %1", _target getVariable "name"]];