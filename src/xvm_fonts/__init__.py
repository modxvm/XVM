"""
SPDX-License-Identifier: GPL-3.0-or-later
Copyright (c) 2013-2025 XVM Contributors
"""

#
# Imports
#

# stdlib
import os

# OpenWG
import openwg_fonts
import openwg_loader
import openwg_vfs



#
# Globals
#

__package_id = "com.modxvm.xvm.fonts"



#
# OpenWG API
#

__initialized = False

def owg_module_init():
    global __initialized
    if not __initialized:
        dir_fonts = openwg_loader.get_mod_directory_path(__package_id) + '/fonts/'
        if openwg_loader.is_mod_in_realfs(__package_id):
            for font in os.listdir(dir_fonts):
                openwg_fonts.register_font(font)
        else:
            for font in openwg_vfs.directory_list_files(dir_fonts, True):
                openwg_fonts.register_font(font)

        openwg_fonts.add_alias(u"dynamic" , u"DynamicDefault")
        openwg_fonts.add_alias(u"dynamic2", u"DynamicOutline")
        openwg_fonts.add_alias(u"vtype"   , u"VehicleType")
        openwg_fonts.add_alias(u"xvm"     , u"XVMSymbol")
        openwg_fonts.add_alias(u"mono"    , u"ZurichCondMono")

        __initialized = True


def owg_module_fini():
    global __initialized
    if __initialized:
        __initialized = False


def owg_module_loaded():
    global __initialized
    return __initialized


def owg_module_event(eventName, *args, **kwargs):
    pass
