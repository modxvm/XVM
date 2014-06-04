""" XVM (c) www.modxvm.com 2013-2014 """

def get(dbname, key):
    #debug('db.get: ' + str(key))
    return _db.get(dbname, key)

def set(dbname, key, value):
    #debug('db.set: ' + str(key) + ' => ' + str(value))
    _db.set(dbname, key, value)


# PRIVATE

import os
import traceback
import threading

import simplejson

from constants import XVM_DB_DIR
from logger import *
import utils

if not os.path.isdir(XVM_DB_DIR):
    os.makedirs(XVM_DB_DIR)

class _DB():
    def __init__(self):
        self._lock = threading.RLock()

    def get(self, dbname, key):
        try:
            data = self._read(dbname)
            #debug(data)
            return data.get(str(key), None)
        except Exception, ex:
            err('db.get() exception: ' + traceback.format_exc())
        return None

    def set(self, dbname, key, value):
        try:
            data = self._read(dbname)
            data[str(key)] = value
            self._write(dbname, data)
        except Exception, ex:
            err('db.set() exception: ' + traceback.format_exc())


    def _read(self, dbname):
        with self._lock:
            path = os.path.join(XVM_DB_DIR, dbname + '.xdb')
            utils.touch(path)
            with open(path, 'r') as f:
                try:
                    try:
                        data = simplejson.load(f)
                    except:
                        data = {}
                    return data
                finally:
                    f.close()

    def _write(self, dbname, data):
        with self._lock:
            path = os.path.join(XVM_DB_DIR, dbname + '.xdb')
            with open(path, 'w') as f:
                try:
                    simplejson.dump(data, f)
                finally:
                    f.close()

_db = _DB()
