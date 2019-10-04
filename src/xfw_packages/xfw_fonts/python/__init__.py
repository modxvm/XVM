"""
This file is part of the XVM Framework project.

Copyright (c) 2018-2019 XVM Team.

XVM Framework is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation, version 3.

XVM Framework is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
"""

#####################################################################
# imports

import imp
import os
import traceback
import sys

from xfw.constants import PATH
from xfw.utils import resolve_path
import xfw.vfs as vfs

#####################################################################
# bank manager

class XFWFonts(object):
    """
    Class that helps to load/unload fonts to World of Tanks
    Use g_fonts object for interaction with this class.

    Example:
        TODO:
    """

    def __init__(self):
        """
        XFWFonts initialization
        """
        self.native = None

        try:
            if "python27" in sys.modules:
                path_realfs = PATH.XFWLOADER_PACKAGES_REALFS + '/xfw_fonts/native/xfw_fonts.pyd'
                path_vfs = PATH.XFWLOADER_PACKAGES_VFS + '/xfw_fonts/native/xfw_fonts.pyd'

                is_in_realfs = os.path.isfile(path_realfs)
                if is_in_realfs:
                    self.native = imp.load_dynamic('XFW_Fonts', path_realfs)
                else:
                    self.native = vfs.c_extension_load('XFW_Fonts', path_vfs, 'com.modxvm.xfw.fonts')
            else:
                print "[XFW/Fonts][init] was not loaded because of python27 error"
                return
        except Exception:
            print "[XFW/Fonts][init] Error on loading native components"
            traceback.print_exc()
            return

        self.native.init_hooks()
        self.__register_builtin()


    def register_font(self, font_path, private = True, non_enumerable = False):
        """
        Register font to system or game.
      
        font_path      -- path to font relative to TODO
        private        -- false to install font global to system
        non_enumerable -- true to hide font for EnumFonts* WinAPI functions
        """
        
        print "[XFW/Fonts][register_font]: register %s" % font_path

        if self.native is None:
            return

        font_path = self.__get_file(font_path)
        if font_path is None:
            print "[XFW/Fonts][register_font] Failed to register font: empty path"
            return

        try:
            if not self.native.register_font(unicode(font_path), private, non_enumerable):
                print "[XFW/Fonts][register_font] Failed to register font %s" % font_path
        except Exception:
            traceback.print_exc()

        
    def add_alias(self, alias, font_name):
        """
        TODO
        """
        if self.native is None:
            return

        try:
            return self.native.add_alias(alias, font_name)
        except Exception:
            traceback.print_exc()

        
    def remove_alias(self, alias):
        """
        TODO
        """
        if self.native is None:
            return

        try:
            return self.native.remove_alias(alias)
        except Exception:
            traceback.print_exc()

    def unregister_font(self, font_path, private = True, non_enumerable = False):
        """
        Unregister font from system or game.
      
        font_path      -- path to font relative to TODO
        private        -- false to install font global to system
        non_enumerable -- true to hide font for EnumFonts* WinAPI functions
        """
        
        if self.native is None:
            return

        font_path = self.__get_file(font_path)
        if font_path is None:
            return

        try:
            if not self.native.unregister_font(unicode(font_path), private, non_enumerable):
                print "[XFW/Fonts][unregister_font] Failed to unregister font %s" % font_path
        except Exception:
            traceback.print_exc()


    def __register_builtin(self):
        fontsdir_realfs= PATH.XFWLOADER_PACKAGES_REALFS + '/xfw_fonts/fonts/'
        fontsdir_vfs = PATH.XFWLOADER_PACKAGES_VFS + '/xfw_fonts/fonts/'

        is_in_realfs = os.path.isdir(fontsdir_realfs)

        if is_in_realfs:
            for font in os.listdir(fontsdir_realfs):
                self.register_font(font)
        else:
            for font in vfs.directory_list_files(fontsdir_vfs, True):            
                self.register_font(font)

        self.add_alias(u"dynamic" , u"DynamicDefault")
        self.add_alias(u"dynamic2", u"DynamicOutline")
        self.add_alias(u"vtype"   , u"VehicleType")
        self.add_alias(u"xvm"     , u"XVMSymbol")
        self.add_alias(u"mono"    , u"ZurichCondMono")

    def __get_file(self, path):
        """
        Get absolute path to font:

        cfg://* -> /res_mods/configs/xvm/*
        res://* -> /res_mods/mods/shared_resources/*
        xvm://* -> /res_mods/mods/shared_resources/xvm/*
        """
           
        font_path = resolve_path(path).lower()
        if not vfs.file_exists(font_path):
            print "[XFW/Fonts][__get_file] Font does not exists %s" % font_path
            return None

        is_in_realfs = os.path.isfile(font_path)
        if is_in_realfs:
            return font_path
    
        realfs_path = 'mods\\temp\\com.modxvm.xfw.fonts\\fonts\\%s' % os.path.basename(font_path)
        if vfs.file_copy(font_path, realfs_path):
            return realfs_path
        else:
            print "[XFW/Fonts][__get_file] Failed to copy font to RealFS: %s --> %s" % (font_path, realfs_path)
            return None

        print "[XFW/Fonts][__get_file] Unknown error"
        return None

g_fonts = XFWFonts()
