"""
This file is part of the XVM Framework project.

Copyright (c) 2018-2020 XVM Team.

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


#cpython
import logging
import os

#xfw.loader
import xfw_loader.python as loader
import xfw_vfs as vfs

#xfw_libraries
from xfw.utils import resolve_path

g_xfwfonts = None

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
        self.__native = None
        self.__package_name = 'com.modxvm.xfw.fonts'
        self.__initialized = False

        try:
            xfwnative = loader.get_mod_module('com.modxvm.xfw.native')
            if not xfwnative:
                logging.error('[XFW/Ping] Failed to load native module. XFW Native is not available')
                return

            if not xfwnative.unpack_native(self.__package_name):
                logging.error('[XFW/Ping] Failed to load native module. Failed to unpack native module')
                return

            self.__native = xfwnative.load_native(self.__package_name, 'xfw_fonts.pyd', 'XFW_Fonts')
            if not self.__native:
                logging.error("[XFW/Ping] Failed to load native module. Crash report were not enabled")
                return

            self.__native.init_hooks()
            self.__register_builtin()

            self.__initialized = True
        except Exception:
            logging.exception("[XFW/Ping] Error when loading native library:")



    def is_initialized(self):
        return self.__initialized

    def register_font(self, font_path, private = True, non_enumerable = False):
        """
        Register font to system or game.

        font_path      -- path to font relative to TODO
        private        -- false to install font global to system
        non_enumerable -- true to hide font for EnumFonts* WinAPI functions
        """

        logging.info("[XFW/Fonts][register_font]: register %s" % font_path)

        if self.__native is None:
            return

        font_path = self.__get_file(font_path)
        if font_path is None:
            logging.warning("[XFW/Fonts][register_font] Failed to register font: empty path")
            return

        try:
            if not self.__native.register_font(unicode(font_path), private, non_enumerable):
                logging.error("[XFW/Fonts][register_font] Failed to register font %s" % font_path)
        except Exception:
            logging.exception("[XFW/Fonts][register_font]")


    def add_alias(self, alias, font_name):
        """
        TODO
        """
        if self.__native is None:
            return

        try:
            return self.__native.add_alias(alias, font_name)
        except Exception:
            logging.exception("[XFW/Fonts][add_alias]")


    def remove_alias(self, alias):
        """
        TODO
        """
        if self.__native is None:
            return

        try:
            return self.__native.remove_alias(alias)
        except Exception:
            logging.exception("[XFW/Fonts][remove_alias]")


    def unregister_font(self, font_path, private = True, non_enumerable = False):
        """
        Unregister font from system or game.

        font_path      -- path to font relative to TODO
        private        -- false to install font global to system
        non_enumerable -- true to hide font for EnumFonts* WinAPI functions
        """

        if self.__native is None:
            return

        font_path = self.__get_file(font_path)
        if font_path is None:
            return

        try:
            if not self.__native.unregister_font(unicode(font_path), private, non_enumerable):
                logging.error("[XFW/Fonts][unregister_font] Failed to unregister font %s" % font_path)
        except Exception:
            logging.exception("[XFW/Fonts][unregister_font]")


    def __register_builtin(self):
        dir_mod = loader.get_mod_directory_path(self.__package_name)
        dir_fonts = dir_mod + '/fonts/'

        if loader.is_mod_in_realfs(self.__package_name):
            for font in os.listdir(dir_fonts):
                self.register_font(font)
        else:
            for font in vfs.directory_list_files(dir_fonts, True):
                self.register_font(font)


        self.add_alias(u"dynamic" , u"DynamicDefault")
        self.add_alias(u"dynamic2", u"DynamicOutline")
        self.add_alias(u"vtype"   , u"VehicleType")
        self.add_alias(u"xvm"     , u"XVMSymbol")
        self.add_alias(u"mono"    , u"ZurichCondMono")


    def __get_file(self, path):
        """
        Get absolute path to font:

        cfg://* -> ../res_mods/configs/xvm/*
        res://* -> ../res_mods/mods/shared_resources/*
        xvm://* -> ../res_mods/mods/shared_resources/xvm/*
        """

        font_path = resolve_path(path).lower()
        if not vfs.file_exists(font_path):
            logging.warning("[XFW/Fonts][__get_file] Font does not exists %s" % font_path)
            return None

        #do not copy RealFS fonts
        if os.path.isfile(font_path):
            return font_path

        realfs_path = loader.XFWLOADER_TEMPDIR + '/'+self.__package_name + '/fonts/%s' % os.path.basename(font_path)
        if vfs.file_copy(font_path, realfs_path):
            return realfs_path
        else:
            logging.error("[XFW/Fonts][__get_file] Failed to copy font to RealFS: %s --> %s" % (font_path, realfs_path))
            return None


def xfw_is_module_loaded():
    if not g_xfwfonts:
        return False

    return g_xfwfonts.is_initialized()

g_xfwfonts = XFWFonts()
