""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO (mandatory)

XFW_MOD_VERSION = '3.0.0'
XFW_MOD_URL = 'http://www.modxvm.com/'
XFW_MOD_UPDATE_URL = 'http://www.modxvm.com/en/download-xvm/'
XFW_GAME_VERSIONS  = ['0.9.7','0.9.8']

#####################################################################

import traceback

import BigWorld

from xfw import *
import xvm_main.python.config as config
from xvm_main.python.logger import *
from xvm_main.python.xvm import l10n

#####################################################################
# event handlers

#barracks: add nation flag and skills for tanksman
def BarracksMeta_as_setTankmenS(base, self, tankmenCount, placesCount, tankmenInBarracks, tankmanArr):
    try:
        import nations
        from gui.shared import g_itemsCache
        imgPath = 'img://../mods/shared_resources/xvm/res/icons/barracks'
        for tankman in tankmanArr:
            if 'role' not in tankman:
                continue
            tankman['rank'] = tankman['role']
            tankman['role'] = "<img src='%s/nations/%s.png' vspace='-3'>" % (imgPath, nations.NAMES[tankman['nationID']])
            tankman_full_info = g_itemsCache.items.getTankman(tankman['tankmanID'])
            skills_str = ''
            for skill in tankman_full_info.skills:
                skills_str += "<img src='%s/skills/%s' vspace='-3'>" % (imgPath, skill.icon)
            if len(tankman_full_info.skills):
                skills_str += "%s%%" % tankman_full_info.descriptor.lastSkillLevel
            if tankman_full_info.hasNewSkill:
                skills_str += "<img src='%s/skills/new_skill.png' vspace='-3'>x%s" % (imgPath, tankman_full_info.newSkillCount[0])
            if not skills_str:
                skills_str = l10n('noSkills')
            tankman['role'] += ' ' + skills_str
    except Exception as ex:
        err(traceback.format_exc())

    return base(self, tankmenCount, placesCount, tankmenInBarracks, tankmanArr)

#####################################################################
# Register events

def _RegisterEvents():
    from gui.Scaleform.daapi.view.meta.BarracksMeta import BarracksMeta
    OverrideMethod(BarracksMeta, 'as_setTankmenS', BarracksMeta_as_setTankmenS)

BigWorld.callback(0, _RegisterEvents)
