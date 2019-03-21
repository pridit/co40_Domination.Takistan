/**
 * Core Module - Common (client & server)
 */

#define THIS_MODULE common
#include "x_macros.sqf"

X_MP = isMultiplayer;
X_CLIENT = !isDedicated;
X_SERVER = isServer;

X_JIP = false;
X_SPE = false;
X_INIT = false;

#define __waitpl 0 spawn {scriptName "spawn_WaitForNotIsNullPlayer";waitUntil {!isNull player};X_INIT = true}
if (isServer) then {
    if (!isDedicated) then {
        X_SPE = true;
        __waitpl;
    } else {
        X_INIT = true;
    };
} else {
    if (isNull player) then {
        X_JIP = true;
        __waitpl;
    } else {
        X_INIT = true;
    };
};

__ccppfln(core\THIS_MODULE\scripts\common.sqf);

__cppfln(FUNC(THIS_MODULE,objectMapper),ca\modules\dyno\data\scripts\objectMapper.sqf);

if (isServer) then {
    __core(server);
};

__ccppfln(core\THIS_MODULE\modules.sqf);

QGVAR(base_marker) setMarkerAlphaLocal 0;

skipTime 5;

GVAR(init_processed) = true;