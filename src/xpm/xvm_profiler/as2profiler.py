""" XVM (c) www.modxvm.com 2013-2015 """

import time

from xfw import *
from xvm_main.python.logger import *

class _AS2Profiler(object):
    def __init__(self):
        self.init()

    def init(self):
        self.data = dict()

    def methodStart(self, name):
        if not name in self.data:
            self.data[name] = { 'name': name, 'ncalls': 0, 'cumtime': 0 }
        self.data[name]['_start'] = time.clock()

    def methodEnd(self, name):
        if not name in self.data:
            return
        d = self.data[name]
        d['ncalls'] += 1
        d['cumtime'] += time.clock() - d['_start']

    def showResult(self):
        s = '\n\nAS2Profiler:\n\n   ncalls  cumtime  percall  name'
        for i in sorted(self.data.values(), key=lambda x: x['cumtime']):
            percall = i['cumtime'] / i['ncalls'] if i['ncalls'] > 0 else 0
            s += '\n {:>8d} {:>8.3f} {:>8.3f}  {}'.format(i['ncalls'], i['cumtime'], percall, i['name'])
        log(s + '\n\n')

g_as2profiler = _AS2Profiler()
