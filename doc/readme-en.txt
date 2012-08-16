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
    * In-game players rating (only in xvm-full package)

  Project site:  http://code.google.com/p/wot-xvm/
  Support:       http://forum.bulychev.net/viewforum.php?f=7
  FAQ (Russian): http://www.koreanrandom.com/forum/topic/1381-faq-otveti-na-chastie-voprosi-po-xvm/
  Ready configs: http://www.koreanrandom.com/forum/topic/1384-xvm-configurations/
  Сonfig editor: http://www.koreanrandom.com/forum/topic/1422-/#entry11316

-----------------------------------------------------------
2. INSTALL
-----------------------------------------------------------

  1. Game must be installed to disk with NTFS file system.

  2. Microsoft .NET Framework 2.0 is required.
     You can check your installed .NET versions using this utility:
       http://www.tmgdevelopment.co.uk/versioncheck.htm

  3. Install DokanLibrary: http://dokan-dev.net/en/download/#dokan

  4. Unzip archive to game folder:
     Right click to archive -> "Extract all..." -> select game folder -> "Extract"

  5. You do not need to setup anything by default.

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

  6. If you do not want statistics, run game as usual.

     If you want statistics, run wot-xvm-proxy.exe (game will be started
     automatically). Also make a note that statistics is turned off by default,
     so you need to enable it in config file.

     If you want statistics and game launcher, start with /launcher argument:
       Create shortcut wot-xvm-proxy.exe
       Open Properties
       Write 'wot-xvm-proxy.exe /launcher' (without quotas) in Object field
       Press OK

  7. If you use Skype, in Tools -> Options -> Advanced -> Connection ->
     REMOVE CHECK "Use port 80 and 443 as alternatives for incoming connections".

  8. If you want to send bug report, run wot-xvm-proxy.exe with /debug argument
     and add console output to report.

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

  Macros available:
    In players panel, battle loading screen and statistic form:
      {{nick}}        - player name
      {{vehicle}}     - vehicle name

    In tank markers:
      {{hp}}          - current health points
      {{hp-ratio}}    - current health ratio (without '%' sign)
      {{hp-max}}      - maximum health points
      {{nick}}        - player name
      {{vehicle}}     - vehicle name
      {{level}}       - vehicle level (Arabic numerals)
      {{rlevel}}      - vehicle level (Roman numerals)
      {{dmg}}         - damage health points
      {{dmg-ratio}}   - damage health ratio (without '%' sign)

    Statistics macros ('rating/showPlayersStatistics' must be anabled):
      {{rating}}      - GWR (Global Win Ratio)
      {{eff}}         - player efficiency (http://wot-news.com/index.php/stat/calc/en/)
      {{kb}}          - number of kilo-battles (total battles count divided by 1000).
      {{battles}}     - total battles count
      {{wins}}        - total wins count
      {{rating:3}}    - GWR aligned from left to 3 chars
      {{eff:4}}       - player efficiency aligned from left to 4 chars
      {{kb:3}}        - number of kilo-battles aligned from left to 3 chars
      {{t-rating}}    - vehicle win ratio
      {{t-kb}}        - number of kilo-battles for current vehicle
      {{t-battles}}   - total battles count for current vehicle
      {{t-wins}}      - total wins count for current vehicle
      {{t-rating:3}}  - vehicle win ratio aligned from left to 3 chars
      {{t-kb:4}}      - number of kilo-battles for current vehicle aligned from left to 4 chars
      {{t-battles:4}} - number of battles for current vehicle aligned from left to 4 chars
      {{t-kb-0}}      - number of kilo-battles for current vehicle with leading zero
      {{t-hb}}        - number of hecto-battles for current vehicle (hecto = 100)
      {{t-hb:3}}      - number of hecto-battles for current vehicle aligned from left to 3 chars

    Dynamic colors macros:
      {{c:hp}}        - color depended from current health points (only in vehicle markers)
      {{c:hp-ratio}}  - color depended from current health ratio (only in vehicle markers)
      {{c:vtype}}     - color depended from vehicle type (only in vehicle markers)
      {{c:eff}}       - color depended from player efficiency
      {{c:rating}}    - color depended from GWR
      {{c:kb}}        - color depended from kilo-battles
      {{c:t-rating}}  - color depended from current vehicle win ratio
      {{c:t-battles}} - color depended from current vehicle battles

    Dynamic transparency macros:
      {{a:hp}}        - transparency depended from current health points (only in vehicle markers)
      {{a:hp-ratio}}  - transparency depended from current health ratio (only in vehicle markers)

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
    http://code.google.com/p/wot-xvm/downloads/detail?name=clanicons-full-ru.zip (RU)
    http://code.google.com/p/wot-xvm/downloads/detail?name=clanicons-full-eu.zip (EU)
    http://code.google.com/p/wot-xvm/downloads/detail?name=clanicons-full-us.zip (US)
