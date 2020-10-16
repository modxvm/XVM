""" XVM (c) https://modxvm.com 2013-2020 """

from messenger.gui.Scaleform.meta.ContactNoteManageViewMeta import ContactNoteManageViewMeta

from xfw import *

@overrideMethod(ContactNoteManageViewMeta, 'as_setUserPropsS')
def ContactNoteManageViewMeta_as_setUserPropsS(base, self, value):
    print 'ContactNoteManageViewMeta_as_setUserPropsS'
    return self.flashObject.as_setUserProps_xvm(value) if self._isDAAPIInited() else None
