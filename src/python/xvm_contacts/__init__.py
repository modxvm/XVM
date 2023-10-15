"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2023 XVM Contributors
"""

#
# Imports
#

# Big Worls
from gui.Scaleform.framework import g_entitiesFactories, ViewSettings, ScopeTemplates
from gui.shared.tooltips.common import ContactTooltipData
from frameworks.wulf import WindowLayer
from messenger.gui.Scaleform.view.lobby.ContactsListPopover import ContactsListPopover
from messenger.gui.Scaleform.data.contacts_vo_converter import ContactConverter
from messenger.gui.Scaleform.data.contacts_cm_handlers import PlayerContactsCMHandler

# XFW
from xfw import *
from xfw_actionscript.python import *

# XVM
from xvm_main.python.logger import *
from xvm_main.python.xvm import l10n

# XVM Contacts
import as3
import contacts
import view



#
# Constants
#

class COMMANDS(object):
    AS_EDIT_CONTACT_DATA = "xvm_contacts.as_edit_contact_data"


class MENU(object):
    XVM_EDIT_CONTACT_DATA = 'XvmEditContactData'


class VIEW(object):
    XVM_EDIT_CONTACT_DATA_ALIAS = 'XvmEditContactDataView'



#
# Handlers/ContactsListPopover
#

def ContactsListPopover_populate(base, self):
    base(self)
    contacts.initialize()



#
# Handlers/ContactConverter
#

def ContactConverter_makeVO(base, cls, contact, useBigIcons = False):
    res = base(contact, useBigIcons)
    if contacts.isAvailable():
        res.update({'xvm_contact_data':contacts.getXvmContactData(contact.getID())})
    return res



#
# Handlers/PlayerContactsCMHandler
#

# TODO: broken since WoT 1.22.1 preload

#def PlayerContactsCMHandler_getHandlers(base, self):
#    handlers = base(self)
#    handlers.update({MENU.XVM_EDIT_CONTACT_DATA: '_XvmEditContactData'})
#    return handlers


#def PlayerContactsCMHandler_generateOptions(base, self, ctx = None):
#    #log('PlayerContactsCMHandler_generateOptions')
#    options = base(self, ctx)
#    options.append(self._makeItem(MENU.XVM_EDIT_CONTACT_DATA, l10n('Edit data'), optInitData={'enabled': contacts.isAvailable()}))
#    return options

#def _XvmEditContactData(self):
#    as_xfw_cmd(COMMANDS.AS_EDIT_CONTACT_DATA, self.userName, self.databaseID)



#
# Handlers/ContactTooltipData
#

def ContactTooltipData_getDisplayableData(base, self, dbID, defaultName):
    result = base(self, dbID, defaultName)
    if contacts.isAvailable():
        #if result['xvm_contact_data']['nick']: # commented for use original nick in tooltip
        #    result['userProps']['userName'] = result['xvm_contact_data']['nick']
        if result['xvm_contact_data']['comment']:
            result['note'] = "<font color='#%s'>%s</font>"  % (XFW_COLORS.UICOLOR_LABEL, l10n(result['xvm_contact_data']['comment']))
    return result



#
# XFW API
#

__initialized = False

def xfw_module_init():
    global __initialized
    if not __initialized:
        g_entitiesFactories.addSettings(ViewSettings(
            VIEW.XVM_EDIT_CONTACT_DATA_ALIAS,
            view.XvmEditContactDataView,
            None,
            WindowLayer.UNDEFINED,
            None,
            ScopeTemplates.DEFAULT_SCOPE))
        
        overrideMethod(ContactsListPopover, '_populate')(ContactsListPopover_populate)
  
        overrideClassMethod(ContactConverter, 'makeVO')(ContactConverter_makeVO)
  
        # TODO: broken since WoT 1.22.1 preload
        #overrideMethod(PlayerContactsCMHandler, '_getHandlers')(PlayerContactsCMHandler_getHandlers)
        #overrideMethod(PlayerContactsCMHandler, '_generateOptions')(PlayerContactsCMHandler_generateOptions)
        #PlayerContactsCMHandler._XvmEditContactData = _XvmEditContactData

        overrideMethod(ContactTooltipData, 'getDisplayableData')(ContactTooltipData_getDisplayableData)

        as3.init()

        __initialized = True
    

def xfw_module_fini():
    global __initialized
    if __initialized:
        __initialized = False


def xfw_is_module_loaded():
    global __initialized
    return __initialized
