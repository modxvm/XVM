# Check these files before and after release, and keep them up to date.

## On Every Release

* In building shell script config file:
    * `/build/xvm-build.conf`
        * XVM version
        * WoT version
* ChangeLogs:
    * `/release/doc/ChangeLog-*.md`
* Info about the released version. It's used to notify users about available updates:
    * `/build/ReleaseInfo.json`

## Depending on the changes

* `configVersion` in the default XVM config file (if config has changed):
    * `/release/configs/default/@xvm.xc`