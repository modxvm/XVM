""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO (mandatory)

XFW_MOD_VERSION    = "3.0.0"
XFW_MOD_URL        = "http://www.modxvm.com/"
XFW_MOD_UPDATE_URL = "http://www.modxvm.com/en/download-xvm/"
XFW_GAME_VERSIONS  = ["0.9.7"]

#####################################################################
# constants

class COMMANDS(object):
    AS_EDIT_CONTACT_DATA = "xvm_contacts.as_edit_contact_data"
#    GET_CONTACTS = "xvm_contacts.get_contacts"

class MENU(object):
    XVM_EDIT_CONTACT_DATA = 'XvmEditContactData'

class VIEW(object):
    XVM_EDIT_CONTACT_DATA_ALIAS = 'XvmEditContactDataView'

#####################################################################
# includes

import traceback

import BigWorld

from xfw import *
from xvm_main.python.logger import *
from xvm_main.python.xvm import l10n

import contacts

#####################################################################
# event handlers

# INIT

def start():
    import view
    from gui.Scaleform.framework import g_entitiesFactories, ViewSettings, ViewTypes, ScopeTemplates
    from gui.Scaleform.framework.entities.View import View
    g_entitiesFactories.addSettings(ViewSettings(
        VIEW.XVM_EDIT_CONTACT_DATA_ALIAS,
        view.XvmEditContactDataView,
        None,
        ViewTypes.COMPONENT,
        None,
        ScopeTemplates.DEFAULT_SCOPE))

def ContactsListPopover_populate(self):
    #log('ContactsListPopover_populate')
    contacts.initialize()

def ContactConverter_makeVO(base, self, contact, includeIcons = True):
    #log('ContactConverter_makeVO')
    res = base(self, contact, includeIcons)
    if contacts.isAvailable():
        res.update({'xvm_contact_data':contacts.getXvmContactData(contact.getID())})
    #log(res)
    return res

# PlayerContactsCMHandler

def PlayerContactsCMHandler_getHandlers(base, self):
    #log('PlayerContactsCMHandler_getHandlers')
    handlers = base(self)
    handlers.update({MENU.XVM_EDIT_CONTACT_DATA: '_XvmEditContactData'})
    return handlers

def PlayerContactsCMHandler_generateOptions(base, self):
    #log('PlayerContactsCMHandler_generateOptions')
    options = base(self)
    options.append(self._makeItem(MENU.XVM_EDIT_CONTACT_DATA, l10n('Edit data'), optInitData={'enabled': contacts.isAvailable()}))
    return options

def _XvmEditContactData(self):
    #log('_XvmEditContactData')
    as_xvm_cmd(COMMANDS.AS_EDIT_CONTACT_DATA, self.userName, self.databaseID)

#####################################################################
# Register events

# Delayed registration
def _RegisterEvents():
    start()

    from messenger.gui.Scaleform.view.ContactsListPopover import ContactsListPopover
    RegisterEvent(ContactsListPopover, '_populate', ContactsListPopover_populate)

    from messenger.gui.Scaleform.data.contacts_vo_converter import ContactConverter
    OverrideMethod(ContactConverter, 'makeVO', ContactConverter_makeVO)

    from messenger.gui.Scaleform.data.contacts_cm_handlers import PlayerContactsCMHandler
    OverrideMethod(PlayerContactsCMHandler, '_getHandlers', PlayerContactsCMHandler_getHandlers)
    OverrideMethod(PlayerContactsCMHandler, '_generateOptions', PlayerContactsCMHandler_generateOptions)
    PlayerContactsCMHandler._XvmEditContactData = _XvmEditContactData

BigWorld.callback(0, _RegisterEvents)
