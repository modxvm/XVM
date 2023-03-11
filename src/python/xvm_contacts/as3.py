""" XVM (c) https://modxvm.com 2013-2021 """

from messenger.gui.Scaleform.meta.ContactNoteManageViewMeta import ContactNoteManageViewMeta

from xfw.events import overrideMethod

@overrideMethod(ContactNoteManageViewMeta, 'as_setUserPropsS')
def ContactNoteManageViewMeta_as_setUserPropsS(base, self, value):
    if hasattr(self.flashObject, 'as_setUserProps_xvm'):
        return self.flashObject.as_setUserProps_xvm(value) if self._isDAAPIInited() else None
    else:
        return base(self, value)
