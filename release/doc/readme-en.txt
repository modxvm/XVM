Content:
  1. Common information
  2. Installation
  3. Update
  4. Additional information about config file
  5. Making a personal configuration

-----------------------------------------------------------
1. COMMON INFORMATION
-----------------------------------------------------------

  This mod has many features like:
    * Customizable vehicle markers
    * Disabling of postmortem panel
    * Vehicle icons mirroring
    * Players panel options (width, transparency, content)
    * Clock at battle loading screen
    * Clan and player icons
    * Different vehicle icon sets in player panels, battle loading screen
    * Player statistics
    * Additional information in capture bar
    * Customizable minimap
    * Extended statistics in the user info windows
    * Tank info in platoon window
    * Enemy spotted status
    * Best crew auto selection
    * Ping display on login screen and before a battle

  Project site: https://modxvm.com/

  Support:      https://koreanrandom.com/forum/topic/1383-xvm
  FAQ:          https://modxvm.com/en/faq/
  User configs: https://koreanrandom.com/forum/forum/50-/

-----------------------------------------------------------
2. INSTALLATION
-----------------------------------------------------------

  1. Unzip archive to game folder:
     Right-click archive -> "Extract all..." -> select game folder -> "Extract"

  2. By default, you do not need to setup anything else.

    If you want to use non-default config, you need to rename boot config file:
      \res_mods\configs\xvm\xvm.xc.sample to xvm.xc
    See further instructions inside the file.

    See default config for all possible options:
      \res_mods\configs\xvm\default

    Note: If you want to change config files manually, use plain text editor (like Notepad).
    DO NOT use MS Word, Wordpad or similar editors.

  3. If XVM incorrectly detects the language of the game client,
    then in the configuration file (by default \res_mods\configs\xvm\default\@xvm.xc)
    change the value of the variable "language" from "auto" to the language code.
    The language code must match the name of the file in the res_mods\mods\shared_resources\xvm\l10n\ (for example, "en").

  4. It is also possible to install nightly builds of XVM.
    You can download nightly builds on https://nightly.modxvm.com/

-----------------------------------------------------------
3. UPDATE
-----------------------------------------------------------

  1. Unzip archive to game folder:
     Right-click archive -> "Extract all..." -> select game folder -> "Extract"

  2. DO NOT do anything else.

-----------------------------------------------------------
4. ADDITIONAL INFORMATION ABOUT CONFIG FILE
-----------------------------------------------------------

  Config files are located:
    \res_mods\configs\xvm
  You can select user made config files from \res_mods\configs\xvm\user configs\ directory

  You can learn about all possible config options in this file:
    \res_mods\configs\xvm\default


  Supported HTML tags:
    https://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/TextField.html#htmlText

  List of all available macros is presented in macros.txt and macros-hangar.txt.

      Extended macros formatting rules:
        {{name[:norm][%[flag][width][.prec]type][~suf][(=|!=|<|<=|>|>=)match][?rep][|def]}}
        name  - macro name

        :norm - value normalization, for example {{hp-ratio:300}} returns values in range 0..300

        flag  - "-" for left align, else right align
                "0" for filling with leading zeros
                "'" for thousands separator (only for integer numbers)
        width - minimum width
        prec  - depending on the type:
                - maximum string width
                - number of digits after the decimal point for float numbers
                - offset of ASCII table for numbers as ASCII char (default is 129)
        type  - type
                s - string
                d, i - integer number
                f, F - float number
                x, X - hex number
                a - number as ascii char

        suf   - suffix added at the end
        match - value matching, only matched value is returned, else default value
                allowed operators: =, !=, >, >=, <, <=
        rep   - value replacement, returned instead of the regular value if the value is present
        def   - default value, set when value is absent:

      For example:
      {{name%-10.10s}}      - cuts names longer than 10 chars and fills names shorter than 10 chars, left aligned
      {{kb%4.01f~k|----}}   - width 4 chars, exactly 1 char after the decimal point, right aligned
                              if kb==null, display "----"

      Details: https://en.wikipedia.org/wiki/Printf_format_string

    Using localization macros - {{l10n:localizationKey}}
      Macros are links to translations in \res_mods\mods\shared_resources\xvm\l10n\XX.xc file (XX is a language code).
      If the translation is not found, "localizationKey" is displayed.

      Capture bar example
        \l10n\en.xc
          "enemyBaseCaptured": "Base captured by allies!"
        captureBar.xc
          "captureDoneFormat": "<font size='17' color='#FFCC66'>{{l10n:enemyBaseCaptured}}</font>"

        Will be formatted as "<font size='17' color='#FFCC66'>Base captured by allies!</font>"

      More about localization at wiki: https://koreanrandom.com/forum/topic/27394-xvm-localization/

  "format" field examples:
    1. Show number of kilo-battles, efficiency and GWR without changing a color:
      "{{kb}} {{xwn8}} {{winrate}}"
    2. The same but with each number colored by its value:
      "<font color='{{c:kb}}'>{{kb}}</font> <font color='{{c:xwn8}}'>{{xwn8}}</font> <font color='{{c:winrate}}'>{{winrate}}%</font>"
    3. Same as 2, but with aligned columns:
      "<font face='Consolas' size='11'><font color='{{c:kb}}'>{{kb%2d}}k</font> <font color='{{c:xwn8}}'>{{xwn8}}</font> <font color='{{c:winrate}}'>{{rating%2d}}%</font></font>"
    4. Show GWR colored by xwn:
      "<font color='{{c:xwn8}}'>{{winrate}}</font>"

  Dynamic color and transparency usage examples:
    "color": "{{c:xwn8}}" - color depending on XVM Scale for WN8
    "alpha": "{{a:hp}}" - transparency depending on current health

  Clan and players icons.
    For the clan rating is used:
      Elo rating on the Global Map:        https://eu.wargaming.net/clans/wot/leaderboards/#ratingssearch&order=-egm (wGM column).
      Elo rating in Stronghold:            https://eu.wargaming.net/clans/wot/leaderboards/#ratingssearch&order=-wsh (wSH column).
      Formula used for the rating:         https://eu.wargaming.net/clans/wot/leaderboards/#ratingssearch&offset=0&limit=25&order=-esh&guide-slug=ratings&guide-anchor=1
      Principles of the Elo rating system: https://en.wikipedia.org/wiki/Elo_rating_system
    XVM server monitors the list of top clans and downloads it at client launch. If a player in top clan is encounter in a battle, that clan's icon is downloaded from the XVM server.
    The list is updated 8 times a day.
    There is an option to use custom clan/player icons.
    Config parameter "battle"/"clanIconsFolder" sets path to clan icons root folder.
    The icons are loaded automatically from a subfolder corresponding to game's region
    (RU, EU, NA, etc.) or player's account ID.
  To add your clan or player icon, just copy an icon file to:
    \res_mods\mods\shared_resources\xvm\res\clanicons\[REGION]\clan\ (for clans)
    \res_mods\mods\shared_resources\xvm\res\clanicons\[REGION]\nick\ (for players)
    \res_mods\mods\shared_resources\xvm\res\clanicons\[REGION]\ID\ (for player by account ID)
  You can also create default clan and player icons:
    \res_mods\mods\shared_resources\xvm\res\clanicons\[REGION]\clan\default.png (for default clan)
    \res_mods\mods\shared_resources\xvm\res\clanicons\[REGION]\nick\default.png (for default player)
  The following order is used for searching the icons:
    ID\<accountId>.png -> nick\<playerName>.png -> clan\<clan>.png -> clan\default.png -> nick\default.png

  6-th sense image.
    To change sixth sense indicator place an alternative PNG image named SixthSense.png to
    \res_mods\mods\shared_resources\xvm\res\.

  Hit Log.
    Negative x, y values allow to bind the text to the right and bottom edges of the screen so that
    the config works with different screen resolutions.

  Clock in battle and on battle loading screen.
    Format: PHP Date: http://php.net/date
    For example:
      "clockFormat": "H:i"          => 01:23
      "clockFormat": "Y.m.d H:i:s"  => 2013.05.20 01:23:45

-----------------------------------------------------------
5. MAKING A PERSONAL CONFIGURATION
-----------------------------------------------------------

  Personal configuration allows you to save individual settings and not lose them when you upgrade the mod or install custom configs

    1. in the res_mods\configs\xvm create a new folder and name it appropriately
    2. copy the contents of "default" folder in it
    3. rename the file xvm.xc.sample to the xvm.xc
    4. replace in the xvm.xc
      ${"default/@xvm.xc":"."}
    with
      ${"your_folder_name/@xvm.xc":"."}
    5. Personal configuration is created, you can start editing

    Attention! File encoding must remain encoded in UTF8+BOM.
    For editing use Notepad++. https://kr.cm/f/t/1382/c/25815/
    In the case of Windows Notepad: Save as -> Encoding: utf.
