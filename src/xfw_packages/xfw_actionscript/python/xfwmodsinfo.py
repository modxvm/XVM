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

class _XfwModsInfo(object):
    info = {}
    loaded_swfs = {}

    def add(self, name, modinfo):
        self.info[name] = modinfo

    def update(self, name, modinfo):
        if name not in self.info:
            self.add(name, modinfo)
        else:
            self.info[name].update(modinfo)

    def swf_loaded(self, swf):
        self.loaded_swfs[swf] = 1

    def clear_swfs(self):
        self.loaded_swfs = {}
        for key in iter(self.info):
            self.info[key].pop('swf_file_name', None)

xfw_mods_info = _XfwModsInfo()
