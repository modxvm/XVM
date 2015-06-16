""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '3.1.0',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.8.1'],
    # optional
}

#####################################################################

import traceback
import BigWorld
from xfw import *
from xvm_main.python.logger import *
import xvm_main.python.config as config

def BattleResultsWindow_as_setDataS(base, self, data):
    try:
#            var origCrewXP:int = xdata.tmenXP / (xdata.isPremium ? (xdata.premiumXPFactor10 / 10.0) : 1);
#            var premCrewXP:int = xdata.tmenXP * (xdata.isPremium ? 1 : (xdata.premiumXPFactor10 / 10.0));
#            var vdata:VehicleData = VehicleInfo.get(xdata.typeCompDescr);
#            if (vdata != null && vdata.premium)
#            {
#                origCrewXP *= 1.5;
#                premCrewXP *= 1.5;
#            }
#        private function calcDetails(field:String):Number
#        {
#            var n:int = 0;
#            for each (var obj:Object in _data.personal.details)
#            {
#                var v:* = obj[field];
#                if (v is String)
#                    n += int(parseInt(v));
#                else if (v is Boolean)
#                    n += v == true ? 1 : 0
#                else
#                    n += int(v);
#            }
#            return n;
#        }
#
#        private function getTotalSpotted():Number
#        {
#            return calcDetails("spotted");
#        }
#
#        private function getTotalAssistCount():Number
#        {
#            var n:int = 0;
#            for each (var obj:Object in _data.personal.details)
#            {
#                if (obj["damageAssistedRadio"] != 0 || obj["damageAssistedTrack"] != 0)
#                    n++;
#            }
#            return n;
#        }
#
#        private function getTotalCritsCount():Number
#        {
#            return calcDetails("critsCount");
#        }

        xdata = {
            '__xvm': True, # XVM data marker
            'typeCompDescr': 0,
            'origXP': 0,
            'premXP': 0,
            'shots': 0,
            'hits': 0,
            'damageDealt': 0,
            'damageAssisted': 0,
            'damageAssistedCount': 0,
            'damageAssistedRadio': 0,
            'damageAssistedTrack': 0,
            'damageAssistedNames': 0,
            'piercings': 0,
            'kills': 0,
            'origCrewXP': 0,
            'premCrewXP': 0,
            'spotted': 0,
            'critsCount': 0,
            'creditsNoPremTotalStr': '',
            'creditsPremTotalStr': '',
        }

        # Use first vehicle item for transferring XVM data.
        # Cannot add to data object because DAAPIDataClass is not dynamic.
        data['vehicles'].insert(0, xdata)
    except Exception as ex:
        err(traceback.format_exc())
    return base(self, data)


#####################################################################
# Register events

def _RegisterEvents():
    from gui.Scaleform.daapi.view.BattleResultsWindow import BattleResultsWindow
    OverrideMethod(BattleResultsWindow, 'as_setDataS', BattleResultsWindow_as_setDataS)

BigWorld.callback(0, _RegisterEvents)
