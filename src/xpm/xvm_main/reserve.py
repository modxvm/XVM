""" XVM (c) https://modxvm.com 2013-2018 """

#############################
# Command

def is_reserved(vehCD):
    return _reserve._is_reserved(vehCD)

def set_reserved(vehCD, to_reserve):
    return _reserve._set_reserved(vehCD, to_reserve)

#############################
# Private

import traceback
import config
from logger import *
import userprefs

#############################

class _Reserve(object):

    def __init__(self):
        self.reserve_cache = userprefs.get('tankcarousel/reserve', [])

    def _is_reserved(self, vehCD):
        return vehCD in self.reserve_cache

    def _set_reserved(self, vehCD, to_reserve):
        try:
            if to_reserve:
                if vehCD not in self.reserve_cache:
                    self.reserve_cache.append(vehCD)
                    userprefs.set('tankcarousel/reserve', self.reserve_cache)
            else:
                if vehCD in self.reserve_cache:
                    self.reserve_cache.remove(vehCD)
                    userprefs.set('tankcarousel/reserve', self.reserve_cache)
        except Exception as ex:
            err('_set_reserved() exception: ' + traceback.format_exc())

_reserve = _Reserve()
