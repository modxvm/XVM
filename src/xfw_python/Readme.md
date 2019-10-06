### XFW Framework ###
##### Actionscript module #####

## Content ##

 |file or folder                | description               |
 |------------------------------|---------------------------|
 |scaleform                     | XFW entry point           |
 |mods/xfw/python/xfw_loader.py | XFW loader                |
 |mods/xfw/python/xfw_empty.py  | XFW workaround empty file |
 |mods/xfw/python/xfw.py        | XFW library               |
 |mods/xfw/python/lib           | 3rd party libraries       |
 |build.sh                      | build script              |

## How to build ##
You should run
```
./build.sh
```
And grab your .py files in *[xfw_root]/~output/python/* directory

## How to create your own mod ##
 * Create folder **mods/[mod name]**
 * Create file **mods/[mod name]/__init__.py**

```
### XFW Framework header
XFW_MOD_INFO = {
    # mandatory
    'VERSION':       '0.0.1',                     # mod version
    'URL':           'http://example.com',        # mod website
    'UPDATE_URL':    'http://example.com/update', # url with mod updates
    'GAME_VERSIONS': ['0.9.7','0.9.8'],           # tested WoT versions
    # optional
}
###

###Put your sources here###
```

## Included libraries ##
 * **simplejson** *3.4.0*. http://simplejson.readthedocs.org/en/latest/
 * **tlslite** *0.4.6*. https://github.com/trevp/tlslite
 * **pika** *0.10.0* https://github.com/pika/pika
 * **six** *1.8.0* http://pythonhosted.org/six/
 * **ssl**. Wrapper for SSL lib using tlslite. Developed by XVM team.
 * **xfw**. XFW Framework library. Contains different function for work with World of Tanks.

## Build tweaks ##
You can specify these environment variables

 |variable               | description                                                      |
 |-----------------------|------------------------------------------------------------------|
 |$XFW_BUILD_LIBS        | if set to **1** libs will be build even with $XFW_DEVELOPMENT    |
 |$XFW_BUILD_CLEAR       | clear output path before build                                   |
 |$XFW_DEVELOPMENT       | if set to **1** libs will not build. See $BUILD_LIBS description |
