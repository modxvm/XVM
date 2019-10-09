import BigWorld
import traceback
from xfw import *
from xfw_actionscript.python import *
from xvm_main.python.logger import *
import xvm_main.python.config as config

#######################################
# add perks for every tankman in the crew
ADD_PERKS_COUNT = 8
from gui.Scaleform.daapi.view.lobby.hangar.Crew import Crew
#@overrideMethod(Crew, 'as_tankmenResponseS')
def as_tankmenResponseS(base, self, data):
    for t in data['tankmen']:
        if t['skills']:
            for x in range(0, ADD_PERKS_COUNT):
                t['skills'].insert(0, data['tankmen'][0]['skills'][0].copy())
                t['skills'][0]['id'] = x + 1
                t['skills'][0]['level'] = 100
    #log(data)
    base(self, data)


#######################################
# test as_callback()

import GUI

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
