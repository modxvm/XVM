### XFW Framework ###
##### Actionscript module #####

## Content ##

####scripts####

 |file             | action                |
 |-----------------|-----------------------|
 |build.sh         | build *.as3proj files |
 |.build-swc-wg.sh | build wg.swc file     |
 |.build-swc-xfw.sh| build xvm.swc file    |

####other files and folders####

 |file or folder | action                             |
 |---------------|------------------------------------|
 |src            | XVM Framework sources              |
 |wg             | lobby.swf decompiled sources       |
 |wg.as3proj     | project for wg.swc                 |
 |xvm.as3proj    | project for xvm.swc and xvm.swf    |

## How to build ##
You should run
```
./build.sh
```
And grab

 * *.swc* files - in *[repo_root]/~output/swc* directory
 * *.swf* files - in *[repo_root]/~output/swf* directory

Do not run **.build-swc-** files, use **build.sh** instead.

## Tweaks ##

These variables are used in shells scripts

 |variable               | action                                                           |
 |-----------------------|------------------------------------------------------------------|
 |$xfw_OS                | current OS. Available values: Linux, Windows                     |
 |$xfw_arch              | OS architecture. Available values: i386, amd64                   |
 |$xfw_mono              | .NET interpreter. Default: empty for Windows, **mono** for Linux |

You can specify these environment variables

 |variable               | action                                                                                |
 |-----------------------|---------------------------------------------------------------------------------------|
 |$ASSDK_HOME            | Path to Apache Flex SDK                                                               |
 |$PLAYERGLOBAL_HOME     | Path to playerglobal swfs root dirctory. Default is $FLEX_HOME/frameworks/libs/player |
