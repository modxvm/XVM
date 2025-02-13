"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

import ast

#
# Exceptions
#

class IllegalStatementException(Exception):
    def __init__(self, file_name, messages):
        super(IllegalStatementException, self).__init__('\n\t'.join(messages))
        self.file_name = file_name
        self.messages = messages


#
# Illegal Checker
#

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
        if not hasattr(node.func, 'id'):
            return
        if node.func.id in self.illegal_functions:
            self.errors += 'Illegal function call "{}"'.format(node.func.id),


#
# Public
#

def parse(source, file_name='<ast>'):
    node = ast.parse(source)
    v = IllegalChecker()
    v.visit(node)
    if v.errors:
        raise IllegalStatementException(file_name=file_name, messages=v.errors)
    return compile(node, file_name, 'exec')
