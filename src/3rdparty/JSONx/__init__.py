__author__ = 'Alex'


from . import ast
from . import lexer
from . import parser
from . import utils
from .exception import JSONxException


def parse(source):
    visitor = ast.JSONxVisitor()
    tokens = lexer.tokenize(source)
    json_ast = parser.parse(tokens)
    return visitor.visit(json_ast)
