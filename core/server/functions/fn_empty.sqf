#define THIS_MODULE server
#include "x_macros.sqf"

({alive _x} count (crew _this)) == 0;