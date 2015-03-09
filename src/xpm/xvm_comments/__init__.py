""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO (mandatory)

XFW_MOD_VERSION    = "2.0.0"
XFW_MOD_URL        = "http://www.modxvm.com/"
XFW_MOD_UPDATE_URL = "http://www.modxvm.com/en/download-xvm/"
XFW_GAME_VERSIONS  = ["0.9.6"]

#####################################################################
# constants

#class COMMANDS(object):
#    GET_CONTACTS = "xvm_contacts.get_contacts"
#    AS_EDIT_CONTACT_DATA = "xvm_contacts.as_edit_contact_data"
#    AS_UPDATE_DATA = "xvm_contacts.as_update_data"

#class MENU(object):
#    XVM_EDIT_CONTACT_DATA = 'XvmEditContactData'

#class VIEW(object):
#    XVM_EDIT_CONTACT_DATA_ALIAS = 'XvmEditContactDataView'

#####################################################################
# includes

import traceback

import BigWorld

#import simplejson

from xfw import *
from xvm_main.python.logger import *

import contacts

#####################################################################
# event handlers

# INIT

def start():
    from gui.shared import g_eventBus
    g_eventBus.addListener(XPM_CMD, onXpmCommand)

#    import view
#    from gui.Scaleform.framework import g_entitiesFactories, ViewSettings, ViewTypes, ScopeTemplates
#    from gui.Scaleform.framework.entities.View import View
#    g_entitiesFactories.addSettings(ViewSettings(
#        VIEW.XVM_EDIT_CONTACT_DATA_ALIAS,
#        view.XvmEditContactDataView,
#        None,
#        ViewTypes.COMPONENT,
#        None,
#        ScopeTemplates.DEFAULT_SCOPE))

def fini():
    from gui.shared import g_eventBus
    g_eventBus.removeListener(XPM_CMD, onXpmCommand)

_BATTLE_SWF = 'battle.swf'
_VMM_SWF = 'VehicleMarkersManager.swf'
_SWFS = [_BATTLE_SWF, _VMM_SWF]

def FlashInit(self, swf, className='Flash', args=None, path=None):
    self.swf = swf
    if self.swf in _SWFS:
        self.addExternalCallback('xvm.cmd', lambda *args: onXvmCommand(self, *args))

def FlashBeforeDelete(self):
    if self.swf in _SWFS:
        self.removeExternalCallback('xvm.cmd')

# onXpmCommand

#_LOG_COMMANDS = (
#    COMMANDS.GET_CONTACTS,
#)

# returns: (result, status)
def onXpmCommand(cmd, *args):
    return (None, False) # TODO
#    try:
#        if IS_DEVELOPMENT and cmd in _LOG_COMMANDS:
#            debug("cmd=" + str(cmd) + " args=" + simplejson.dumps(args))
#        if cmd == COMMANDS.GET_CONTACTS:
#            return (contacts.getXvmUserContacts(args[0] if len(args) else False), True)
#    except Exception, ex:
#        err(traceback.format_exc())
#        return (None, True)
#    return (None, False)

def onXvmCommand(proxy, id, cmd, *args):
    return # TODO
#    try:
#        if IS_DEVELOPMENT and cmd in _LOG_COMMANDS:
#            debug("cmd=" + str(cmd) + " args=" + simplejson.dumps(args))
#        res = None
#
#        if cmd == COMMAND_GETCONTACTS:
#            res = comments.getXvmUserContacts(False)
#        else:
#            return
#
#        proxy.movie.invoke(('xvm.respond', [id] + res if isinstance(res, list) else [id, res]))
#    except Exception, ex:
#        err(traceback.format_exc())

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

# Early registration
from gui.Scaleform.Flash import Flash
RegisterEvent(Flash, '__init__', FlashInit)
RegisterEvent(Flash, 'beforeDelete', FlashBeforeDelete)

# Delayed registration
def _RegisterEvents():
    start()

    import game
    RegisterEvent(game, 'fini', fini)

    from messenger.gui.Scaleform.view.ContactsListPopover import ContactsListPopover
    RegisterEvent(ContactsListPopover, '_populate', ContactsListPopover_populate)

    from messenger.gui.Scaleform.data.contacts_vo_converter import ContactConverter
    OverrideMethod(ContactConverter, 'makeVO', ContactConverter_makeVO)

    #from messenger.gui.Scaleform.data.contacts_cm_handlers import PlayerContactsCMHandler
    #OverrideMethod(PlayerContactsCMHandler, '_getHandlers', PlayerContactsCMHandler_getHandlers)
    #OverrideMethod(PlayerContactsCMHandler, '_generateOptions', PlayerContactsCMHandler_generateOptions)
    #PlayerContactsCMHandler._XvmEditContactData = _XvmEditContactData

BigWorld.callback(0, _RegisterEvents)
