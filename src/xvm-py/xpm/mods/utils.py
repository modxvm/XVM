""" Misc functions (c) sirmax 2013 """

import datetime
import json
import codecs
import random

import Event

#####################################################################
# Common methods

def log(msg):
    print datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S:'), msg

def msec(start, end):
    td = end - start
    return int(td.microseconds / 1000 + td.seconds * 1000)

def enum(**enums):
    return type('Enum', (), enums)

def logtrace(exc=None):
    print "============================="
    import traceback
    if exc is not None:
        log("ERROR: " + str(exc))
        traceback.print_exc()
    else:
        traceback.print_stack()
    print "============================="

def load_config(fn):
    try:
        return json.load(codecs.open(fn, 'r', 'utf-8-sig'))
    except:
        logtrace(__file__)
        return None

# warning: slow methon, but can work with nont-hashable items
def uniq(seq):
    # Order preserving
    checked = []
    for e in seq:
        if e not in checked:
            checked.append(e)
    return checked

#################################################################
# Singleton

class Singleton(type):
    def __init__(self, name, bases, dict):
        super(Singleton, self).__init__(name, bases, dict)
        self.instance = None

    def __call__(self, *args, **kw):
        if self.instance is None:
            self.instance = super(Singleton, self).__call__(*args, **kw)
        return self.instance

#####################################################################
# Register events

def RegisterEvent(cls, method, handler, prepend=False):
    evt = '__event_%i_%s' % ((1 if prepend else 0), method)
    if hasattr(cls, evt):
        e = getattr(cls, evt)
    else:
        newm = '__orig_%i_%s' % ((1 if prepend else 0), method)
        setattr(cls, evt, Event.Event())
        setattr(cls, newm, getattr(cls, method))
        e = getattr(cls, evt)
        m = getattr(cls, newm)
        setattr(cls, method, lambda *a, **k: __event_handler(prepend, e, m, *a, **k))
    e += handler

def __event_handler(prepend, e, m, *a, **k):
    if prepend:
        e(*a, **k)
        r = m(*a, **k)
    else:
        r = m(*a, **k)
        e(*a, **k)
    return r

def OverrideMethod(cls, method, handler):
    i = 0
    while True:
        newm = '__orig_%i_%s' % (i, method)
        if not hasattr(cls, newm):
            break
        i += 1
    setattr(cls, newm, getattr(cls, method))
    setattr(cls, method, lambda *a, **k: handler(getattr(cls, newm), *a, **k))
