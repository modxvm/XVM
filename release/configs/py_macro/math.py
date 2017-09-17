# Addition. Сложение.
@xvm.export('math.add')
@xvm.export('math.sum')
@xvm.export('add')
@xvm.export('sum')
def math_sum(*a):
    a = [i for i in a if i is not None]
    return sum(a) if a else None

# Subtraction. Вычитание.
@xvm.export('math.sub')
@xvm.export('sub')
def math_sub(a, b):
    return None if a is None or b is None else a - b

# Multiplication. Умножение.
@xvm.export('math.mul')
@xvm.export('mul')
def math_mul(*a):
    a = [i for i in a if i is not None]
    return reduce(lambda x, y: x*y, a, 1) if not a else None

# Division. Деление.
@xvm.export('math.div')
@xvm.export('div')
def math_div(a, b):
    if a is not None and b is not None:
        return a / float(b) if b != 0 else 0

# Raise to power. Возведение в степень.
@xvm.export('math.pow')
@xvm.export('pow')
def math_pow(a, n):
    return None if a is None or n is None else a ** n
  
# Absolute value. Абсолютная величина
@xvm.export('math.abs')
@xvm.export('abs')
def math_abs(a):
    return abs(a) if a is not None else None

# Minimum value. Минимальное значение
@xvm.export('math.min')
@xvm.export('min')
def math_min(*a):
    a = [i for i in a if i is not None]
    return min(*a) if a else None

# Maximum value. Минимальное значение
@xvm.export('math.max')
@xvm.export('max')
def math_max(*a):
    a = [i for i in a if i is not None]
    return max(*a) if a else None

# Random numbers

import random

@xvm.export('random.randint', deterministic=False)
def random_randint(a=0, b=1):
    return random.randint(a, b)
