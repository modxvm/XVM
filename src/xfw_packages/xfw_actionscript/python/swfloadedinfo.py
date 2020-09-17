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

class _SwfLoadedInfo(object):

    def __init__(self):
        self.__swfs_loaded = list()
        self.__swfs_names = dict()

    def clear(self):
        self.__swf_name_clear()
        self.__swf_loaded_clear()

    ## swf name
    def swf_name_get(self, mod_name):
        if not mod_name.lower() in self.__swfs_names:
            return None

        return self.__swfs_names[mod_name.lower()]

    def swf_name_get_all(self):
        return self.__swfs_names

    def swf_name_set(self, mod_name, swf_info):
        self.__swfs_names[mod_name.lower()] = swf_info.lower()

    def __swf_name_clear(self):
        self.__swfs_names.clear()

    ## swf loaded flag
    def swf_loaded_get_all(self):
        return self.__swfs_loaded

    def swf_loaded_get(self, swf):
        return swf.lower() in self.__swfs_loaded

    def swf_loaded_set(self, swf):
        if swf.lower() not in self.__swfs_loaded:
            self.__swfs_loaded.append(swf.lower())

    def __swf_loaded_clear(self):
        del self.__swfs_loaded[:]


swf_loaded_info = _SwfLoadedInfo()
