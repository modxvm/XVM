""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO

XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '3.1.0',
    'URL':           'http://www.modxvm.com/',
    'UPDATE_URL':    'http://www.modxvm.com/en/download-xvm/',
    'GAME_VERSIONS': ['0.9.9'],
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
    as_xfw_cmd(COMMANDS.AS_EDIT_CONTACT_DATA, self.userName, self.databaseID)

def ContactTooltipData_getDisplayableData(base, self, dbID, defaultName):
    result = base(self, dbID, defaultName)
    if contacts.isAvailable():
        if result['xvm_contact_data']['nick']:
            result['userProps']['userName'] = result['xvm_contact_data']['nick']
        if result['xvm_contact_data']['comment']:
            result['note'] = result['xvm_contact_data']['comment']
    return result

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
    
    from gui.shared.tooltips.common import ContactTooltipData
    OverrideMethod(ContactTooltipData, 'getDisplayableData', ContactTooltipData_getDisplayableData)

BigWorld.callback(0, _RegisterEvents)
