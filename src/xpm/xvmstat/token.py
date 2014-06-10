""" XVM (c) www.modxvm.com 2013-2014 """

# PUBLIC

def getXvmStatActiveTokenData():
    return _getXvmStatActiveTokenData()

def getXvmStatTokenData():
    return _getXvmStatTokenData()


# PRIVATE

from pprint import pprint
from random import randint
import traceback
import datetime
import time

import simplejson

import BigWorld
from gui import SystemMessages

from constants import *
import db
from logger import *
from loadurl import loadUrl
import utils

_tdataPrev = None

def _getXvmStatActiveTokenData():
    playerId = getCurrentPlayerId()
    if playerId is None:
        return None

    tdata = db.get('tokens', playerId)
    if tdata is None:
        # fallback to the last player id if replay is running
        if isReplay():
            playerId = db.get('tokens', 'lastPlayerId')
            if playerId is None:
                return None
            tdata = db.get('tokens', playerId)

    return tdata

#    token = None
#    if tdata is None:
#    try:
#        if tdata['status'] == 'active':
#            if long(tdata['expires_at'])/1000 > time.time():
#                token = tdata
#    except:
#        token = None
#
#    #log(token)
#    return token

def _getXvmStatTokenData():
    global _tdataPrev

    playerId = getCurrentPlayerId()
    if playerId is None:
        return None

    tdataActive = _getXvmStatActiveTokenData()
    tdata = _checkToken(playerId, None if tdataActive is None else tdataActive['token'])
    if tdata is None:
        tdata = _tdataPrev

    type = SystemMessages.SM_TYPE.Warning
    msg = '<textformat tabstops="[130]"><img src="img://../xvm/res/icons/xvm/16x16t.png" vspace="-5">'
    msg += '&nbsp;<a href="#XVM_SITE#"><font color="#E2D2A2">www.modxvm.com</font></a>\n\n'
    if tdata is None:
        msg += '{{l10n:token/network_error}}'
    elif tdata['status'] == 'badToken':
        msg += '{{l10n:token/bad_token}}'
    elif tdata['status'] == 'blocked':
        msg += '{{l10n:token/blocked}}'
    elif tdata['status'] == 'inactive':
        msg += '{{l10n:token/inactive}}'
    elif tdata['status'] == 'active':
        type = SystemMessages.SM_TYPE.GameGreeting
        msg += '{{l10n:token/active}}\n'
        s = time.time()
        e = tdata['expires_at']/1000
        days_left = int((e - s) / 86400)
        hours_left = int((e - s) / 3600) % 24
        mins_left = int((e - s) / 60) % 60
        token_name = 'time_left' if days_left >= 3 else 'time_left_warn'
        msg += '{{l10n:token/%s:%d:%02d:%02d}}\n' % (token_name, days_left, hours_left, mins_left)
        msg += '{{l10n:token/cnt:%d}}' % tdata['cnt']
    else:
        type = SystemMessages.SM_TYPE.Error
        msg += '{{l10n:token/unknown_status}}\n%s' % simplejson.dumps(tdata)
    msg += '</textformat>'

    if _tdataPrev is None or _tdataPrev['status'] != 'active' or tdata is None or tdata['status'] != 'active':
        SystemMessages.pushMessage(msg, type)

    if tdata is not None:
        _tdataPrev = tdata
        if 'token' in tdata:
            db.set('tokens', playerId, tdata)
        elif tdataActive is not None:
            tdata['token'] = tdataActive['token']
        db.set('tokens', 'lastPlayerId', playerId)

    return tdata


def _checkToken(playerId, token):
    data = None
    try:
        req = "checkToken/%d" % playerId
        if token is not None:
            req += "/%s" % token.encode('ascii')
        server = XVM_STAT_SERVERS[randint(0, len(XVM_STAT_SERVERS) - 1)]
        (response, duration) = loadUrl(server, req)

        #response = """{"expires_at":1394834790589,"cnt":0,"_id":4630209,"status":"active","token":"84a45576-5f06-4945-a607-bbee61b4876a","__v":0,"start_at":1393625190589}"""
        #response = """{"expires_at":1394817931657,"cnt":1,"_id":2178413,"status":"inactive","start_at":1393608331657}"""
        #response = """{"expires_at":1394817931657,"cnt":3,"_id":2178413,"status":"badToken","start_at":1393608331657}"""

        if not response:
            #err('Empty response or parsing error')
            pass
        else:
            try:
                if response is None:
                    return None
                response = response.strip()
                data = None if response in ('', '[]') else simplejson.loads(response)
                log(utils.hide_guid(response))
            except Exception, ex:
                err('  Bad answer: ' + response)
                data = None
    except Exception, ex:
        err(traceback.format_exc())

    return data
