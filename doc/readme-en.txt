Content:
  1. Common information
  2. Install
  3. Update
  4. Additional information about config file

-----------------------------------------------------------
1. COMMON INFORMATION
-----------------------------------------------------------

  This mod have many features, like:
    * Vehicle markers (formerly OverTargetMarkers)
    * Disable Postmortem Panel
    * Vehicle Icons Mirroring Controlling
    * Players Panel Controlling (width, transparency, content)
    * Clock at battle loading screen
    * Player/clan icon
    * Vehicle icon sets
    * In-game players rating (only with xvm-stat package)
    * Capture bar additional information

  Project site:  http://code.google.com/p/wot-xvm/

  Support:       http://www.koreanrandom.com/forum/topic/1383-xvm
  FAQ (Russian): http://www.koreanrandom.com/forum/topic/1381-faq
  Ready configs: http://www.koreanrandom.com/forum/topic/1384-configurations
  Сonfig editor: http://www.koreanrandom.com/forum/topic/1422-/#entry11316

-----------------------------------------------------------
2. INSTALL
-----------------------------------------------------------

  1. Unzip archive to game folder:
     Right click to archive -> "Extract all..." -> select game folder -> "Extract"

  2. You do not need to setup anything by default.

     If you want special settings, you need to create config file:
       \res_mods\[GAME VERSION]\gui\flash\XVM.xvmconf

     You can select ready config file from \xvm-doc\samples\ directory, or use
     online editor: http://www.koreanrandom.com/forum/topic/1422-/#entry11316

     Old OTMData.xml configs are also supported in legacy mode, you can use if if
     you do not need new features.

     All possible config options you can see in this file:
       \xvm-doc\samples\Full config EN\XVM.xvmconf

     Note: If you changing config manually, use Notepad, DO NOT use MS Word,
     WordPad and such editors.

-----------------------------------------------------------
3. UPDATE
-----------------------------------------------------------

  1. Unzip archive to game folder:
     Right click to archive -> "Extract all..." -> select game folder -> "Extract"

  2. If game version was updated, copy your config:
     from res_mods/[OLD VERSION]/gui/flash/XVM.xvmconf
     to res_mods/[NEW VERSION]/gui/flash/XVM.xvmconf

  3. Do NOT do anything else.

-----------------------------------------------------------
4. ADDITIONAL INFORMATION ABOUT CONFIG FILE
-----------------------------------------------------------

  Mod config files:
    \res_mods\[GAME VERSION]\gui\flash\XVM.xvmconf
  You can select ready config file from \xvm-doc\samples\ directory
  You can create new config or edit existing using online editor:
    http://www.koreanrandom.com/forum/topic/1422-/#entry11316

  All possible config options you can see in this file:
    \xvm-doc\samples\Full config EN\XVM.xvmconf

  Supported HTML tags:
    http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/text/TextField.html#htmlText

  Macros available:
    In players panel, battle loading screen and statistic form:
      {{nick}}        - player nickname with clan name
      {{name}}        - player nickname without clan name
      {{clan}}        - clan name with brackets (empty if no clan)
      {{vehicle}}     - vehicle name
      {{vtype}}       - vehicle type
      {{c:vtype}}     - color depended from vehicle type
      + statistics macros (see below)

    In tank markers:
      {{nick}}        - player nickname with clan name
      {{name}}        - player nickname without clan name
      {{clan}}        - clan name with brackets (empty if no clan)
      {{squad}}       - value '1' for own squad, empty for others
      {{vehicle}}     - vehicle name
      {{vtype}}       - vehicle type
      {{level}}       - vehicle level (Arabic numerals)
      {{rlevel}}      - vehicle level (Roman numerals)
      {{turret}}      - stock turret marker:
                          "*" symbol - stock turret, cannot mount top gun
                          "'" symbol - stock turret, top gun is possible
                          empty - top turret
      {{hp}}          - current health points
      {{hp-ratio}}    - current health ratio (without '%' sign)
      {{hp-max}}      - maximum health points
      {{dmg}}         - damage health points
      {{dmg-ratio}}   - damage health ratio (without '%' sign)
      {{dmg-kind}}    - damage kind (attack, fire, ramming, ...)
      {{c:hp}}        - color depended from current health points (only in vehicle markers)
      {{c:hp-ratio}}  - color depended from current health ratio (only in vehicle markers)
      {{c:dmg}}       - color depended from damage source
      {{c:dmg-kind}}  - color depended from damage kind
      {{c:vtype}}     - color depended from vehicle type
      {{c:system}}    - system color (disable override color)
      {{a:hp}}        - transparency depended from current health points (only in vehicle markers)
      {{a:hp-ratio}}  - transparency depended from current health ratio (only in vehicle markers)
      + statistics macros (see below)

    In Hits Log:
      {{n}}           - total number of hits
      {{n-player}}    - number of hits for each player
      {{dmg}}         - last hit value
      {{dmg-total}}   - total sum of hits
      {{dmg-avg}}     - average damage during the battle
      {{dmg-player}}  - sum of hits for each player
      {{dead}}        - tank's death marker
      {{nick}}        - player nickname with clan name
      {{name}}        - player nickname without clan name
      {{clan}}        - clan name with brackets (empty if no clan)
      {{vehicle}}     - vehicle name
      {{vtype}}       - vehicle type
      {{level}}       - vehicle level (Arabic numerals)
      {{rlevel}}      - vehicle level (Roman numerals)
      {{dmg-kind}}    - damage kind (attack, fire, ramming, ...)
      {{c:dmg-kind}}  - color depended from damage kind
      {{c:vtype}}     - color depended from vehicle type

    In Capture bar:
      {{points}}      - points already capture
      {{extra}}       - extra text section; is shows only when timeleft and number of capturers was calculated successfully
      {{tanks}}       - number of capturers; cant define if more than 3; can be placed only inside extra section
      {{time}}        - time left to full capture; minutes and seconds;  can be placed only inside extra section
      {{time-sec}}    - time left to full capture; seconds only;         can be placed only inside extra section
      {{speed}}       - capture speed in points per second;              can be placed only inside extra section

    In Minimap:
      {{level}}        - subject level
      {{short-nick}}   - subject shortened nickname
      {{vehicle}}      - subject full vehicle type
      {{ifspg}}        - place special square symbol if subject is artillery

    Statistics macros ('rating/showPlayersStatistics' must be anabled):
      {{eff}}         - player efficiency: http://wot-news.com/index.php/stat/calc/en/
      {{eff:4}}       - player efficiency aligned from left to 4 chars
      {{teff}}, {{e}} - player per-vehicle efficiency: http://www.koreanrandom.com/forum/topic/1643-
      {{twr}}         - TWR (T-Calc): http://www.koreanrandom.com/forum/topic/2389-
      {{wn}}          - WN6 rating: http://www.koreanrandom.com/forum/topic/2575-
      {{rating}}      - GWR (Global Win Ratio)
      {{rating:3}}    - GWR aligned from left to 3 chars
      {{battles}}     - total battles count
      {{wins}}        - total wins count
      {{kb}}          - number of kilo-battles (total battles count divided by 1000).
      {{kb:3}}        - number of kilo-battles aligned from left to 3 chars
      {{t-rating}}    - vehicle win ratio
      {{t-rating:3}}  - vehicle win ratio aligned from left to 3 chars
      {{t-battles}}   - total battles count for current vehicle
      {{t-battles:4}} - number of battles for current vehicle aligned from left to 4 chars
      {{t-wins}}      - total wins count for current vehicle
      {{t-kb}}        - number of kilo-battles for current vehicle
      {{t-kb-0}}      - number of kilo-battles for current vehicle with leading zero
      {{t-kb:4}}      - number of kilo-battles for current vehicle aligned from left to 4 chars
      {{t-hb}}        - number of hecto-battles for current vehicle (hecto = 100)
      {{t-hb:3}}      - number of hecto-battles for current vehicle aligned from left to 3 chars
      {{tdb}}, {{tdb:4}} - average damage for current tank - damage/battles
      {{tdv}} - average damage efficiency for tank - damage/(battles*maxHP)
      {{tfb}} - average frags per battle for current tank
      {{tsb}} - average number of spotted enemies per battle for current tank
      {{c:tdb}}, {{c:tdv}}, {{c:tfb}}, {{c:tsb}} - dynamic colors for this macros
      {{c:eff}}       - color depended from player efficiency
      {{c:e}}         - color depended from player per-vehicle efficiency
      {{c:twr}}       - color depended from TWR (T-Calc)
      {{c:wn}}        - color depended from WN6 rating
      {{c:rating}}    - color depended from GWR
      {{c:kb}}        - color depended from kilo-battles
      {{c:t-rating}}  - color depended from current vehicle win ratio
      {{c:t-battles}} - color depended from current vehicle battles

  "format" field examples:
    1. Show number of kilo-battles, efficiency and GWR without changing a color:
      "{{kb}} {{eff}} {{rating}}"
    2. The same, but with each number colored by its value:
      "<font color='{{c:kb}}'>{{kb}}</font> <font color='{{c:eff}}'>{{eff}}</font> <font color='{{c:rating}}'>{{rating}}</font>"
    3. Same as 2, but with aligned columns:
      "<font face='Consolas' size='11'><font color='{{c:kb}}'>{{kb:3}}</font> <font color='{{c:eff}}'>{{eff:4}}</font> <font color='{{c:rating}}'>{{rating:3}}</font></font>"
    4. Show GWR colored by efficiency:
      "<font color='{{c:eff}}'>{{rating}}</font>"

  Dynamic color and transparency usage examples:
  In XVM.xvmconf:
    "color": "{{c:eff}}" - color depended from efficiency
    "alpha": "{{a:hp}}" - transparency depended from current health

  Clan and players icons.
  Config parameter battle/clanIconsFolder set path to clan icons root folder.
  All icons are loading automatically from game region subfolder (RU/EU/US/...).
  To add your clan or player icon, just copy icon file to:
    clanicons/[REGION]/clan/ (for clan)
    clanicons/[REGION]/nick/ (for single player)
  Also you can create default clan and player icons:
    clanicons/[REGION]/clan/default.png (for default clan)
    clanicons/[REGION]/nick/default.png (for default player)
  Search order is:
    nick/<player>.png -> clan/<clan>.png -> clan/default.png -> nick/default.png
  TOP 100 clans are added to mod archive by default.
  Full archive with all clans can be downloaded separately:
    http://code.google.com/p/wot-xvm/downloads/list
    Files: clanicons-full-ru-XXX.zip (RU), clanicons-full-eu-XXX.zip (EU),
    clanicons-full-us-XXX.zip (US), clanicons-full-sea-XXX.zip (SEA)

  6-th sence image.
  To change sixth sense indicator place alternative PNG image to
  res_mods/icons/SixthSense.png

  Hit Log.
  Negative x, y values allow to bind the text to the right and bottom edges for
  the same behavior with different screen resolutions.
  Will work only with running xvm-stat!!!

  Clock in battle and in battle loading screen.
  Format: Y:year, M:month, D:day, H:hour, N:minute, S:second. "" - remove clock.
  For example:
  "clockFormat": "H:N"          => 01:23
  "clockFormat": "Y-M-D H:N:S"  => 2012-12-31 01:23:45
  Also possible to use HTML in clock in battle.

  Efficiency ranges for {{teff}}, {{e}}.
    TEFF       E
    0..299     1 - very bad player
    300..499   2 - bad player
    500..699   3 - poor
    700..899   4 - below average
    900..1099  5 - average
    1100..1299 6 - above average
    1300..1549 7 - good
    1550..1799 8 - great
    1800..1999 9 - master
    2000+      E - Expert (top-100 players on this vehicle)
  This ranges also can be used for {{eff}} and {{wn}}.
