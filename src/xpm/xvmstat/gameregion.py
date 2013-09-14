""" xvm-stat (c) sirmax 2013 """

import ResMgr
from gui import VERSION_FILE_PATH

#############################
# Public

_ver = ResMgr.openSection(VERSION_FILE_PATH).readString('version')

if 'Common Test' in _ver:
    region = 'CT'
else:
    region = ResMgr.openSection(VERSION_FILE_PATH).readString('meta/localization')
    region = region[region.find(' ')+1:]

from helpers import getClientLanguage
language = getClientLanguage()
print language
