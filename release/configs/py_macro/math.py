# Addition. Сложение.
@xvm.export('math.sum')
def sum(a, b):
    return a + b

# Subtraction. Вычитание.
@xvm.export('math.sub')
def razn(a, b):
    return a - b

# Multiplication. Умножение.
@xvm.export('math.mul')
def mul(a, b):
    return a * b

# Division. Деление.
@xvm.export('math.div')
def div(a, b):
    return a / b

# Raise to power. Возведение в степень.
@xvm.export('math.pow')
def pow(a, n):
    return a ** n
