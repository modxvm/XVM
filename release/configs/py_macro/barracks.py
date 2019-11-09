import gui.Scaleform.daapi.view.lobby.barracks.Barracks as barrack
import nations
from gui.Scaleform.locale.MENU import MENU
from gui.Scaleform.locale.TOOLTIPS import TOOLTIPS
from gui.shared.gui_items.Tankman import Tankman

import xvm_main.python.config as config
from xfw import *

# sorting in the barracks
@overrideMethod(barrack.Barracks, '_Barracks__showActiveTankmen')
def __showActiveTankmen(base, self, criteria):

    def keySorted(_tankman):
        # vehicle = self.itemsCache.items.getVehicle(_tankman.vehicleInvID)
        keys = {'nation': nations_order.get(_tankman.nationID, nations.NONE_INDEX),
                'inVehicle': _tankman.isInTank,
                '-inVehicle': -_tankman.isInTank,
                'vehicle': _tankman.vehicleNativeDescr.type.userString, #vehicle.invID if vehicle is not None else _tankman.lastUserName,
                'role': roles_order.get(_tankman.descriptor.role, 10),
                # 'lastUserName': _tankman.lastUserName,
                'XP': _tankman.descriptor.totalXP(),
                '-XP': -_tankman.descriptor.totalXP(),
                'level': _tankman.vehicleNativeDescr.type.level,
                '-level': -_tankman.vehicleNativeDescr.type.level,
                'gender': _tankman.isFemale,
                '-gender': -_tankman.isFemale}
        return tuple(keys.get(x, None) for x in sorting_criteria)

    cfg_barracks = config.get('hangar/barracks')
    if not cfg_barracks:
        return base(self, criteria)
    sorting_criteria = cfg_barracks.get('sorting_criteria', False)
    if not sorting_criteria:
        return base(self, criteria)
    sorting_criteria = [criterion.replace(' ', '') for criterion in sorting_criteria]
    _nations = cfg_barracks.get('nations_order', False)
    if _nations:
        nations_order = {nations.INDICES[name]: idx for idx, name in enumerate(_nations)}
    else:
        nations_order = {idx: idx for idx, name in enumerate(nations.AVAILABLE_NAMES)}
    _roles = cfg_barracks.get('roles_order', False)
    if _roles:
        roles_order = {name: idx for idx, name in enumerate(_roles)}
    else:
        roles_order = Tankman.TANKMEN_ROLES_ORDER

    allTankmen = self.itemsCache.items.getTankmen().values()
    tankmenInBarracks = 0
    tankmenList = [barrack._packBuyBerthsSlot()]
    for tankman in sorted(allTankmen, key=keySorted):
        if not tankman.isInTank:
            tankmenInBarracks += 1
        if not criteria(tankman):
            continue
        tankmanData = barrack._packTankmanData(tankman)
        if tankmanData is not None:
            if tankman.isInTank:
                actionBtnLabel = MENU.BARRACKS_BTNUNLOAD
                actionBtnTooltip = TOOLTIPS.BARRACKS_TANKMEN_UNLOAD
            else:
                actionBtnLabel = MENU.BARRACKS_BTNDISSMISS
                actionBtnTooltip = TOOLTIPS.BARRACKS_TANKMEN_DISMISS
            tankmanData.update({'isRankNameVisible': True,
                                'recoveryPeriodText': None,
                                'actionBtnLabel': actionBtnLabel,
                                'actionBtnTooltip': actionBtnTooltip,
                                'skills': None,
                                'isSkillsVisible': False})
            tankmenList.append(tankmanData)

    tankmenInSlots = len(tankmenList) - 1
    slots = self.itemsCache.items.stats.tankmenBerthsCount
    if tankmenInBarracks < slots:
        tankmenList.insert(1, {'empty': True,
                               'freePlaces': slots - tankmenInBarracks})
    self.as_setTankmenS({'tankmenCount': self._Barracks__getTankmenCountStr(tankmenInSlots=tankmenInSlots, totalCount=len(allTankmen)),
                         'placesCount': self._Barracks__getPlaceCountStr(free=max(slots - tankmenInBarracks, 0), totalCount=slots),
                         'placesCountTooltip': None,
                         'tankmenData': tankmenList,
                         'hasNoInfoData': False})
    return
