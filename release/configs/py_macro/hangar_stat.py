from datetime import datetime
from helpers import dependency
from skeletons.gui.game_control import IBootcampController
from skeletons.gui.shared import IItemsCache

from xvm_main.python import stats, utils
from xvm_main.python.xvm import Xvm
from xfw.events import registerEvent

timestamp = None


def onUserData(self, data, *args):
    global timestamp
    timestamp = data.get('ts', None)

@registerEvent(Xvm, 'hangarInit')
def hangarInit(self):
    player = utils.getAccountPlayerName()
    if (player is not None) and (timestamp is None):
        stats.getUserData([player], onUserData)

@xvm.export('stat_update', deterministic=False)
def stat_update(formatDate):
    return None if timestamp is None else datetime.fromtimestamp(timestamp / 1000).strftime(formatDate)

@xvm.export('winrate_next')
def winrate_next(diff):
    if dependency.instance(IBootcampController).isInBootcamp():
        return
    itemsCache = dependency.instance(IItemsCache)
    battles = itemsCache.items.getAccountDossier().getRandomStats().getBattlesCount()
    if battles is None:
        return '-'
    wins = itemsCache.items.getAccountDossier().getRandomStats().getWinsCount()
    if wins is None:
        return '-'
    winrate = itemsCache.items.getAccountDossier().getRandomStats().getWinsEfficiency()
    if winrate is None:
        return '-'
    winrate *= 100
    f = winrate - int(winrate)
    if f < diff:
        next = int(winrate) + diff
    elif f + diff < 1:
        next = round(winrate, 2) + diff
    else:
        next = int(winrate) + diff + 1
    value = int((100 * wins - next * battles) / (next - 100)) + 1
    if next == int(next):
        next = int(next)
    return '<font color="#FFC133">{}</font>{}<font color="#FFC133">{}%</font>'.format(value, '{{l10n:toWithSpaces}}', next)
