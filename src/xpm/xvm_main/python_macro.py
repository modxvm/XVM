""" XVM (c) www.modxvm.com 2013-2016 """

import traceback
import ast
import sys
import os
import glob

from xfw import *
from constants import *
from logger import *


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

    def __init__(self):
        super(IllegalChecker, self).__init__()
        self.errors = []

    def visit_Exec(self, node):
        self.errors += 'Illegal statement "exec {}"'.format(node.body.id),

    def visit_Import(self, node):
        names = ', '.join(map(lambda alias: alias.name, node.names))
        self.errors += 'Illegal statement "import {}"'.format(names),

    def visit_ImportFrom(self, node):
        names = ', '.join(map(lambda alias: alias.name, node.names))
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
    def export(namespace, function_name):
        def decorator(func):
            _container.setdefault(namespace, {})
            f = _container.get(namespace).get(function_name)
            if f:
                log('!!! Override {}.{}'.format(namespace, function_name))

            _container[namespace][function_name] = func
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


def execute(code, context):
    try:
        exec(code, context)
    except Exception, e:
        error_name = e.__class__.__name__
        message = e.args[0]
        cl, exc, tb = sys.exc_info()
        line_number = traceback.extract_tb(tb)[-1][1]
        raise ExecutionException("{} at line {}: {}".format(error_name, line_number, message))


def initialize():
    global _container
    _container = {}
    files = glob.iglob(os.path.join(XVM.PY_MACRO_DIR, "*.py"))
    if files:
        for file_name in files:
            load_macros_lib(file_name)


def load_macros_lib(file_name):
    try:
        code = load(file_name)
        execute(code, {'xvm': XvmNamespace})
    except Exception as ex:
        err(traceback.format_exc())
        return None


def get_function(function):
    try:
        left_bracket_pos = function.index('(')
        right_bracket_pos = function.index(')')
        namespace, func_name = function[0:left_bracket_pos].split('.', 2)
        args_string = function[left_bracket_pos: right_bracket_pos + 1]
    except ValueError:
        raise ValueError('Function syntax error')
    args = ast.literal_eval(args_string)
    if not isinstance(args, tuple):
        args = (args,)
    result = _container.get(namespace, {}).get(func_name)
    if not result:
        raise NotImplementedError('Function {}.{} not implemented'.format(namespace, func_name))
    return lambda: result(*args)


def process_python_macro(arg):
    #log('process_python_macro: {}'.format(arg))
    try:
        func = get_function(arg)
        return func()
    except Exception as ex:
        err(traceback.format_exc())
        return None
