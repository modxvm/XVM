"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
"""

#
# Imports
#

# stdlib
import sys
import os
import glob
import traceback
import logging
import ast
import compileall

# XFW Loader
from xfw_loader.python import XFWLOADER_PATH_TO_ROOT

# XVM Main
from xvm_main.python.consts import *
from xvm_main.python.logger import *

# XVM PyMacro
import parser



#
# Globals
#

_container = {}


#
# Classes and exceptions
#

class ExecutionException(Exception):
    pass


class XvmNamespace(object):
    @staticmethod
    def export(function_name, deterministic=True):
        def decorator(func):
            f = _container.get(function_name)
            if f:
                logging.getLogger('XVM/PyMacro').info('Override {}'.format(function_name))
            _container[function_name] = (func, deterministic)
            return func
        return decorator


#
# Private
#

def __compile():
    for root, dirnames, _ in os.walk(XFWLOADER_PATH_TO_ROOT + "res_mods/configs/xvm/py_macro/"):
        for dirname in dirnames:
            compileall.compile_dir(os.path.join(root, dirname), quiet = 1)


def __read_file(file_name):
    stream = open(file_name)
    source = stream.read()
    stream.close()
    return source


def __execute(code, file_name, context):
    try:
        exec(code, context)
    except Exception as e:
        error_name = e.__class__.__name__
        message = e.args[0]
        cl, exc, tb = sys.exc_info()
        line_number = traceback.extract_tb(tb)[-1][1]
        raise ExecutionException("{} at file '{}' line {}: {}".format(error_name, file_name, line_number, message))


def __load_lib(file_name):
    # TODO: fixup DEBUG loglevel for stdlib logging
    logging.getLogger('XVM/PyMacro').info("__load_lib('{}')".format(file_name.replace('\\', '/').replace(XVM.CONFIG_DIR, '[cfg]')))
    try:
        code = parser.parse(__read_file(file_name), file_name)
        __execute(code, file_name, {'xvm': XvmNamespace})
    except Exception:
        logging.getLogger('XVM/PyMacro').exception('__load_lib')
        return None


def __get_function(function):
    try:
        if function.find('(') == -1:
            function += '()'
        left_bracket_pos = function.index('(')
        right_bracket_pos = function.rindex(')')
        func_name = function[0:left_bracket_pos]
        args_string = function[left_bracket_pos: right_bracket_pos + 1]
    except ValueError:
        raise ValueError('Function syntax error: {}'.format(function))
    args = ast.literal_eval(args_string)
    if not isinstance(args, tuple):
        args = (args,)
    (func, deterministic) = _container.get(func_name)
    if not func:
        raise NotImplementedError('Function {} not implemented'.format(func_name))
    return (lambda: func(*args), deterministic)


def __reload(e=None):
    __compile()

    global _container
    _container = {}
    files = glob.iglob(os.path.join(XVM.PY_MACRO_DIR, "*.py"))
    if files:
        for file_name in files:
            __load_lib(file_name)


def __initialize():
    trace('xvm_main.python.python_macro::initialize()')

    sys.path.append(XFWLOADER_PATH_TO_ROOT + "res_mods/configs/xvm/py_macro")
    __reload()
#
#     g_eventBus.addListener(XVM_EVENT.CONFIG_LOADED, __reload)
#
#
# def __finalize():
#     g_eventBus.removeListener(XVM_EVENT.CONFIG_LOADED, __reload)


#
# Public
#

def process(arg):
    try:
        (func, deterministic) = __get_function(arg)
        return (func(), deterministic)
    except Exception:
        logging.getLogger('XVM/PyMacro').exception("process: arg='{}'".format(arg))
        return (None, True)


#
# XFW Mod initialization
#

__xvm_main_loaded = False

def xfw_module_init():
    __initialize()

    global __xvm_main_loaded
    __xvm_main_loaded = True


def xfw_is_module_loaded():
    return __xvm_main_loaded
