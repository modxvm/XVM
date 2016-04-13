""" XVM (c) www.modxvm.com 2013-2015 """

import traceback
import importlib
import ast

import BigWorld
import GUI
from gui.shared.utils.functions import getBattleSubTypeBaseNumder

from xfw import *

from logger import *


class _DAAPI(object):

    def py_xvm_log(self, *args):
        log(*args)

    def py_xvm_pythonMacro(self, arg):
        #log('py_xvm_pythonMacro: {}'.format(arg))
        try:
            macro_args = arg.split('(', 1)
            if len(macro_args) < 2:
                err('Wrong python macro: %s' % arg)
                return None
            module, method = macro_args[0].strip().rsplit('.', 1)
            met = getattr(importlib.import_module(module), method)
            args = list(ast.literal_eval('[' + macro_args[1].rsplit(')',1)[0] + ']'))
            return met(*args)
        except Exception as ex:
            err(traceback.format_exc())
            return None

    def py_xvm_getScreenSize(self):
        return GUI.screenResolution()

    def py_xvm_captureBarGetBaseNumText(self, id):
        n = int(id)
        return getBattleSubTypeBaseNumder(BigWorld.player().arenaTypeID, n & 0x3F, n >> 6)

g_daapi = _DAAPI()
