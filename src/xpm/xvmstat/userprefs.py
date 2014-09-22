""" XVM (c) www.modxvm.com 2013-2014 """

def get(key):
    return _settings.get(key)

def set(key, value):
    _settings.set(key, value)

# PRIVATE

import traceback
import simplejson
import cPickle
import base64

import BigWorld
import Settings

from logger import *

class _Settings():
    def __init__(self):
        pass

    def get(self, key):
        try:
            self._check_key(key)
            prefs = Settings.g_instance.userPrefs['XVM']
            value = prefs.readString(key)
            return None if not value else cPickle.loads(base64.b64decode(value))
        except Exception, ex:
            err('settings.get() exception: ' + traceback.format_exc())
        return None

    def set(self, key, value):
        try:
            self._check_key(key)
            prefs = Settings.g_instance.userPrefs['XVM']
            prefs.writeString(key, str(base64.b64encode(cPickle.dumps(value))))
            Settings.g_instance.save()
        except Exception, ex:
            err('settings.set() exception: ' + traceback.format_exc())

    def _check_key(self, key):
        prefs = Settings.g_instance.userPrefs
        if not prefs.has_key('XVM'):
            prefs.write('XVM', '')
        xvm_prefs = prefs['XVM']
        if not xvm_prefs.has_key(key):
            xvm_prefs.writeString(key, '')

_settings = _Settings()
