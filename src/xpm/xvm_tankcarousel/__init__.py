""" XVM (c) www.modxvm.com 2013-2016 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '0.9.16',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.16'],
    # optional
}


import xvm_main.python.config as config
if config.get('hangar/carousel/enabled'):
    import tankcarousel
    import filter_popover
    import reserve
