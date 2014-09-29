""" XPM misc functions (c) www.modxvm.com 2013-2014 """

import os
import datetime
import json
import codecs
import random
import glob
import traceback

#####################################################################
# Global constants

IS_DEVELOPMENT = os.environ.get('XPM_DEVELOPMENT') != None
if IS_DEVELOPMENT:
    print '[XPM] Development mode'

#####################################################################
# Common methods

def log(msg):
    print datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S:'), msg

def err(msg):
    log('[ERROR] %s' % msg)

def debug(msg):
    if IS_DEVELOPMENT:
        log('[DEBUG] %s' % msg)

def msec(start, end):
    td = end - start
    return int(td.microseconds / 1000 + td.seconds * 1000)

def enum(**enums):
    return type('Enum', (), enums)

def logtrace(exc=None):
    print "============================="
    import traceback
    if exc is not None:
        err(str(exc))
        traceback.print_exc()
    else:
        traceback.print_stack()
    print "============================="

def load_file(fn):
    try:
        return codecs.open(fn, 'r', 'utf-8-sig').read()
    except:
        logtrace(__file__)
        return None

def load_config(fn):
    try:
        return json.load(codecs.open(fn, 'r', 'utf-8-sig'))
    except:
        logtrace(__file__)
        return None

# warning: slow methon, but can work with nont-hashable items
def uniq(seq):
    # Order preserving
    checked = []
    for e in seq:
        if e not in checked:
            checked.append(e)
    return checked

#################################################################
# Singleton

class Singleton(type):
    def __init__(self, name, bases, dict):
        super(Singleton, self).__init__(name, bases, dict)
        self.instance = None

    def __call__(self, *args, **kw):
        if self.instance is None:
            self.instance = super(Singleton, self).__call__(*args, **kw)
        return self.instance


#####################################################################
# EventHook

class EventHook(object):

    def __init__(self):
        self.__handlers = []

    def __iadd__(self, handler):
        self.__handlers.append(handler)
        return self

    def __isub__(self, handler):
        if handler in self.__handlers:
            self.__handlers.remove(handler)
        return self

    def fire(self, *args, **keywargs):
        for handler in self.__handlers:
            handler(*args, **keywargs)

    def clearObjectHandlers(self, inObject):
        for theHandler in self.__handlers:
            if theHandler.im_self == inObject:
                self -= theHandler


#####################################################################
# Register events

def RegisterEvent(cls, method, handler, prepend=False):
    evt = '__event_%i_%s' % ((1 if prepend else 0), method)
    if hasattr(cls, evt):
        e = getattr(cls, evt)
    else:
        newm = '__orig_%i_%s' % ((1 if prepend else 0), method)
        setattr(cls, evt, EventHook())
        setattr(cls, newm, getattr(cls, method))
        e = getattr(cls, evt)
        m = getattr(cls, newm)
        setattr(cls, method, lambda *a, **k: __event_handler(prepend, e, m, *a, **k))
    e += handler

def __event_handler(prepend, e, m, *a, **k):
    try:
        if prepend:
            e.fire(*a, **k)
            r = m(*a, **k)
        else:
            r = m(*a, **k)
            e.fire(*a, **k)
        return r
    except:
        logtrace(__file__)


def OverrideMethod(cls, method, handler):
    i = 0
    while True:
        newm = '__orig_%i_%s' % (i, method)
        if not hasattr(cls, newm):
            break
        i += 1
    setattr(cls, newm, getattr(cls, method))
    setattr(cls, method, lambda *a, **k: handler(getattr(cls, newm), *a, **k))


#################################################################
# WG-Specific

import BigWorld

def getCurrentPlayerId():
    player = BigWorld.player()
    if hasattr(player, 'databaseID'):
        return player.databaseID

    arena = getattr(player, 'arena', None)
    if arena is not None:
        vehID = getattr(player, 'playerVehicleID', None)
        if vehID is not None and vehID in arena.vehicles:
            return arena.vehicles[vehID]['accountDBID']

    #print('===================')
    #pprint(vars(player))
    #print('===================')
    return None

def isReplay():
    import BattleReplay
    return BattleReplay.g_replayCtrl.isPlaying


#####################################################################
# SWF mods initializer

from gui.shared import events

_APPLICATION_SWF = 'Application.swf'
_COMMAND_GETMODS = "getMods"
_XVM_MODS_DIR = "res_mods/xvm/mods"
_XVM_VIEW_ALIAS = 'xvm'
_XVM_SWF_URL = '../../../xvm/mods/xvm.swf'

def _start():
    #debug('start')
    from gui.shared import g_eventBus
    g_eventBus.addListener(events.GUICommonEvent.APP_STARTED, _appStarted)

def _fini():
    #debug('fini')
    from gui.shared import g_eventBus
    g_eventBus.removeListener(events.GUICommonEvent.APP_STARTED, _appStarted)

def _FlashInit(self, swf, className = 'Flash', args = None, path = None):
    self.swf = swf
    if self.swf == _APPLICATION_SWF:
        self.addExternalCallback('xpm.cmd', lambda *args: _onXpmCommand(self, *args))

def _FlashBeforeDelete(self):
    if self.swf == _APPLICATION_SWF:
        self.removeExternalCallback('xpm.cmd')

def _appStarted(event):
    #debug('AppStarted')
    from gui.WindowsManager import g_windowsManager
    from gui.Scaleform.framework import g_entitiesFactories, ViewSettings, ViewTypes, ScopeTemplates
    from gui.Scaleform.framework.entities.View import View
    viewType = ViewTypes.SERVICE_LAYOUT
    scopeTemplate = ScopeTemplates.GLOBAL_SCOPE
    settings = ViewSettings(_XVM_VIEW_ALIAS, View, _XVM_SWF_URL, viewType, None, scopeTemplate)
    g_entitiesFactories.addSettings(settings)
    app = g_windowsManager.window
    if app is not None:
        #BigWorld.callback(0, _loadView)
        _loadView()

def _loadView():
    try:
        #debug('loadView')
        from gui.WindowsManager import g_windowsManager
        g_windowsManager.window.loadView(_XVM_VIEW_ALIAS)
    except Exception, ex:
        err(traceback.format_exc())

def _onXpmCommand(proxy, id, cmd, *args):
    try:
        #debug("id=" + str(id) + " cmd=" + str(cmd) + " args=" + json.dumps(args))
        res = None
        if cmd == _COMMAND_GETMODS:
            mods_dir = _XVM_MODS_DIR
            if not os.path.isdir(mods_dir):
                return None
            mods = []
            for m in glob.iglob(mods_dir + "/*.swf"):
                m = m.replace('\\', '/')
                if not m.lower().endswith("/xvm.swf"):
                    mods.append(m)
            res = json.dumps(mods) if mods else None

        proxy.movie.invoke(('xpm.respond', [id, res]))
    except Exception, ex:
        err(traceback.format_exc())

from gui.Scaleform.Flash import Flash
RegisterEvent(Flash, '__init__', _FlashInit)
RegisterEvent(Flash, 'beforeDelete', _FlashBeforeDelete)
def _RegisterEvents():
    _start()
    import game
    RegisterEvent(game, 'fini', _fini)

BigWorld.callback(0, _RegisterEvents)


#####################################################################
# Setup development environment

def _autoFlushPythonLog():
    BigWorld.flushPythonLog()
    BigWorld.callback(0.1, _autoFlushPythonLog)
if IS_DEVELOPMENT:
    _autoFlushPythonLog()
