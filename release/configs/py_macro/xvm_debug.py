"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2024 XVM Contributors
"""

#
# Imports
#

# BigWorld
import GUI

# XFW
from xfw import *
from xfw_actionscript.python import *

# XVM
from xvm_main.python.logger import *


#######################################
# test as_callback()

_xvm_debug_data = None
_xvm_debug_x = 0
_xvm_debug_y = 0

@xvm.export('xvm_debug_get_x', deterministic=False)
def _xvm_debug_get_x():
    global _xvm_debug_x
    return _xvm_debug_x

@xvm.export('xvm_debug_get_y', deterministic=False)
def _xvm_debug_get_y():
    global _xvm_debug_y
    return _xvm_debug_y

def _handler(data):
    #log(data)
    pass

def _handler_down(data):
    if data['buttonIdx'] == 0:
        global _xvm_debug_data
        _xvm_debug_data = data

def _handler_up(data):
    if data['buttonIdx'] == 0:
        global _xvm_debug_data
        _xvm_debug_data = None

def _handler_move(data):
    global _xvm_debug_data, _xvm_debug_x, _xvm_debug_y
    if _xvm_debug_data:
        _xvm_debug_x = data['stageX'] - _xvm_debug_data['x']
        _xvm_debug_y = data['stageY'] - _xvm_debug_data['y']
        as_event('xvm_debug_update')

def _register_as_callback():
    as_callback("xvm_debug_click", _handler)
    as_callback("xvm_debug_mouseDown", _handler_down)
    as_callback("xvm_debug_mouseUp", _handler_up)
    as_callback("xvm_debug_mouseOver", _handler)
    as_callback("xvm_debug_mouseOut", _handler)
    as_callback("xvm_debug_mouseMove", _handler_move)
    as_callback("xvm_debug_mouseWheel", _handler)
_register_as_callback()
