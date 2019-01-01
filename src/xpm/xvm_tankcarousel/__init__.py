""" XVM (c) https://modxvm.com 2013-2019 """

import xvm_main.python.config as config
if config.get('hangar/carousel/enabled'):
    import tankcarousel
    import filter_popover
