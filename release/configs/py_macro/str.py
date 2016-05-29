@xvm.export('replace')
def str_replace(str, old, new, max=-1):
    return str.replace(old, new, max)
