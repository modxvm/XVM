""" XVM (c) www.modxvm.com 2013-2017 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '0.9.17.1',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.17.1'],
    # optional
}


#####################################################################
# imports

import BigWorld
import game
from gui.shared import g_eventBus, g_itemsCache
from CurrentVehicle import g_currentVehicle
from gui.Scaleform.daapi.view.lobby.hangar.Crew import Crew
from gui.Scaleform.daapi.view.lobby.hangar.hangar_cm_handlers import CrewContextMenuHandler
from gui.Scaleform.daapi.view.lobby.hangar.hangar_cm_handlers import CREW as WG_CREW
from gui.Scaleform.daapi.view.lobby.hangar.TmenXpPanel import TmenXpPanel
from gui.Scaleform.daapi.view.lobby.cyberSport.VehicleSelectorPopup import VehicleSelectorPopup

from xfw import *

import xvm_main.python.config as config
from xvm_main.python.logger import *
from xvm_main.python.xvm import l10n
import xvm_main.python.userprefs as userprefs

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
    PUT_PREVIOUS_CREW = 'xvm_crew.put_previous_crew'
    AS_VEHICLE_CHANGED = 'xvm_crew.as_vehicle_changed'
    AS_PUT_OWN_CREW = 'xvm_crew.as_put_own_crew'
    AS_PUT_BEST_CREW = 'xvm_crew.as_put_best_crew'
    AS_PUT_CLASS_CREW = 'xvm_crew.as_put_class_crew'


#####################################################################
# initialization/finalization

def start():
    g_eventBus.addListener(XFWCOMMAND.XFW_CMD, onXfwCommand)

BigWorld.callback(0, start)


@registerEvent(game, 'fini')
def fini():
    g_eventBus.removeListener(XFWCOMMAND.XFW_CMD, onXfwCommand)


#####################################################################
# onXfwCommand

# returns: (result, status)
def onXfwCommand(cmd, *args):
    try:
        if cmd == COMMANDS.PUT_PREVIOUS_CREW:
            if g_currentVehicle.isInHangar() and not (g_currentVehicle.isCrewFull() or g_currentVehicle.isInBattle() or g_currentVehicle.isLocked()):
                PutPreviousCrew(g_currentVehicle, False)
            return (None, True)
    except Exception, ex:
        err(traceback.format_exc())
        return (None, True)
    return (None, False)


#####################################################################
# handlers

@overrideMethod(CrewContextMenuHandler, '__init__')
def CrewContextMenuHandler__init__(base, self, cmProxy, ctx=None):
    # debug('CrewContextMenuHandler__init__')
    super(CrewContextMenuHandler, self).__init__(cmProxy, ctx, {
        WG_CREW.PERSONAL_CASE: 'showPersonalCase',
        WG_CREW.UNLOAD: 'unloadTankman',
        CREW.DROP_ALL_CREW: CREW.DROP_ALL_CREW,
        CREW.PUT_OWN_CREW: CREW.PUT_OWN_CREW,
        CREW.PUT_BEST_CREW: CREW.PUT_BEST_CREW,
        CREW.PUT_CLASS_CREW: CREW.PUT_CLASS_CREW,
        CREW.PUT_PREVIOUS_CREW: CREW.PUT_PREVIOUS_CREW,
    })
    self._cmProxy = cmProxy


@overrideMethod(CrewContextMenuHandler, '_generateOptions')
def CrewContextMenuHandler_generateOptions(base, self, ctx = None):
    # debug('CrewContextMenuHandler_generateOptions')
    if self._tankmanID:
        return base(self, ctx) + [
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


@registerEvent(TmenXpPanel, '_onVehicleChange')
def TmenXpPanel_onVehicleChange(self):
    #log('TmenXpPanel_onVehicleChange')
    if config.get('hangar/enableCrewAutoReturn'):
        vehicle = g_currentVehicle.item
        invID = g_currentVehicle.invID if vehicle is not None else 0
        isElite = vehicle.isElite if vehicle is not None else 0
        as_xfw_cmd(COMMANDS.AS_VEHICLE_CHANGED, invID, isElite)


@registerEvent(VehicleSelectorPopup, 'onSelectVehicles', True)
def VehicleSelectorPopup_onSelectVehicles(self, items):
    try:
        if len(items) == 1:
            cd = int(items[0])
            vehicle = g_itemsCache.items.getItemByCD(cd)
            if vehicle and vehicle.isInInventory and not (vehicle.isCrewFull or vehicle.isInBattle or vehicle.isLocked):
                if config.get('hangar/enableCrewAutoReturn') and userprefs.get('xvm_crew/auto_prev_crew/%s' % vehicle.invID, True):
                    wg_compat.g_instance.processReturnCrewForVehicleSelectorPopup(vehicle)
    except Exception, ex:
        err(traceback.format_exc())


#####################################################################
# Menu item handlers

def DropAllCrew(self):
    Crew.unloadCrew()


def PutOwnCrew(self):
    as_xfw_cmd(COMMANDS.AS_PUT_OWN_CREW)


def PutBestCrew(self):
    as_xfw_cmd(COMMANDS.AS_PUT_BEST_CREW)


def PutClassCrew(self):
    as_xfw_cmd(COMMANDS.AS_PUT_CLASS_CREW)


def PutPreviousCrew(self, print_message = True):
    wg_compat.g_instance.processReturnCrew(print_message)


CrewContextMenuHandler.DropAllCrew = DropAllCrew
CrewContextMenuHandler.PutOwnCrew = PutOwnCrew
CrewContextMenuHandler.PutBestCrew = PutBestCrew
CrewContextMenuHandler.PutClassCrew = PutClassCrew
CrewContextMenuHandler.PutPreviousCrew = PutPreviousCrew
