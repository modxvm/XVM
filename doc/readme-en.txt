This mod is a successor of the next mods:
  * OverTargetMarkers
  * Disable Postmortem Panel
  * Vehicle Icons Mirroring Controlling
  * Players Panel Controlling (width and transparency)
  * Clock at battle loading screen
  * In-game players rating (only in xvm-full package)

Project site: http://code.google.com/p/wot-xvm/
Support:      http://forum.bulychev.net/viewforum.php?f=7

Mod config files:
  \res_mods\<game version>\gui\flash\XVM.xvmconf (main config file)
  \res_mods\<game version>\gui\flash\OTMData.xml (in legacy mode)
You can select ready config file from \xvm-doc\samples\ directory
You can create new config or edit existing using online editor:
  http://bulychev.net/generator/

XVM.xvmconf parameters:

battle
  mirroredVehicleIcons:   false - disable vehicle icons mirroring (useful for
                                  alternative icons)
  showPostmortemTips:     false - disable sliding postmortem panel
  battleLoadingShowClock: false - disable clock at battle loading screen
  playersPanelAlpha:      0..100 - players panel transparentness. 0 - transparent,
                                  100 - not transparent
  playersPanelLargeWidth: 0..170 - set players names width in panels in large mode.
                                  Default: 170
  drawGrid:               true  - draw coordinates grid (may be usefil for
                                  aligning marker elements)

rating
  showPlayersStatistics:  true  - enable player statistics. Global switch,
                                  statistics module will be disabled
                                  everywhere without it.
  loadEnemyStatsInFogOfWar: true - enable loading enemy stats in Fog of War (experimental).

  battleLoading
    show:                 false - disable showing statistics at battle loading
                                  screen
    format:               "text" - format of field (statistics macros can be
                                  used - see below)
  playersPanel
    show:                 false - disable showing statistics at players panels
    format:               "text" - format of field
    middleColor:          "{{c:...}}" - color of player names in the middle
                                  mode of players panels (statistics macros can
                                  be used)
  statisticForm
    show:                 false - disable showing statistics at battle
                                  statistics window (when Tab pressed)
    format:               "text" - format of field

colors
  eff: [ ]              array of values for dynamic colors by efficiency
  rating: [ ]           array of values for dynamic colors by GWR
  kb: [ ]               array of values for dynamic colors by kilo-battles
  hp: [ ]               array of values for dynamic colors by health points (only in markers)
  hp_ratio: [ ]         array of values for dynamic colors by health ratio (only in markers)

alpha
  eff: [ ]              array of values for dynamic transparency by efficiency
  rating: [ ]           array of values for dynamic transparency by GWR
  kb: [ ]               array of values for dynamic transparency by kilo-battles
  hp: [ ]               array of values for dynamic transparency by health points (only in markers)
  hp_ratio: [ ]         array of values for dynamic transparency by health ratio (only in markers)

markers
  ally
    alive
      normal
        vehicleIcon:    vehicle icon settings for current state of marker
        healthBar:      health bar settings for current state of marker
        damageText:     floating damage text settings for current state of marker
        contourIcon:    vehicle icon settings for current state of marker
        levelIcon:      level icon settings for current state of marker
        actionMarker:   action marker settings for current state of marker
        textFields: [ ] array of text fields for current state of marker
      extended: ...
    dead
      normal: ...
      extended: ...
  enemy
    alive
      normal: ...
      extended: ...
    dead
      normal: ...
      extended: ...


(Obsolete, new config file XVM.xvmconf usage is recommended)
Enhancements not available from OTM Editor (OTMData.xml):

- If 'color' attribute is absent, mod will use defaulr client color for this
  type of marker (including colors for squad / team killer);

- 'lcolor' attribute of 'fill' element can be used for health bar color
  gradient;

- all colors, except shadow filter and health bar border can be replaced by
  dynamic colors using statistics macros (see below);

- 'rating/showPlayersStatistics' tag allow to enable statistics in the
  'infoText' fields (see below)
  <rating>
    <showPlayersStatistics>true</showPlayersStatistics>
  </rating>

- 'combatScrollText/hitKind' element allow to switch floating damage text
  between hit points and percents
  <combatScrollText>
    <hitKind>Relative</hitKind>

- 'combatScrollText/font' element allow to set font for floating damage text

- 'healthRatio/format/@font', 'playerName/format/@font',
  'vehicleName/format/@font', 'currentHealth/format/@font' attributes allow to
  set font for corresponding lines

- 'components/*/infoText' element set default format for text fields (like
  'components/*/currentHealth')
  'behavior/*/*/*/infoText' set position and content of text fields

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

  Statistics macros ('rating/showPlayersStatistics' must be anabled):
    {{rating}}     - GWR (Global Win Ratio)
    {{eff}}        - player efficiency (http://wot-news.com/index.php/stat/calc/en/)
    {{kb}}         - number of kilo-battles (total battles count divided by 1000).
    {{battles}}    - total battles count
    {{wins}}       - total wins count
    {{rating:3}}   - GWR aligned from left to 3 chars
    {{eff:4}}      - player efficiency aligned from left to 4 chars
    {{kb:3}}       - number of kilo-battles aligned from left to 3 chars

  Dynamic colors macros:
    {{c:hp}}       - color depended from current health points (only in vehicle markers)
    {{c:hp-ratio}} - color depended from current health ratio (only in vehicle markers)
    {{c:eff}}      - color depended from player efficiency
    {{c:rating}}   - color depended from GWR
    {{c:kb}}       - color depended from kilo-battles

  Dynamic transparency macros:
    {{a:hp}}       - transparency depended from current health points (only in vehicle markers)
    {{a:hp-ratio}} - transparency depended from current health ratio (only in vehicle markers)
    {{a:eff}}      - transparency depended from player efficiency
    {{a:rating}}   - transparency depended from GWR
    {{a:kb}}       - transparency depended from kilo-battles

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
  "color": "{{c:eff}}"
In OTMData.xml:
  <infoText x="0" y="-50" color="{{c:eff}}" alpha="75" visible="true" format="{{kb}} {{eff}} {{rating}}" bold="true"/>
  <currentHealth x="-41" y="-38" color="{{c:hp}}" alpha="{{a:hp}}" visible="true"/>


---

And sorry for my english. :)
