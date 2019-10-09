@xvm.export('replace')
def str_replace(str, old, new, max=-1):
    return str.replace(old, new, max)


@xvm.export('upper')
def str_upper(string):
    return unicode(string, 'utf-8').upper() if isinstance(string, basestring) else string


@xvm.export('lower')
def str_lower(string):
    return unicode(string, 'utf-8').lower() if isinstance(string, basestring) else string


@xvm.export('capitalize')
def str_capitalize(string):
    return unicode(string, 'utf-8').capitalize() if isinstance(string, basestring) else string


@xvm.export('title')
def str_title(string):
    return unicode(string, 'utf-8').title() if isinstance(string, basestring) else string


@xvm.export('strip')
def str_strip(string, chars=' '):
    return unicode(string, 'utf-8').strip(chars) if isinstance(string, basestring) else string


@xvm.export('lstrip')
def str_lstrip(string, chars=' '):
    return unicode(string, 'utf-8').lstrip(chars) if isinstance(string, basestring) else string


@xvm.export('rstrip')
def str_rstrip(string, chars=' '):
    return unicode(string, 'utf-8').rstrip(chars) if isinstance(string, basestring) else string
