Automatical scripts for ratings replacing in XVM configuration files.
These scripts also change color & alpha macros and the rating for company windows.
The scripts support extended macros formatting for XVM-5.3.0+

Usage:

Very detailed video instruction [(russian)]: https://www.youtube.com/watch?v=OI61kN5Wuvo

Short instruction:

1 variant:
Script file may be placed to arbitrary folder.
Choose the configuration file(s) or folder(s) and drag'n'drop it (them) on the script file.
The script will replace rating in all the dropped files and in all files with *.xc, *.XC, *.xvmconf and *.XVMconf extensions in all the folders(but not subfolders), that were dropped on it.

2 variant:
Place the script into the folder with configs and run it.
Script will replace rating in all files with *.xc, *.XC, *.xvmconf and *.XVMconf extensions in the current folder.

Attention! The script doesn't check the subfolders and links in multifile configs. If you use the script for xvm.xc file, make sure, that it really is a config file, but not a link to a config in other folder.
If you are not sure, drag'n'drop all content of res_mods\xvm\configs folder on the script, except files, that can't be configs for sure: images, video, shortcuts, etc.

Question:
- Which script do I need?
Answer:
- You are provided with a full set of scripts, that allow to replace any of six possible rating representations to any other (including color and alpha).
Currently there are such possible rating representations in XVM:
eff - initial form of wot-news rating
xeff - two-sign form of wot-news rating by XVM scale
wn6 - initial form of WN6 rating
xwn6 - two-sign form of WN6 rating by XVM scale
wn8 - initial form of WN8 rating
xwn8 - two-sign form of WN8 rating by XVM scale
wgr - initial form of WG rating
xwgr - two-sign form of WG rating by XVM scale
The default macro is a two-sign form of WN8 rating by XVM scale: xwn8.

E.g. if you want to use initial form of wot-news rating,
you need to use any_to_eff.js
To switch to two-sign form of WN8 rating by XVM scale use any_to_xwn8.js
etc.


For developers:

Script may be called from other scripts, batch files and programs with arguments or without them:
anyscript.js [rating] [file1 folder1 folder2 folder3 file3 ...]
The first argument may be a rating, that will be applied to all the files and folders, enumerated further.
Possible values for [rating]: eff xeff wn8 xwn8 wn6 xwn6 wn xwn wgr xwgr
If the first argument is not one of latter, the default rating from the script body will be used.
If there are no arguments or the only argument is rating, the script will proceed all the files with *.xc, *.XC, *.xvmconf and *.XVMconf extensions in the current folder.
For all the arguments that are files, the script will replace ratings in all of them independently of extensions.
For all the arguments that are folders, the script will replace ratings in all the files with *.xc, *.XC, *.xvmconf and *.XVMconf extensions from the given folders (but not subfolders).

Examples:

anyscript.js xeff "C:\Games\World_of_Tanks\res_mods\xvm\configs\default" "C:\Games\World_of_Tanks\res_mods\xvm\readme.txt"
Will change rating to xeff in all the files xvm\configs\default\*.xc and in xvm\readme.txt

anyscript.js "C:\Games\World_of_Tanks\res_mods\xvm\configs\default"
Will change rating to the one from the script body in all the files xvm\configs\default\*.xc

anyscript.js wn8
Will change rating to wn8 in all *.xc files in current folder.

*************************
Translated by sech_92.
If you see some mistakes, you may PM me on http://kr.cm