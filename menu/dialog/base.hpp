// $[1.03,[[0,0,1,1],0.01125,0.01],[1200,"",[0,"\ca\ui\data\ui_gameoptions_background_ca",[0.311555,0.212878,0.395518,0.650505],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],""],[]],[1700,"",[0,"OK",[0.511875,0.66,0.162563,0.110005],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],""],[]],[1500,"",[0,"",[0.315024,0.278248,0.364848,0.32316],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],""],[]],[1000,"",[0,"",[0.323231,0.22987,0.286869,0.0455628],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],""],[]],[1100,"",[0,"",[0.315656,0.603896,0.365151,0.0705628],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],""],[]],[1201,"",[0,"#(argb,8,8,3)color(1,1,1,1)",[0.377682,0.308441,0.252778,0.262771],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],""],[]],[1701,"",[0,"Close",[0.32625,0.66,0.162563,0.110005],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],""],[]]]
class XD_MenuDialog {
    idd = -1;
    movingEnable = 1;
    onLoad = "uiNamespace setVariable ['X_MENU_DIALOG', _this select 0]";
    onUnLoad = "uiNamespace setVariable ['X_MENU_DIALOG', nil]";
    objects[] = {};
    class controlsBackground {
        class MenuDialogBackground: XD_RscPicture
        {
            x = 0.311555;
            y = 0.212878;
            w = 0.395518;
            h = 0.650505;
            text = "ca\ui\data\ui_gameoptions_background_ca";
        };
    };
    class controls {
        class MenuEntityPicture: XD_RscPicture
        {
            idc = 1201;
            style = ST_MULTI + ST_TITLE_BAR + ST_KEEP_ASPECT_RATIO;
            x = 0.377682;
            y = 0.308441;
            w = 0.252778;
            h = 0.262771;
            colorText[] = {0.6,0.5,0.3,0.3};
        };
        class MenuActionListbox: RscListBox
        {
            idc = 1500;
            style = CT_NO_BORDER + ST_LEFT;
            x = 0.315024;
            y = 0.278248;
            w = 0.364848;
            h = 0.32316;
            sizeEx = 0.025;
            rowHeight = 0.064;
            borderSize = 1;
            onLBSelChanged = "((uiNamespace getVariable ""X_MENU_DIALOG"") displayCtrl 1700) ctrlEnable true";
            onLBDblClick = "call d_fnc_menu_action";
        };
        class MenuTitleText: X3_RscText
        {
            idc = 1000;
            style = ST_LEFT;
            x = 0.323231;
            y = 0.22987;
            w = 0.286869;
            h = 0.0455628;
        };
        class MenuActionButton: XD_ButtonBase
        {
            idc = 1700;
            x = 0.511875;
            y = 0.66;
            w = 0.162563;
            h = 0.110005;
            text = "OK";
            action = "call d_fnc_menu_action";
        };
        class MenuCloseButton: XD_ButtonBase
        {
            x = 0.32625;
            y = 0.66;
            w = 0.162563;
            h = 0.110005;
            text = "Close";
            action = "closeDialog 0";
        };
        class MenuAdditionalText: BBRscStructuredText
        {
            idc = 1100;
            x = 0.315656;
            y = 0.603896;
            w = 0.365151;
            h = 0.0705628;
            size = 0.025;
            colorBackground[] = {0.173, 0.157, 0.094, 0.75};
        };
    };
};