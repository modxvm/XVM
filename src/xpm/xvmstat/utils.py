""" XVM (c) www.modxvm.com 2013-2014 """

import os
import sys
import re
import traceback
import threading
from pprint import pprint

import BigWorld

from logger import *

def touch(fname, times=None):
    with open(fname, 'a'):
        os.utime(fname, times)

def rm(fname):
    if os.path.isfile(fname):
        os.remove(fname)

def hide_guid(txt):
    return re.sub('([0-9A-Fa-f]{8}-)[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}(-[0-9A-Fa-f]{12})', \
        '\\1****-****-****\\2', txt)

def show_threads():
    for t in threading.enumerate():
        log('Thread: %s' % t.getName())

def openWebBrowser(url, allowInternalBrowser=True):
    openBrowser = BigWorld.wg_openWebBrowser
    if allowInternalBrowser:
        from gui.WindowsManager import g_windowsManager
        browser = g_windowsManager.window.browser
        if browser is not None:
            openBrowser = browser.openBrowser
    openBrowser(url)
