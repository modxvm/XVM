# Addition. Сложение.
@xvm.export('math.sum')
def math_sum(*a):
    return sum(a)

# Subtraction. Вычитание.
@xvm.export('math.sub')
def math_sub(a, b):
    return a - b

# Multiplication. Умножение.
@xvm.export('math.mul')
def math_mul(*a):
    return reduce(lambda x, y: x*y, a, 1)

# Division. Деление.
@xvm.export('math.div')
def math_div(a, b):
    return a / float(b)

# Raise to power. Возведение в степень.
@xvm.export('math.pow')
def math_pow(a, n):
    return a ** n

#  Absolute value. Абсолютная величина
@xvm.export('math.abs')
def math_abs(a):
    return abs(a)

# Random numbers

import random

@xvm.export('random.randint', deterministic=False)
def random_randint(a=0, b=1):
    return random.randint(a, b)
