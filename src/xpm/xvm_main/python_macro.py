""" XVM (c) www.modxvm.com 2013-2017 """

import traceback
import ast
import sys
import os
import glob

from xfw.constants import PATH
from consts import *
from logger import *


sys.path.append("%s/../configs/xvm/py_macro" % PATH.XFW_MODS_DIR)

# Globals
_container = {}


# Exceptions
class IllegalStatementException(Exception):
    def __init__(self, file_name, messages):
        super(IllegalStatementException, self).__init__('\n\t'.join(messages))
        self.file_name = file_name
        self.messages = messages


class ExecutionException(Exception):
    pass


# Private
# noinspection PyMethodMayBeStatic
class IllegalChecker(ast.NodeVisitor):
    illegal_functions = ('__import__', 'eval', 'execfile')
    illegal_import = ('os', 'sys', 'import_lib')

    def __init__(self):
        super(IllegalChecker, self).__init__()
        self.errors = []

    def visit_Exec(self, node):
        self.errors += 'Illegal statement "exec {}"'.format(node.body.id),

    def visit_Import(self, node):
        names = map(lambda alias: alias.name, node.names)
        illegals = set(names).intersection(self.illegal_import)
        if illegals:
            names = ', '.join(names)
            self.errors += 'Illegal statement "import {}"'.format(names),

    def visit_ImportFrom(self, node):
        if node.module in self.illegal_import:
            names = map(lambda alias: alias.name, node.names)
            names = ', '.join(names)
            self.errors += 'Illegal statement "from {} import {}"'.format(node.module, names),

    def visit_Name(self, node):
        if node.id in self.illegal_functions:
            self.errors += 'Illegal id call "{}"'.format(node.id),

    def visit_Call(self, node):
        if isinstance(node.func, ast.Attribute):
            return
        if node.func.id in self.illegal_functions:
            self.errors += 'Illegal function call "{}"'.format(node.func.id),



class XvmNamespace(object):
    @staticmethod
    def export(function_name, deterministic=True):
        def decorator(func):
            f = _container.get(function_name)
            if f:
                log('[PY_MACRO] Override {}'.format(function_name))
            _container[function_name] = (func, deterministic)
            return func
        return decorator


def __read_file(file_name):
    stream = open(file_name)
    source = stream.read()
    stream.close()
    return source


# Public
def parse(source, file_name='<ast>'):
    node = ast.parse(source)
    v = IllegalChecker()
    v.visit(node)
    if v.errors:
        raise IllegalStatementException(file_name=file_name, messages=v.errors)
    return compile(node, file_name, 'exec')


def load(file_name):
    source = __read_file(file_name)
    return parse(source, file_name)


def execute(code, file_name, context):
    try:
        exec(code, context)
    except Exception, e:
        error_name = e.__class__.__name__
        message = e.args[0]
        cl, exc, tb = sys.exc_info()
        line_number = traceback.extract_tb(tb)[-1][1]
        raise ExecutionException("{} at file '{}' line {}: {}".format(error_name, file_name, line_number, message))


def initialize():
    global _container
    _container = {}
    files = glob.iglob(os.path.join(XVM.PY_MACRO_DIR, "*.py"))
    if files:
        for file_name in files:
            load_macros_lib(file_name)


def load_macros_lib(file_name):
    debug("[PY_MACRO] load_macros_lib('{}')".format(file_name))
    try:
        code = load(file_name)
        execute(code, file_name, {'xvm': XvmNamespace})
    except Exception as ex:
        err(traceback.format_exc())
        return None


def get_function(function):
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


def process_python_macro(arg):
    #log('process_python_macro: {}'.format(arg))
    try:
        (func, deterministic) = get_function(arg)
        return (func(), deterministic)
    except Exception as ex:
        err(traceback.format_exc() + "arg='{}'".format(arg))
        return (None, True)
