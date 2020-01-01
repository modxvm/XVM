"""
This file is part of the XVM Framework project.

Copyright (c) 2018-2020 XVM Team.

XVM Framework is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation, version 3.

XVM Framework is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
"""

from __future__ import absolute_import

import os
import glob
import logging
import traceback
import itertools
import weakref

from constants import ARENA_GUI_TYPE
from gui import DialogsInterface, SystemMessages
from gui.app_loader.settings import APP_NAME_SPACE
from gui.battle_control import avatar_getter
from gui.shared import g_eventBus, EVENT_BUS_SCOPE
from gui.shared.events import HasCtxEvent, ComponentEvent
from gui.Scaleform.daapi.view import dialogs
from gui.Scaleform.framework import g_entitiesFactories, ViewSettings, ViewTypes, ScopeTemplates
from gui.Scaleform.framework.entities.View import View
from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent
from gui.Scaleform.genConsts.BATTLE_VIEW_ALIASES import BATTLE_VIEW_ALIASES
from helpers import dependency
from skeletons.gui.app_loader import IAppLoader

import xfw_loader.python as loader

from xfw import IS_DEVELOPMENT
from xfw.constants import *
from xfw.logger import *

from . import swf
from .swfloadedinfo import swf_loaded_info

_LOG_COMMANDS = [
    COMMAND.XFW_COMMAND_INITIALIZED,
    XFW_COMMAND.MESSAGEBOX,
]

_WOT_ROOT = '../../../'


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
                logging.info('[XFW/Actionscript] COMMAND_SWF_LOADED: %s' % args[0])
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
                handlers = g_eventBus._EventBus__scopes[EVENT_BUS_SCOPE.DEFAULT][XFW_COMMAND.XFW_CMD]
                for handler in handlers.copy():
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

            as_paths = None
            if app.appNS == APP_NAME_SPACE.SF_LOBBY:
                as_paths = ['as_lobby']
            elif app.appNS == APP_NAME_SPACE.SF_BATTLE:
                as_paths = ['as_battle']
                arenaGuiType = avatar_getter.getArena().guiType
                if arenaGuiType == ARENA_GUI_TYPE.RANKED:
                    as_paths += ['as_battle_ranked']
                elif arenaGuiType == ARENA_GUI_TYPE.EPIC_RANDOM:
                    as_paths += ['as_battle_epicrandom']
                elif arenaGuiType == ARENA_GUI_TYPE.EPIC_BATTLE:
                    as_paths += ['as_battle_epicbattle']
                else:
                    as_paths += ['as_battle_classic']
            else:
                return None

            #TODO: add VFS support
            #TODO: process only successful loaded mods
            mods_dir = loader.XFWLOADER_PACKAGES_REALFS
            if not os.path.isdir(mods_dir):
                logging.warning('[XFW/Actionscript] getMods: directory: %s does not exists' % mods_dir)
                return None

            for as_path in as_paths:
                files = glob.iglob(u'{}/*/{}/*.swf'.format(mods_dir, as_path))
                for m in files:
                    m = '%s%s' % (_WOT_ROOT, str(m).replace('\\', '/').replace('//', '/'))
                    name = os.path.basename(os.path.dirname(os.path.dirname(m)))
                    if not m.lower().endswith('_ui.swf') and not m.lower().endswith('_view.swf'):
                        swf_loaded_info.swf_name_set(name, m)

            logging.info('[XFW/Actionscript] getMods: found: %s' % swf_loaded_info.swf_name_get_all())
            return {
                'names': swf_loaded_info.swf_name_get_all(),
                'loaded': swf_loaded_info.swf_loaded_get_all()
            }

        except:
            err(traceback.format_exc())
        return None


g_entitiesFactories.addSettings(ViewSettings(
    CONST.XFW_VIEW_ALIAS,
    _XfwInjectorView,
    PATH.XFW_SWF_URL,
    ViewTypes.WINDOW,
    None,
    ScopeTemplates.GLOBAL_SCOPE))

g_entitiesFactories.addSettings(ViewSettings(
    CONST.XFW_COMPONENT_ALIAS,
    _XfwComponent,
    None,
    ViewTypes.COMPONENT,
    None,
    ScopeTemplates.DEFAULT_SCOPE))
