""" Mods loader (c) sirmax 2013 """

try:
    from gui.mods import *
except:
    print "============================="
    import traceback
    traceback.print_exc()
    print "============================="
