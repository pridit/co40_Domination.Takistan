class XD_TeleportDialog {
    idd = -1;
    movingEnable = false;
    objects[] = {};
    onLoad="uiNamespace setVariable ['X_TELEPORT_DIALOG', _this select 0]; d_teleport = nil";
    onUnLoad="uiNamespace setVariable ['X_TELEPORT_DIALOG', nil]; d_teleport = nil";
    class controlsBackground {
        class RscTeleportBackground: XD_RscPicture
        {
            idc = 1200;
            text = "ca\ui\data\ui_armory_background_ca";
            x = 0.0156243;
            y = 0.15;
            w = 1.23438;
            h = 0.825;
        };
    };
    class controls {
        class RscTeleportMapControl: XD_RscMapControl
        {
            idc = 10000;
            x = 0.0211491;
            y = 0.231735;
            w = 0.710858;
            h = 0.501853;
            onMouseButtonDown = "if !([lbCurSel 1500, -1] call BIS_fnc_areEqual) then {call d_fnc_teleport_populate}";
            onMouseZChanged = "if !([lbCurSel 1500, -1] call BIS_fnc_areEqual) then {call d_fnc_teleport_populate}";
        };
        class RscTeleportListbox: RscListbox
        {
            idc = 1500;
            x = 0.732113;
            y = 0.231735;
            w = 0.243676;
            h = 0.500000;
            sizeEx = 0.023;
            rowHeight = 0.05;
            style = CT_NO_BORDER + ST_LEFT;
            borderSize = 1;
            onLBSelChanged = "[_this select 1] call d_fnc_teleport_switch";
            onLBDblClick = "call d_fnc_teleport_action";
        };
        class RscTeleportButtonAction: XD_ButtonBase
        {
            idc = 2000;
            x = 0.734849;
            y = 0.72744;
            w = 0.237627;
            h = 0.113468;
            text = "No Selection";
            action = "call d_fnc_teleport_action";
        };
        class RscTeleportButtonClose: XD_ButtonBase
        {
            x = 0.03000;
            y = 0.72744;
            w = 0.167627;
            h = 0.113468;
            text = "Close";
            action = "closeDialog 0";
        };
        class RscTeleportTextTitle: X3_RscText
        {
            x = 0.0328292;
            y = 0.148153;
            w = 0.2;
            h = 0.1;
            text = "Fast Travel";
            style = ST_LEFT;
        };
    };
};