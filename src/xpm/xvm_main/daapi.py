""" XVM (c) www.modxvm.com 2013-2016 """

import BigWorld
import GUI
from gui.shared.utils.functions import getBattleSubTypeBaseNumder

from xfw import *

from logger import *
import stats
import python_macro
import xmqp_events

class DAAPI(object):

    def __init__(self, flashObject):
        self.flashObject = flashObject

    def py_xvm_pythonMacro(self, arg):
        #log('py_xvm_pythonMacro: {}'.format(arg))
        return python_macro.process_python_macro(arg)

    def py_xvm_minimapClick(self, path):
        #log('py_xvm_minimapClick: {}'.format(path))
        return xmqp_events.send_minimap_click(path)
