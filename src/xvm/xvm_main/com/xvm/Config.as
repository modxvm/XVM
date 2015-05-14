/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm
{
    import com.xfw.*;
    import com.xvm.types.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;

    public class Config
    {
        public static var networkServicesSettings:NetworkServicesSettings = new NetworkServicesSettings({});

        // instance
        private static var _instance:Config = null;
        private static function get instance():Config
        {
            if (_instance == null)
                _instance = new Config();
            return _instance;
        }

        public static function get config():CConfig
        {
            return instance._config;
        }

        public static function setConfig(value:CConfig):void
        {
            instance._config = value;
        }

        public static function get gameRegion():String
        {
            return config.region;
        }

        public static function get language():String
        {
            return config.language;
        }

        public static function get stateInfo():Object
        {
            return instance._stateInfo;
        }

        // PRIVATE

        private var _config:CConfig;
        private var _stateInfo:Object;

        function Config()
        {
            _config = null;
            _stateInfo = { };
        }
    }
}
