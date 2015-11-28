""" XVM (c) www.modxvm.com 2013-2015 """

import time

from gui import SystemMessages
from gui.shared import g_eventBus, events

from constants import *
import config
import utils

def tokenUpdated():
    type = SystemMessages.SM_TYPE.Warning
    msg = _getXvmMessageHeader()
    status = config.token.status
    if status is None:
        msg += '{{l10n:token/services_unavailable}}\n\n%s' % utils.hide_guid(config.token.errStr)
    elif status == 'badToken' or status == 'inactive':
        msg += '{{l10n:token/services_inactive}}'
    elif status == 'blocked':
        msg += '{{l10n:token/blocked}}'
    elif status == 'active':
        type = SystemMessages.SM_TYPE.GameGreeting
        msg += '{{l10n:token/active}}\n'
        s = time.time()
        e = config.token.expires_at / 1000
        days_left = int((e - s) / 86400)
        hours_left = int((e - s) / 3600) % 24
        mins_left = int((e - s) / 60) % 60
        token_name = 'time_left' if days_left >= 3 else 'time_left_warn'
        msg += '{{l10n:token/%s:%d:%02d:%02d}}\n' % (token_name, days_left, hours_left, mins_left)
        msg += '{{l10n:token/cnt:%d}}' % config.token.cnt
    else:
        type = SystemMessages.SM_TYPE.Error
        msg += '{{l10n:token/unknown_status}}\n%s' % status
    msg += '</textformat>'

    g_eventBus.handleEvent(events.HasCtxEvent(XVM_EVENT.SYSTEM_MESSAGE, {'msg':msg,'type':type}))


# PRIVATE

def _getXvmMessageHeader():
    msg = '<textformat tabstops="[130]"><img src="img://../mods/shared_resources/xvm/res/icons/xvm/16x16t.png" ' \
          'vspace="-5">&nbsp;<a href="#XVM_SITE#"><font color="#E2D2A2">www.modxvm.com</font></a>\n\n'
    rev = ''
    try:
        from __version__ import __revision__
        rev = __revision__
    except Exception as ex:
        err(traceback.format_exc())
    msg += '{{l10n:ver/currentVersion:%s:%s}}\n' % (config.get('__xvmVersion'), rev)
    msg += _getVersionText() + '\n'
    return msg


def _getVersionText():
    ver = config.verinfo.ver
    cur = config.get('__xvmVersion')
    if ver is not None and utils.compareVersions(ver, cur) == 1:
        return '{{l10n:ver/newVersion:%s:%s}}\n' % (ver, config.verinfo.msg)
    return ''
