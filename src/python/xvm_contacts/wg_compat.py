"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2023 XVM Contributors
"""

from helpers import dependency
from account_helpers.AccountSettings import AccountSettings, CONTACTS
from skeletons.account_helpers.settings_core import ISettingsCore

def refreshContacts():
    settingsCore = dependency.instance(ISettingsCore)
    settings = settingsCore.serverSettings.getSection(CONTACTS, AccountSettings.getFilterDefault(CONTACTS))
    settingsCore.onSettingsChanged(settings)
