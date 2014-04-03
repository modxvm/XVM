""" xvm (c) sirmax 2013-2014 """

def get(dbname, key):
    #debug('db.get: ' + str(key))
    return _get(dbname, key)

def set(dbname, key, value):
    #debug('db.set: ' + str(key) + ' => ' + str(value))
    _set(dbname, key, value)


# PRIVATE

import os
import traceback
import threading

from constants import XVM_DB_DIR
from logger import *
import utils
from tinydb import TinyDB, where

_db_lock = threading.RLock()

def _get(dbname, key):
    global _db_lock
    with _db_lock:
        try:
            db = TinyDB(os.path.join(XVM_DB_DIR, dbname + '.xdb'))
            t = db.table('xvm')
            obj = t.get(where('key') == key)
            if obj is None or not 'value' in obj:
                return None
            return obj['value']
        except Exception, ex:
            err('db.get() exception: ' + traceback.format_exc())
        return None

def _set(dbname, key, value):
    global _db_lock
    with _db_lock:
        try:
            db = TinyDB(os.path.join(XVM_DB_DIR, dbname + '.xdb'))
            t = db.table('xvm')
            t.remove(where('key') == key)
            t.insert({'key': key, 'value': value})
        except Exception, ex:
            err('db.set() exception: ' + traceback.format_exc())
