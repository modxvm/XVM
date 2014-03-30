""" xvm (c) sirmax 2013-2014 """

def get(dbname, key):
    d = _db.getdb(dbname)
    return d[key] if d.has_key(key) else None

def set(dbname, key, value):
    d = _db.getdb(dbname)
    d[key] = value

# PRIVATE

import os
import shelve

from constants import XVM_DB_DIR

class _DB():
    def __init__(self):
        if not os.path.isdir(XVM_DB_DIR):
            os.makedirs(XVM_DB_DIR)
        _db_filename = os.path.join(XVM_DB_DIR, 'xvm')
        self.d = dict()

    def __del__(self):
        for (n, d) in self.d:
            d.close()

    def getdb(self, dbname):
        if not self.d.has_key(dbname):
            self.d[dbname] = shelve.open(os.path.join(XVM_DB_DIR, dbname))
        return self.d[dbname]

_db = _DB()
