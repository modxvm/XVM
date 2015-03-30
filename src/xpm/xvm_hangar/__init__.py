""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO (mandatory)

XFW_MOD_VERSION = '2.0.0'
XFW_MOD_URL = 'http://www.modxvm.com/'
XFW_MOD_UPDATE_URL = 'http://www.modxvm.com/en/download-xvm/'
XFW_GAME_VERSIONS = ['0.9.6','0.9.7']

#####################################################################

import BigWorld

from xfw import *
import xvm_main.python.config as config
from xvm_main.python.logger import *

#####################################################################
# event handlers

#barracks: add nation flag and skills for tanksman
def BarracksMeta_as_setTankmenS(base, self, tankmenCount, placesCount, tankmenInBarracks, berthPrice, actionPriceData, berthBuyCount, tankmanArr):
    try:
        import nations
        from gui.shared import g_itemsCache
        for tankman in tankmanArr:
            tankman['rank'] = tankman['role']
            tankman['role'] = nation_icon = "<img src='img://gui/maps/icons/filters/nations/%s.png' height='14' width='22' vspace='-7'>" % nations.NAMES[tankman['nationID']]
            tankman_full_info = g_itemsCache.items.getTankman(tankman['tankmanID'])
            skills_str = ''
            for skill in tankman_full_info.skills:
                skills_str += "<img src='img://gui/maps/icons/tankmen/skills/small/%s' width='14' height='14' vspace='-3'>" % skill.icon
            if len(tankman_full_info.skills):
                skills_str += "%s%%" % tankman_full_info.descriptor.lastSkillLevel
            if tankman_full_info.hasNewSkill:
                skills_str += "<img src='img://gui/maps/icons/tankmen/skills/small/new_skill.png' width='14' height='14' vspace='-3'>x%s" % tankman_full_info.newSkillCount[0]
            if not skills_str:
                skills_str = l10n('noSkills')
            tankman['role'] += ' ' + skills_str
    except Exception as ex:
        err(traceback.format_exc())
    return base(self, tankmenCount, placesCount, tankmenInBarracks, berthPrice, actionPriceData, berthBuyCount, tankmanArr)

#####################################################################
# Register events

def _RegisterEvents():
    from gui.Scaleform.daapi.view.meta.BarracksMeta import BarracksMeta
    OverrideMethod(BarracksMeta, 'as_setTankmenS', BarracksMeta_as_setTankmenS)

BigWorld.callback(0, _RegisterEvents)
