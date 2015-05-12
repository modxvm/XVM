""" XVM (c) www.modxvm.com 2013-2015 """

__all__ = ['config', 'configLoadError', 'load']

from copy import deepcopy
import traceback

import JSONxLoader

from xfw import *

from constants import *
from logger import *
from default_config import DEFAULT_CONFIG

config = None
configLoadError = None

def load(filename):
    load_xvm_xc(filename)
    load_region()
    load_language()

    log('Config loaded. Region: {} ({}), Language: {} ({})'.format(
        config['region'],
        'detected' if config['regionDetected'] else 'config',
        config['language'],
        'detected' if config['languageDetected'] else 'config'))


def load_xvm_xc(filename):
    global config
    global configLoadError
    try:
        autoReloadConfig = False if config is None else config['autoReloadConfig'];

        config = deepcopy(DEFAULT_CONFIG)
        configLoadError = None

        result = JSONxLoader.load(filename, load_log)
        if result is not None:
            config = merge_configs(config, fix_config(result))
    except Exception:
        config['autoReloadConfig'] = autoReloadConfig;
        configLoadError = traceback.format_exc()
        err(configLoadError)
    #log('config={}'.format(config))

    tuneup_config(config)

    #configwatchdog.startConfigWatchdog()


def load_region():
    global config
    try:
        config['regionDetected'] = 'region' not in config or config['region'].lower() == XVM.REGION_AUTO_DETECTION
        if config['regionDetected']:
            config['region'] = GAME_REGION
    except Exception:
        err(traceback.format_exc())


def load_language():
    global config
    try:
        config['languageDetected'] = 'language' not in config or config['language'].lower() == XVM.LOCALE_AUTO_DETECTION
        if config['languageDetected']:
            config['language'] = GAME_LANGUAGE
        #TODO
        #Locale.LoadLocaleFile();
    except Exception:
        err(traceback.format_exc())


def load_log(msg):
    log(msg
        .replace(XVM.CONFIG_DIR, '[cfg]')
        .replace(XVM.SHARED_RESOURCES_DIR, '[res]'))


def fix_config(config):
    # TODO
    """
            if (!config)
                return undefined;

            var v:String = config.configVersion;
            var s:* = null;

            if (!v || v == "" || XfwUtils.compareVersions(v, "5.0.0") < 0)
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
                    .split("{{wn}}")            .join("{{wn8%4d}}")
                    .split("{{wn6}}")           .join("{{wn6%4d}}")
                    .split("{{wn8}}")           .join("{{wn8%4d}}")
                    .split("{{wgr}}")           .join("{{wgr%4d}}")
                    .split("{{xeff}}")          .join("{{xeff%2s}}")
                    .split("{{xwn}}")           .join("{{xwn%2s}}")
                    .split("{{xwn6}}")          .join("{{xwn6%2s}}")
                    .split("{{xwn8}}")          .join("{{xwn8%2s}}")
                    .split("{{xwgr}}")          .join("{{xwgr%2s}}")
                    .split("{{kb}}")            .join("{{kb%d~k}}")
                    .split("{{kb:3}}")          .join("{{kb%2d~k}}")
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
    """
    return config


def merge_configs(orig_config, new_config):
    # TODO
    """
            if (config === undefined)
                return def;
            if (config === null)
                return null;
            switch (typeof def)
            {
                case 'object':
                    if (def is Array)
                    {
                        // note: arrays will always be returned untouched
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
                    var name:String;
                    for (name in def)
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

                    // add attributes present in config and missed in def
                    for (name in config)
                    {
                        if (!def.hasOwnProperty(name))
                            result[name] = config[name];
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
                    {
                        var config_lower:String = config.toLowerCase();
                        if (config_lower == "true")
                            return true;
                        if (config_lower == "false")
                            return false;
                        return config;
                    }
                    return def;

                case 'string':
                    return (config == null || typeof config == 'string') ? config : def;

                case 'undefined':
                case 'null':
                    return (typeof config == 'string' || typeof config == 'number' || typeof config == 'object') ? config : def;

                default:
                    return def;
            }
    """
    return new_config


def tuneup_config(config):
    # TODO
    """
            config.battle.clanIconsFolder = XfwUtils.fixPath(config.battle.clanIconsFolder);

            config.iconset.battleLoadingAlly = XfwUtils.fixPath(config.iconset.battleLoadingAlly);
            config.iconset.battleLoadingEnemy = XfwUtils.fixPath(config.iconset.battleLoadingEnemy);
            config.iconset.playersPanelAlly = XfwUtils.fixPath(config.iconset.playersPanelAlly);
            config.iconset.playersPanelEnemy = XfwUtils.fixPath(config.iconset.playersPanelEnemy);
            config.iconset.statisticFormAlly = XfwUtils.fixPath(config.iconset.statisticFormAlly);
            config.iconset.statisticFormEnemy = XfwUtils.fixPath(config.iconset.statisticFormEnemy);
            config.iconset.vehicleMarkerAlly = XfwUtils.fixPath(config.iconset.vehicleMarkerAlly);
            config.iconset.vehicleMarkerEnemy = XfwUtils.fixPath(config.iconset.vehicleMarkerEnemy);

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
    """
    return config
