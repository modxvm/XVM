""" XVM (c) www.modxvm.com 2013-2015 """

from account_helpers.settings_core.SettingsCore import g_settingsCore
from account_helpers.AccountSettings import AccountSettings, CONTACTS

def refreshContacts():
    settings = g_settingsCore.serverSettings.getSection(CONTACTS, AccountSettings.getFilterDefault(CONTACTS))
    g_settingsCore.onSettingsChanged(settings)
