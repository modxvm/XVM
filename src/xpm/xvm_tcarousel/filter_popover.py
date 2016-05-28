""" XVM (c) www.modxvm.com 2013-2016 """

from gui.Scaleform.daapi.view.lobby.hangar.filter_popover import FilterPopover

from xfw import *

from xvm_main.python.logger import *


class XvmTankCarouselFilterPopover(FilterPopover):
    def __init__(self, ctx = None):
        #log('XvmTankCarouselFilterPopover')
        super(XvmTankCarouselFilterPopover, self).__init__(ctx)
