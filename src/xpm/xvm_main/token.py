""" XVM (c) www.modxvm.com 2013-2015 """

from logger import *
import config
import utils
import xvmapi

def clear():
    trace('token.clear')
    config.token = config.XvmServicesToken()

def restore():
    trace('token.restore')
    config.token = config.XvmServicesToken.restore()

def updateTokenFromApi():
    trace('token.updateTokenFromApi')
    try:
        (data, errStr) = xvmapi.getToken()
        log(utils.hide_guid(data))

        # response= """{"status":"inactive"}"""
        # response = """{"expires_at":1394834790589,"cnt":0,"_id":4630209,"status":"active",
        # "token":"84a45576-5f06-4945-a607-bbee61b4876a","__v":0,"start_at":1393625190589}"""
        # response = """{"expires_at":1394817931657,"cnt":3,"_id":2178413,"status":"badToken",
        # "start_at":1393608331657}"""

        config.token.update(data, errStr)

    except Exception, ex:
        err(traceback.format_exc())
