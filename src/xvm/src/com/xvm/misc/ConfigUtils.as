/**
 * XVM Config utils
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package com.xvm.misc
{
    import com.xvm.*;
    import com.xvm.io.*;
    import com.xvm.utils.*;
    import com.xvm.types.cfg.*;
    import flash.utils.*;
    import org.idmedia.as3commons.util.*;

    public class ConfigUtils extends Object
    {
        /**
         * Recursive walk default config and merge with loaded values.
         */
        public static function MergeConfigs(config:*, def:*, prefix:String = "def"):*
        {
            if (config === undefined)
                return def;
            if (config === null)
                return null;
            switch (typeof def)
            {
                case 'object':
                    if (def is Array)
                    {
                        // warning: arrays are not checked now
                        return (config is Array) ? config : def;
                    }
                    if (prefix == "def.vehicleNames")
                    {
                        return config == null ? def : config;
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

            config.iconset.battleLoadingAlly = Utils.fixPath(config.iconset.battleLoadingAlly);
            config.iconset.battleLoadingEnemy = Utils.fixPath(config.iconset.battleLoadingEnemy);
            config.iconset.playersPanelAlly = Utils.fixPath(config.iconset.playersPanelAlly);
            config.iconset.playersPanelEnemy = Utils.fixPath(config.iconset.playersPanelEnemy);
            config.iconset.statisticFormAlly = Utils.fixPath(config.iconset.statisticFormAlly);
            config.iconset.statisticFormEnemy = Utils.fixPath(config.iconset.statisticFormEnemy);
            config.iconset.vehicleMarkerAlly = Utils.fixPath(config.iconset.vehicleMarkerAlly);
            config.iconset.vehicleMarkerEnemy = Utils.fixPath(config.iconset.vehicleMarkerEnemy);

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
                s = config.iconset;
                if (s != null)
                {
                    if (s.battleLoading != null && s.battleLoadingAlly == null && s.battleLoadingEnemy == null)
                    {
                        s.battleLoadingAlly = s.battleLoadingEnemy = s.battleLoading;
                        delete s.battleLoading;
                    }
                    if (s.playersPanel != null && s.playersPanelAlly == null && s.playersPanelEnemy == null)
                    {
                        s.playersPanelAlly = s.playersPanelEnemy = s.playersPanel;
                        delete s.playersPanel;
                    }
                    if (s.statisticForm != null && s.statisticFormAlly == null && s.statisticFormEnemy == null)
                    {
                        s.statisticFormAlly = s.statisticFormEnemy = s.statisticForm;
                        delete s.statisticForm;
                    }
                    if (s.vehicleMarker != null && s.vehicleMarkerAlly == null && s.vehicleMarkerEnemy == null)
                    {
                        s.vehicleMarkerAlly = s.vehicleMarkerEnemy = s.vehicleMarker;
                        delete s.vehicleMarker;
                    }
                }
                v = "5.0.0";
            }

            if (v == "5.0.0")
            {
                v = "5.0.1";
            }

            if (v == "5.0.1")
            {
                s = config.battle;
                var s2:* = config.markers;
                if (s2 != null && s != null)
                {
                    if (s2.useStandardMarkers == null && s.useStandardMarkers != null)
                        s2.useStandardMarkers = s.useStandardMarkers;
                }
                s2 = config.playersPanel;
                if (s2 != null && s != null)
                {
                    if (s2.removePanelsModeSwitcher == null && s.removePanelsModeSwitcher != null)
                        s2.removePanelsModeSwitcher = s.removePanelsModeSwitcher;
                }
                v = "5.0.2";
            }

            if (v == "5.0.2")
            {
                var json:String = JSONx.stringify(config, '', true);
                // TIP: replace() is buggy
                json = json
                    .split("{{avglvl}}")        .join("{{avglvl%d|-}}")
                    .split("{{name}}")          .join("{{name%.16s~..}}")
                    .split("{{eff}}")           .join("{{eff%d}}")
                    .split("{{eff:4}}")         .join("{{eff%4d}}")
                    .split("{{teff}}")          .join("{{teff%4d}}")
                    .split("{{e}}")             .join("{{e%d}}")
                    .split("{{wn}}")            .join("{{wn8%4d}}")
                    .split("{{wn6}}")           .join("{{wn6%4d}}")
                    .split("{{wn8}}")           .join("{{wn8%4d}}")
                    .split("{{wgr}}")           .join("{{wgr%4d}}")
                    .split("{{xeff}}")          .join("{{xeff%2s}}")
                    .split("{{xwn}}")           .join("{{xwn%2s}}")
                    .split("{{xwn6}}")          .join("{{xwn6%2s}}")
                    .split("{{xwn8}}")          .join("{{xwn8%2s}}")
                    .split("{{xwgr}}")          .join("{{xwgr%2s}}")
                    .split("{{rating}}")        .join("{{rating%d~%}}")
                    .split("{{rating:3}}")      .join("{{rating%2d~%}}")
                    .split("{{kb}}")            .join("{{kb%d~k}}")
                    .split("{{kb:3}}")          .join("{{kb%2d~k}}")
                    .split("{{t-rating}}")      .join("{{t-rating%d~%}}")
                    .split("{{t-rating:3}}")    .join("{{t-rating%2d~%}}")
                    .split("{{t-battles:4}}")   .join("{{t-battles%4d}}")
                    .split("{{t-kb}}")          .join("{{t-kb%.1f~k}}")
                    .split("{{t-kb-0}}")        .join("{{t-kb%0.1f~k}}")
                    .split("{{t-kb:4}}")        .join("{{t-kb%3.01f~k}}")
                    .split("{{t-hb}}")          .join("{{t-hb%d~h}}")
                    .split("{{t-hb:3}}")        .join("{{t-hb%2d~h}}")
                    .split("{{tdb:4}}")         .join("{{tdb%4d}}")
                    .split("{{tdv}}")           .join("{{tdv%.1f}}")
                    .split("{{tfb}}")           .join("{{tfb%.1f}}")
                    .split("{{tsb}}")           .join("{{tsb%.1f}}")
                    .split("{{vehicle-type}}")  .join("{{vehicle}}")
                    .split("{{short-nick}}")    .join("{{nick%.5s}}");
                config = JSONx.parse(json);
                v = "5.1.0";
            }

/*
            if (v == "5.x.x")
            {
                v = "5.y.y";
            }
*/

            config.configVersion = v;
            return config;
        }

        public static function parseErrorEvent(ex:Error):String {
            var e:JSONxError = ex as JSONxError;
            if (e == null)
                return e.getStackTrace();

            if (e.at < 0)
                return "[" + e.type + "] " + e.getStackTrace();

            var head:String = e.at > 0 ? e.text.substring(0, e.at) : "";
            head = head.split("\r").join("").split("\n").join("");
            while (head.indexOf("  ") != -1)
                head = head.split("  ").join(" ");
            head = head.substr(head.length - 75, 75);

            var tail:String = (e.at + 1 < e.text.length) ? e.text.substring(e.at + 1, e.text.length) : "";
            tail = tail.split("\r").join("").split("\n").join("");
            while (tail.indexOf("  ") != -1)
            tail = tail.split("  ").join(" ");
            tail = tail.substr(0, 125);

            return "[" + e.at + "] " + StringUtils.trim(e.name) + ": " + StringUtils.trim(e.message) + "\n  " +
                head + ">>>" + e.text.charAt(e.at) + "<<<" + tail;
        }
    }
}
