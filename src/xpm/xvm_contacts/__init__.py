""" XVM (c) www.modxvm.com 2013-2017 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '0.9.17.1',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.17.1'],
    # optional
}


#####################################################################
# constants

class COMMANDS(object):
    AS_EDIT_CONTACT_DATA = "xvm_contacts.as_edit_contact_data"


class MENU(object):
    XVM_EDIT_CONTACT_DATA = 'XvmEditContactData'


class VIEW(object):
    XVM_EDIT_CONTACT_DATA_ALIAS = 'XvmEditContactDataView'


#####################################################################
# includes

import BigWorld
from gui.Scaleform.framework import g_entitiesFactories, ViewSettings, ViewTypes, ScopeTemplates
from gui.Scaleform.framework.entities.View import View
from gui.shared.tooltips.common import ContactTooltipData
from messenger.gui.Scaleform.view.lobby.ContactsListPopover import ContactsListPopover
from messenger.gui.Scaleform.data.contacts_vo_converter import ContactConverter
from messenger.gui.Scaleform.data.contacts_cm_handlers import PlayerContactsCMHandler

from xfw import *
from xvm_main.python.logger import *
from xvm_main.python.xvm import l10n

import contacts
import view


#####################################################################
# initialization

g_entitiesFactories.addSettings(ViewSettings(
    VIEW.XVM_EDIT_CONTACT_DATA_ALIAS,
    view.XvmEditContactDataView,
    None,
    ViewTypes.COMPONENT,
    None,
    ScopeTemplates.DEFAULT_SCOPE))


#####################################################################
# handlers

@registerEvent(ContactsListPopover, '_populate')
def ContactsListPopover_populate(self):
    #log('ContactsListPopover_populate')
    contacts.initialize()

@overrideClassMethod(ContactConverter, 'makeVO')
def ContactConverter_makeVO(base, cls, contact, useBigIcons = False):
    #log('ContactConverter_makeVO')
    res = base(contact, useBigIcons)
    if contacts.isAvailable():
        res.update({'xvm_contact_data':contacts.getXvmContactData(contact.getID())})
    #log(res)
    return res

@overrideMethod(PlayerContactsCMHandler, '_getHandlers')
def PlayerContactsCMHandler_getHandlers(base, self):
    #log('PlayerContactsCMHandler_getHandlers')
    handlers = base(self)
    handlers.update({MENU.XVM_EDIT_CONTACT_DATA: '_XvmEditContactData'})
    return handlers

@overrideMethod(PlayerContactsCMHandler, '_generateOptions')
def PlayerContactsCMHandler_generateOptions(base, self, ctx = None):
    #log('PlayerContactsCMHandler_generateOptions')
    options = base(self, ctx)
    options.append(self._makeItem(MENU.XVM_EDIT_CONTACT_DATA, l10n('Edit data'), optInitData={'enabled': contacts.isAvailable()}))
    return options

def _XvmEditContactData(self):
    #log('_XvmEditContactData')
    as_xfw_cmd(COMMANDS.AS_EDIT_CONTACT_DATA, self.userName, self.databaseID)

PlayerContactsCMHandler._XvmEditContactData = _XvmEditContactData

@overrideMethod(ContactTooltipData, 'getDisplayableData')
def ContactTooltipData_getDisplayableData(base, self, dbID, defaultName):
    result = base(self, dbID, defaultName)
    if contacts.isAvailable():
        #if result['xvm_contact_data']['nick']: # commented for use original nick in tooltip
        #    result['userProps']['userName'] = result['xvm_contact_data']['nick']
        if result['xvm_contact_data']['comment']:
            result['note'] = "<font color='#%s'>%s</font>"  % (XFWCOLORS.UICOLOR_LABEL, l10n(result['xvm_contact_data']['comment']))
    return result
