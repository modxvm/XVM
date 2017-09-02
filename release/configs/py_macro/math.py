# Addition. Сложение.
@xvm.export('math.add')
@xvm.export('math.sum')
@xvm.export('add')
@xvm.export('sum')
def math_sum(*a):
    return sum(a)

# Subtraction. Вычитание.
@xvm.export('math.sub')
@xvm.export('sub')
def math_sub(a, b):
    return a - b

# Multiplication. Умножение.
@xvm.export('math.mul')
@xvm.export('mul')
def math_mul(*a):
    return reduce(lambda x, y: x*y, a, 1)

# Division. Деление.
@xvm.export('math.div')
@xvm.export('div')
def math_div(a, b):
    return a / float(b)

# Raise to power. Возведение в степень.
@xvm.export('math.pow')
@xvm.export('pow')
def math_pow(a, n):
    return a ** n
  
# Absolute value. Абсолютная величина
@xvm.export('math.abs')
@xvm.export('abs')
def math_abs(a):
    return abs(a)

# Minimum value. Минимальное значение
@xvm.export('math.min')
@xvm.export('min')
def math_min(*a):
    return min(*a)

# Maximum value. Минимальное значение
@xvm.export('math.max')
@xvm.export('max')
def math_max(*a):
    return max(*a)

# Random numbers

import random

@xvm.export('random.randint', deterministic=False)
def random_randint(a=0, b=1):
    return random.randint(a, b)
