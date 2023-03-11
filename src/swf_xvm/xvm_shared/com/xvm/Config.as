/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm
{
    import com.xfw.*;
    import com.xvm.types.*;
    import com.xvm.types.cfg.*;

    public class Config
    {
        private static var _IS_DEVELOPMENT:Boolean = false;
        private static var s_config:CConfig = null;
        private static var s_networkServicesSettings:NetworkServicesSettings = new NetworkServicesSettings({});

        public static function get IS_DEVELOPMENT():Boolean
        {
            return _IS_DEVELOPMENT;
        }

        public static function setIsDevelopment(value:Boolean):void
        {
            _IS_DEVELOPMENT = value;
        }

        public static function get config():CConfig
        {
            return s_config;
        }

        public static function setConfig(value:CConfig):void
        {
            s_config = value;
        }

        public static function get networkServicesSettings():NetworkServicesSettings
        {
            return s_networkServicesSettings;
        }

        public static function setNetworkServicesSettings(value:NetworkServicesSettings):void
        {
            s_networkServicesSettings = value;
            Macros.RegisterXvmServicesMacrosData();
        }

        public static function applyGlobalMacros():void
        {
            s_config.applyGlobalMacros();
        }
    }
}
