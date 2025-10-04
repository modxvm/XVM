"""
SPDX-License-Identifier: LGPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# stdlib
import os
import weakref
import collections
import traceback
import logging

# BigWorld
from constants import ARENA_GUI_TYPE
from gui import DialogsInterface, SystemMessages
from gui.app_loader.settings import APP_NAME_SPACE
from gui.battle_control import avatar_getter
from gui.shared import g_eventBus, EVENT_BUS_SCOPE
from gui.shared.events import HasCtxEvent
from gui.Scaleform.daapi.view import dialogs
from gui.Scaleform.framework import g_entitiesFactories, ViewSettings, ScopeTemplates
from gui.Scaleform.framework.entities.View import View
from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent
from frameworks.wulf import WindowLayer
from helpers import dependency
from skeletons.gui.app_loader import IAppLoader

# OpenWG
import openwg_loader as loader
import openwg_vfs

# XFW
from xfw import IS_DEVELOPMENT
from xfw.constants import *
from xfw.logger import *

# XVM Actionscript
from . import swf
from .swfloadedinfo import swf_loaded_info



#
# Logger
#

logger = logging.getLogger('XVM/Actionscript')



#
# Defines
#

_LOG_COMMANDS = [
    COMMAND.XFW_COMMAND_INITIALIZED,
    XFW_COMMAND.MESSAGEBOX,
]


class XfwArenaGuiType:
    WINBACK = 31 # removed in Lesta since 1.29
    TOURNAMENT_COMP7 = 33 # WG 1.24.1
    TRAINING_COMP7 = 34
    COMP7_LIGHT = 35 # WG 2.0
    STORY_MODE_ONBOARDING = 100 # _ONBOARDING (WG 1.25) / STORY_MODE (Lesta)
    LAST_STAND = 102 # WG 2.0
    STORY_MODE_REGULAR = 104 # WG 1.25
    WHITE_TIGER = 110 # WG 2.0
    COSMIC_EVENT = 300 # Lesta 1.25
    WHITE_TIGER_LESTA = 301 # Lesta 1.37
    RTS_RANGE = (ARENA_GUI_TYPE.RTS, ARENA_GUI_TYPE.RTS_TRAINING, ARENA_GUI_TYPE.RTS_BOOTCAMP, )
    COMP7_RANGE = (ARENA_GUI_TYPE.COMP7, TOURNAMENT_COMP7, TRAINING_COMP7, COMP7_LIGHT, )
    STORY_MODE_RANGE = (STORY_MODE_ONBOARDING, STORY_MODE_REGULAR, )
    EVENT_RANGE = (ARENA_GUI_TYPE.EVENT_BATTLES, WINBACK, LAST_STAND, WHITE_TIGER, WHITE_TIGER_LESTA, )
    # List for event battles to ignore basic XVM features (clock and sixth sense)
    # Mainly used for special events with GF usage in battle
    EVENT_SPECIAL_RANGE = (COSMIC_EVENT, )


_BATTLE_PACKAGES_MAP = {
    ARENA_GUI_TYPE.RANKED: ['as_battle_ranked'],
    ARENA_GUI_TYPE.EPIC_RANDOM: ['as_battle_epicrandom'],
    ARENA_GUI_TYPE.EPIC_BATTLE: ['as_battle_epicbattle'],
    ARENA_GUI_TYPE.BATTLE_ROYALE: ['as_battle_royale'],
    XfwArenaGuiType.EVENT_RANGE: ['as_battle_event'],
    XfwArenaGuiType.EVENT_SPECIAL_RANGE: ['as_battle_event_special'],
    XfwArenaGuiType.RTS_RANGE: ['as_battle_rts'],
    ARENA_GUI_TYPE.STRONGHOLD_RANGE: ['as_battle_stronghold'],
    XfwArenaGuiType.COMP7_RANGE: ['as_battle_comp7'],
    XfwArenaGuiType.STORY_MODE_RANGE: ['as_battle_storymode'],
}



#
# Classes
#

class _XfwInjectorView(View):

    def __init__(self):
        super(_XfwInjectorView, self).__init__()

    def _populate(self):
        super(_XfwInjectorView, self)._populate()
        if swf.appNS in [APP_NAME_SPACE.SF_LOBBY, APP_NAME_SPACE.SF_BATTLE]:
            self.flashObject.as_inject()


class _XfwComponent(BaseDAAPIComponent):

    def __init__(self):
        super(_XfwComponent, self).__init__()
        swf.g_xfwview = weakref.ref(self)

    def as_xfw_cmdS(self, cmd, *args):
        try:
            if self.flashObject is None:
                return None
            return self.flashObject.as_xfw_cmd(cmd, *args)
        except:
            err(traceback.format_exc())

    def xfw_cmd(self, cmd, *args):
        try:
            if IS_DEVELOPMENT and cmd in _LOG_COMMANDS:
                debug('[XFW] xfw_cmd: {} {}'.format(cmd, args))
            if cmd == COMMAND.XFW_COMMAND_LOG:
                if swf.g_xvmlogger is None:
                    swf.g_xvmlogger = Logger(PATH.XVM_LOG_FILE_NAME)
                swf.g_xvmlogger.add(*args)
            elif cmd == COMMAND.XFW_COMMAND_INITIALIZED:
                swf.xfwInitialized = True
            elif cmd == COMMAND.XFW_COMMAND_SWF_LOADED:
                logging.getLogger('XFW/Actionscript').info('COMMAND_SWF_LOADED: %s' % args[0])
                swf_loaded_info.swf_loaded_set(args[0])
                g_eventBus.handleEvent(HasCtxEvent(XFW_EVENT.SWF_LOADED, args[0]))
            elif cmd == COMMAND.XFW_COMMAND_GETMODS:
                return self.getMods()
            elif cmd == COMMAND.XFW_COMMAND_LOADFILE:
                return load_file(args[0])
            elif cmd == XFW_COMMAND.GETGAMEREGION:
                return getRegion()
            elif cmd == XFW_COMMAND.GETGAMELANGUAGE:
                return getLanguage()
            elif cmd == XFW_COMMAND.CALLBACK:
                e = swf._events.get(args[0], None)
                if e:
                    e.fire({
                      "name": args[0],
                      "type": args[1],
                      "x": int(args[2]),
                      "y": int(args[3]),
                      "stageX": int(args[4]),
                      "stageY": int(args[5]),
                      "buttonIdx": int(args[6]),
                      "delta": int(args[7]),
                      "ctrlKey": int(args[8]),
                      "altKey": int(args[9]),
                      "shiftKey": int(args[10]),
                    })
            elif cmd == XFW_COMMAND.MESSAGEBOX:
                # title, message
                DialogsInterface.showDialog(dialogs.SimpleDialogMeta(
                    args[0],
                    args[1],
                    dialogs.I18nInfoDialogButtons('common/error')),
                    (lambda x: None))
            elif cmd == XFW_COMMAND.SYSMESSAGE:
                # message, type
                # Types: gui.SystemMessages.SM_TYPE:
                #   'Error', 'Warning', 'Information', 'GameGreeting', ...
                SystemMessages.pushMessage(
                    args[0],
                    type=SystemMessages.SM_TYPE.of(args[1]))
            else:
                handlers = g_eventBus._EventBus__handlers[EVENT_BUS_SCOPE.DEFAULT][XFW_COMMAND.XFW_CMD]
                for handler in handlers:
                    try:
                        (result, status) = handler(cmd, *args)
                        if status:
                            return result
                    except TypeError:
                        err(traceback.format_exc())
                log('WARNING: unknown command: {}'.format(cmd))
        except:
            err(traceback.format_exc())

    # commands handlers
    def getMods(self):
        try:
            app = dependency.instance(IAppLoader).getApp(swf.appNS)
            if app is None:
                return None

            as_packages = None
            appNS = app.appNS
            if appNS == APP_NAME_SPACE.SF_LOBBY:
                as_packages = ['as_lobby']
            elif appNS == APP_NAME_SPACE.SF_BATTLE:
                as_packages = []
                gui_type = avatar_getter.getArena().guiType
                for target, packages in _BATTLE_PACKAGES_MAP.iteritems():
                    if isinstance(target, collections.Iterable):
                        if gui_type in target:
                            as_packages += packages
                            break
                    if target == gui_type:
                        as_packages += packages
                        break
                if not as_packages:
                    as_packages += ['as_battle_classic']
                logger.info('Collected battle SWF mods to load for battle type %s: %s', gui_type, as_packages)
            else:
                return None

            for file in openwg_vfs.directory_list_files(loader.PATH_VFS, True, True):
                if not file.endswith('.swf'):
                    continue
                if file.endswith('_ui.swf') or file.endswith('_view.swf'):
                    continue
                for as_package in as_packages:
                    as_package_dir = os.path.basename(os.path.dirname(file))
                    if as_package == as_package_dir:
                        name = os.path.basename(os.path.dirname(os.path.dirname(file)))
                        swf_loaded_info.swf_name_set(name, '%s%s' % ('../../', file.replace('\\', '/').replace('//', '/')))

            logger.info('getMods: found: %s' % swf_loaded_info.swf_name_get_all())
            return {
                'names': swf_loaded_info.swf_name_get_all(),
                'loaded': swf_loaded_info.swf_loaded_get_all()
            }
        except:
            logger.exception('getMods')
            return None


g_entitiesFactories.addSettings(ViewSettings(
    CONST.XFW_VIEW_ALIAS,
    _XfwInjectorView,
    PATH.XFW_SWF_URL,
    WindowLayer.WINDOW,
    None,
    ScopeTemplates.GLOBAL_SCOPE))

g_entitiesFactories.addSettings(ViewSettings(
    CONST.XFW_COMPONENT_ALIAS,
    _XfwComponent,
    None,
    WindowLayer.UNDEFINED,
    None,
    ScopeTemplates.DEFAULT_SCOPE))
