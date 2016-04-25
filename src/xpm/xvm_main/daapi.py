""" XVM (c) www.modxvm.com 2013-2015 """

import BigWorld
import GUI
from gui.shared.utils.functions import getBattleSubTypeBaseNumder

from xfw import *

from logger import *
import stats
import python_macro

class DAAPI(object):

    def __init__(self, flashObject):
        self.flashObject = flashObject

    def py_xvm_log(self, *args):
        log(*args)

    def py_xvm_getScreenSize(self):
        return GUI.screenResolution()

    def py_xvm_captureBarGetBaseNumText(self, id):
        n = int(id)
        return getBattleSubTypeBaseNumder(BigWorld.player().arenaTypeID, n & 0x3F, n >> 6)

    def py_xvm_loadBattleStat(self):
        stats.getBattleStat(None, self.flashObject)

    def py_xvm_pythonMacro(self, arg):
        #log('py_xvm_pythonMacro: {}'.format(arg))
        return python_macro.processPythonMacro(arg)
