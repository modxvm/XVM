"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Includes
#

# XFW
from xfw import *

# Per-realm imports
if IS_WG:
    from messenger.gui.Scaleform.meta.ContactNoteManageViewMeta import ContactNoteManageViewMeta
else:
    from gui.Scaleform.daapi.view.meta.ContactNoteManageViewMeta import ContactNoteManageViewMeta



#
# Handlers/ContactNoteManageViewMeta_as_setUserPropsS
#

def ContactNoteManageViewMeta_as_setUserPropsS(base, self, value):
    if hasattr(self.flashObject, 'as_setUserProps_xvm'):
        return self.flashObject.as_setUserProps_xvm(value) if self._isDAAPIInited() else None
    else:
        return base(self, value)



#
# Initialization
#

def init():
    overrideMethod(ContactNoteManageViewMeta, 'as_setUserPropsS')(ContactNoteManageViewMeta_as_setUserPropsS)



def fini():
    pass
