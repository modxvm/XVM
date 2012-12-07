###################
# 1. Introduction #
###################

XvmFS is virtual filesystem based on FUSE driver. It is used by XVM mod
to obtain and show player's game rating.

XVM is popular mod for 'Worls of Tanks' MMO game.

XVM, XVM-STAT and XvmFS are distributed under GNU GPL v3 public license.
The packages, the source code and the bug tracker are available at 
http://code.google.com/p/wot-xvm/
The setup and configuration routines are described at the project's home.
It is assumed that XVM is already installed and configured.

#############################
# 2. Installation and setup #
#############################

XvmFS requires:
 - FUSE support from kernel side. Applicable to 2.4.X and 2.6.X kernels
   and is enabled by default on the most of modern Linux distributives.

 - Python v.2.X  interpretator. Already presents on the most of Linux
   distributives. The XvmFS was tested on Python 2.6.5 and 2.7.3

 - FUSE bindings for Python. Should be installed manually. See the following
   examples for some Linux distributives.

   Debian, Ubuntu:

   $ sudo apt-get install python-fuse

   RedHat, CentOS:

   # yum install fuse-python
   
   ArchLinux:

   # pacman -S python2-fuse

   Gentoo:

   # emerge -av dev-python/fuse-python

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

##################
# 3. XvmFS usage #
##################

Generic usage:
$ ./xvmfs [mount point] [parameters]

The mount point should be the 'res_mods/.stat' directory under the
main game folder. After successfull mount there will be 'README' file
available in read-only mode.

Parameters description:

-h, --help
    Show brief help and all applicable parameters

-o opt,[opt...]
    Mount option(s). Several mount options can be specified as comma-separated
    list or as separate '-o opt[=...]' key-value pairs. All generic mount
    options are applicable, and the description of XvmFS-specific options
    see below.

-o xvm_cfg=FILE
    Specify the file which contains xvm-stat module settings. By default it
    is named 'xvm-stat.exe.config' and is expected to be in the current
    directory.

-o wot_cfg=FILE
    Specify the file with World of Tanks launcher settings. By default it is
    named 'WOTLauncher.cfg' and is expected to be in the current directory.
    
-o game_dir=DIR
    The full path to the game's folder as it should be visible to the game
    which is run under WINE. For example, if the game is placed into
    '~/.wine/drive_c/Games/World_of_Tanks' directory, then the DIR should
    be equal 'C:\Games\World_of_Tanks'

-o log_dir=DIR
    Specify the directory where XvmFS logs will be present. By default
    log files are placed into current directory.

-o debug
    Enable additional (debug) messages output in log files.

Examples:

    Show help:

    $ ./xvmfs --help

    Basic XvmFS start options:

    $ ./xvmfs res_mods/.stat -o game_dir='С:\WOT'

    Write logs to '/tmp/xvm' folder:

    $ ./xvmfs res_mods/.stat -o game_dir='С:\WOT' -o log_dir=/tmp/xvm

    Mount options can be provided as comma-separated list:

    $ ./xvmfs res_mods/.stat -o debug,log_dir=/tmp/xvm,game_dir='С:\WOT'

    Unmounting XvmFS:

    $ fusermount -u res_mods/.stat

After XvmFS is mounted into the right place, you can start the game exactly
as before. No additional actions are required on game restart since XvmFS
will be still mounted. 

It is recommented to unmount XvmFS after you've finished the gaming time.
    
#############
# 4. Issues #
#############

Sometimes things goes wrong and do not work as expected. Check xvmfs.log file
content. If 'HTTP Error' messages are present, it means that outer XVM proxy
have perfomance issues (again) and no further investigation is required.

In other cases, mounting XvmFS with '-o debug' option will produce extra
debugging info for logging.

Before first run please ensure that 'xvmfs' file have executable permissions.
Use the following command to set required permissions:

$ chmod +x xvmfs

