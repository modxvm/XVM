@xvm.export('replace')
def str_replace(str, old, new, max=None):
    return str.replace(old, new, max)
