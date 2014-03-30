""" xvm (c) sirmax 2013-2014 """

# PUBLIC

def getXvmStatTokenData():
    return _getXvmStatTokenData()

def getXvmStatActiveTokenData():
    return _getXvmStatActiveTokenData()

# PRIVATE

from pprint import pprint
from random import randint
import json
import traceback
import datetime
import time

import BigWorld
from gui import SystemMessages

from constants import *
import db
from logger import *
from loadurl import loadUrl
import utils

_tokens = db.get('tokens', 'tokens') or dict()
_tdata2 = None

def _getXvmStatTokenData():
    global _tokens
    global _tdata2

    playerId = _getPlayerId()
    if playerId is None:
        return None

    tdata = _getXvmStatActiveTokenData()
    tdata2 = _checkToken(playerId, None if tdata is None else tdata['token'])
    if tdata2 is None:
        tdata2 = _tdata2

    type = SystemMessages.SM_TYPE.Warning
    msg = '<textformat tabstops="[120]"><a href="#XVM_SITE#">www.modxvm.com</a>\n\n'
    if tdata2 is None:
        msg += '{{l10n:token/network_error}}'
    elif tdata2['status'] == 'badToken':
        msg += '{{l10n:token/bad_token}}'
    elif tdata2['status'] == 'blocked':
        msg += '{{l10n:token/blocked}}'
    elif tdata2['status'] == 'inactive':
        msg += '{{l10n:token/inactive}}'
    elif tdata2['status'] == 'active':
        type = SystemMessages.SM_TYPE.Information
        msg += '{{l10n:token/active}}\n'
        s = _get_current_unix_time()
        e = tdata2['expires_at']/1000
        days_left = int((e - s) / 86400)
        if days_left > 0:
            msg += '{{l10n:token/days_left:%d}}\n' % days_left
        else:
            hours_left = int((e - s) / 3600)
            msg += '{{l10n:token/hours_left:%d}}\n' % hours_left
        msg += '{{l10n:token/cnt:%d}}' % tdata2['cnt']
    else:
        type = SystemMessages.SM_TYPE.Error
        msg += '{{l10n:token/unknown_status}}\n%s' % json.dumps(tdata2)
    msg += '</textformat>'

    if _tdata2 is None or _tdata2['status'] != 'active' or tdata2 is None or tdata2['status'] != 'active':
        SystemMessages.pushMessage(msg, type)

    if tdata2 is not None:
        _tdata2 = tdata2

    if tdata2 is not None:
        if 'token' in tdata2:
            _tokens[playerId] = tdata2
            db.set('tokens', 'tokens', _tokens)
        elif tdata is not None:
            tdata2['token'] = tdata['token']
        db.set('tokens', 'lastPlayerId', playerId)

    return tdata2


def _getXvmStatActiveTokenData():
    global _tokens

    playerId = _getPlayerId()
    #log(playerId)
    if playerId is None:
        return None

    if playerId not in _tokens:
        # fallback to the last player id if replay is running
        if utils.is_replay():
            playerId = db.get('tokens', 'lastPlayerId') or None

    if playerId is None:
        return None

    token = None
    try:
        if playerId in _tokens:
            if _tokens[playerId]['status'] == 'active':
                if long(_tokens[playerId]['expires_at'])/1000 > _get_current_unix_time():
                    token = _tokens[playerId]
    except:
        token = None

    #log(token)
    return token

def _get_current_unix_time():
    return int(time.mktime(datetime.datetime.utcnow().timetuple()))

def _getPlayerId():
    player = BigWorld.player()
    if hasattr(player, 'databaseID'):
        return player.databaseID

    arena = getattr(player, 'arena', None)
    if arena is not None:
        vehID = getattr(player, 'playerVehicleID', None)
        if vehID is not None and vehID in arena.vehicles:
            return arena.vehicles[vehID]['accountDBID']

    #print('===================')
    #pprint(vars(player))
    #print('===================')
    return None


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
                data = None if response in ('', '[]') else json.loads(response)
            except Exception, ex:
                err('  Bad answer: ' + response)
                data = None
    except Exception, ex:
        err(traceback.format_exc())

    return data
