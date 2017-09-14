@xvm.export('replace')
def str_replace(str, old, new, max=-1):
    return str.replace(old, new, max)


@xvm.export('upper')
def str_upper(string):
    return string.upper()


@xvm.export('lower')
def str_lower(string):
    return string.lower()


@xvm.export('capitalize')
def str_capitalize(string):
    return string.capitalize()
