__author__ = 'Alex'


import lexer
import parser
import utils
import JSONx.ast
from exception import JSONxException


def parse(source):
    visitor = JSONx.ast.JSONxVisitor()
    tokens = lexer.tokenize(source)
    json_ast = parser.parse(tokens)
    return visitor.visit(json_ast)
