""" XVM (c) https://modxvm.com 2013-2017 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '0.9.20.1',
    'URL':           'https://modxvm.com/',
    'UPDATE_URL':    'https://modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.20.1'],
    # optional
}


import xvm_main.python.config as config
if config.get('hangar/carousel/enabled'):
    import tankcarousel
    import filter_popover
    import reserve
