""" XVM (c) www.modxvm.com 2013-2015 """

#############################
# Command

def is_reserved(veh_id):
    return _reserve._is_reserved(veh_id)

def set_reserved(veh_id, to_reserve):
    return _reserve._set_reserved(veh_id, to_reserve)

#############################
# Private

import traceback
from xvm_main.python.logger import *
import xvm_main.python.userprefs as userprefs

#############################

class _Reserve(object):

    def __init__(self):
        self.reserve_cache = userprefs.get('tcarousel.reserve', [])

    def _is_reserved(self, veh_id):
        return veh_id in self.reserve_cache

    def _set_reserved(self, veh_id, to_reserve):
        try:
            if to_reserve:
                if veh_id not in self.reserve_cache:
                    self.reserve_cache.append(veh_id)
                    userprefs.set('tcarousel.reserve', self.reserve_cache)
            else:
                if veh_id in self.reserve_cache:
                    self.reserve_cache.remove(veh_id)
                    userprefs.set('tcarousel.reserve', self.reserve_cache)
        except Exception as ex:
            err('_set_reserved() exception: ' + traceback.format_exc())

_reserve = _Reserve()
