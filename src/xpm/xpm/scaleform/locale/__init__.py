""" XPM mods loader (c) www.modxvm.com 2013-2014 """

print "[XPM] preloader", __name__
try:
    import gui.mods
except:
    print "============================="
    import traceback
    traceback.print_exc()
    print "============================="
