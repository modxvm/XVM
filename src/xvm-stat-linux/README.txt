XvmFS is XVM FUSE driver implementation with additional features
required for XVM mod.

XVM is popular mod for 'Worls of Tanks' MMO game.
Original mod is located at http://code.google.com/p/wot-xvm/

XvmFS is distributed under GNU GPL v3 public license.


This script requires a kernel with FUSE support, Python interpreter
(2.6.5 was used during creation) and Python FUSE libraries. The FUSE is
supported by most of modern kernels, and Python is included in base OS
installation. However, Python FUSE libraries should be installed manually.

Here is example for Ubuntu:

$ sudo apt-get install python-fuse

The XvmFS should be mounted into 'res_mods/.stat' subfolder of the
World of Tanks game installation folder. The full path to '.stat' folder should
look like '/home/user/.wine/drive_c/Games/World_of_Tanks/res_mods/.stat' .

If the target folder does not exist, if must be created before mounting XvmFS.
For example:

$ cd ~/.wine/drive_c/Games/World_of_Tanks
$ mkdir -p res_mods/.stat

Please note that XvmFS knows nothing about WINE and cannot determine
how exactly the path to the mount point will be look from WINE side.
In the same time, there is one important value which is passed via XvmFS:
the Windows-like path to the game binaries folder. This was the reason of
'-o game_dir' option creation. The argument for that option should be the
path to the game binaries folder as it is visible to WINE-powered application.

TL;DR: ALWAYS run XvmFS with '-o game_dir=...' option, providing correct values
as in example below:

$ xvmfs res_mods/.stat -o game_dir='C:\Games\World_of_Tanks'

By default, XvmFS will create log files in the current folder. If necessary,
log folder may be specified using '-o log_dir' option:

$ xvmfs res_mods/.stat -o game_dir='C:\WOT' -o log_dir=/var/log/wot

XvmFS depends on two configuration files:
- World of Tanks Launcher config file (currently - 'WOTLauncher.cfg').
    This file is created during the game installation.

- XVM statistics configuration file (currently - 'xvm-stat.exe.config').
    This file is provided from 'xvm-stat' archive from main XVM repository
    http://code.google.com/p/wot-xvm

Both of these two files should be in the game binaries folder. By default, XvmFS
expects that it is launched from that folder. If not, use '-o xvm_cfg=...' and
'-o wot_cfg=...' options to point on these files.

Sometimes things goes wrong and do not work as expected. Check xvmfs.log file
content. If 'HTTP Error' messages are present, it means that outer XVM proxy
have perfomance issues (again) and no further investigation is required.

In other cases, mounting XvmFS with '-o debug' option will produce extra
debugging info for logging.

