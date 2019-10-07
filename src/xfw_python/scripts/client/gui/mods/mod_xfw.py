"""
This file is part of the XVM Framework project.

Copyright (c) 2013-2019 XVM Team.

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

import sys
import traceback

try:
    #Files in VFS
    sys.path.insert(0, 'mods/xfw/python')
    sys.path.insert(0, 'mods/xfw_libraries')

    #Files in RealFS
    sys.path.insert(0, '../res_mods/mods/xfw/python')
    sys.path.insert(0, '../res_mods/mods/xfw_libraries')

    import xfw
    import xfw.vfs as vfs

    import xfw_loader

except Exception:
    print "[XFW/Entrypoint] Error:"
    traceback.print_exc()
