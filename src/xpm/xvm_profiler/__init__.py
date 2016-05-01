""" XVM (c) www.modxvm.com 2013-2016 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '0.9.15',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.15'],
    # optional
}

from xfw import IS_DEVELOPMENT

if IS_DEVELOPMENT:
    import profiler
