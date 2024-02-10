"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
"""

#############################
# Command

def init(accountDBID):
    _reserve._update_reserve_cache(accountDBID)

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
import vehinfo

#############################

class USERPREFS(object):
    CAROUSEL_RESERVE = "users/{accountDBID}/tankcarousel/reserve"

class _Reserve(object):

    def __init__(self):
        self.accountDBID = None
        self.reserve_cache = []

    def _update_reserve_cache(self, accountDBID):
        self.accountDBID = accountDBID
        vehinfo.resetReserve()
        if self.accountDBID is None:
            self.reserve_cache = []
        else:
            self.reserve_cache = userprefs.get(USERPREFS.CAROUSEL_RESERVE, [])
            for vehCD in self.reserve_cache:
                vehinfo.updateReserve(vehCD, True)

    def _is_reserved(self, vehCD):
        return vehCD in self.reserve_cache

    def _set_reserved(self, vehCD, to_reserve):
        try:
            vehinfo.updateReserve(vehCD, to_reserve)
            if to_reserve:
                if vehCD not in self.reserve_cache:
                    self.reserve_cache.append(vehCD)
                    userprefs.set(USERPREFS.CAROUSEL_RESERVE, self.reserve_cache)
            else:
                if vehCD in self.reserve_cache:
                    self.reserve_cache.remove(vehCD)
                    userprefs.set(USERPREFS.CAROUSEL_RESERVE, self.reserve_cache)
        except Exception as ex:
            err('_set_reserved() exception: ' + traceback.format_exc())

_reserve = _Reserve()
