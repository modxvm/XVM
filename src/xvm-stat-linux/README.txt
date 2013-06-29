################
# 0. Changelog #
################

Added in 0.4.0:
 - Ping WoT servers (statistics on login screen)

Changed in this README:
 2. Mount point was changed from res_mods/.stat to res_mods/xvm/.xvmfs
 3. Appended new parameter description.

 Added usage examples.

###################
# 1. Introduction #
###################

XvmFS is virtual filesystem based on FUSE driver. It is used by XVM mod to 
obtain and show player's game rating.

XVM is popular mod for 'Worls of Tanks' MMO game.

XVM, XVM-STAT and XvmFS are distributed under GNU GPL v3 public license. The 
packages, the source code and the bug tracker are available at
    http://code.google.com/p/wot-xvm/
The setup and configuration routines are described at the project's home. It is 
assumed that XVM is already installed and configured.

#############################
# 2. Installation and setup #
#############################

XvmFS requires:
 - FUSE support from kernel side. Applicable to 2.4.X and 2.6.X kernels and is 
   enabled by default on the most of modern Linux distributives.

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

From v.0.4.0, the XvmFS should be mounted into 'res_mods/xvm/.xvmfs' subfolder 
of the World of Tanks game installation folder. The full path to '.xvmfs' folder 
should look like 
'/home/user/.wine/drive_c/Games/World_of_Tanks/res_mods/xvm/.xvmfs'

If the target folder does not exist, if must be created before mounting XvmFS.
For example:

$ cd ~/.wine/drive_c/Games/World_of_Tanks
$ mkdir -p res_mods/xvm/.xvmfs

If the game is installed on NTFS partition, the XvmFS should be started with '-o 
game_dir=...' option. That option should specify the Windows-like path to the 
game directory. For example, if the game is installed into 
/home/user/.wine/drive_c/Games/World_of_Tanks directory, the following option 
should be used:
 -o game_dir='C:\Games\World_of_Tanks'
There is no needs to use this option when the game is installed on any Linux 
partition, i.e. ext2, ext3, reiserfs and so on.

By default, XvmFS will create log files in the current folder. If necessary, log 
folder may be specified using '-o log_dir' option:

$ ./xvmfs res_mods -o game_dir='C:\WOT' -o log_dir=/var/log/wot

XvmFS depends on several configuration files:
- World of Tanks Launcher config file (currently - 'WOTLauncher.cfg').  This 
  file is created during the game installation.

- XVM statistics configuration file (currently - 'xvm-stat.exe.config').  This 
  file is provided by xvmfs-X.X.X.tar.gz archive. Also it can be taken from 
  'xvm-stat' archive in main XVM repository at http://code.google.com/p/wot-xvm

- The path to the World of Tanks resource directory 'res_mods' is used to find a 
  reference to other game resource files (currently,only 
  'res/scripts_config.xml' file is referenced).

All these files should be in the game binaries folder. By default, XvmFS 
expects that it is launched from that folder. If not, use '-o xvm_cfg=...', 
'-o wot_cfg=...' and '-o res_mods=...' options to point on these files and 
directories.

##################
# 3. XvmFS usage #
##################

Extract the xvmfs-X.X.X.tar.gz archive into the game's directory:
$ cd ~/.wine/drive_c/Games/World_of_Tanks
$ tar -zxf xvmfs-*.tar.gz

Generic usage:
$ ./xvmfs [mount point] [parameters]

The mount point should be the 'res_mods/xvm/.xvmfs' directory under the main 
game folder. After successfull mount there will be 'README' file available in 
read-only mode.

Parameters description:

-h, --help
    Show brief help and all applicable parameters

-o opt,[opt...]
    Mount option(s). Several mount options can be specified as comma-separated 
    list or as separate '-o opt[=...]' key-value pairs. All generic mount 
    options are applicable, and the description of XvmFS-specific options see 
    below.

-o xvm_cfg=FILE
    Specify the file which contains xvm-stat module settings. By default it is 
    named 'xvm-stat.exe.config' and is expected to be in the current directory. 

-o wot_cfg=FILE
    Specify the file with World of Tanks launcher settings. By default it is 
    named 'WOTLauncher.cfg' and is expected to be in the current directory.

-o game_dir=DIR
    The full path to the game's folder as it should be visible to the game which 
    is run under WINE. For example, if the game is placed into 
    '~/.wine/drive_c/Games/World_of_Tanks' directory, then the DIR should be 
    equal 'C:\Games\World_of_Tanks'

-o log_dir=DIR
    Specify the directory where XvmFS logs will be present. By default log files 
    are placed into current directory.

-o res_mods=DIR
    The path to the 'res_mods' directory within main game directory. Used to 
    find a reference to other game resource files.

-o debug
    Enable additional (debug) messages output in log files.

At startup, XvmFS will try to read its own settings from following files (from 
less significant to most significant):

    /etc/default/xvmfs
    /etc/xvm/xvmfs.conf
    /etc/xvmfs.conf
    ~/.xvmfsrc

Command-line options have highest priority over configuration files. All 
configuration options are available in 'default.xvmfsrc' file.

##############
# 4.Examples #
##############

After XvmFS is mounted into the right place, you can start the game exactly as 
before. No additional actions are required on game restart since XvmFS will be 
still mounted. It is recommented to unmount XvmFS after you've finished the 
gaming time.

Use case 1: installation in the game directory.

    $ cd ~/.wine/drive_c/Games/World_Of_Tanks
    $ tar -zxf ~/xvmfs-X.X.X.tar.gz
    $ mkdir -p res_mods/xvm/.xvmfs

    Show help:

    $ ./xvmfs --help

    Common XvmFS start options:

    $ ./xvmfs

    Write logs to '/tmp/xvm' folder:

    $ ./xvmfs -o log_dir=/tmp/xvm

    Mount options can be provided as comma-separated list:

    $ ./xvmfs -o debug,log_dir=/tmp/xvm,game_dir='С:\WOT'

    Unmounting XvmFS:

    $ fusermount -u res_mods/xvm/.xvmfs

##########################

Use case 2: installation in any other directory

    $ mkdir ~/xvm
    $ cd ~/xvm
    $ tar -zxf ~/xvmfs-X.X.X.tar.gz
    $ cd ~/.wine/drive_c/Games/World_of_Tanks
    $ mkdir -p res_mods/xvm/.xvmfs

    Start from game directory:

    $ ~/xvm/xvmfs -o xvm_cfg=~/xvm/xvm-stat.exe.config

    Or from installation directory:

    $ cd ~/xvm
    $ ./xvmfs -o res_mods=~/.wine/drive_c/Games/World_of_Tanks/res_mods,\
    > wot_cfg=~/.wine/drive_c/Games/World_of_Tanks/WOTLauncher.cfg

Using xvmfs config files:

    $ cat << EOF > ~/.xvmfsrc
xvm_cfg = ~/xvm/xvm-stat.exe.config
wot_cfg = ~/.wine/drive_c/Games/World_of_Tanks/WOTLauncher.cfg
res_mods = ~/.wine/drive_c/Games/World_of_Tanks/res_mods
log_dir = /tmp
EOF

    $ cd ~/.wine/drive_c/Games/World_of_Tanks
    $ ~/xvm/xvmfs

##########################

Use case 3: mounting with fstab in Ubuntu 12.04

Add user account to the 'fuse' group:
    $ whoami
    user
    $ sudo usermod -a -G fuse user

After that, exit from account and log in again in order to apply changed 
permissions. Check that account is added to the 'fuse' group:
    $ id
    uid=1001(user) gid=1001(user) groups=1001(user),4(adm),24(cdrom),
    27(sudo),30(dip),46(plugdev),104(fuse),109(lpadmin),124(sambashare)

Copy xvmfs into system library:
    $ cd ~/xvm
    $ sudo mkdir /usr/lib/xvmfs
    $ sudo cp xvmfs xvm_utils.py xvm_bxml.py /usr/lib/xvmfs

Create links to the executables:
    $ cd /usr/local/bin
    $ sudo ln -s /usr/lib/xvmfs/xvmfs
    $ sudo ln -s xvmfs mount.xvmfs

Create log directory:
    $ cd /var/log
    $ sudo bash -c 'mkdir xvm; chown root:fuse xvm; chmod g+w xvm'

Create system settings directory:
    $ sudo mkdir /etc/xvm
    $ cd /etc/xvm
    $ sudo cp ~/xvm/xvm-stat.exe.config .
    $ cat << EOF | sudo tee xvmfs.conf
xvm_cfg = /etc/xvm/xvm-stat.exe.config
wot_cfg = /home/user/.wine/drive_c/Games/World_of_Tanks/WOTLauncher.cfg
res_mods = /home/user/.wine/drive_c/Games/World_of_Tanks/res_mods
log_dir = /var/log/xvm
EOF

Edit '/etc/fuse.conf' file, uncommenting the 'user_allow_other' option:
    $ sudo nano /etc/fuse.conf

Append the entry to the fstab:
    $ sudo nano -w /etc/fstab
xvmfs /home/user/.wine/drive_c/Games/World_of_Tanks/res_mods/xvm/.xvmfs fuse.xvmfs ro,noauto,users,allow_other 0 2

Setup is complete. Mount:
    $ mount xvmfs

Verify:
    $ mount | grep xvmfs
    xvmfs on /home/user/.wine/drive_c/Games/World_of_Tanks/res_mods/xvm/.xvmfs
    type fuse.xvmfs (ro,noexec,nosuid,nodev,allow_other,user=user)

Un-mount:
    $ umount xvmfs

#############
# 5. Issues #
#############

Sometimes things goes wrong and do not work as expected. Check xvmfs.log file 
content. If 'HTTP Error' messages are present, it means that outer XVM proxy 
have perfomance issues (again) and no further investigation is required.

In other cases, mounting XvmFS with '-o debug' option will produce extra 
debugging info for logging.

Before first run please ensure that 'xvmfs' file have executable permissions.  
Use the following command to set required permissions:

$ chmod +x xvmfs

