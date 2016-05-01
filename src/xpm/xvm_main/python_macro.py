""" XVM (c) www.modxvm.com 2013-2016 """

import traceback
import importlib
import ast

from xfw import *

from logger import *

def processPythonMacro(arg):
    #log('processPythonMacro: {}'.format(arg))
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
