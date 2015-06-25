""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '3.1.0',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.8.1','0.9.9'],
    # optional
}

#####################################################################

import cgi
import re
import traceback
import BigWorld
from xfw import *
from xvm_main.python.logger import *
import xvm_main.python.config as config

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


def getTipText(text, isError=False):
    text = cgi.escape(text)
    if isError:
        text = re.sub(r'(line #\d+)', r'<font color="#FF4040">\1</font>', text)
        text = re.sub(r'([^/\\]+\.xc)', r'<font color="#FF4040">\1</font>', text)
        text = '<textformat leading="0"><p align="left"><font size="12">{}</font></p></textformat>'.format(text)
    return text


#####################################################################
# Register events

def _RegisterEvents():
    from gui.Scaleform.daapi.view.BattleLoading import BattleLoading
    OverrideMethod(BattleLoading, 'as_setTipTitleS', BattleLoading_as_setTipTitleS)
    OverrideMethod(BattleLoading, 'as_setTipS', BattleLoading_as_setTipS)

BigWorld.callback(0, _RegisterEvents)
