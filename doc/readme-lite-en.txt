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

  Project site:  http://code.google.com/p/wot-xvm/
  Support:       http://forum.bulychev.net/viewforum.php?f=7
  FAQ (Russian): http://www.koreanrandom.com/forum/topic/1381-faq-otveti-na-chastie-voprosi-po-xvm/
  Сonfig editor: https://sites.google.com/site/sirmaxwiki/xvm-editor

-----------------------------------------------------------
2. INSTALL
-----------------------------------------------------------

  1. Unzip archive to game folder:
     Right click to archive -> "Extract all..." -> select game folder -> "Extract"

  2. You do not need to setup anything by default.

     If you want special settings, you need to create config file:
       \res_mods\<game version>\gui\flash\XVM.xvmconf

     You can select ready config file from \xvm-doc\samples\ directory, or use
     online editor: https://sites.google.com/site/sirmaxwiki/xvm-editor

     Old OTMData.xml configs are also supported in legacy mode, you can use if if
     you do not need new features.

     All possible config options you can see in this file:
       \xvm-doc\samples\Lite config EN\XVM.xvmconf

     Note: If you changing config manually, use Notepad, DO NOT use MS Word,
     WordPad and such editors.

-----------------------------------------------------------
3. UPDATE
-----------------------------------------------------------

  1. Unzip archive to game folder:
     Right click to archive -> "Exctract all..." -> select game folder -> "Extract"

  2. If game version was updated, copy your config:
     from res_mods/[OLD VERSION]/gui/flash/XVM.xvmconf
     to res_mods/[NEW VERSION]/gui/flash/XVM.xvmconf

  3. Do NOT do anything else.

-----------------------------------------------------------
4. ADDITIONAL INFORMATION ABOUT CONFIG FILE
-----------------------------------------------------------

  Mod config files:
    \res_mods\<game version>\gui\flash\XVM.xvmconf (main config file)
    \res_mods\<game version>\gui\flash\OTMData.xml (in legacy mode)
  You can select ready config file from \xvm-doc\samples\ directory
  You can create new config or edit existing using online editor:
    https://sites.google.com/site/sirmaxwiki/xvm-editor

  All possible config options you can see in this file:
    \xvm-doc\samples\Lite config EN\XVM.xvmconf

  Macros available:
    In players panel:
      {{nick}}       - player name
      {{vehicle}}    - vehicle name

    In tank markers:
      {{hp}}         - current health points
      {{hp-ratio}}   - current health ratio (without '%' sign)
      {{hp-max}}     - maximum health points
      {{nick}}       - player name
      {{vehicle}}    - vehicle name
      {{level}}      - vehicle level
      {{dmg}}        - damage health points
      {{dmg-ratio}}  - damage health ratio (without '%' sign)

    Dynamic colors macros:
      {{c:hp}}       - color depended from current health points (only in vehicle markers)
      {{c:hp-ratio}} - color depended from current health ratio (only in vehicle markers)

    Dynamic transparency macros:
      {{a:hp}}       - transparency depended from current health points (only in vehicle markers)
      {{a:hp-ratio}} - transparency depended from current health ratio (only in vehicle markers)

  Dynamic color and transparency usage examples:
  In XVM.xvmconf:
    "color": "{{c:hp-ratio}}" - color depended from current health ratio
    "alpha": "{{a:hp}}" - transparency depended from current health
