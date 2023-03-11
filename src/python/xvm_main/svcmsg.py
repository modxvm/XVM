""" XVM (c) https://modxvm.com 2013-2021 """
# -*- coding: utf-8 -*-

import time

from gui import SystemMessages
from gui.shared import g_eventBus, events

from xfw import *

from consts import *
import config
from logger import *
import utils
from xvm import l10n

_XVM_MESSAGE_HEADER = \
    '<textformat tabstops="[50]"><img src="img://../mods/shared_resources/xvm/res/icons/xvm/16x16t.png" ' \
    'vspace="-5">&nbsp;<a href="#XVM_SITE#"><font color="#E2D2A2">modxvm.com</font></a>'

def sendXvmSystemMessage(type, msg):
    msg = _XVM_MESSAGE_HEADER + '\n\n' + msg + '</textformat>'
    g_eventBus.handleEvent(events.HasCtxEvent(XVM_EVENT.SYSTEM_MESSAGE, {'msg': msg, 'type': type}))

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
        msg += '{{l10n:token/active}} '
        s = time.time()
        e = config.token.expires_at / 1000
        days_left = int((e - s) / 86400)
        hours_left = int((e - s) / 3600) % 24
        mins_left = int((e - s) / 60) % 60
        token_name = 'time_left' if days_left >= 11 else 'time_left_warn'
        msg += '{{l10n:token/%s:%d:%02d:%02d}}' % (token_name, days_left, hours_left, mins_left)
    else:
        type = SystemMessages.SM_TYPE.Error
        msg += '{{l10n:token/unknown_status}}\n%s' % status
    msg += '</textformat>\n'
    msg += _getXvmMessageFooter()

    g_eventBus.handleEvent(events.HasCtxEvent(XVM_EVENT.SYSTEM_MESSAGE, {'msg': msg, 'type': type}))

def fixData(value):
    if value and 'message' in value and 'message' in value['message']:
        message = l10n(value['message']['message'])
        if getRegion() == "RU":
            message = message \
              .replace('#XVM_SITE#',             'event:https://modxvm.com/#wot-main') \
              .replace('#XVM_SITE_DL#',          'event:https://modxvm.com/%d1%81%d0%ba%d0%b0%d1%87%d0%b0%d1%82%d1%8c-xvm/#wot-main') \
              .replace('#XVM_SITE_UNAVAILABLE#', 'event:https://modxvm.com/%D1%81%D0%B5%D1%82%D0%B5%D0%B2%D1%8B%D0%B5-%D1%81%D0%B5%D1%80%D0%B2%D0%B8%D1%81%D1%8B-%D0%BD%D0%B5%D0%B4%D0%BE%D1%81%D1%82%D1%83%D0%BF%D0%BD%D1%8B/#wot-main') \
              .replace('#XVM_SITE_INACTIVE#',    'event:https://modxvm.com/%D1%81%D0%B5%D1%82%D0%B5%D0%B2%D1%8B%D0%B5-%D1%81%D0%B5%D1%80%D0%B2%D0%B8%D1%81%D1%8B-xvm/#wot-main') \
              .replace('#XVM_SITE_BLOCKED#',     'event:https://modxvm.com/%D1%81%D1%82%D0%B0%D1%82%D1%83%D1%81-%D0%B7%D0%B0%D0%B1%D0%BB%D0%BE%D0%BA%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD/#wot-main')
        else:
            message = message \
              .replace('#XVM_SITE#',             'event:https://modxvm.com/en/#wot-main') \
              .replace('#XVM_SITE_DL#',          'event:https://modxvm.com/en/download-xvm/#wot-main') \
              .replace('#XVM_SITE_UNAVAILABLE#', 'event:https://modxvm.com/en/network-services-unavailable/#wot-main') \
              .replace('#XVM_SITE_INACTIVE#',    'event:https://modxvm.com/en/network-services-xvm/#wot-main') \
              .replace('#XVM_SITE_BLOCKED#',     'event:https://modxvm.com/en/status-blocked/#wot-main')
        message = message \
            .replace('#XVM_CHECK_ACTIVATION#',   'event:XVM_CHECK_ACTIVATION')
        value['message']['message'] = message
    return value

# PRIVATE

def _getXvmMessageHeader():
    msg = _XVM_MESSAGE_HEADER + ' - '
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
    msg = ''
    if ver is not None:
        if utils.compareVersions(ver, cur) == 1:
            msg += '\n{{l10n:ver/newVersion:%s:%s}}\n' % (ver, config.verinfo.message)
        elif config.verinfo.message:
            msg += '\n%s\n' % config.verinfo.message

        if cur.endswith('-dev'):
            if config.get('region').lower() == 'ru':
                msg += """
<font color='#FF0000'>Внимание!</font>
Установлена тестовая сборка XVM, не рекомендуемая для неопытных пользователей.
Некоторые функции могут работать неправильно, или не работать вообще.

Если вы тестируете XVM, проигнорируйте это сообщение.

<b>Если вы простой пользователь, пожалуйста, используйте стабильную версию с официального сайта мода XVM: <a href='#XVM_SITE_DL#'>https://modxvm.com</a></b>
"""
            else:
                msg += """
<font color='#FF0000'>Warning!</font>
You've installed nightly build of XVM, which is not recommended for inexperienced users.
Some functionality may work incorrectly or may not work at all.

If you are testing XVM, you can ignore this message.

<b>If you're just a player and not a tester of XVM, please use a stable version instead of nightly builds. Download the stable version from the official website of XVM: <a href='#XVM_SITE_DL#'>https://modxvm.com</a></b>
"""
    return msg

def _getXvmMessageFooter():
    return '\n{{l10n:stats_link/svcmsg:%s}}\n\n' % (utils.getAccountDBID())
