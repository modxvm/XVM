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

XPM_CMD = 'xpm.cmd'

_XVM_MODS_DIR = "res_mods/xvm/mods"
_XVM_VIEW_ALIAS = 'xvm'
_XVM_SWF_URL = '../../../xvm/mods/xvm.swf'

_XPM_COMMAND_GETMODS = "xpm.getMods"
_XPM_COMMAND_INITIALIZED = "xpm.initialized"
_XPM_COMMAND_LOADFILE = "xpm.loadFile"

_xvmView = None
_xpmInitialized = False

def _start():
    #debug('start')

    from gui.shared import g_eventBus, EVENT_BUS_SCOPE
    from gui.Scaleform.framework import g_entitiesFactories, ViewSettings, ViewTypes, ScopeTemplates
    from gui.Scaleform.framework.entities.View import View

    class XvmView(View):
        def xvm_cmd(self, cmd, *args):
            log('[XPM] cmd: ' + cmd + str(args))
            if cmd == _XPM_COMMAND_GETMODS:
                return _xpm_getMods()
            elif cmd == _XPM_COMMAND_INITIALIZED:
                global _xpmInitialized
                _xpmInitialized = True
            elif cmd == _XPM_COMMAND_LOADFILE:
                return loadFile(args[0])
            else:
                handlers = g_eventBus._EventBus__scopes[EVENT_BUS_SCOPE.DEFAULT][XPM_CMD]
                for handler in handlers.copy():
                    try:
                        (result, status) = handler(cmd, *args)
                        if status:
                            return result
                    except TypeError:
                        err(traceback.format_exc())
                log('WARNING: unknown command: %s' % cmd)

        def as_xvm_cmdS(self, cmd, *args):
            return self.flashObject.as_xvm_cmd(cmd, *args)

    g_entitiesFactories.addSettings(ViewSettings(
        _XVM_VIEW_ALIAS,
        XvmView,
        _XVM_SWF_URL,
        ViewTypes.SERVICE_LAYOUT,
        None,
        ScopeTemplates.GLOBAL_SCOPE))

    g_eventBus.addListener(events.GUICommonEvent.APP_STARTED, _appStarted)

def _fini():
    #debug('fini')
    from gui.shared import g_eventBus
    g_eventBus.removeListener(events.GUICommonEvent.APP_STARTED, _appStarted)

def _appStarted(event):
    #debug('AppStarted')
    try:
        from gui.WindowsManager import g_windowsManager
        app = g_windowsManager.window
        if app is not None:
            global _xvmView
            _xvmView = None
            global _xpmInitialized
            _xpmInitialized = False
            app.loaderManager.onViewLoaded += _onViewLoaded
            BigWorld.callback(0, lambda:app.loadView(_XVM_VIEW_ALIAS))
            #app.loadView(_XVM_VIEW_ALIAS)
    except Exception, ex:
        err(traceback.format_exc())

def _AppLoadView(base, self, newViewAlias, name = None, *args, **kwargs):
    #log('loadView: ' + newViewAlias)
    if newViewAlias == 'hangar':
        global _xpmInitialized
        if _xpmInitialized == False:
            BigWorld.callback(0, lambda:_AppLoadView(base, self, newViewAlias, name, *args, **kwargs))
            return
    base(self, newViewAlias, name, *args, **kwargs)

def _onViewLoaded(view):
    #log('onViewLoaded: ' + view.alias)
    if view is not None and view.alias == _XVM_VIEW_ALIAS:
        from gui.WindowsManager import g_windowsManager
        app = g_windowsManager.window
        #if app is not None:
        #    app.loaderManager.onViewLoaded -= _onViewLoaded
        global _xvmView
        _xvmView = view

# commands handlers

def _xpm_getMods():
    try:
        #from gui.WindowsManager import g_windowsManager
        #app = g_windowsManager.window
        #from gui.shared import g_eventBus, EVENT_BUS_SCOPE
        #BigWorld.callback(5, lambda: app.fireEvent(events.LoadEvent(events.LoadEvent.LOAD_BARRACKS), scope = EVENT_BUS_SCOPE.LOBBY))
        #BigWorld.callback(6, lambda: app.fireEvent(events.LoadEvent(events.LoadEvent.LOAD_HANGAR), scope = EVENT_BUS_SCOPE.LOBBY))

        mods_dir = _XVM_MODS_DIR
        if not os.path.isdir(mods_dir):
            return None
        mods = []
        for m in glob.iglob(mods_dir + "/*.swf"):
            m = m.replace('\\', '/')
            if not m.lower().endswith("/xvm.swf"):
                mods.append(m)
        return mods
    except Exception, ex:
        err(traceback.format_exc())
    return None

# register events

def _RegisterEvents():
    _start()
    import game
    RegisterEvent(game, 'fini', _fini)
    from gui.Scaleform.framework.application import App
    OverrideMethod(App, 'loadView', _AppLoadView)
BigWorld.callback(0, _RegisterEvents)


#####################################################################
# Setup development environment

def _autoFlushPythonLog():
    BigWorld.flushPythonLog()
    BigWorld.callback(0.1, _autoFlushPythonLog)
if IS_DEVELOPMENT:
    _autoFlushPythonLog()
