# -*- coding: utf-8 -*-

from memoryfs import *

m=MemoryFS()
f=m.open('jp.txt', 'w')
x = u'私は学生です'
f.write(x)

f.close()
m.tree()
