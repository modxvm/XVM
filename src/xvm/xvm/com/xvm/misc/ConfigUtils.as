/**
 * XVM Config utils
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package com.xvm.misc
{
    import com.xvm.types.cfg.CColors;
    import flash.utils.*;
    import org.idmedia.as3commons.util.StringUtils;
    import com.xvm.utils.*;
    import com.xvm.Logger;
    import com.xvm.types.cfg.CConfig;

    public class ConfigUtils extends Object
    {
        /**
         * Recursive walk default config and merge with loaded values.
         */
        public static function MergeConfigs(config:*, def:*, prefix:String = "def"):*
        {
            if (config == null)
                return def;
            switch (typeof def)
            {
                case 'object':
                    if (def is Array)
                    {
                        // warning: arrays are not checked now
                        return (config is Array) ? config : def;
                    }
                    if (def == null)
                        return (typeof config == 'string' || typeof config == 'number') ? config : null;

                    var result:Object = { };
                    var descr:XML = describeType(def);
                    for (var name:String in def)
                    {
                        result[name] = config.hasOwnProperty(name)
                           ? MergeConfigs(config[name], def[name], prefix + "." + name)
                           : def[name];
                    }
                    var ac:XML;
                    var xml:XMLList = descr.accessor;
                    for each (ac in xml)
                    {
                        if (ac.@access != "readonly" && ac.@access != "readwrite")
                            continue;
                        result[ac.@name] = config.hasOwnProperty(ac.@name)
                           ? MergeConfigs(config[ac.@name], def[ac.@name], prefix + "." + ac.@name)
                           : def[ac.@name];
                    }
                    xml = descr.variable;
                    for each (ac in xml)
                    {
                        result[ac.@name] = config.hasOwnProperty(ac.@name)
                           ? MergeConfigs(config[ac.@name], def[ac.@name], prefix + "." + ac.@name)
                           : def[ac.@name];
                    }
                    return ObjectConverter.convertData(result, Class(getDefinitionByName(getQualifiedClassName(def))));

                case 'number':
                    if (!isNaN(parseFloat(config)))
                        return parseFloat(config);
                    if (typeof config == 'string')
                        return config;
                    return def;

                case 'boolean':
                    if (typeof config == 'boolean')
                        return config;
                    if (typeof config == 'string')
                        return config.toLowerCase() == "true";
                    return def;

                case 'string':
                    return (config == null || typeof config == 'string') ? config : def;

                case 'undefined':
                case 'null':
                    return (typeof config == 'string' || typeof config == 'number' || typeof config == 'object') ? config : def;

                default:
                    return def;
            }
        }

        /**
         * Modify some parameters to be with correct format.
         */
        public static function TuneupConfig(config:CConfig):void
        {
            config.battle.clanIconsFolder = Utils.fixPath(config.battle.clanIconsFolder);

            config.iconset.battleLoading = Utils.fixPath(config.iconset.battleLoading);
            config.iconset.playersPanel = Utils.fixPath(config.iconset.playersPanel);
            config.iconset.statisticForm = Utils.fixPath(config.iconset.statisticForm);
            config.iconset.vehicleMarker = Utils.fixPath(config.iconset.vehicleMarker);

            if (config && config.battleLoading && config.battleLoading.clanIcon)
            {
                //Logger.addObject(config.battleLoading.clanIcon);
                if (isNaN(config.battleLoading.clanIcon.xr))
                    config.battleLoading.clanIcon.xr = config.battleLoading.clanIcon.x;
                if (isNaN(config.battleLoading.clanIcon.yr))
                    config.battleLoading.clanIcon.yr = config.battleLoading.clanIcon.y;
                if (isNaN(config.statisticForm.clanIcon.xr))
                    config.statisticForm.clanIcon.xr = config.statisticForm.clanIcon.x;
                if (isNaN(config.statisticForm.clanIcon.yr))
                    config.statisticForm.clanIcon.yr = config.statisticForm.clanIcon.y;
                if (isNaN(config.playersPanel.clanIcon.xr))
                    config.playersPanel.clanIcon.xr = config.playersPanel.clanIcon.x;
                if (isNaN(config.playersPanel.clanIcon.yr))
                    config.playersPanel.clanIcon.yr = config.playersPanel.clanIcon.y;
            }
        }

        /**
         * Convert config to new format.
         */
        public static function FixConfig(config:Object):Object
        {
            if (!config)
                return undefined;

            var v:String = config.configVersion;
            var s:* = null;

            if (!v || v == "" || Utils.compareVersions(v, "5.0.0") < 0)
                v = "4.99.0";

            if (v == "4.99.0")
            {
                s = config.battleLoading;
                if (s != null)
                {
                    if (s.formatLeft != null && s.formatLeftVehicle == null)
                    {
                        s.formatLeftVehicle = s.formatLeft;
                        delete s.formatLeft;
                    }
                    if (s.formatRight != null && s.formatRightVehicle == null)
                    {
                        s.formatRightVehicle = s.formatRight;
                        delete s.formatRight;
                    }
                }
                s = config.statisticForm;
                if (s != null)
                {
                    if (s.formatLeft != null && s.formatLeftVehicle == null)
                    {
                        s.formatLeftVehicle = s.formatLeft;
                        delete s.formatLeft;
                    }
                    if (s.formatRight != null && s.formatRightVehicle == null)
                    {
                        s.formatRightVehicle = s.formatRight;
                        delete s.formatRight;
                    }
                }
                if (config.finalStatistic != null && config.battleResults == null)
                {
                    config.battleResults = config.finalStatistic;
                    delete config.finalStatistic;
                }
                v = "5.0.0";
            }

    /*
            if (v == "5.x.x")
            {
                if (config.battle)
                {
                    if (config.battle.mirroredVehicleIcons != null)
                        config.battle.mirroredVehicleIcons = Utils.toBool(config.battle.mirroredVehicleIcons, true);
                }
                v = "5.y.y";
            }
    */

            config.configVersion = v;
            return config;
        }

        public static function parseErrorEvent(ex:Object):String {
            var e:Error = ex as Error;
            if (e != null)
                return e.getStackTrace();

            if (ex.at == null)
                return ex.toString();

            var head:String = ex.at > 0 ? ex.text.substring(0, ex.at) : "";
            head = head.split("\r").join("").split("\n").join("");
            while (head.indexOf("  ") != -1)
                head = head.split("  ").join(" ");
            head = head.substr(head.length - 75, 75);

            var tail:String = (ex.at + 1 < ex.text.length) ? ex.text.substring(ex.at + 1, ex.text.length) : "";
            tail = tail.split("\r").join("").split("\n").join("");
            while (tail.indexOf("  ") != -1)
            tail = tail.split("  ").join(" ");
            tail = tail.substr(0, 125);

            return "[" + ex.at + "] " + StringUtils.trim(ex.name) + ": " + StringUtils.trim(ex.message) + "\n  " +
                head + ">>>" + ex.text.charAt(ex.at) + "<<<" + tail;
        }
    }
}
