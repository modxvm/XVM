""" XVM (c) www.modxvm.com 2013-2015 """

from logger import *
import config
import utils
import xvmapi

def clear():
    #trace('token.clear')
    config.token = config.XvmServicesToken()

def restore():
    #trace('token.restore')
    config.token = config.XvmServicesToken.restore()

def updateTokenFromApi():
    #trace('token.updateTokenFromApi')
    try:
        (data, errStr) = xvmapi.getToken()
        #log(utils.hide_guid(data))
        config.token.update(data, errStr)
    except Exception, ex:
        err(traceback.format_exc())
