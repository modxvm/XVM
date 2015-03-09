""" XVM (c) www.modxvm.com 2013-2015 """

from . import COMMANDS
from xfw import *
from xvm_main.python.logger import *

from helpers import i18n
from gui.Scaleform.locale.MESSENGER import MESSENGER
from messenger.proto.xmpp.xmpp_constants import CONTACT_LIMIT
from messenger.gui.Scaleform.view.contact_manage_note_views import ContactManageNoteView

class XvmEditContactDataView(ContactManageNoteView):

    def __init__(self):
        super(XvmEditContactDataView, self).__init__()
        self.__defaultText = None
        return

    def onOk(self, text):
        #log(str(self._dbID) + ": " + text)
        #success =
        as_xvm_cmd(COMMANDS.AS_UPDATE_DATA, contacts.setXvmUserContacts())

        as_xvm_cmd(COMMANDS.SAVE_CONTACT_DATA, self._dbID, text)
        #if success:
        self.as_closeViewS()

    def sendData(self, data):
        super(XvmEditContactDataView, self).sendData(data)
        self.__defaultText = ''
        self.as_setInputTextS(self.__defaultText)

    def _isTextValid(self, text):
        return super(XvmEditContactDataView, self)._isTextValid(text) and self.__defaultText != text

    def _getInitDataObject(self):
        defData = self._getDefaultInitData(MESSENGER.MESSENGER_CONTACTS_VIEW_MANAGEGROUP_EDITNOTE_MAINLABEL, MESSENGER.MESSENGER_CONTACTS_VIEW_MANAGEGROUP_EDITNOTE_BTNOK_LABEL, MESSENGER.MESSENGER_CONTACTS_VIEW_MANAGEGROUP_EDITNOTE_BTNCANCEL_LABEL)
        defData['inputPrompt'] = i18n.makeString(MESSENGER.MESSENGER_CONTACTS_VIEW_MANAGEGROUP_CREATEGROUP_SEARCHINPUTPROMPT, symbols=CONTACT_LIMIT.NOTE_MAX_CHARS_COUNT)
        defData['groupMaxChars'] = CONTACT_LIMIT.NOTE_MAX_CHARS_COUNT
        return defData
