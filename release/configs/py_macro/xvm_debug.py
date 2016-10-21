import BigWorld
import traceback
from xfw import *
from xvm_main.python.logger import *
import xvm_main.python.config as config

#######################################
# add perks for every tankman in the crew
ADD_PERKS_COUNT = 5
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
def _handler(data):
    log(data)
def _register_as_callback():
    as_callback("xvm_debug_click", _handler)
    as_callback("xvm_debug_mouseDown", _handler)
    as_callback("xvm_debug_mouseUp", _handler)
    as_callback("xvm_debug_mouseOver", _handler)
    as_callback("xvm_debug_mouseOut", _handler)
    as_callback("xvm_debug_mouseMove", _handler)
    as_callback("xvm_debug_mouseWheel", _handler)
#_register_as_callback()
