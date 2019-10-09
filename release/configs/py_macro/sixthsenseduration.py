# settings
from gui import GUI_SETTINGS
import xvm_main.python.config as config

sixthSenseDuration = config.get('battle/sixthSenseDuration')
GUI_SETTINGS.__dict__['_GuiSettings__settings'].update({'sixthSenseDuration':sixthSenseDuration})
