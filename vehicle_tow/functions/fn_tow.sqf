/**
 * Original Author: rundll.exe
 *
 * Description:
 * Generic Towing script 
 */

#define THIS_MODULE vehicle_tow
#include "x_macros.sqf"
private ["_vehicle", "_tow"];

PARAMS_1(_vehicle);

if (!isServer) exitWith {
    tow = _this;
    publicVariableServer "tow";
};

_tow = _this select 3;

_tow setVariable [QGVAR(towed), true, true];
_vehicle setVariable [QGVAR(towing), _tow, true];

_offset = [_tow] call FUNC(THIS_MODULE,offset);
_axis = (_offset select 0) + [0];
_wheel = (_offset select 1) + [0];

while {alive _tow && {_tow getVariable QGVAR(towed)}} do {
    _aTpos = _vehicle modelToWorld [0, -2, 0];
    _aPpos = _tow modelToWorld _axis;
    _wheelPpos = _tow modelToWorld _wheel;
    
    //get the x and y length of the difference vector
    _dx_axis = (_aTpos select 0) - (_aPpos select 0);
    _dy_axis = (_aTpos select 1) - (_aPpos select 1);		
    _d_axis = sqrt(_dx_axis^2 + _dy_axis^2);//absolute length of diff vector
    
    if (_d_axis > 0.05) then {		
        //get global distance between the T axis and P wheelpos
        _dx = (_aTpos select 0) - (_wheelPpos select 0);
        _dy = (_aTpos select 1) - (_wheelPpos select 1);		
        _dirdeg = _dx atan2 _dy; //convert to direction in deg
        
        [_tow, [_dx, _dy, 0]] call FUNC(network,setVectorDir); //set the direction of P, preserving pitch and bank
        
        //velocity implementation (smoother but elastic)		
        _dirdeg_axis = _dx_axis atan2 _dy_axis;	//get the direction of the difference vector						
        _speed = _d_axis * 4; //control the speed needed to make this distance smaller TWEAK HERE	Higher value means less elasticty, but more choppy.
        _speed = _speed min 15; //set max speed for safety.
        _Pvel = velocity _tow;
        
        sleep 0.1;
        
        [_tow, [
            (sin _dirdeg_axis * _speed),
            (cos _dirdeg_axis * _speed),
            (_Pvel select 2)
        ]] call FUNC(network,setVelocity); //set the velocity in the correct direction
        
        [nil, nil, rExecVM, FUNCTION(vehicle,speed), _vehicle, GVAR(vehicle_tow_amount_speed)] call RE;
    };
};

[nil, _vehicle, "per", rRemoveAction, "vehicleDetach"] call RE;