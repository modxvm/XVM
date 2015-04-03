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

        // Load XVM mod config
        public static function load():void
        {
            instance.loadConfig();
        }

        // PRIVATE

        private var _config:CConfig;
        private var _stateInfo:Object;

        function Config()
        {
            _config = null;
            _stateInfo = { };
        }

        // Load XVM mod config; config data is shared between all instances, so
        // it should be loaded only once per session.
        private function loadConfig():void
        {
            loadXvmXc();
            loadGameRegion();
            loadLanguage();
            VehicleInfo.populateData();
            setConfigLoaded();
        }

        // STAGE 1 - xvm.xc

        private function loadXvmXc():void
        {
            //Logger.add("TRACE: STAGE 1: loadXvmXc()");
            try
            {
                var autoReloadConfig:Boolean = _config == null ? false : _config.autoReloadConfig;

                _config = DefaultConfig.config;

                var res:* = JSONxLoader.Load(Defines.XVM_CONFIG_FILE_NAME);

                //Logger.addObject(res, 2);

                var e:Error = res as Error;
                if (e != null)
                {
                    _config.autoReloadConfig = autoReloadConfig;
                    if (res.type == "NO_FILE")
                    {
                        _stateInfo = { warning: "" };
                        Logger.add("[XVM] WARNING: xvm.xc was not found, using the built-in config");
                    }
                    else
                    {
                        var text:String = res.filename ? "Error parsing file " + res.filename.replace(Defines.XVM_CONFIGS_DIR_NAME, '') + ":\n" : "";
                        text += ConfigUtils.parseErrorEvent(e);

                        _stateInfo = { error: text };
                        Logger.add(text);
                    }
                }
                else
                {
                    _stateInfo = { };
                    _config = ConfigUtils.MergeConfigs(ConfigUtils.FixConfig(res), config);
                    //Logger.addObject(_config, 2);
                    //Logger.addObject(_config.markers.enemy.alive.normal, 3);
                }
                ConfigUtils.TuneupConfig(_config);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // STAGE 2 - Game Region

        private function loadGameRegion():void
        {
            //Logger.add("TRACE: STAGE 2: loadGameRegion()");
            try
            {
                _config.regionDetected = (_config.region.toLowerCase() == Defines.REGION_AUTO_DETECTION);
                if (_config.regionDetected)
                    _config.region = Xfw.cmd(XfwConst.XFW_COMMAND_GETGAMEREGION);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // STAGE 3

        private function loadLanguage():void
        {
            //Logger.add("TRACE: STAGE 3: loadLanguage()");
            try
            {
                //Logger.add("TRACE: STAGE 3: loadLanguage()");
                _config.languageDetected = _config.language.toLowerCase() == Defines.LOCALE_AUTO_DETECTION
                if (_config.languageDetected)
                    _config.language = Xfw.cmd(XfwConst.XFW_COMMAND_GETGAMELANGUAGE);
                Locale.LoadLocaleFile();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // All done

        private function setConfigLoaded():void
        {
            try
            {
                //if (e.result != null && e.result.error != null && _stateInfo.error == null)
                //    _stateInfo = { error: e.result.error };

                Logger.add(Sprintf.format("Config loaded. Region: %s (%s), Language: %s (%s)",
                    _config.region,
                    _config.regionDetected ? "detected" : "config",
                    _config.language,
                    _config.languageDetected ? "detected" : "config"));
                //Logger.addObject(_config, "config", 10);

                Xfw.cmd(XvmCommandsInternal.SET_CONFIG, JSONx.stringify(Config.config, '', true), JSONx.stringify(Locale.s_lang, '', true));
                Xvm.dispatchEvent(new Event(Defines.XVM_EVENT_CONFIG_LOADED));
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
