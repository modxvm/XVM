""" XVM (c) www.modxvm.com 2013-2016 """

from helpers import dependency
from account_helpers.AccountSettings import AccountSettings, CONTACTS
from skeletons.account_helpers.settings_core import ISettingsCore

def refreshContacts():
    settingsCore = dependency.instance(ISettingsCore)
    settings = settingsCore.serverSettings.getSection(CONTACTS, AccountSettings.getFilterDefault(CONTACTS))
    settingsCore.onSettingsChanged(settings)
