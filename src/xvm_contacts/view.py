"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

from messenger.gui.Scaleform.view.lobby.contact_manage_note_views import ContactEditNoteView

from xfw import *
from xvm_main.logger import *

import contacts
import wg_compat

class XvmEditContactDataView(ContactEditNoteView):

    def __init__(self):
        super(XvmEditContactDataView, self).__init__()
        self.userName = None


    def as_setUserPropsS(self, value):
        self.userName = value['userName']
        value.update({'xvm_contact_data': contacts.getXvmContactData(self._dbID)})
        super(XvmEditContactDataView, self).as_setUserPropsS(value)


    def onOk(self, value):
        if value.nick == self.userName:
            value.nick = None
        success = contacts.setXvmContactData(self._dbID, {'nick':value.nick,'comment':value.comment})
        if success:
            wg_compat.refreshContacts()
            self.as_closeViewS()
