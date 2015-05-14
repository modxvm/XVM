""" XVM (c) www.modxvm.com 2013-2015 """

__all__ = ['load', 'get', 'config_errors', 'config_str', 'lang_str', 'lang_data']

from copy import deepcopy
import traceback
import simplejson
import JSONxLoader
import dpath.util

from xfw import *

from constants import *
from logger import *
from default_config import DEFAULT_CONFIG
import configwatchdog

_config = None
config_errors = None
config_str = None
lang_str = None
lang_data = None

def get(glob, default=None):
    if _config is None or not glob or glob == '':
        return default
    try:
        glob = glob.replace('.', '/')
        if glob[0] != '/':
            glob = '/%s' % glob
        return dpath.util.get(_config, glob)
    except (ValueError, KeyError) as e:
        err('[xvm_main] config.get(): %s' % repr(e))
    except Exception:
        err(traceback.format_exc())
    return default


def load(e):
    global _config
    global config_errors
    global config_str
    global lang_str
    global lang_data

    try:
        # TODO: config selection
        filename = e.ctx.get('filename', XVM.CONFIG_FILE)

        configwatchdog.stopConfigWatchdog()

        config_str = None
        lang_str = None
        lang_data = None

        autoreload = get('autoReloadConfig', False)
        (_config, config_errors) = _load_xvm_xc(filename, autoreload)

        _config['xvmVersion'] = XVM.XVM_VERSION
        _config['wotVersion'] = XVM.WOT_VERSION
        _config['xvmIntro'] = XVM.XVM_INTRO

        regionDetected = 'region' not in _config or _config['region'].lower() == XVM.REGION_AUTO_DETECTION
        if regionDetected:
            _config['region'] = GAME_REGION

        languageDetected = 'language' not in _config or _config['language'] == XVM.LOCALE_AUTO_DETECTION
        if languageDetected:
            _config['language'] = GAME_LANGUAGE
        lang_data = _load_locale_file()

        log('Config loaded. Region: {} ({}), Language: {} ({})'.format(
            get('region'),
            'detected' if regionDetected else 'config',
            get('language'),
            'detected' if languageDetected else 'config'))

        config_str = simplejson.dumps(_config)
        lang_str = simplejson.dumps(lang_data)

    except Exception:
        err(traceback.format_exc())

    if get('autoReloadConfig', False) == True:
        configwatchdog.startConfigWatchdog()

    from gui.shared import g_eventBus, events
    g_eventBus.handleEvent(events.HasCtxEvent(XVM_EVENT.CONFIG_LOADED))


# PRIVATE

def _load_xvm_xc(filename, autoreload):
    debug('_load_xvm_xc: "{}", {}'.format(filename, autoreload))
    try:
        config = deepcopy(DEFAULT_CONFIG)
        errors = None
        result = JSONxLoader.load(filename, _load_log)
        if result is not None:
            config = _merge_configs(config, _fix_config(result))
    except Exception:
        config['autoReloadConfig'] = autoreload
        errors = traceback.format_exc()
        err(errors)
    #log('config={}'.format(config))

    _tuneup_config(config)

    return (config, errors)


def _load_locale_file():
    # TODO
    return {}

def _load_log(msg):
    log(msg
        .replace(XVM.CONFIG_DIR, '[cfg]')
        .replace(XVM.SHARED_RESOURCES_DIR, '[res]'))


def _fix_config(config):
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


def _merge_configs(orig_config, new_config):
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


def _tuneup_config(config):
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
