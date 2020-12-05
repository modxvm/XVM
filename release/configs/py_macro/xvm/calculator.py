from math import sin, cos, asin, acos, radians, degrees
from operator import add, sub, mul, truediv


OPERATOR_FUNCTIONS = {'+': add,
                      '-': sub,
                      '*': mul,
                      '/': truediv,
                      '^': pow,
                      'sin': lambda x: sin(radians(x)),
                      'cos': lambda x: cos(radians(x)),
                      'asin': lambda x: degrees(asin(x)),
                      'acos': lambda x: degrees(acos(x))}

OPERATORS = OPERATOR_FUNCTIONS.keys()
BRACKETS = ['(', ')']

OPERATOR = 1
ARGUMENT = 2


class Token(object):
    PRIORITY = {'+': 1,
                '-': 1,
                '*': 2,
                '/': 2,
                '^': 3}

    ONE_ARGUMENT = frozenset({'sin', 'cos', 'asin', 'acos'})

    def __init__(self, category, value):
        self.__type = category
        self.__str_t = value

        try:
            self.__value = float(value) if category == ARGUMENT else value
        except ValueError:
            self.__value = None

        if category == OPERATOR:
            if self.__value not in (OPERATORS + BRACKETS):
                self.__value = None
            self.__priority = self.PRIORITY.get(self.__value, 0)
            self.__count_arg = 1 if self.__value in self.ONE_ARGUMENT else 2
        else:
            self.__priority = None
            self.__count_arg = None

    @property
    def category(self):
        return self.__type

    @property
    def value(self):
        return self.__value

    @value.setter
    def value(self, _value):
        self.__value = _value

    @property
    def priority(self):
        return self.__priority

    @property
    def countArg(self):
        return self.__count_arg


def calculation(postfix_expression):
    stack = []
    for token in postfix_expression:
        if token.category == ARGUMENT:
            stack.append(token.value)
        else:
            try:
                if token.countArg == 2:
                    if (token.value == '-' or token.value == '+') and len(stack) == 1:
                        arg1, arg2 = stack.pop(), 0
                    else:
                        arg1, arg2 = stack.pop(), stack.pop()
                    stack.append(OPERATOR_FUNCTIONS[token.value](arg2, arg1))
                else:
                    arg = stack.pop()
                    stack.append(OPERATOR_FUNCTIONS[token.value](arg))
            except IndexError:
                return None
    return stack.pop()


def getPostfix(infix_expression):
    postfix_expression = []
    stack = []
    for token in infix_expression:
        if token.category == ARGUMENT:
            postfix_expression.append(token)
        elif token.category == OPERATOR:
            if token.value == '(':
                stack.append(token)
            elif token.value == ')':
                while stack and stack[-1].value != '(':
                    postfix_expression.append(stack.pop())
                if stack and stack[-1].value == '(':
                    stack.pop()
                else:
                    return None
            else:
                while stack and (token.priority > 0) and (stack[-1].priority >= token.priority):
                    postfix_expression.append(stack.pop())
                stack.append(token)
    stack.reverse()
    return postfix_expression + stack


def getInfix(expression):
    infix_expression = []
    len_expression = len(expression)
    index = begin_i = 0
    unary_minus = 0
    maybe_unary = 0
    while index < len_expression:
        prev_index = index

        while index < len_expression and (expression[index].isdigit() or expression[index] == '.'):
            index += 1
        if index > begin_i:
            infix_expression.append(Token(ARGUMENT, expression[begin_i: index]))
            begin_i = index
            if maybe_unary:
                infix_expression[-1].value = maybe_unary * infix_expression[-1].value
                maybe_unary = 0
            while unary_minus > 0:
                infix_expression[-1].value = - infix_expression[-1].value
                unary_minus -= 1

        while index < len_expression and expression[index].isalpha():
            index += 1
        if index > begin_i:
            infix_expression.append(Token(OPERATOR, expression[begin_i: index]))
            begin_i = index

        if index < len_expression and expression[index] in (OPERATORS + BRACKETS):
            if expression[index] == '-' or expression[index] == '+':
                if len(infix_expression) == 0:
                    maybe_unary = -1 if expression[index] == '-' else 1
                elif infix_expression[-1].value in ['+', '-', '*', '/', '^', '(']:
                    unary_minus += int(expression[index] == '-')
                else:
                    infix_expression.append(Token(OPERATOR, expression[index]))
            else:
                if maybe_unary and expression[index] == '(':
                    if maybe_unary == 1:
                        infix_expression.append(Token(OPERATOR, '+'))
                    else:
                        infix_expression.append(Token(OPERATOR, '-'))
                    maybe_unary = 0
                infix_expression.append(Token(OPERATOR, expression[index]))
            index += 1
            begin_i = index

        if prev_index == index:
            index += 1
            begin_i = index

    return infix_expression


def calc(expression):
    infix_expression = getInfix(expression)
    postfix_expression = getPostfix(infix_expression)
    if postfix_expression is not None:
        result = calculation(postfix_expression)
        if result is not None:
            return result
    raise Exception('[INTERNAL_ERROR] [PY_MACRO] Incorrect mathematical expression in macro {{{{py:calc({})}}}}.'.format(expression))


# print calc('4^2 + 460 - (460 - 60) * (- 0.1)')
# print calc('sin(-60+30)')
# print calc('asin(sin(-30))')
# print calc('2^-2')
# print calc('+2*-2')
