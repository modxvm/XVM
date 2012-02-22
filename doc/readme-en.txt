XVM.xvmconf parameters:

battle
  mirroredVehicleIcons:  false - disable vehicle icons mirroring (useful for
                                 alternative icons)
  showPostmortemTips:    false - disable sliding postmortem panel
  drawGrid:              true  - draw coordinates grid (may be usefil for
                                 aligning marker elements)

rating
  showPlayersStatistics: true  - enable player statistics. Global switch,
                                 statistics module will be disabled
                                 everywhere without it.
  battleLoading
    show:                false - disable showing statistics at battle loading
                                 screen
    format:              "text" - format of field (statistics macros can be
                                 used - see below)
  playersPanel
    show:                false - disable showing statistics at players panels
    format:              "text" - format of field
    middleColor:         "{{c:...}}" - color of player names in the middle
                                 mode of players panels (statistics macros can
                                 be used)
  statisticForm
    show:                false - disable showing statistics at battle
                                 statistics window (when Tab pressed)
    format:              "text" - format of field

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
    {{hp}}         - current health points
    {{hp-ratio}}   - current health ratio (without '%' sign)
    {{hp-max}}     - maximum health points
    {{nick}}       - player name
    {{vehicle}}    - vehicle name
  Statistics macros ('rating/showPlayersStatistics' must be anabled):
    {{rating}}     - GWR (Global Win Ratio)
    {{eff}}        - player efficiency (http://wot-news.com/index.php/stat/calc/en/)
    {{kb}}         - number of kilo-battles (total battles count divided by 1000).
    {{battles}}    - total battles count
    {{wins}}       - total wins count
    {{rating:3}}   - GWR aligned from left to 3 chars
    {{eff:4}}      - player efficiency aligned from left to 4 chars
    {{kb:3}}       - number of kilo-battles aligned from left to 3 chars

"format" field examples:

1. Show number of kilo-battles, efficiency and GWR without changing a color:
  "{{kb}} {{eff}} {{rating}}"
2. The same, but with each number colored by its value:
  "<font color='{{c:kb}}'>{{kb}}</font> <font color='{{c:eff}}'>{{eff}}</font> <font color='{{c:rating}}'>{{rating}}</font>"
3. Same as 2, but with aligned columns:
   "<font face='Consolas' size='10' color='{{c:kb}}'>{{kb:3}}</font> <font face='Consolas' size='10' color='{{c:eff}}'>{{eff:4}}</font> <font face='Consolas' size='10' color='{{c:rating}}'>{{rating:3}}</font>"
4. Show GWR colored by efficiency:
  "<font color='{{c:eff}}'>{{rating}}</font>"

Dynamic color usage examples:
In XVM.xvmconf:
  "middleColor": "{{c:eff}}"
In OTMData.xml:
   <infoText x="0" y="-50" color="{{c:eff}}" alpha="75" visible="true" format="{{kb}} {{eff}} {{rating}}" bold="true"/>



---

And sorry for my english. :)
