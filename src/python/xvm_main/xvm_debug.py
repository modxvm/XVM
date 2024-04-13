"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
"""

from xfw import *

#############################
# Command

from gui.shared import events, g_eventBus
from gui.shared import event_dispatcher as shared_events

def onHangarInit():
    # debug
    if IS_DEVELOPMENT:
        import glob
        files = glob.glob("[0-9]*.dat")
        if files:
            for fn in files:
                log('[TEST]  battle result: {}'.format(fn))
                runTest(('battleResults', fn))

        #import gui.awards.event_dispatcher as shared_events
        #from helpers import dependency
        #from skeletons.gui.goodies import IGoodiesCache
        #goodiesCache = dependency.instance(IGoodiesCache)
        #shared_events.showBoosterAward(goodiesCache.getBooster(5022))

        # Load Views
        #g_eventBus.handleEvent(events.LoadViewEvent('profileWindow', 'profileWindow_519821', {'userName': 'TurinDeNar', 'databaseID': 519821}), 1)

        # Show User profile
        def onDossierReceived(databaseID, userName):
            shared_events.showProfileWindow(databaseID, userName)
        #shared_events.requestProfile(31996, 'Jade', successCallback=onDossierReceived)


def runTest(args):
    if args is not None:
        cmd = args[0]
        if cmd == 'battleResults':
            _showBattleResults(int(args[1][:-4]))


#############################
# imports

import os
import cPickle
import traceback

import AccountCommands
from account_helpers import BattleResultsCache
from helpers import dependency
from gui.shared.utils import decorators
from gui.battle_results import RequestResultsContext
from skeletons.gui.battle_results import IBattleResultsService

from logger import *


#############################
# BattleResults

@decorators.adisp_process('loadStats')
def _showBattleResults(arenaUniqueID):
    if IS_DEVELOPMENT:
        battleResults = dependency.instance(IBattleResultsService)
        ctx = RequestResultsContext(arenaUniqueID, showImmediately=False, showIfPosted=True, resetCache=False)
        yield battleResults.requestResults(ctx)

#@decorators.adisp_process('loadStats')
#def _showWindow(self, notification, arenaUniqueID):
#    uniqueID = long(arenaUniqueID)
#    result = yield self.battleResults.requestResults(RequestResultsContext(uniqueID, showImmediately=False, showIfPosted=True, resetCache=False))
#    if not result:
#        self._updateNotification(notification)

if IS_DEVELOPMENT:
    try:
        import gui.mods.mod_battle_results_fix
    except:
        pass

@overrideMethod(BattleResultsCache.BattleResultsCache, 'get')
def BattleResultsCache_get(base, self, arenaUniqueID, callback):
    if not IS_DEVELOPMENT:
        return base(self, arenaUniqueID, callback)

    fileHandler = None
    try:
        #log('get: ' + str(callback))
        filename = '{0}.dat'.format(arenaUniqueID)
        if not os.path.exists(filename):
            base(self, arenaUniqueID, callback)
        else:
            fileHandler = open(filename, 'rb')
            version, battleResults = cPickle.load(fileHandler)
            if battleResults is not None:
                if callback is not None:
                    #log('callback: ' + str(callback))
                    callback(AccountCommands.RES_CACHE, BattleResultsCache.convertToFullForm(battleResults))
    except Exception as ex:
        err(traceback.format_exc())
        base(self, arenaUniqueID, callback)

    if fileHandler is not None:
        fileHandler.close()

#############################
# DEBUG events

#from gui.shared import events
#from gui.shared.event_bus import EventBus, EVENT_BUS_SCOPE
#
#@overrideMethod(EventBus, 'handleEvent')
#def _EventBus_handleEvent(base, self, event, scope=EVENT_BUS_SCOPE.DEFAULT):
#    if isinstance(event, events.LoadViewEvent):
#        log('EVENT: class={} alias={} name={} ctx={} scope={}'.format(event.__class__.__name__, event.eventType, event.name, event.ctx, scope))
#    elif isinstance(event, events.HasCtxEvent):
#        log('EVENT: class={} eventType={} ctx={} scope={}'.format(event.__class__.__name__, event.eventType, event.ctx, scope))
#    #else:
#    #    log('EVENT: class={} scope={}'.format(event.__class__.__name__, scope))
#    base(self, event, scope)
