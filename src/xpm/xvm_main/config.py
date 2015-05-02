""" XVM (c) www.modxvm.com 2013-2015 """

__all__ = ['config', 'configLoadError', 'load']

from copy import deepcopy
import traceback
import JSONxLoader
from logger import *

config = None
configLoadError = None

defaultConfig = None

def load(filename):
    global config
    global defaultConfig
    global configLoadError
    try:
        config = deepcopy(defaultConfig)
        configLoadError = None
        result = JSONxLoader.load(filename)
        if result is not None:
            config = merge_configs(config, result)
    except Exception:
        configLoadError = traceback.format_exc()
        err(configLoadError)


def merge_configs(orig_config, new_config):
    # TODO
    return new_config
