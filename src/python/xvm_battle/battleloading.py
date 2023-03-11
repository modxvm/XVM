"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2022 XVM Contributors
"""

#
# Imports
#

# stdlib
import cgi
import re

# BigWorld
from gui.Scaleform.daapi.view.battle.shared.battle_loading import BattleLoading

# XFW
from xfw.events import overrideMethod

# XVM Main
import xvm_main.python.config as config



#
# Handlers
#

def BattleLoading_as_setTipTitleS(base, self, title):
    title = cgi.escape('XVM v{}     {}'.format(config.get('__xvmVersion'), config.get('__xvmIntro')))
    stateInfo = config.get('__stateInfo')
    if 'error' in stateInfo:
        title = '<font color="#FF4040">{}</font>'.format(title)
    elif 'warning' in stateInfo:
        title = '<font color="#FFD040">{}</font>'.format(title)
    title = '<p align="left"><font size="16">{}</font></p>'.format(title)
    return base(self, title)


def BattleLoading_as_setTipS(base, self, val):
    stateInfo = config.get('__stateInfo')
    if 'error' in stateInfo and stateInfo['error']:
        val = getTipText(stateInfo['error'], True)
    elif 'warning' in stateInfo and stateInfo['warning']:
        val = getTipText(stateInfo['warning'])
    return base(self, val)



#
# Helpers
#

def getTipText(text, isError=False):
    text = cgi.escape(text)
    if isError:
        text = re.sub(r'(line #\d+)', r'<font color="#FF4040">\1</font>', text)
        text = re.sub(r'([^/\\]+\.xc)', r'<font color="#FF4040">\1</font>', text)
        text = '<textformat leading="0"><p align="left"><font size="12">{}</font></p></textformat>'.format(text)
    return text



#
# Initialization
#

def init():
    overrideMethod(BattleLoading, 'as_setTipTitleS')(BattleLoading_as_setTipTitleS)
    overrideMethod(BattleLoading, 'as_setTipS')(BattleLoading_as_setTipS)

def fini():
    pass
