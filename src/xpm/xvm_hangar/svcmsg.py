import traceback

import BigWorld
from gui.Scaleform.daapi.view.lobby.messengerBar.NotificationListButton import NotificationListButton

from xfw import *
import xvm_main.python.config as config
from xvm_main.python.logger import *

###

@overrideMethod(NotificationListButton, 'as_setStateS')
def _NotificationListButton_as_setStateS(base, self, isBlinking, counterValue):
    if not config.get('hangar/showNotificationsCounter', True):
        counterValue = ''
    base(self, isBlinking, counterValue)
