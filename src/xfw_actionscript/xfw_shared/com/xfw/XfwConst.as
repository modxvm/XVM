/**
 * XFW
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xfw
{
    public class XfwConst
    {
        // PUBLIC

        // UI Colors
        public static const UICOLOR_LABEL:uint = 0xA19D95;
        public static const UICOLOR_VALUE:uint = 0xC9C9B6;
        public static const UICOLOR_LIGHT:uint = 0xFDF4CE;
        public static const UICOLOR_DISABLED:uint = 0x4C4A47;
        public static const UICOLOR_GOLD:uint = 0xFFC133;
        public static const UICOLOR_GOLD2:uint = 0xCBAD78;
        public static const UICOLOR_SPECIAL:uint = 0xFE7903;
        public static const UICOLOR_BLUE:uint = 0x408CCF;

        public static const UICOLOR_TEXT1:uint = 0xE1DDCE;
        public static const UICOLOR_TEXT2:uint = 0xB4A983;
        public static const UICOLOR_TEXT3:uint = 0x9F9260;

        // ColorPalette
        public static const C_WHITE:String = "0xFCFCFC";
        public static const C_RED:String = "0xFE0E00";
        public static const C_ORANGE:String = "0xFE7903";
        public static const C_YELLOW:String = "0xF8F400";
        public static const C_GREEN:String = "0x60FF00";
        public static const C_BLUE:String = "0x02C9B3";
        public static const C_PURPLE:String = "0xD042F3";
        public static const C_MAGENTA:String = "0xEE33FF";
        public static const C_GREENYELLOW:String = "0x99FF44";
        public static const C_REDSMOOTH:String = "0xDD4444";
        public static const C_REDBRIGHT:String = "0xFF0000";

        // Team
        public static const TEAM_ALLY:int = 1;
        public static const TEAM_ENEMY:int = 2;

        // Public Commands
        public static const XFW_COMMAND_GETGAMEREGION:String = "xfw.gameRegion";
        public static const XFW_COMMAND_GETGAMELANGUAGE:String = "xfw.gameLanguage";
        public static const XFW_COMMAND_CALLBACK:String = "xfw.callback";
        // args: title, message
        public static const XFW_COMMAND_MESSAGEBOX:String = 'xfw.messageBox';
        // args: message, type
        // Types: gui.SystemMessages.SM_TYPE: 'Error', 'Warning', 'Information', 'GameGreeting', ...
        public static const XFW_COMMAND_SYSMESSAGE:String = 'xfw.systemMessage';

        // INTERNAL

        // Events
        internal static const XFW_EVENT_CMD_RECEIVED:String = "xfw.cmd_rvcd";

        // Internal Commands
        // Flash -> Python
        internal static const XFW_COMMAND_LOG:String = "xfw.log";
        internal static const XFW_COMMAND_GETMODS:String = "xfw.getMods";
        internal static const XFW_COMMAND_INITIALIZED:String = "xfw.initialized";
        internal static const XFW_COMMAND_SWF_LOADED:String = "xfw.swf_loaded";
        internal static const XFW_COMMAND_LOADFILE:String = "xfw.loadFile";

        // res_mods/configs/
        public static const XFW_CONFIGS_DIR_NAME:String = "res_mods/configs/";
        // res_mods/mods/shared_resources/
        public static const XFW_RESOURCES_DIR_NAME:String = "res_mods/mods/shared_resources/";
        // ../../../res_mods/mods/xfw_packages/
        public static const XFW_PACKAGES_PATH:String = "../../../res_mods/mods/xfw_packages/";

        // swf load status
        public static const SWF_START_LOADING:int = 1;
        public static const SWF_LOADING:int = 2;
        public static const SWF_LOAD_ERROR:int = 3;
        public static const SWF_LOADED:int = 4;
    }
}
