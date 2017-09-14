@xvm.export('replace')
def str_replace(str, old, new, max=-1):
    return str.replace(old, new, max)


@xvm.export('upper')
def str_upper(string):
    return unicode(string, 'utf-8').upper()


@xvm.export('lower')
def str_lower(string):
    return unicode(string, 'utf-8').lower()


@xvm.export('capitalize')
def str_capitalize(string):
    return unicode(string, 'utf-8').capitalize()
