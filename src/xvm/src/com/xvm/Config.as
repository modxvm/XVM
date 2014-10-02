/**
 * XVM Config
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package com.xvm
{
    import com.xvm.*;
    import com.xvm.events.*;
    import com.xvm.io.*;
    import com.xvm.misc.*;
    import com.xvm.utils.*;
    import com.xvm.types.cfg.*;

    public class Config
    {
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
            return instance.config;
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
            return instance.stateInfo;
        }

        // Load XVM mod config
        public static function load():void
        {
            instance.loadConfig();
        }

        // PRIVATE

        private var config:CConfig;
        private var stateInfo:Object;

        function Config()
        {
            config = null;
            stateInfo = { };
        }

        // Load XVM mod config; config data is shared between all instances, so
        // it should be loaded only once per session.
        private function loadConfig():void
        {
            loadXvmXc();
            loadGameRegion();
            loadLanguage();
            setConfigLoaded();
        }

        // STAGE 1 - xvm.xc

        private function loadXvmXc():void
        {
            //Logger.add("TRACE: STAGE 1: loadXvmXc()");
            try
            {
                this.config = DefaultConfig.config;
                var res:Object = JSONxLoader.Load(Defines.XVM_CONFIG_FILE_NAME);

                //Logger.addObject(res, 2);

                if (res is Error)
                {
                    var e:Object = res.inner ? res.inner : res;
                    if (e.type == "NO_FILE")
                    {
                        stateInfo = { warning: "" };
                    }
                    else
                    {
                        var text:String = e.message + ": ";
                        text += ConfigUtils.parseErrorEvent(e.error);

                        stateInfo = { error: text };
                        Logger.add(text);
                    }
                    return;
                }

                config = ConfigUtils.MergeConfigs(ConfigUtils.FixConfig(res), config);

                //Logger.addObject(config, "config", 2);
                //Logger.addObject(config.markers.enemy.alive.normal, "", 3);
                stateInfo = { };

                ConfigUtils.TuneupConfig(config);
            }
            catch (e:Error)
            {
                Logger.add(e.getStackTrace());
            }
        }

        // STAGE 2 - Game Region

        private function loadGameRegion():void
        {
            //Logger.add("TRACE: STAGE 2: loadGameRegion()");
            try
            {
                this.config.regionDetected = (this.config.region.toLowerCase() == Defines.REGION_AUTO_DETECTION);
                if (this.config.regionDetected)
                    this.config.region = Xvm.cmd(Xvm.XPM_COMMAND_GETGAMEREGION);
            }
            catch (e:Error)
            {
                Logger.add(e.getStackTrace());
            }
        }

        // STAGE 3

        private function loadLanguage():void
        {
            //Logger.add("TRACE: STAGE 3: loadLanguage()");
            try
            {
                //Logger.add("TRACE: STAGE 3: loadLanguage()");
                config.languageDetected = config.language.toLowerCase() == Defines.LOCALE_AUTO_DETECTION
                if (config.languageDetected)
                    config.language = Xvm.cmd(Xvm.XPM_COMMAND_GETGAMELANGUAGE);
                Locale.LoadLocaleFile();
            }
            catch (e:Error)
            {
                Logger.add(e.getStackTrace());
            }
        }

        // All done

        private function setConfigLoaded():void
        {
            //if (e.result != null && e.result.error != null && stateInfo.error == null)
            //    stateInfo = { error: e.result.error };

            Logger.add(Sprintf.format("Config loaded. Region: %s (%s), Language: %s (%s)",
                config.region,
                config.regionDetected ? "detected" : "config",
                config.language,
                config.languageDetected ? "detected" : "config"));
            //Logger.addObject(config, "config", 10);

            Cmd.setConfig();
        }
    }
}
