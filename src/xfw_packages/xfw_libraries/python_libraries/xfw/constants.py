""" XFW Library (c) https://modxvm.com 2013-2021 """

# EXPORT

class XFW_COMMAND(object):
    XFW_CMD = "xfw.cmd"
    GETGAMEREGION = "xfw.gameRegion"
    GETGAMELANGUAGE = "xfw.gameLanguage"
    CALLBACK = "xfw.callback"
    MESSAGEBOX = 'xfw.messageBox'
    SYSMESSAGE = 'xfw.systemMessage'

class XFW_EVENT(object):
    SWF_LOADED = 'xfw.swf_loaded'
    APP_INITIALIZED = 'xfw.app_initialized'
    APP_DESTROYED = 'xfw.app_destroyed'

class XFW_COLORS(object): #in hex, 6 symbols
    UICOLOR_LABEL = "A19D95"
    UICOLOR_VALUE = "C9C9B6"
    UICOLOR_LIGHT = "FDF4CE"
    UICOLOR_DISABLED = "4C4A47"
    UICOLOR_GOLD = "FFC133"
    UICOLOR_GOLD2 = "CBAD78"
    UICOLOR_BLUE = "408CCF"

    UICOLOR_TEXT1 = "E1DDCE"
    UICOLOR_TEXT2 = "B4A983"
    UICOLOR_TEXT3 = "9F9260"

    C_WHITE = "FCFCFC"
    C_RED = "FE0E00"
    C_ORANGE = "FE7903"
    C_YELLOW = "F8F400"
    C_GREEN = "60FF00"
    C_BLUE = "02C9B3"
    C_PURPLE = "D042F3"
    C_MAGENTA = "EE33FF"
    C_GREENYELLOW = "99FF44"
    C_REDSMOOTH = "DD4444"
    C_REDBRIGHT = "FF0000"

# INTERNAL

class VERSION(object):
    WOT_VERSION_FULL = ''  #initialized in xfw_loader.py
    WOT_VERSION_SHORT = '' #initialized in xfw_loader.py

class CONST(object):
    XFW_VIEW_ALIAS = 'xfw_injector'
    XFW_COMPONENT_ALIAS = 'xfw'

class PATH(object):
    XFW_SWF_URL = "xfw.swf"
    XVM_LOG_FILE_NAME = "xvm.log"

class COMMAND(object):
    # Flash -> Python
    XFW_COMMAND_LOG = "xfw.log"
    XFW_COMMAND_INITIALIZED = "xfw.initialized"
    XFW_COMMAND_SWF_LOADED = "xfw.swf_loaded"
    XFW_COMMAND_GETMODS = "xfw.getMods"
    XFW_COMMAND_LOADFILE = "xfw.loadFile"

class URLS(object):
    WG_API_SERVERS = {
        'RU':   'http://api.worldoftanks.ru',
        'EU':   'http://api.worldoftanks.eu',
        'NA':   'http://api.worldoftanks.com',
        'ASIA': 'http://api.worldoftanks.asia',
      # can be uncommented to test on common test server:
      # 'CT':   'http://api.worldoftanks.ru',
    }
