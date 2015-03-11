""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO (mandatory)

XFW_MOD_VERSION    = "2.0.0"
XFW_MOD_URL        = "http://www.modxvm.com/"
XFW_MOD_UPDATE_URL = "http://www.modxvm.com/en/download-xvm/"
XFW_GAME_VERSIONS  = ["0.9.6"]

#####################################################################

import BigWorld

from xfw import *
import xvm_main.python.config as config
from xvm_main.python.logger import *

import wg_compat

#####################################################################
# constants

class CREW(object):
    DROP_ALL_CREW = 'DropAllCrew'
    PUT_OWN_CREW = 'PutOwnCrew'
    PUT_BEST_CREW = 'PutBestCrew'
    PUT_CLASS_CREW = 'PutClassCrew'
    PUT_PREVIOUS_CREW = 'PutPreviousCrew'

class COMMANDS(object):
    PUT_OWN_CREW = 'xvm_crew.as_PutOwnCrew'
    PUT_BEST_CREW = 'xvm_crew.as_PutBestCrew'
    PUT_CLASS_CREW = 'xvm_crew.as_PutClassCrew'

#####################################################################
# event handlers

def CrewContextMenuHandler__init__(base, self, cmProxy, ctx=None):
    # debug('CrewContextMenuHandler__init__')
    import gui.Scaleform.daapi.view.lobby.hangar.hangar_cm_handlers as crew
    super(crew.CrewContextMenuHandler, self).__init__(cmProxy, ctx, {
        crew.CREW.PERSONAL_CASE: 'showPersonalCase',
        crew.CREW.UNLOAD: 'unloadTankman',
        CREW.DROP_ALL_CREW: CREW.DROP_ALL_CREW,
        CREW.PUT_OWN_CREW: CREW.PUT_OWN_CREW,
        CREW.PUT_BEST_CREW: CREW.PUT_BEST_CREW,
        CREW.PUT_CLASS_CREW: CREW.PUT_CLASS_CREW,
        CREW.PUT_PREVIOUS_CREW: CREW.PUT_PREVIOUS_CREW,
    })
    self._cmProxy = cmProxy

def CrewContextMenuHandler_generateOptions(base, self):
    # debug('CrewContextMenuHandler_generateOptions')
    if self._tankmanID:
        return base(self) + [
            self._makeSeparator(),
            self._makeItem(CREW.DROP_ALL_CREW, l10n(CREW.DROP_ALL_CREW)),
        ]
    else:
        return [
            self._makeItem(CREW.PUT_OWN_CREW, l10n(CREW.PUT_OWN_CREW)),
            self._makeSeparator(),
            self._makeItem(CREW.PUT_BEST_CREW, l10n(CREW.PUT_BEST_CREW)),
            self._makeSeparator(),
            self._makeItem(CREW.PUT_CLASS_CREW, l10n(CREW.PUT_CLASS_CREW)),
            self._makeSeparator(),
            self._makeItem(CREW.PUT_PREVIOUS_CREW, l10n(CREW.PUT_PREVIOUS_CREW)),
        ]

#####################################################################
# Menu item handlers

def DropAllCrew(self):
    from gui.Scaleform.daapi.view.lobby.hangar.Crew import Crew
    Crew.unloadCrew()

def PutOwnCrew(self):
    as_xvm_cmd(COMMANDS.PUT_OWN_CREW)

def PutBestCrew(self):
    as_xvm_cmd(COMMANDS.PUT_BEST_CREW)

def PutClassCrew(self):
    as_xvm_cmd(COMMANDS.PUT_CLASS_CREW)

def PutPreviousCrew(self, print_message = True):
    wg_compat.g_instance.processReturnCrew(print_message)

def ClientHangarSpace_PutPreviousCrew(self, vDesc, vState, onVehicleLoadedCallback = None):
    if config.config['hangar']['autoPutPreviousCrewInTanks']:
        PutPreviousCrew(self, False)

#####################################################################
# Register events

def _RegisterEvents():
    from gui.Scaleform.daapi.view.lobby.hangar.hangar_cm_handlers import CrewContextMenuHandler
    OverrideMethod(CrewContextMenuHandler, '__init__', CrewContextMenuHandler__init__)
    OverrideMethod(CrewContextMenuHandler, '_generateOptions', CrewContextMenuHandler_generateOptions)
    CrewContextMenuHandler.DropAllCrew = DropAllCrew
    CrewContextMenuHandler.PutOwnCrew = PutOwnCrew
    CrewContextMenuHandler.PutBestCrew = PutBestCrew
    CrewContextMenuHandler.PutClassCrew = PutClassCrew
    CrewContextMenuHandler.PutPreviousCrew = PutPreviousCrew
    from gui.ClientHangarSpace import ClientHangarSpace
    RegisterEvent(ClientHangarSpace, 'recreateVehicle', ClientHangarSpace_PutPreviousCrew)

BigWorld.callback(0, _RegisterEvents)
