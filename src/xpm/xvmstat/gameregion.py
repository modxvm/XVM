""" XVM (c) www.modxvm.com 2013-2014 """

import ResMgr

#############################
# Public

_updateurl = ResMgr.openSection('scripts_config.xml').readString('csisUrl')

if _updateurl is not None:
    if 'csis-ct.worldoftanks.' in _updateurl:
        region = 'CT'
    elif 'worldoftanks.ru' in _updateurl:
        region = 'RU'
    elif 'worldoftanks.eu' in _updateurl:
        region = 'EU'
    elif 'worldoftanks.com' in _updateurl:
        region = 'NA'
    elif 'worldoftanks.cn' in _updateurl:
        region = 'CN'
    elif 'worldoftanks.asia' in _updateurl:
        region = 'ASIA'
    elif 'worldoftanks.vn' in _updateurl:
        region = 'VTC'
    elif 'worldoftanks.kr' in _updateurl:
        region = 'KR'
    else:
        region = 'null'
else:
    region = 'null'

from helpers import getClientLanguage
language = getClientLanguage()
