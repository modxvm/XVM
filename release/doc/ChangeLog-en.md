### XVM 10.4.0

  * Compatibility with World of Tanks 1.20.0.0
  * Compatibility with Mir Tankov 1.20.0.0
  * Markers: added ability to move/hide hover marker

### XVM 10.3.0

  * Compatibility with World of Tanks 1.19.1.0

### XVM 10.2.1

  * Compatibility with World of Tanks 1.19.0.2
  * Various fixes and improvements

  #### damageLog

  * Added "armor_not_hit" parameter to "hit-effects" and "c:hit-effects" sections

### XVM 10.2.0

  * Compatibility with World of Tanks 1.19.0.1
  * Various fixes and improvements

### XVM 10.1.2

  * Compatibility with World of Tanks 1.18.1.2
  * Various fixes and improvements

### XVM 10.1.1

  * Compatibility with World of Tanks 1.18.1.1
  * Various fixes and improvements

### XVM 10.1.0

  * Compatibility with World of Tanks 1.18.1.0

  #### Battle

  * `{{x-sense-on}}` macro removed from config

### XVM 10.0.0

  * Compatibility with World of Tanks 1.18.0.1

  #### Battle

  * Added support for special combat modes in Strongholds

  #### Minimap

  * Added option:

    * `"deadAnimationAlpha"` — transparency of animation when destroying vehicles

  * Moved layers on the minimap

  #### Carousel

  * Added options in the `"carousel"/"normal"/"fields"` and `"carousel"/"small"/"fields"` sections:

    * `"coreBorder"` — Core Vehicles mark for the Battle Pass

  * Added macro `{{v.core}}`

### XVM 9.3.4

  * Compatibility with World of Tanks 1.17.1.3

  #### Battle

  * Added normalization support for `{{cap.points}}`.

  * Added a setting for the capture bar to the "captureBar" when blocking the capture of the base.

### XVM 9.3.3

  * py_macro/total_hp: fix normalization in macros `{{py:xvm.total_hp.enemy}}` and `{{py:xvm.total_hp.ally}}`

### XVM 9.3.2

  * hangar/tankcarousel: fix carousels with >2 rows

### XVM 9.3.1

  * Compatibility with World of Tanks 1.17.1.2

### XVM 9.3.0

  * Compatibility with World of Tanks 1.17.1.0
  * Added macros to **totalEfficiency**:

    * `{{py:xvm.dmgKindKey}}`

### XVM 9.2.1

  * Compatibility with World of Tanks 1.17.0.1

### XVM 9.2.0

  * Compatibility with World of Tanks 1.17.0.0

### XVM 9.1.0

  * Compatibility with World of Tanks 1.16.1.0

  #### Battle

  * Added macro `{{dmg-color-key}}`

  #### damageLog, hitLog

  * Added "high_explosive_stun" parameter to "type-shell" and "c:type-shell" sections.

### XVM 9.0.0

  * Compatibility with World of Tanks 1.16.0.0

### XVM 8.9.8

  * Compatibility with World of Tanks 1.15.0.3
  * Fixed `{{v.levelPostProgress}}` macro
  * Updated short vehicle names

### XVM 8.9.7

  * Compatibility with World of Tanks 1.15.0.2
  * Various fixes and improvements

  #### Python macros

  * Added macros to **totalEfficiency**:

    * `{{py:xvm.avgDmg}}`

### XVM 8.9.6

  * Compatibility with World of Tanks 1.15.0.1

### XVM 8.9.5

  * Compatibility with World of Tanks 1.15.0.0

### XVM 8.9.4

  * Compatibility with World of Tanks 1.14.1.4
  * Bug fixes

  #### damageLog

  * Added "minefield" parameter to "dmg-kind" and "c:dmg-kind" sections.

  #### hitLog

  * Added "minefield" parameter to "dmg-kind", "c:dmg-kind" and "dmg-kind-player" sections.

### XVM 8.9.3

  * Compatibility with World of Tanks 1.14.1.3

  #### Hangar

  * added `{{v.levelPostProgress}}` macro

### XVM 8.9.2

  * Compatibility with World of Tanks 1.14.1.2

### XVM 8.9.1

  * Compatibility with World of Tanks 1.14.1.1

### XVM 8.9.0

  #### General

  * Compatibility with World of Tanks 1.14.1.0

  #### Carousel

  * fix `crystalsBorder` option in carousel

  #### totalEfficiency

  * fix macros `{{py:xvm.toMainGun}}` and `{{py:xvm.toAvgDmg}}`

  #### hitLog

  * fix macro `{{alive}}`

  #### XFW.Native 2.4.4

  * revert SSL stack
  * remove additional modules

______________________________

### XVM 8.8.4

  #### General

  * Compatibility with World of Tanks 1.14.0.5 nanopatch 1

  #### XFW.Native 2.4.0
  * fixed compatibility with Windows 11
  * new SSL-stack (OpenSSL 1.1, TLS 1.2) for 32-bit WoT

______________________________

### XVM 8.8.3

  #### General

  * Compatibility with World of Tanks 1.14.0.5

  #### Python macros

  * Added macros to **totalEfficiency**:

    * `{{py:xvm.toAvgDmg(norm)}}`
    * `{{py:xvm.toMainGun(norm)}}`

______________________________

### XVM 8.8.2

  #### General

  * Compatibility with World of Tanks 1.14.0.0

______________________________

### XVM 8.8.1

  #### General

  * Compatibility with World of Tanks 1.13.0.1

______________________________

### XVM 8.8.0

  #### General

  * Compatibility with World of Tanks 1.13.0.0
  * Removed section:

    * `"export*"` in **@xvm.xc** file (deleted **export.xc** file)

  #### Players panel

  * Added option:

    * `"playersPanel"/"removeHealthPoints"` — remove the number of hit points (HP) vehicle

  #### Minimap

  * Added option:

    * `"minimapAlt"/"healthPointsEnabled"` — use standard the number of hit points (HP) vehicle

______________________________

### XVM 8.7.9

  #### General

  * Compatibility with World of Tanks 1.12.1.2

  #### Python macros

  * Added macros to **damageLog**:

    * `{{n-crits}}` - number of crits received per hit, 0 - if not received
    * `{{hp}}` - current health points

______________________________

### XVM 8.7.8

  #### General

  * Compatibility with World of Tanks 1.12.1.1

  #### Carousel

  * Added option in the `"carousel"/"normal"/"fields"` and `"carousel"/"small"/"fields"` sections:

    * `"progressionPoints"` — battle Pass progression points

  * Added the `"slotSelectedBorderAlpha "` option to the `"carousel"` section

  #### Camera

  * Removed section "camera"/"noCameraLimit"

______________________________

### XVM 8.7.7

  #### General

  * Compatibility with World of Tanks 1.12.0.0

  #### Players panel

  * Added option in the sections "playersPanel"/"short", "medium", "medium2", "large":

    * `"removeSpottedIndicator"` — disable enemy spotted status icons
    * `"spottedIndicatorAlpha"` — transparency of the enemy spotted status icons
    * `"spottedIndicatorOffsetX"` — offset of X value for enemy spotted status icons
    * `"spottedIndicatorOffsetY"` — offset of Y value for enemy spotted status icons

______________________________

### XVM 8.7.6

  #### General

  * Compatibility with World of Tanks 1.11.1.3

______________________________

### XVM 8.7.5

  #### General

  * Compatibility with World of Tanks 1.11.1.2

______________________________

### XVM 8.7.4 (was not released)

  #### Hangar

  * New parameters `"storage", "barracks", "StrongholdView"` have been added in the `"hangar"/"notificationCounter"` section

______________________________

### XVM 8.7.3

  #### General

  * Compatibility with World of Tanks 1.11.1.1

______________________________

### XVM 8.7.2

  #### General

  * Compatibility with World of Tanks 1.11.1.0

  #### Battle

  * Removed sections:

    * `"repairTime*"` in **battleLabels.xc**, **battleLabelsTemplates.xc** file

  #### Hangar

  * Removed section:

    * `"squad*"` in **@xvm.xc** file (deleted **squad.xc** file)

  * Removed option:

    * `"login"/"saveLastServer"`

______________________________

### XVM 8.7.1

  #### General

  * Compatibility with World of Tanks 1.11.0.0 2020.12.23
  * Fixed keyboard shortcuts in hitLog and damageLog

______________________________

### XVM 8.7.0

  #### General

  * Compatibility with World of Tanks 1.11.0.0

  #### Battle

  * New parameters have been added in the `"colors"/"system"`, `"colors"/"damage"` and `"colors"/"dmg_kind"` sections

  #### Python macros

  * Added `"{{py:calc(expression [, ...])}}"` macro

______________________________

### XVM 8.6.8

  #### General

  * Compatibility with World of Tanks 1.10.1.4

______________________________

### XVM 8.6.7

  #### General

  * Compatibility with World of Tanks 1.10.1.3

  #### Battle

  * Added option:

    * `"battle"/"showBattleHint"` — display battle hints

  * Removed section:

    * `"battle"/"battleHint"`

______________________________

### XVM 8.6.6

  #### General

  * Compatibility with World of Tanks 1.10.1.1

  #### Hangar

  * Removed section:

    * `"hangar"/"equipmentPanel"`

______________________________

### XVM 8.6.5

  #### General

  * Compatibility with World of Tanks 1.10.1.0

  #### Battle

  * Added option:

    * `"battle"/"showPostmortemDogTag"` — display pop-up panel with a dog tag

  #### Hangar

  * Added option:

    * `"hangar"/"showEventBanner"` — banner of various events in the hangar

  * Removed option:

    * `"hangar"/"showLastWtBanner"`

  #### Python macros

  * Added `{{py:xvm.XFromRight(x)}}` and `{{py:xvm.YFromBottom(y)}}` macros

  * In **damageLog** added:

    * section **"lastHitBackground"** to the file **damageLog.xc**
    * macro `{{py:xvm.damageLog.lastHit.bg}}` - returns the value **"formatLastHit"** from the **"lastHitBackground"** section of the **damageLog.xc** file

  * Added macro to **hitLog**:

    * `{{shell-dmg}}` - shell damage

______________________________

### XVM 8.6.4

  #### General

  * Compatibility with World of Tanks 1.10.0.4

  #### Hangar

  * Added option:

    * `"hangar"/"showLastWtBanner"` — show banner "Last Waffenträger" in the hangar

  * Removed option:

    * `"hangar"/"showTenYearsBanner"`

______________________________

### XVM 8.6.3

  #### General

  * Fix incorrect tankcarousel behaviour

______________________________

### XVM 8.6.2

  #### General

  * Compatibility with World of Tanks 1.10.0.2

  #### Python macros

  * Added macro to **damageLog**:

    * `{{shell-dmg}}` - shell damage

______________________________

### XVM 8.6.1

  #### General

  * Compatibility with World of Tanks 1.10.0.1

  #### Battle

  * Added macros:

    * `{{bp-stage}}` — current stage of battle pass (stage of elite progression)

  #### Hangar

  * Restored functionality of the option:

    * `"hangar"/"masteryMarkInTechTree"`

______________________________

### XVM 8.6.0

  #### General

  * Compatibility with World of Tanks 1.10.0.0

  #### Battle

  * Added options:

    * `"battle"/"battleHint"/"hideBattleCommunication"` — hide the hint about new battle communication
    * `"battle"/"battleHint"/"hideRadarHint"` — hide the tips about radar activation ("Steel Hunter" mode)

  #### Hangar

  * Added options:

    * `"hangar"/"showProgressiveDecalsWindow"` — show info windows when receiving progressive decals
    * `"tooltips"/"hideCrystalBlock"` — hide block "Weekly earning limit"

  * Removed option:

    * `"hangar"/"enableEquipAutoReturn"`

  * Added macros:

    * `{{v.crystalEarned}}` — number of bonds earned (from weekly limit)

  #### Carousel

  * Added options in the `"carousel"/"normal"/"fields"` and `"carousel"/"small"/"fields"` sections:

    * `"crystalsBorder"` — vehicle mark with the ability to earn bonds
    * `"crystalsIcon"` — image in in the stats field "stats" for vehicle with the ability to earn bonds

______________________________

### XVM 8.5.7

  #### General

  * Fixed replay playback

______________________________

### XVM 8.5.6

  #### General

  * Fix incorrect tankcarousel behaviour

______________________________

### XVM 8.5.5

  #### General

  * Compatibility with World of Tanks 1.9.1.2

______________________________

### XVM 8.5.4

  #### General

  * Compatibility with World of Tanks 1.9.1.1
  * XFW.Native update to 2.0.5
  * Added automatic crash reporting (only for CIS region)

  #### Hangar

  * Added option:

      `"hangar"/"showCustomizationCounter"` — show notifications counters in the window and on the button "Exterior"

  * Removed option:

      `"hangar"/"showSE20Banner"`

______________________________

### XVM 8.5.3

  #### General

  * XFW.Native updated to 2.0.1

______________________________

### XVM 8.5.2

  #### General

  * Compatibility with World of Tanks 1.9.0.3

  #### Hangar

  * Added option:

      `"hangar"/"showSE20Banner"` — show banner "Road to Berlin" in the hangar

  * Renamed option:

      `"hangar"/"showTenYearsWidget"` &rarr; `"hangar"/"showTenYearsBanner"`

______________________________

### XVM 8.5.1

  #### General

  * Compatibility with World of Tanks 1.9.0.2

______________________________

### XVM 8.5.0

  #### General

  * Compatibility with World of Tanks 1.9.0.1

  #### Hangar

  * Added option:

      `"hangar"/"showTenYearsWidget"` — show widget "World of Tanks' 10th Anniversary" in the hangar

______________________________

### XVM 8.4.0
```
  [GENERAL]
  * World of Tanks 1.8.0.2
```
______________________________

### XVM 8.3.5
```
  [GENERAL]
  * Temporarily disable crashreporting tool
```
______________________________

### XVM 8.3.4
```
  [GENERAL]
  * Fix compatibility with Windows 7
```
______________________________

### XVM 8.3.3
```
  [GENERAL]
  * World of Tanks 1.8.0.1
```
______________________________

### XVM 8.3.2
```
  [GENERAL]
  * World of Tanks 1.8.0.0

  [HANGAR]
  * added option:
      "hangar"/"showDailyQuestWidget" - show widget "Daily Quests" in the hangar
  * removed option:
      "hangar"/"showRewardWindow"

  [PYTHON MACROS]
  * damageLog: in the “dmg-kind” and “c:dmg-kind” sections, the “recovery” parameter has been added
```
______________________________

### XVM 8.3.1
```
  [GENERAL]
  * World of Tanks 1.7.1.2

  [MARKERS]
  * Added macro:
      {{dmg-kind-key}} - damage kind table key value (attack, fire, ramming, ...)
```
______________________________

### XVM 8.3.0
```
  [GENERAL]
  * World of Tanks 1.7.1.1

  [BATTLE]
  * The macro {{my-anonym}} has been renamed to {{anonym}}, the description in the documentation has been updated

  [MARKERS]
  * The macro {{dmg}} sums the value, in a time span of less than 400 ms

  [PLAYERS PANEL]
  * Fixed macros {{nick}}, {{name}}, {{clan}}, {{clannb}} for platoon with an anonymous player
```
______________________________

### XVM 8.2.3
```
  [GENERAL]
  * Fix fonts loading
```
______________________________

### XVM 8.2.2
```
  [GENERAL]
  * Fixed incompability with modifications which uses battle results
  * Various bugs fixed

  [BATTLE]
  * Added macro:
      {{my-anonym}} - returns 'anonym' for the player if anonymizer is enabled in the game, ' ' - if not
```
______________________________

### XVM 8.2.1
```
  [KNOWN ISSUES]
  * No indicator of the player's name hiding enabled in the players panel

  [GENERAL]
  * World of Tanks 1.7.0.2
  * Various bugs fixed
```
______________________________

### XVM 8.2.0
```
  [KNOWN ISSUES]
  * No indicator of the player's name hiding enabled in the players panel

  [GENERAL]
  * World of Tanks 1.7.0.1
  * Various bugs fixed
```
______________________________

### XVM 8.1.9
```
  [GENERAL]
  * World of Tanks 1.6.1.4 micropatch 2019.11.27
```
______________________________

### XVM 8.1.8
```
  [GENERAL]
  * World of Tanks 1.6.1.4

  [HANGAR]
  * Renamed options in the "hangar"/"equipmentPanel" section:
      "showNumberEquipment"  -> "showConsumablesCount"
      "showNumberDirectives" -> "showDirectivesCount"

  [BARRACKS]
  * Added new feature of sorting tankmen in barracks from config (hangar.xc)
  * Added section:
      "hangar"/"barracks"

  [CAROUSEL]
  * The functionality in the "carousel"/"filters" section has been restored
  * Added options:
      "carousel"/"filters"/"elite"/"enabled" - show/hide "Elite vehicle" filter
      "carousel"/"filters"/"premium"/"enabled" - show/hide "Premium vehicle" filter

  [HITLOG]
  * Added macro:
      {{number}} - line number
```
______________________________

### XVM 8.1.7
```
  [GENERAL]
  * Added option:
      "userLanguageFolder" - the path to the folder containing custom localization files,
                             set relative to the user config folder.
  * Various bugs fixed

  [XFW]
  * Implemented sound banks loading on 64-bit clients

  [BATTLE]
  * Fixed {{pp.mode}} macro in battle mode "Ranked battle"
  * Added the ability to scroll the contents of the hit log

  [HANGAR]
  * Added filter for vehicles that have crews with less than 100% training level
  * Added option:
      "hangar"/"showRankedBattleResults" - display info window with the battle results in the "Ranked battle"
      "hangar"/"equipmentPanel"/"showNumberEquipment" - show the remaining quantity of consumables in depot
      "hangar"/"equipmentPanel"/"showNumberDirectives" - show the remaining quantity of directives in depot
```
______________________________

### XVM 8.1.6
```
  [GENERAL]
  * World of Tanks 1.6.1.3
  * Improved support for WoT client installed in path with non-latin characters
```
______________________________

### XVM 8.1.5
```
  [GENERAL]
  * Fixed XVM loading if WoT path has non-latin characters
  * Initial macOS Catalina support
```
______________________________

### XVM 8.1.4
```
  [GENERAL]
  * World of Tanks 1.6.1.2
  * Added support for <WoT_DIR> working directory
```
______________________________

### XVM 8.1.3
```
  [XFW.Native]
  * Fixed loading error if vcomp140.dll is not present in the operating systems
```
______________________________

### XVM 8.1.2
```
  [GENERAL]
  * World of Tanks 1.6.1.1 nanopatch 1

  [XFW.Native]
  * Added initial support for 64-bit clients
  * Reduced first start time on systems with a large number of processor cores

  [BUGFIXES]
  * Fixed crash to desktop in "Grand Battles"
  * Fixed extrafields for timkillers
  * Fixed {{pp.widthLeft}} and {{pp.widthRight}} macros
  * Fixed display of vehicle name in tank carousel
  * Fixed typpos in configuration files
```
______________________________

### XVM 8.1.1
```
  [GENERAL]
  * World of Tanks 1.6.1.1

  [XFW]
  * Refactored XFW Loader.
      More info: https://gitlab.com/xvm/xvm/wikis
  * Changes in `.wotmod` names:
      * `com.modxvm.xfw.loader` was added
      * `com.modxvm.xfw` was removed

  [MACROS]
  * added macros in hangar:
      {{v.multiNation}} - 'multi' for vehicle on which it is possible to change the nation, empty for normal vehicle

  [KNOWN ISSUES]
  * XVM is not compatible with the 64-bit version of the client
```
______________________________

### XVM 8.1.0
```
  [GENERAL]
  * World of Tanks 1.6.1.0

  [BATTLE]
  * removed option:
      "battle"/"showPostmortemDogtag"

  [HANGAR]
  * removed option:
      "hangar"/"showDogtagWidget"

  [KNOWN ISSUES]
  * XVM is not compatible with the 64-bit version of the client
```
______________________________

### XVM 8.0.7
```
  [GENERAL]
  * Fix platoons for Grand Race
```
______________________________

### XVM 8.0.6
```
  [GENERAL]
  * World of Tanks 1.6.0.8
```
______________________________

### XVM 8.0.5
```
  [GENERAL]
  * World of Tanks 1.6.0.7

  [BATTLE]
  * removed options:
      "battle"/"battleHint"/"hideRadarHint"
```
______________________________

### XVM 8.0.4
```
  [GENERAL]
  * World of Tanks 1.6.0.5

  [PYTHON MACROS]
  * added macro {{py:xvm.arabic_to_roman(number)}}
```
______________________________

### XVM 8.0.3
```
  [GENERAL]
  * World of Tanks 1.6.0.4
```
______________________________

### XVM 8.0.2
```
  [GENERAL]
  * World of Tanks 1.6.0.3

  [BATTLE]
  * added option:
      "battle"/"battleHint"/"hideRadarHint" - hide the tips about radar activation ("Steel Hunter" mode)
```
______________________________

### XVM 8.0.1
```
  [GENERAL]
  * World of Tanks 1.6.0.1
```
______________________________

### XVM 8.0.0
```
  [GENERAL]
  * World of Tanks 1.6.0.0

  [HANGAR]
  * added option:
      "hangar"/"showDogtagWidget" - display of the dog tag widget

  [BATTLE]
  * added option:
      "battle"/"showPostmortemDogtag" - display pop-up panel with a dog tag
```
______________________________

### XVM 7.9.9
```
  [GENERAL]
  * World of Tanks 1.5.1.3
```
______________________________

### XVM 7.9.8
```
  [GENERAL]
  * World of Tanks 1.5.1.2
  * added options to extra-fields:
      "tweens"
      "tweensIn"
      "tweensOut"
  * description for the parameters see extra-field.txt

  [HANGAR]
  * restored functionality of the options:
      "login"/"onlineServers"
      "hangar"/"onlineServers"

  [BATTLE]
  * added options in "battleLoading", "battleLoadingTips" and "statisticForm" sections:
      "removeTesterIcon" - disable alpha/beta testers icons
```
______________________________

### XVM 7.9.7
```
  [GENERAL]
  * bugfixes and optimization
```
______________________________

### XVM 7.9.6
```
  [GENERAL]
  * bugfixes and optimization
```
______________________________

### XVM 7.9.5
```
  [GENERAL]
  * World of Tanks 1.5.1.1

  [MACROS]
  * added macros in battle:
      {{special}}, {{my-special}} - value 'special' for award and event (excluding premium vehicles with increased income on credits) vehicle, empty for normal vehicle
  * added macros in hangar:
      {{v.special}} - value 'special' for award and event (excluding premium vehicles with increased income on credits) vehicle, empty for normal vehicle

  [HANGAR]
  * added options:
      "hangar"/"sessionStatsButton"/"showButton" - display "Session statistics" button
      "hangar"/"sessionStatsButton"/"showBattleCount" - display the counter of spent battles on the button
```
______________________________

### XVM 7.9.4
```
  [HANGAR]
  * fixed display of xTE column in player profiles

  [XFW]
  * backport Python HTTP and SSL stacks from CPython 2.7.16
  * update 3rdparty libraries
    - decorator: 4.1.2 -> 4.4.0
    - dpath: 1.3.3 -> 1.4.2
    - pika: 0.10.0 -> 1.0.1
    - simplejson: 3.4.0 -> 3.16.1
    - six: 1.8.0 -> 1.12.0
  * replaced networkX with py-dag for dependencies resolving
```
______________________________

### XVM 7.9.3
```
  [GENERAL]
  * World of Tanks 1.5.0.4
  * adaptation for the battle mode "Ranked Battle"

  [PYTHON MACROS]
  * hitLog: added macro {{battletype-key}}. Added support for {{battletype-key}} macro in "lines" option.
  * hitLog: if you are allowed to move the log with the mouse, the coordinates are stored separately for each type of battle.
```
______________________________

### XVM 7.9.2
```
  [GENERAL]
  * World of Tanks 1.5.0.3

  [BATTLE RESULTS]
  * added option:
      "battleResults"/"showStandardFrontLineInterface" - display standard interface for the "FrontLine" mode.

  [PYTHON MACROS]
  * added macros {{py:mod(a, b)}}, {{py:strip(string, chars)}}, {{py:lstrip(string, chars)}}, {{py:rstrip(string, chars)}}
  * damageLog: added option "groupDamageFromArtAndAirstrike"
```
______________________________

### XVM 7.9.1
```
  [GENERAL]
  * World of Tanks 1.5.0.1

  [HANGAR]
  * added section:
      "battleResults"/"bonusState" - customize "Manageable bonus to experience" panel
```
______________________________

### XVM 7.9.0
```
  [GENERAL]
  * World of Tanks 1.5.0.0

  [BATTLE]
  * adaptation for the battle mode "Frontline"
  * updated sections:
      "battleLabelsTemplates"/"hitLogHeader"
      "battleLabelsTemplates"/"hitLogBody"
      "battleLabelsTemplates"/"totalEfficiency"

  [CAROUSEL]
  * removed macros: {{v.rankCount}}, {{v.rankSteps}}, {{v.rankStepsTotal}}
```
______________________________

### XVM 7.8.7
```
  [GENERAL]
  * World of Tanks 1.4.1.2

  [HANGAR]
  * added options:
      "hangar"/"showRewardWindow" - show info window with list of received awards for "Reward for Merit"
      "tooltips"/"showXpToUnlockVeh" - display of missing experience to unlock vehicles

  [PYTHON MACROS]
  * totalEfficiency: normalization added in the macros:
      {{py:xvm.totalDamage(norm)}},
      {{py:xvm.totalAssist(norm)}},
      {{py:xvm.damagesSquad(norm)}},
      {{py:xvm.totalDamagesSquad(norm)}}
```
______________________________

### XVM 7.8.6
```
  [GENERAL]
  * World of Tanks 1.4.1.1

  [HANGAR]
  * restored functionality of the options:
      "login"/"saveLastServer" - save last server
      "hangar"/"hidePricesInTechTree" - hide price button in tech tree
      "hangar"/"masteryMarkInTechTree" - show mastery mark in tech tree
```
______________________________

### XVM 7.8.5
```
  [GENERAL]
  * World of Tanks 1.4.1.0

  [PYTHON MACROS]
  * totalEfficiency: added macro {{py:xvm.dmgKindColor}}
  * hitLog: added macro {{vehiclename}}
  * damageLog: added macro {{vehiclename}}
  * damageLog: the "wheel" parameter has been added to the "comp-name" section
  * damageLog: updated list of available macros with their description:
      (/res_mods/mods/shared_resources/xvm/docs/py_macros_ru.txt)

  [HIT LOG]
  * hitlog settings was completely reworked;
      see "hitLog.xc" file.
  * added sections:
      "battleLabels"/"hitLogBackground"
      "battleLabelsTemplates"/"hitLogBackground"
      "colors"/"dmg_ratio_player"
  * renamed sections:
      "battleLabels"/"hitlogHeader" > "battleLabels"/"hitLogHeader"
      "battleLabels"/"hitlogBody" > "battleLabels"/"hitLogBody"
      "battleLabelsTemplates"/"hitlogHeader" > "battleLabelsTemplates"/"hitLogHeader"
      "battleLabelsTemplates"/"hitlogBody" > "battleLabelsTemplates"/"hitLogBody"
  * updated sections:
      "battleLabelsTemplates"/"avgDamage"
      "battleLabelsTemplates"/"mainGun"

  [DAMAGE LOG]
  * added parameter:
      "damageLog"/"comp-name"/"wheel"
  * updated sections:
      "battleLabelsTemplates"/"damageLog"
      "battleLabelsTemplates"/"damageLogBackground"
      "battleLabelsTemplates"/"lastHit"

  [PLAYERS PANEL]
  * renamed option in the sections "playersPanel"/"short", "medium", "medium2", "large":
      "vehicleIconXOffsetLeft"   -> "vehicleIconOffsetXLeft"
      "vehicleIconXOffsetRight"  -> "vehicleIconOffsetXRight"
      "vehicleLevelXOffsetLeft"  -> "vehicleLevelOffsetXLeft"
      "vehicleLevelXOffsetRight" -> "vehicleLevelOffsetXRight"
      "fragsXOffsetLeft"         -> "fragsOffsetXLeft"
      "fragsXOffsetRight"        -> "fragsOffsetXRight"
      "rankBadgeXOffsetLeft"     -> "rankBadgeOffsetXLeft"
      "rankBadgeXOffsetRight"    -> "rankBadgeOffsetXRight"
      "nickXOffsetLeft"          -> "nickOffsetXLeft"
      "nickXOffsetRight"         -> "nickOffsetXRight"
      "vehicleXOffsetLeft"       -> "vehicleOffsetXLeft"
      "vehicleXOffsetRight"      -> "vehicleOffsetXRight"

  [HANGAR]
  * added option:
      "hangar"/"enableCrystalLocker" - enable locker for bonds

  [KNOWN ISSUES]
  * disabled options:
      "login"/"saveLastServer" - save last server
      "hangar"/"hidePricesInTechTree" - hide price button in tech tree
      "hangar"/"masteryMarkInTechTree" - show mastery mark in tech tree
    Will be reprocessed in future releases.
```
______________________________

### XVM 7.8.4
```
  [GENERAL]
  * World of Tanks 1.4.0.2
```
______________________________

### XVM 7.8.3
```
  [GENERAL]
  * World of Tanks 1.4.0.1 micropatch 2019.03.06
```
______________________________

### XVM 7.8.2
```
  [GENERAL]
  * bugfixes and optimization
```
______________________________

### XVM 7.8.1
```
  [GENERAL]
  * World of Tanks 1.4.0.1

  [HANGAR]
  * added options:
      "hangar"/"showReferralButton" - show "Referral Program" button
      "hangar"/"combatIntelligence"/"showPopUpMessages" - disable display pop-up messages in the hangar
      "hangar"/"combatIntelligence"/"showUnreadCounter" - disable display unread notifications counter in the menu
  * removed option "hangar"/"showTeaserWidget"
```
______________________________

### XVM 7.8.0
```
  [GENERAL]
  * World of Tanks 1.4.0.0

  [CAROUSEL]
  * added sorting on "battles", "-battles"

  [PYTHON MACROS]
  * damageLog: changed the names of the parameters in the "vtype" and "c:vtype" sections
  * totalEfficiency: added macro {{py:xvm.dmgAlly}}
```
______________________________

### XVM 7.7.9
```
  [GENERAL]
  * World of Tanks 1.3.0.1

  [CAROUSEL]
  * added options in the "hangar"/"carousel" section:
      "slotBackgroundAlpha" - slot transparency
      "slotBorderAlpha" - slot border transparency
      "edgeFadeAlpha" - transparency of gradient frames at the carousel edges
```
______________________________

### XVM 7.7.8
```
  [GENERAL]
  * World of Tanks 1.3.0

  [BATTLE]
  * added option "battle"/"battleHint"/"hideHelpScreen" - hide the tips of the transition to the window of exploring the features of the machine (for wheeled vehicles)
  * updated option "battle"/"battleHint"/"hideSiegeIndicator" - hide the tips about switching to siege mode and changing the driving mode (for wheeled vehicles)

  [MACROS]
  * added macros in hangar:
      {{v.type_l}} - vehicle type (text substitution from config)
      {{v.type_key}} - vehicle class (text substitution from locale)
      {{v.rent}} - 'rent' for rented, empty for normal vehicle

  [PYTHON MACROS]
  * damageLog: log scrolling added

  [OTHER]
  * updated vehicle names
```
______________________________

### XVM 7.7.7
```
  [GENERAL]
  * World of Tanks 1.2.0.2
```
______________________________

### XVM 7.7.6
```
  [GENERAL]
  * changed the location of the file cache folder
  * changed text in the crashreporting form
  * fixed Audiokinetic error #66 on the first WoT launch
  * fixed issues related to file cache
  * updated SWF to the latest micropatch

  [HANGAR]
  * added option "hangar"/"showTeaserWidget" - disable display of the widget with ads
```
______________________________

### XVM 7.7.5
```
  [GENERAL]
  * World of Tanks 1.2.0.1
  * fixed crashes BF-3, BF-5
  * various bugs fixed

  [PYTHON MACROS]
  * totalEfficiency: added macros {{py:xvm.numberAssistStun}}, {{py:xvm.numberAssistSpot}}, {{py:xvm.numberAssistTrack}}, {{py:xvm.numberAssistAndStuns}}, {{py:xvm.totalAssistAndStuns}}
```
______________________________

### XVM 7.7.4
```
  [GENERAL]
  * World of Tanks 1.2.0
```
______________________________

### XVM 7.7.3
```
  [GENERAL]
  * World of Tanks 1.1.0.1

  [HANGAR]
  * added option "carousel"/"hideRestoreTank" - hide cell "Restore Tank"
```
______________________________

### XVM 7.7.2
```
  [GENERAL]
  * adaptation screen on the Tab key
  * fixed offset of the vehicle level on the battle loading screen

  [HANGAR]
  * fixed the possibility of buying premium vehicle if the "enableGoldLocker" option is active

  [PYTHON MACROS]
  * totalEfficiency: various bugs fixed
```
______________________________

### XVM 7.7.1
```
  [KNOWN ISSUES]
  * on the battle loading screen, vehicle levels can be shifted along the vertical axis
  * there is no player statistics on the Tab key

 [OTHER]
  * xfw: fixed crashfixes applying
  * xvm_main/dossier: fixed None dereferencing
  * xvm_battle/battleloading: fixed null dereferencing
  * updated vehicle names
  * fixed displaying of tankmen in barracks

  [CRASH REPORTS]
  * title was changed from "WoT" to "WoT+XVM"
  * disclaimer font was increased
  * disclaimer text was improved
  * added XVM build to client version
  * fixed crashreports sending in case when MSVC Redistributable 2015/2017 was not installed
```
______________________________

### XVM 7.7.0
```
  [KNOWN ISSUES]
  * on the battle loading screen, vehicle levels can be shifted along the vertical axis
  * there is no player statistics on the Tab key

  [GENERAL]
  * World of Tanks 1.1.0

  [XFW]
  * refactored package loading algorithm
  * updated "xfw_package.swf" file format:
      - implented "wot_version_min" and "wot_version_exactmatch" fields for specifiyng target WoT client version
      - implented support for masks in "dependencies_optional" field, for example "com.modxvm.xfw.wotfix.*"
  * XFW.Native was updated to 1.3.1-65
      - implented support for subscribing on some D3D9 and DXGI functions
  * actionscript files now stores in "com.modxvm.xfw.actionscript" package

  [BATTLE]
  * added options:
      "battle"/"battleHint"/"hideTrajectoryView" - hide the tips aiming mode changing in strategic mode
      "battle"/"battleHint"/"hideSiegeIndicator" - hide the tips about switching to siege mode
      "battle"/"battleHint"/"hideQuestProgress" - hide the tips about switching to menu Personal Missions

  [CAMERA]
  * removed option "camera"/"hideHint"

  [OTHER]
  * crashreports: we now using https for crashreports uploading
  * crashreports: now crash upload window should use the client language
```
______________________________

### XVM 7.6.11
```
  [GENERAL]
  * fix incompability with unbound-based UI windows (e.g. new ingame store)
```
______________________________

### XVM 7.6.10
```
  [GENERAL]
  * World of Tanks 1.0.2.4
```
______________________________

### XVM 7.6.9
```
  [GENERAL]
  * World of Tanks 1.0.2.3
```
______________________________

### XVM 7.6.8
```
  [CRASHES]
  * fixed compatibility with MacOS
  * fixed compatibility with Windows XP
  * fixed compatibility with Wargaming Error Monitor
  * improved crashfix #2

  [XFW]
  * fixed xfw_package.json/dependencies_optional option behavior
  * added version info for binary files (.pyd)

  [BATTLE]
  * added displaying of the fractional part of the magnification.

  [PYTHON MACROS]
  * damageLog: various bugs fixed
  * totalEfficiency: various bugs fixed
```
______________________________

### XVM 7.6.7
```
  [GENERAL]
  * World of Tanks 1.0.2.2
  * added semi-automatic crash reporting

  [HANGAR]
  * fixed widgets disappearing after battle

  [OTHER]
  * refactored online and ping displaying
  * builtin fonts are case-insensetive now
  * added check for isDAAPIInited flag on flash loading

  [INSTALLER]
  * removed Microsoft C++ Runtime from archive (it is available for download on modxvm.com)
```
______________________________

### XVM 7.6.6
```
  [OTHER]
  * skip version due to technical reasons
```
______________________________

### XVM 7.6.5
```
  [INSTALLER]
  * fixed XVM installer uninstallation process.

  [OTHER]
  * fixed "updateReserve" function error
```
______________________________

### XVM 7.6.4
```
  [GENERAL]
  * World of Tanks 1.0.2.1

  [CRASHES]
  * added fixes for Autodesk Scaleform crashes
  * fixed crash in case when there is ping or online counters in lobby
  * added updated Microsoft Universal CRT and Microsoft Visual C++ Redistributable versions

  [HANGAR]
  * added section "hangar"/"notificationCounter" - show/hide notifications counters in the main menu
  * added options:
      "hangar"/"showCreateSquadButtonText" - show "Create squad" text on the squad creation button
      "hangar"/"showBattleTypeSelectorText" - show selected battle mode text
      "hangar"/"showPromoPremVehicle" - disable display promo of premium vehicle (on the background in the hangar)

  [BATTLE]
  * added options in the "playersPanel" modes sections:
      "rankBadgeAlpha" - transparency of the rank badge
```
______________________________

### XVM 7.6.3
```
  [HANGAR]
  * added option "hangar"/"restoreBattleType" - restore selected battle type on switching to another server
  * added option in "hangar"/"pingServers" and "hangar"/"onlineServers":
      "currentServerFormat" - html format for current server
  * removed option in "hangar"/"pingServers" and "hangar"/"onlineServers":
      "markCurrentServer" - replaced with "currentServerFormat"
  * added option "login"/"disabledServers" - do not show the specified servers in the servers list

  [MISC]
  * fixed display of tooltips in battle
  * added option "tooltips"/"hideTooltips" - list of tooltips to hide
  * added option "tooltips"/"logLocalization" - log all localization keys to the xvm.log file
```
______________________________

### XVM 7.6.2
```
  [GENERAL]
  * World of Tanks 1.0.1.1 nanopatch 2
  * changed structure of the settings cache files, need to re-configure the filters and tanks in reserve.

  [XFW]
  * implemented WoT functions offset cache.
  * improved Python/C compatibility

  [MISC]
  * fixes in hangar filters
  * disabled tooltip in players panel
```
______________________________

### XVM 7.6.1
```
  [GENERAL]
  * World of Tanks 1.0.1.1

  [PYTHON MACROS]
  * damageLog: disabled panel in the frontline mode
  * damageLog: fix macros {{costShell}} and {{c:costShell}}

  [MISC]
  * fixed old replays playback
  * fixed repair modules timer position
  * player profile: fixed xTE column
  * implemented HTTP-proxy support through environment variable XVM_HTTP_PROXY=http://[login:password@]domain.com:3128
```
______________________________

### XVM 7.6.0
```
  [GENERAL]
  * World of Tanks 1.0.1.0

  [HANGAR]
  * removed option "hangar"/"defaultBoughtForCredits" - no longer needed.

  [MARKERS]
  * added "damageIndicator" settings - damage indicator (ricochet, critical hit, ...);
  * added "vehicleStatusMarker" settings - stun marker and consumables marker
    in "Frontline Returns" mode (smoke screen, morale boost, engineering crew);
  * removed "stunMarker" settings (replaced by "vehicleStatusMarker").

  [XFW]
  * fixed ctypes module;
  * fixed CJK languages support.
```
______________________________

### XVM 7.5.6
```
  [GENERAL]
  * World of Tanks 1.0.0 micropatch 3
```
______________________________

### XVM 7.5.5
```
  [GENERAL]
  * World of Tanks 1.0.0 micropatch 2
```
______________________________

### XVM 7.5.4
```
  [GENERAL]
  * xUI was renamed to XVM (xUI was a joke for April 1st).

xUI-7.5.3:
  [GENERAL]
  * XVM was renamed to xUI
```
______________________________

### XVM 7.5.2
```
  [XFW]
  * XFW.Native was updated 1.0.9-39
```
______________________________

### XVM 7.5.1
```
  [GENERAL]
  * World of Tanks 1.0.0 micropatch 1

  [PYTHON MACROS]
  * added macro {{py:xvm.isImpact}}
```
______________________________

### XVM 7.5.0
```
  [GENERAL]
  * World of Tanks 1.0

  [SOUNDS]
  * new options "sounds"/"xvm_gunReloaded" - the sound of the end of recharging the gun.

  [HANGAR]
  * removed option "hangar/hangarType" and section "hangar/camera".

  [PYTHON MACROS]
  * damageLog: added macro {{hitTime}}
```
______________________________

### XVM 7.4.1
```
  [GENERAL]
  * World of Tanks 9.22 micropatch 1

  [XFW]
  * fixed check for native components loading before using them.
```
______________________________

### XVM 7.4.0
```
  [GENERAL]
  * World of Tanks 9.22
```
______________________________

### XVM 7.3.3
```
  [GENERAL]
  * World of Tanks 9.21.0.3

  [HANGAR]
  * new options "hangar"/"showGeneralChatButton" - show "General chat" button.

  [SOUNDS]
  * new options "sounds"/"remote_communication option" - remote communication between WoT client and WWISE Authoring Tools.

  [MISC]
  * updated "texts"/"battletype" section with text replacements for {{battletype}} macro.
```
______________________________

### XVM 7.3.2
```
  [GENERAL]
  * World of Tanks 9.21.0.2

  [KNOWN ISSUES]
  * Microsoft Windows XP: crash to desktop on battle loading if graphics mode is standard.
```
______________________________

### XVM 7.3.1
```
  [GENERAL]
  * fixed crash when leaving the battle.

  [KNOWN ISSUES]
  * Microsoft Windows XP: crash to desktop on battle loading if graphics mode is standard.
```
______________________________

### XVM 7.3.0
```
  [KNOWN ISSUES]
  * possible game client crash when leaving the battle;
  * to minimize crash possibility, markers were disabled by default.
  * Microsoft Windows XP: crash to desktop on battle loading if graphics mode is standard.

  [GENERAL]
  * World of Tanks 9.21.0.1

  [MACROS]
  * macros {{v.wtr}}, {{v.xwtr}}, {{v.c_xwtr}}, {{v.a_xwtr}} are turned off due to difficult implementation
  * added macros in carousel:
      {{v.camouflageSummer}} - value 'summer' if summer camouflage installed
      {{v.camouflageWinter}} - value 'winter' if winter camouflage installed
      {{v.camouflageDesert}} - value 'desert' if desert camouflage installed
      {{v.camouflageCount}} - count of camouflages installed
  * vehicle macros {{v.*}} works in widgets for current vehicle

  [WIDGETS]
  * mouseEvents can be used in hangar widgets
```
______________________________

### XVM 7.2.4
```
  [GENERAL]
  * World of Tanks 9.20.1.4
```
______________________________

### XVM 7.2.3
```
  [GENERAL]
  * World of Tanks 9.20.1.3

  [HANGAR]
  * renamed option in the "hangar"/"serverInfo" sections:
      "shiftX" -> "offsetX"
      "shiftY" -> "offsetY"
  * renamed option in the "hangar"/"commonQuests" sections:
      "shiftX" -> "offsetX"
      "shiftY" -> "offsetY"
  * renamed option in the "hangar"/"personalQuests" sections:
      "shiftX" -> "offsetX"
      "shiftY" -> "offsetY"
  * renamed option in the "hangar"/"vehicleName" sections:
      "shiftX" -> "offsetX"
      "shiftY" -> "offsetY"
  (hangar.xc)

  [RATINGS]
  * removed config sections:
      "alpha"/"eff"
      "alpha"/"wn8"
      "alpha"/"wtr"
      "alpha"/"wgr"
      "colors"/"eff"
      "colors"/"wn8"
      "colors"/"wtr"
      "colors"/"wgr"
  (colors.xc, alpha.xc)
  * disabled original color and alpha settings for ratings since XVM scale is used by default

  [MACROS]
  * added macros in battle:
      {{vwtr}} - WTR rating for current vehicle
      {{xvwtr}} - WTR rating for current vehicle
      {{c:xvwtr}}, {{a:xvwtr}} - dynamic color and transparency for {{xvwtr}} macro
  * added macros in hangar:
      {{v.wtr}} - WTR rating for current vehicle
      {{v.xwtr}} - WTR rating for current vehicle in XVM Scale
      {{v.c_xwtr}}, {{v.a_xwtr}} - dynamic color and transparency for {{v.xwtr}} macro

  [PYTHON MACROS]
  * damageLog: added macros {{xr}} and {{c:xr}}
```
______________________________

### XVM 7.2.2
```
  [KNOWN ISSUES]
  * Microsoft Windows XP: crash to desktop on battle loading if graphics mode is standard.

  [MISC]
  * fixed minor issues with release package
```
______________________________

### XVM 7.2.1
```
  [KNOWN ISSUES]
  * Microsoft Windows XP: crash to desktop on battle loading if graphics mode is standard.

  [GENERAL]
  * World of Tanks 9.20.1.2

  [MISC]
  * updated "texts"/"battletype" section with text replacements for {{battletype}} macro
```
______________________________

### XVM 7.2.0
```
  [GENERAL]
  * World of Tanks 9.20.1.1
  * XVM site URL changed: http://www.modxvm.com => https://modxvm.com
  * fixed bootcamp mode
```
______________________________

### XVM 7.1.0
```
  [KNOWN ISSUES]
  * Microsoft Windows XP: crash to desktop on battle loading if graphics mode is standard.

  [GENERAL]
  * World of Tanks 9.20.1
```
______________________________

### XVM 7.0.3
```
  [KNOWN ISSUES]
  * Microsoft Windows XP: crash to desktop on battle loading if graphics mode is standard.

  [OTHER]
  * various bugs fixes

  [MACROS]
    * added macros:
      {{xwr}}, {{c:xwr}}, {{a:xwr}},
      {{mystat.xwr}}, {{mystat.c_xwr}}, {{mystat.a_xwr}}

  [TOOLTIPS]
  * added display appropriate vehicles in tooltips for shells
```
______________________________

### XVM 7.0.2
```
  [KNOWN ISSUES]
  * Microsoft Windows XP: crash to desktop on battle loading if graphics mode is standard.

  [MISC]
  * fix XVM version detection
```
______________________________

### XVM 7.0.1
```
  [KNOWN ISSUES]
  * Microsoft Windows XP: crash to desktop on battle loading if graphics mode is standard.

  [BATTLE]
  * fix battle initialization
```
______________________________

### XVM 7.0.0
```
  [KNOWN ISSUES]
  * Microsoft Windows XP: crash to desktop on battle loading if graphics mode is standard.

  [RATINGS]
  * added rating WTR
  * added macros:
      {{wtr}}, {{xwtr}}, {{c:wtr}}, {{c:xwtr}}, {{a:wtr}}, {{a:xwtr}},
      {{mystat.wtr}}, {{mystat.xwtr}}, {{mystat.c_wtr}}, {{mystat.c_xwtr}}
  * added config sections:
      "alpha"/"wtr"
      "colors"/"wtr"
  * updated color and alpha values boundaries for all ratings
  * color and alpha values boundaries for XVM scale are updated automatically every day
  * removed rating WN6
  * removed macros:
      {{wn6}}, {{xwn6}}, {{c:wn6}}, {{c:xwn6}}, {{a:wn6}}, {{a:xwn6}},
      {{mystat.wn6}}, {{mystat.xwn6}}, {{mystat.c_wn6}}, {{mystat.c_xwn6}}
  * removed config sections:
      "alpha"/"wn6"
      "colors"/"wn6"

  [MISC]
  * updated "texts"/"battletype" section with text replacements for {{battletype}} macro

  [PYTHON MACROS]
  * added macros {{py:upper('str')}}, {{py:lower('str')}}, {{py:capitalize('str')}} and {{py:title('str')}}
```
______________________________

### XVM 6.9.1.1
```
  [KNOWN ISSUES]
  * Microsoft Windows XP: crash to desktop on battle loading if graphics mode is standard.

  [MISC]
  * bypass Baidu antivirus false-positive fireAlert
```
______________________________

### XVM 6.9.1
```
  [KNOWN ISSUES]
  * Microsoft Windows XP: crash to desktop on battle loading if graphics mode is standard.

  [GENERAL]
  * fixed bootcamp mode
  * partial support of the "Grand Battle" mode (battle loading, statistics form and
    players panel are not implemented)
  * various bugs fixes

  [XFW]
  * libpython: improved Python/C API coverage
  * libpython: fixed some Python/C API functions

  [MARKERS]
  * fixed "contourIcon"/"amount" option

  [CAROUSEL]
  * added macros:
      {{v.avgdmg}} - average vehicle damage (last month active players with 100+ battles on tank)
      {{v.topdmg}} - top vehicle damage (100 position of the best players)
      {{v.avgfrg}} - average vehicle frags (last month active players with 100+ battles on tank)
      {{v.topfrg}} - top vehicle frags (100 position of the best players)
  * fix carousel when "without sign of mastery" filter is selected

  [MISC]
  * fix "tweaks"/"allowMultipleWotInstances" option
```
______________________________

### XVM 6.9.0
```
  [KNOWN ISSUES]
  * bootcamp: does not work. Run WoT without mods to enter in bootcamp mode.
  * Microsoft Windows XP: crash to desktop on battle loading if graphics mode is standard.

  [GENERAL]
  * World of Tanks 9.20
  * updated capture bar

  [MARKERS]
  * options are implemented:
      "iconset"/"vehicleMarkerAllyAtlas"
      "iconset"/"vehicleMarkerEnemyAtlas"

  [PYTHON MACROS]
  * changed the names of the macros for the score panel (py_macros_ru.txt)
  * battleLabels: added event:
      ON_MY_HP_CHANGED - emitted when current vehicle HP is changed

  [PROFILE]
  * added options in the "userInfo" section:
      "profileStartPage" - initial page for current user service record
      "contactsStartPage" - initial page for other players service records
  * removed option "userInfo"/"startPage"
```
______________________________

### XVM 6.8.2
```
  [GENERAL]
  * World of Tanks 9.19.1 micropatch 2

  [KNOWN ISSUES]
  * bootcamp: does not work. Run WoT without mods to enter in bootcamp mode.
  * Microsoft Windows XP: crash to desktop on battle loading if graphics mode is standard.

  [PYTHON MACROS]
  * added the macro {{py:xvm.color_rating(r, v)}}
  * totalEfficiency: added the macro {{py:xvm.hitAlly}}

  [MINIMAP]
  * added option "showCellClickAnimation" - allow to disable cell click animation

  [WIDGETS]
  * added macros {{mystat.*}} with own statistics values
  * added event:
      ON_MY_STAT_LOADED - emitted when own stat loading complete, useful for {{mystat.*}} macros
```
______________________________

### XVM 6.8.1
```
  [KNOWN ISSUES]
  * bootcamp: does not work. Run WoT without mods to enter in bootcamp mode.
  * Microsoft Windows XP: crash to desktop on battle loading if graphics mode is standard.

  [GENERAL]
  * World of Tanks 9.19.1 micropatch 1

  [MARKERS]
  * fixed markers for players with comments

  [TANK CAROUSEL]
  * fixed carousel reset after battle

  [INSTALLER]
  * implemented WoT detection for Linux and macOS
```
______________________________

### XVM 6.8.0
```
  [KNOWN ISSUES]
  * bootcamp does not work
  * crash to desktop on battle loading if user OS is Microsoft Windows XP.

  [GENERAL]
  * World of Tanks 9.19.1

  [XFW]
  * implemented support for python debuggers based on PyDebugAttach library (for example, Microsoft PTVS)

  [DAMAGE LOG]
  * added macro {{type-shell-key}}

  [BATTLE]
  * added macros:
      {{battletype-key}} - current battle type table key value
      {{premium}}, {{my-premium}} - 'premium' for premium, empty for normal vehicle
      {{hasBadges}} - 'true' if at least one player in the team has badge, empty if not
      {{friend}} - player is in the friends list
      {{ignored}} - player is in the ignore list
      {{muted}} - player is muted for current battle
      {{chatban}} - player have blocked chat by WG

  [MINIMAP]
  * added parameter "selfIconColor" - color for arrow of selected vehicle

  [HANGAR]
  * macro {{battletype-key}} can be used in hangar

  [CAROUSEL]
  * added macros:
      {{v.rankCount}} - vehicle rank achieved in the rank battle
      {{v.rankSteps}} - steps completed to next vehicle rank
      {{v.rankStepsTotal}} - total steps count to next vehicle rank

  [INSTALLER]
  * improved WoT client detection and path selection

  [MISC]
  * removed company mode functions (due to removal from the client)
```
______________________________

### XVM 6.7.4
```
  [MISC]
  * fix level of battles for the vehicle 3rd level
  * fix compatibility with some antivirus software and debuggers

  [HANGAR]
  * fix weekday displaying

  [BATTLE]
  * added players panel, battle loading and full stats in the ranked battle
  * added options in "battleLoading", "battleLoadingTips" and "statisticForm" sections:
      "removeRankBadgeIcon" - disable rank badge icons
  * added new field type "badge" in the "playersPanel"/"standardFields" modes sections
  * added options in the "playersPanel" modes sections:
      "rankBadgeXOffsetLeft" - offset of X value for rank badge column
      "rankBadgeXOffsetRight" - offset of X value for rank badge column
      "rankBadgeWidth" - width of the rank badge column

  [DAMAGE LOG]
  * various bugs fixed

  [MACROS]
  * added macros:
      {{rank-level}} - rank level
      {{rankBadgeId}} - player's rank badge id
  * removed macros for "Top Tankers" event
```
______________________________

### XVM 6.7.3
```
  [GENERAL]
  * World of Tanks 9.19, micropatch 08.06.2017

  [HANGAR]
  * added option "hangar/hangarType" with values: none (default), "premium" and "basic"
  * added section "hangar/camera" with options:
      "minDistance" - minimum distance
      "maxDistance" - maximum distance
      "startDistance" - start distance
      "zoomSensitivity" - camera zoom sensitivity (lower is slower)
  * Sorting the parameters in the hangar.xc
  * fixed "defaultBoughtForCredits" option
  * fixed free XP displaying in research window

  [BATTLE]
  * fixed {{my-frags}} macro
  * fixed tank contour disappearing
  * decreased performance impact of vehicle markers

  [MISC]
  * minimized performance impact of "autoReloadConfig" option
  * use game locale in the xvm.formatDate() py_macro
  * fixed compatibility with Windows XP and Wine
```
______________________________

### XVM 6.7.2
```
  [GENERAL]
  * World of Tanks 9.19, micropatch 02.06.2017
  * various bugs fixed

  [HANGAR]
  * fixed "autoReloadConfig" option
  * fixed battle results window appearance

  [MISC]
  * added new option:
      "tweaks"/"allowMultipleWotInstances": allows to run 2+ WoT clients
```
______________________________

### XVM 6.7.1
```
  [GENERAL]
  * fixed compatibility issues with Actionscript mods.

  [HANGAR]
  * fixed XVM messages displaying in service channel.
```
______________________________

### XVM 6.7.0
```
  [KNOWN ISSUES]
  * some hangar corruptions when ModsListAPI mod is installed. XVM and ModsListAPI developers are notified about the problem and are working on a solution.

  [GENERAL]
  * World of Tanks 9.19

  [DAMAGE LOG]
  * added macro {{crit-device}} and section "crit-device"

  [CAMERA]
  * added options:
      "camera"/"noFlashBang" - switch the red flash if player's vehicle has got a hit
      "camera"/"hideHint" - switch the tips about siege/marching mode and artillery aiming mode
      "camera"/"noCameraLimit" - TODO: English comments
```
______________________________

### XVM 6.6.5
```
  [GENERAL]
  * World of Tanks 9.18 micropatch

  [DAMAGE LOG]
  * added macro {{stun-duration}}

  [PYTHON MACROS]
  * totalEfficiency: added the macro {{py:xvm.numberDamagedVehicles}}
  * added macros {{py:xvm.screenWidth}}, {{py:xvm.screenHeight}}, {{py:xvm.screenVCenter}} and {{py:xvm.screenHCenter}}

  [DAMAGE LOG]
  * added option "enabled"

  [ELEMENTS]
  * updated avaliable parameters list (elements.xc)
```
______________________________

### XVM 6.6.4
```
  [BATTLE LABELS]
  * fix mouse capture
```
______________________________

### XVM 6.6.3
```
  [GENERAL]
  * World of Tanks 9.18 worldwide release

  [CAMERA]
  * added option: "camera"/"sniper"/"noBinoculars" allow to disable dimming and greening in sniper scope

  [STATS]
  * xTE and xtdb were updated
```
______________________________

### XVM 6.6.2
```
  [INSTALLER]
  * fix new installation path selection

  [XFW]
  * enchanced support for CJK (Chinese, Japanese, Korean)

  [HANGAR]
  * fixed clock for CJK
```
______________________________

### XVM 6.6.1
```
  [INSTALLER]
  * fix installation when XVM was previously installer

  [OTHER]
  * restore missing locales
  * XVM-Symbol.ttf font was updated
  * fixed tiers for Light Tanks
  * fixed typos in tanks short name
```
______________________________

### XVM 6.6.0
```
  [GENERAL]
  * adaptation to World of Tanks 9.18

  [XFW]
  * part of the functionality (ping, XInput) was moved from XVM to XFW
  * partially switch to .wotmod packages format
  * XFW can now be used without XVM

  [TOOLTIPS]
  * updated avaliable parameters list (tooltips.xc)

  [DAMAGE LOG]
  * 'alive' value of a macro {{my-alive} } is renamed into 'al'
  * added macros {{wn6}}, {{xwn6}}, {{r}}, {{c:wn6}}, {{c:xwn6}}, {{c:r}}

  [PYTHON MACROS]
  * totalEfficiency: added the macros {{py:xvm.totalStun}}, {{py:xvm.isStuns}}, {{py:xvm.numberStuns}}

  [WIDGETS]
  * added new function - widgets in login and lobby
    currently only "extra-fields" widget type implemented
    configuration files: widgets.xc, widgetsTemplates.xc
    referenced from login.xc, hangar.xc

  [BATTLE LABELS]
  * "layer" parameter can be used in the battleLabels

  [INSTALLER]
  * improvements in WoT client path detection

  [HANGAR]
  * clock in the hangar is moved to widgets
  * removed config file "clock.xc" and references
  * removed userInfo/sortColumn option, build in since 0.9.18

  [MARKERS]
  * added "stunMarker" settings for stun marker

  [CAROUSEL]
  * added settings "fields"/"infoImg"
  * parameters "textFormat" and "shadow" added in the text fields settings in section "fields"
```
______________________________

### XVM 6.5.7
```
  [GENERAL]
  * adaptation to 23.03.2017 micropatch

  [CAROUSEL]
  * rename options: "damageAvgPerMinute" -> "avgDamagePerMinute", "damageAvg" -> "avgDamage"
  * fixed tooltips

  [MINIMAP]
  * changed "artillery" circle behavior:
      circle radius consider vertical gun constraints

  [HANGAR]
  * added options "hangar"/"pingServers"/"bgImage" и "hangar"/"onlineServers"/"bgImage"
```
______________________________

### XVM 6.5.6
```
  [XFW]
  * python console shortcut was changed to Ctrl+Alt+~

  [HANGAR]
  * fixed hangar loading after battle
  * fixed critical hits counter in the battle results window
  * fixed premium XP counter in the battle results window
  * fixed win chances in the battle results window

  [PYTHON MACROS]
  * added the macro {{py:xvm.dynamic_color_rating(rating, value)}}
  * totalEfficiency: fixed macros {{py:xvm.crits}} and {{py:xvm.detection}}
  * repairTime: fixed timers stuck on switching in observer mode
  * damageLog: fixed option "moveInBattle"
  * damageLog: fixed macros usage in the "x" and "y" parameters
```
______________________________

### XVM 6.5.5
```
  [GENERAL]
  * adaptation to WoT 0.9.17.1
  * enable DPI-Aware mode for high pixel density displays for Microsoft Windows Vista or later
  * various bug fixes

  [XFW]
  * part of the functionality (bank loading, Microsoft Windows XP fixes) was moved from XVM to XFW
  * make XFW more independent from XVM
  * add python console (based on Hedger's py4wot). Use Alt+~ to enable it.

  [XMQP]
  * ignoring clicks and lines from blocked players
  * save xmqp data in replay

  [DAMAGE LOG]
  * fix statistics for disconnected player
  * removed the option "saveLocationInBattle"
  * added new options in the "damageLog"/"log" and "damageLog"/"lastHit": sections:
      "moveInBattle" - to allow movement of battleLabels by a mouse in battle

  [MARKERS]
  * added image scaling for extra-fields

  [MINIMAP]
  * save circles data in replay
  * fixed drawing of "motion" and "blindarea_motion" circles

  [CAROUSEL]
  * added new options in the "carousel"/"normal"/"fields" and "carousel"/"small"/"fields" sections:
      "stats" - settings for the stats field that appears on the mouse hover
      "favorite" - favorite vehicle mark
  * added hotkeys support for the extra-fields in the carousel
  * added new filter icons

  [BATTLE LOADING]
  * implemented "highlightVehicleIcon" option
  
  [PLATOONS]
  * fixed battle tier calculation
  * fixed dynamic platoons

  [MACROS]
  * allow formatting for recursive macros like `{{{{py:random.randint()}}==0?zero|one}}`

  [PYTHON MACROS]
  * added xvm.utils.smooth_transition_color() function
  * added list of available macros with their description (/res_mods/mods/shared_resources/xvm/docs/py_macros.txt)
```
______________________________

### XVM 6.5.4
```
  * adaptation to WoT 0.9.17.0.3
  * various bug fixes
```
______________________________

### XVM 6.5.3-CIS
```
  * ONLY FOR CIS(RU) CLUSTER
  * fix clan wars
  * added new options in "hangar" section:
      "commonQuests" - show/hide common quests button or change its parameters
      "personalQuests" - show/hide personal quests button or change its parameters
      "vehicleName" - show/hide current vehicle name, type and level or change their parameters
  * various bug fixes
```
______________________________

### XVM 6.5.2.1
```
  * ONLY FOR EU, NA, ASIA, KR
  * fix clan wars
```
______________________________

### XVM 6.5.2-CIS
```
  * ONLY FOR CIS(RU) CLUSTER
  * adaptation to WoT 0.9.17.0.2
```
______________________________

### XVM 6.5.2
```
  * adaptation of the battle loading screen
  * renamed parameters in the "iconset" section and changed value from folder to atlas name:
      "battleLoadingAlly" => "battleLoadingLeftAtlas"
      "battleLoadingEnemy" => "battleLoadingRightAtlas"
```
______________________________

### XVM 6.5.1.1
```
  * re-release
```
______________________________

### XVM 6.5.1
```
  * fixed switching vehicles on minimap click
  * updated xTE values
  * many bugs fixed
```
______________________________

### XVM 6.5.0.1
```
  * adaptation to WoT 0.9.17.0.1
```
______________________________

### XVM 6.5.0
```
  [MACROS]
  * added global macro:
      {{my-alive}} - is my vehicle alive

  [OTHER]
  * adaptation to WoT 0.9.17
  * removed "token/cnt" parameter in the localization files (no longer used)
  * various bug fixes
```
______________________________

### XVM 6.4.10
```
  * added macros for "Top Tankers" event:
      {{top_tankers_rank}} - player's rank on current vehicle in the "Top Tankers" game event
      {{top_tankers_emblem}} - emblem for player's rank on current vehicle  in the "Top Tankers" game event
  * added option:
      "hangar"/"notificationsButtonType" - behavior of the system channel notifications button on new notifications
```
______________________________

### XVM 6.4.9.1
```
  [INSTALLER]
  * fix installer building
```
______________________________

### XVM 6.4.9
```
  [DAMAGE LOG]
  * reloading timer was removed due to new "fair play" policy

  [MISC]
  * python part of XVM now distributed in source code (.py files)

  [CAROUSEL]
  * added option:
      "enableLockBackground" - set to false to remove background for locked vehicles

  [SOUNDS]
  * restored functionality of the extra sounds settings (sounds.xc)
```
______________________________

### XVM 6.4.8
```
  [XMQP]
  * initial implementation
  * options added:
      "minimapDrawLineThickness" - thickness of the lines for minimap drawings
      "minimapDrawAlpha" - opacity of the minimap drawings
  * options renamed:
      "minimapClicksTime" => "minimapDrawTime"
      "minimapClicksColor" => "minimapDrawColor"

  [XFW]
  * added Python C Extensions (.pyd) support
  * use uncompiled XFW-based mods (/mods/packages/)
  * fix ctypes library

  [MISC]
  * various bugs fixes

  [DOC]
  * added description for the parameters used in setting extra field (see extra-field.txt)
```
______________________________

### XVM 6.4.7.1
```
  * fixed "crewMaxPerksCount" option
```
______________________________

### XVM 6.4.7
```
  [DAMAGE LOG]
  * added "damageLog" implementation using py_macro
      Forum thread: http://www.koreanrandom.com/forum/topic/35169-damagelog/
  * added new section "damageLog"
  * added new elements in sections "battleLabels" and "battleLabelsTemplates":
      "damageLog" - received damage log
      "timerReload" - cooldown timer for the last damager
      "lastHit" - pop up with the received damage

  [PY_MACRO]
  * braces for functions without arguments can be omitted
  * macros formatting implemented
  * added mouse events in the battle labels which can be
    handled in py_macro using the function as_callback(event_name):
      "mouseEvents":
        "click" - event is sent when the mouse button clicked inside the field
        "mouseDown" - event is sent when the mouse button pressed inside the field
        "mouseUp" - event is sent when the mouse button released inside the field
        "mouseOver" - event is sent when the mouse pointer enters the field
        "mouseOut" - event is sent when the mouse pointer leaves the field
        "mouseMove" - event is sent when mouse pointer moves inside the field
        "mouseWheel" - event is sent when mouse wheel rolled inside the field

  [HANGAR]
  * in sections "clock", "pingServers", "onlineServers" option "topmost" replaced with "layer"
  * added new options in the "hangar" section:
      "showBuyPremiumButton" - show "Buy premium" button
      "showPremiumShopButton" - show "Premium shop" button
      "crewMaxPerksCount" - number of perks to show without grouping
  * fixed {{v.elite}} macro in the carousel
  * added new options in the "carousel"/"normal"/"fields" and "carousel"/"small"/"fields" sections:
      "flag" - nation flag
      "tankIcon" - vehicle icon

  [MISC]
  * fixed "minimapDeadSwitch" option
  * added global macros:
      {{my-clan}} - my clan
```
______________________________

### XVM 6.4.6.2
```
  * fixed initial minimap size restoring
```
______________________________

### XVM 6.4.6.1
```
  * fixed development version notification
```
______________________________

### XVM 6.4.6
```
  * adaptation to WoT 0.9.16
  * fixed WorldOfTanks mods compatibility with Microsoft Windows NT 5.x (XP, XP 64-bit, Server 2003)
  * added default value for "carousel"/"rows" option: 0 - use client settings
  * added new options in the "carousel" section:
      "cellType" - type of cells - "default" (depends from window size), "normal" or "small"
  * added new sections in the "carousel" section:
      "normal" - normal cells settings
      "small" - small cells settings
  * sections "padding", "fields" and "extra-fields" moved from "carousel" to
    "carousel"/"normal" and "carousel"/"small" sections to allow separate settings
  * added new options in the "carousel"/"normal" and "carousel"/"small" sections:
      "width" - cell width
      "height" - cell height
  * option "carousel"/"zoom" removed ("width" and "height" allow to do the same)
  * section "padding" replaced with option "gap"
  * created separate files for carousel cell types: "carouselNormal.xc", "carouselSmall.xc"
  * battleLabels: added events:
      PY(event_name)  - event from python, sent by as_event(event_name)

  [KNOWN ISSUES]
  * The module disabled by default: Extra sounds settings. (will be reprocessed in future releases)
```
______________________________

### XVM 6.4.5.1
```
  * fix client crash when "minimap"/"circles"/"special" section is not empty
```
______________________________

### XVM 6.4.5
```
  * circles on the minimap implemented
  * renamed option in the "minimap" and "minimapAlt" sections (with inverted values):
      "useStandardCircles" -> "circlesEnabled"
      "useStandardLabels" -> "labelsEnabled"
      "useStandardLines" -> "linesEnabled"
  * added option "statisticForm"/"removePlayerStatusIcon" - disable player status icon
```
______________________________

### XVM 6.4.4
```
  * lines on the minimap implemented (circles are not yet)
```
______________________________

### XVM 6.4.3
```
  * adaptation to WoT 0.9.15.2
  * labels on the minimap implemented (circles and lines are not yet)
  * added new elements in sections "battleLabels" and "battleLabelsTemplates":
      "avgDamage" - avg damage on current vehicle
      "mainGun" - threshold necessary for achievements "High caliber"
  * added options in the "minimap" and "minimapAlt" sections:
      "selfIconScale" - self icon scale
      "directionTriangleAlpha" - camera direction green triangle transparency
      "directionLineAlpha" - standard camera direction line transparency
      "zoom"/"index" - zoom index value for minimap zoom key
  * removed options in the "minimap" and "minimapAlt" sections:
      "hideCameraTriangle"
      "cameraAlpha"
      "zoom"/"pixelsBack"
  * renamed options in the "minimap" and "minimapAlt" sections:
      "showCameraLineAfterDeath" => "showDirectionLineAfterDeath"
  * extra-fields alignment options behavior changed:
      "align"               - horizontal alignment of the text field relative to its position
      "valign"              - vertical alignment of the text field relative to its position
      "textFormat"/"align"  - horizontal alignment of the text inside the field
      "textFormat"/"valign" - vertical alignment of the text inside the field
  * added options in the "playersPanel" modes sections:
      "squadIconAlpha" - transparency of the squad icon
```
______________________________

### XVM 6.4.2.1
```
  * fix Alt mode in the standard markers
```
______________________________

### XVM 6.4.2
```
  * added options in the "playersPanel" modes sections:
      "fragsShadowLeft", "fragsShadowRight" - shadow for frags field
      "nickShadowLeft", "nickShadowRight" - shadow for player name field
      "vehicleShadowLeft", "vehicleShadowRight" - shadow for vehicle name field
      "fixedPosition" - true - don't change players positions on dead (default false)
  * added options in the "playersPanel"/"none" mode:
      "inviteIndicatorAlpha" - opacity of dynamic squad invite indicator
      "inviteIndicatorX" - X position offset of dynamic squad invite indicator
      "inviteIndicatorY" - Y position offset of dynamic squad invite indicator
  * ping: fixed a memory leak on old Windows versions if ping in hangar was enabled
  * ping: no longer requires additional configuration to work under Wine
  * battleLoading: extra-fields added
  * battleLabels: added events:
      ON_DAMAGE_CAUSED_ALLY - damage to ally
      ON_TARGET_IN  - aim at the vehicle
      ON_TARGET_OUT - aim not at the vehicle
      ON_PANEL_MODE_CHANGED
      ON_EVERY_FRAME           * can reduce performance
      ON_EVERY_SECOND          * can reduce performance
  * added global macros:
      {{pp.mode}}       - current players panel mode (0-none, 1-small, 2-medium, 3-medium2, 4-large)
      {{pp.widthLeft}}  - current left players panel width
      {{pp.widthRight}} - current right players panel width
```
______________________________

### XVM 6.4.1.1
```
  * fix minimap (Only compatibility. Extended functionality not implemented yet.)
```
______________________________

### XVM 6.4.1
```
  * adaptation to WoT 0.9.15.1.1
  * some bugs fixed
  * statisticForm: extra-fields added
  * carousel: restored multi rows
  * carousel: added sorting on "markOfMastery", "xtdb", "xte", "damageRating" and "marksOnGun"
  * added option in "battleLoading" and "statisticForm" sections:
      "vehicleIconAlpha" - opacity percentage of vehicle icon
  * added macros:
      {{allyStrengthStatic}} - ally team strength (static)
      {{enemyStrengthStatic}} - enemy team strength (static)
      {{allyStrengthLive}} - ally team strength (live)
      {{enemyStrengthLive}} - enemy team strength (live)
```
______________________________

### XVM 6.4.0
```
  * adaptation to WoT 0.9.15.1
  * complete refactoring of battle mods (AS2->AS3 migration)
  * markers and hitlog: shadow parameter "size" renamed to "blur"
    now all shadow sections have standard parameters:
      "enabled", "distance", "angle", "color", "alpha", "blur", "strength"
  * renamed parameters:
      "playersPanel"/"medium"/"formatLeft" => "playersPanel"/"medium"/"nickFormatLeft"
      "playersPanel"/"medium"/"formatRight" => "playersPanel"/"medium"/"nickFormatRight"
      "playersPanel"/"medium2"/"formatLeft" => "playersPanel"/"medium2"/"vehicleFormatLeft"
      "playersPanel"/"medium2"/"formatRight" => "playersPanel"/"medium2"/"vehicleFormatRight"
      "camera"/"arcade"/"dynamicCameraEnabled" => "camera"/"arcade"/"shotRecoilEffect"
      "camera"/"postmortem"/"dynamicCameraEnabled" => "camera"/"postmortem"/"shotRecoilEffect"
      "camera"/"strategic"/"dynamicCameraEnabled" => "camera"/"strategic"/"shotRecoilEffect"
      "camera"/"sniper"/"dynamicCameraEnabled" => "camera"/"sniper"/"shotRecoilEffect"
  * removed parameters (not required):
      "battle"/"allowSpottedStatus"
      "battle"/"allowHpInPanelsAndMinimap"
      "battle"/"allowMarksOnGunInPanelsAndMinimap"
      "carousel"/"alwaysShowFilters"
  * renamed parameters in the "iconset" section and changed value from folder to atlas name:
      "playersPanelAlly" => "playersPanelLeftAtlas"
      "playersPanelEnemy" => "playersPanelRightAtlas"
      "statisticFormAlly" => "fullStatsLeftAtlas"
      "statisticFormEnemy" => "fullStatsRightAtlas"
      "vehicleMarkerAlly" => "vehicleMarkerAllyAtlas"
      "vehicleMarkerEnemy" => "vehicleMarkerEnemyAtlas"
  * added macro {{clanicon}} with clan embled image path value
  * removed "clanIcon" section in the "battleLoading", "battleLoadingTips", "statisticForm" and "playersPanel" sections
    and in the markers
  * added options in all modes in the "playersPanel" section:
      "standardFields" - displayed standard fields in this mode and their order.
                         available names: "frags", "vehicle", "nick".
      "fragsWidth" - width of the frags column
      "vehicleWidth" - width of the vehicle name column
      "nickMinWidth" - minimum width of the player's name column
      "nickMaxWidth" - maximum width of the player's name column
      "expandAreaWidth" - width of area for switching to "large" mode on mouse over
      "vehicleIconXOffsetLeft" - offset of X value for vehicle icon for left side
      "vehicleIconXOffsetRight" - offset of X value for vehicle icon for right side
      "vehicleLevelXOffsetLeft" - offset of X value for vehicle level for left side
      "vehicleLevelXOffsetRight" - offset of X value for vehicle level for right side
      "fragsXOffsetLeft" - offset of X value for frags column for left side
      "fragsXOffsetRight" - offset of X value for frags column for right side
      "nickXOffsetLeft" - offset of X value for player name column for left side
      "nickXOffsetRight" - offset of X value for player name column for right side
      "vehicleXOffsetLeft" - offset of X value for vehicle name column for left side
      "vehicleXOffsetRight" - offset of X value for vehicle name column for right side
  * removed options in the "playersPanel" section:
      "short"/"width"
      "medium"/"width"
      "medium2"/"width"
      "large"/"width"
  * camera zoom indicator implemented as extra field with all its options
  * clock is using php format (http://php.net/date)
  * global macros, including {{py:f()}}, can be used in the "battle"/"elements" section
  * changed "carousel"/"scrollingSpeed" value, now it is multiplier for default scrolling rate
  * option "markers"/"useStandardMarkers" renamed to "markers"/"enabled"
  * option "markers"/*/"vehicleIcon"/"scaleX" renamed to "offsetX"
  * option "markers"/*/"vehicleIcon"/"scaleY" renamed to "offsetY"
  * default value for "vehicleIcon"/"offsetY" changed fro 16 to 0
  * config format of the text fields in markers and battleLabels are changed to
    common extra-fields config format
  * option "visible" everywhere changed to "enabled" for unification
  * removed option "hotkeys"/"battleLabelsHotKeys" - not required
  * removed option "battle"/"allowLabelsOnBattleInterface" - not required
  * changed anchor for "bindToIcon" option in the extra-fields
  * changed hitlog macros - added "hitlog." prefix (see macros.txt)
  * removed "hpLeft" section - use {{hp*}} macros
  * added {{comment}} macro to show comment for player from contacts
  * added option "battle"/"sixthSenseDuration" - duration of the sixth sense indicator
  * removed option "hitLog"/"direction" - not required

  [KNOWN ISSUES]
  * minimap is not ready. Some functionality may work incorrectly or may not work at all. (will be fixed in future releases)
  * option "carousel"/"rows" does not implemented. (postponed because it may be implemented by WG)
  * some functionality may work incorrectly with "autoReloadConfig": true
  * service record: List of tanks may scroll to the middle in some configurations
```
______________________________

### XVM 6.3.2.1
```
  * fix for 6th sense sound
  * fix for tank carousel filters
```
______________________________

### XVM 6.3.2
```
  * update for WoT 0.9.15.0.1 micropatch
  * changed "shadow"/"alpha" parameter values range from 0..1 to 0..100 in the carousel
    and players panel extra-fields
```
______________________________

### XVM 6.3.1.1
```
  * update for WoT 0.9.15 #30 micropatch
  * added option "tooltips"/"hideSimplifiedVehParams" - hide simplified vehicle parameters
  * tooltips:
      added parameters:
        "invisibilityStillFactor" - Concealment of Stationary Vehicle (%)
        "invisibilityMovingFactor" - Concealment of Moving Vehicle (%)
      removed parameter:
        "camo_coeff"
```
______________________________

### XVM 6.3.1
```
  * bug fixes
  * total hp indicator implemented using battleLabels and py_macro
  * py_macro: changed export definition:
      was: @xvm.export('xvm', 'xvm2sup')
      now: @xvm.export('xvm.xvm2sup')
  * py_macro: add 'deterministic' argument to export definition to mark function as
      deterministic or not (default: deterministic=True)
  * carousel filters reworked

  [FIXES]
  * fixed "useStandardLabels" option

  [CONFIG]
  * removed options:
      "minimap"/"circles"/"enabled" - duplicates "minimap"/"useStandardCircles"
      "minimap"/"lines"/"enabled"   - duplicates "minimap"/"useStandardLabels"
      "minimap"/"labels"/"enabled"  - duplicates "minimap"/"useStandardLines"
  * moved color settings option for total hp indicator:
      "battle"/"totalHP"/"colors" > "colors"/"totalHP"
  * removed obsolete config section "battle"/"totalHP"
```
______________________________

### XVM 6.3.0
```
  * adaptation to WoT 0.9.15

  [MAJOR UPDATES]
  * added new type of macro - dynamic macros calculated in the python:
    python functions are loaded from res_mods/configs/py_macro/*.py with decorator @xvm.export(a, b)
    E.g. get %SUP for xTE:
      {{py:xvm.xvm2sup('{{xte}}')|==}}
    res_mods/configs/py_macro/xvm.py:
        xvm2sup = [...]
        @xvm.export('xvm', 'xvm2sup')
        def XvmScaleToSup(x=None):
            if x is None or x == '':
                return None
            x = 100 if x == 'XX' else int(x)
            return xvm2sup[max(0, min(100, x-1))]
  * config section "captureBar" completely reworked, without backward compatibility
  * capture bar macros names was changed, formatting possibilities added

  [CONFIG]
  * removed option "camera"/"noScroll" - implemented in client
  * removed option "login"/"skipIntro" - implemented in client
  * new options "sounds"/"xvm_battleEnd_*" - sound notifications informing about the imminent end of the battle
  * new config file "xmqp.xc" for XMQP services settings

  [XMQP]
  * accurate minimap cell clicks
```
______________________________

### XVM 6.2.2
```
  [MAJOR UPDATES]
  * added new sections "battleLabels", "battleLabelsTemplates" for custom labels on battle interface window
  * new xmqp feature for exchanging data between players (experimental):
    new macros:
      {{x-enabled}} - player have xmqp service enabled
      {{x-sense-on}} - player studied "sixth sense" perk
      {{x-spotted}} - player vehicle is spotted
      {{x-fire}} - fire in vehicle
      {{x-overturned}} - player vehicle is overturned
      {{x-drowning}} - player vehicle is drowning

  [CONFIG]
  * added option "battle"/"allowLabelsOnBattleInterface" - enable custom labels on battle interface window
  * added option "hotkeys"/"battleLabelsHotKeys" - use hotkeys in custom labels on battle interface window

  [MACROS]
  * added macros {{chancesStatic}} - win chances at battle (static)
  * added macros {{chancesLive}} - win chances at battle (live)
```
______________________________

### XVM 6.2.1.2
```
  * adaptation to WoT 0.9.14.1
  * added option "camera"/"startZoom" - start zoom value (null for default behavior - last used zoom)
  * added macros {{xtdb}}, {{c:xtdb}}, {{a:xtdb}}, {{v.xtdb}}, {{v.c_xtdb}} - average damage in XVM Scale
```
______________________________

### XVM 6.2.1.1
```
  * improvements and bug fixes
  * show %SUP for xTE in the profile window
  * section "sounds" completely refactored
  * added section "battle"/"totalHP"
  * added option "enabled" in the minimap label settings with global macros support
```
______________________________

### XVM 6.2.1
```
  * adaptation to WoT 0.9.14
  * macro {{cellsize}} can be used in like other global macros
  * added new options:
      "minimap"/"useStandardCircles" - use standard circles
      "minimap"/"useStandardLabels" - use standard labels
      "minimap"/"useStandardLines" - use standard lines
      "tooltips"/"fontSize" - size of the font in vehicle tooltips
      "tooltips"/"fontName" - name of the font in vehicle tooltips
      "tooltips"/"goldColor" - color for premium shells etc. in vehicle tooltips
  * added new section "battleLoadingTips" for new battle loading screen views
  * added new options in the "battleLoading" and "battleLoadingTips" sections:
      "nameFieldShowBorder" - show border for name field (useful for config tuning)
      "vehicleFieldShowBorder" - show border for vehicle field (useful for config tuning)
      "nameFieldWidthDeltaLeft" - width delta for allies player names field
      "nameFieldWidthDeltaRight" - width delta for enemies player names field
      "vehicleFieldWidthDeltaLeft" - width delta for "formatLeftVehicle" field
      "vehicleFieldWidthDeltaRight" - width delta for "formatRightVehicle" field
  * added new options in the "statisticForm" section:
      "nameFieldShowBorder" - show border for name field (useful for config tuning)
      "vehicleFieldShowBorder" - show border for vehicle field (useful for config tuning)
      "fragsFieldShowBorder" - show border for frags field (useful for config tuning)
  * removed obsolete option:
      "userInfo"/"showExtraDataInProfile"
  * ping/online: minimalLength is renamed to minimalValueLength, added minimalNameLength
```
______________________________

### XVM 6.2.0.1
```
  * improvements and bug fixes
  * added options:
      "hangar"/"pingServers"/"ignoredServers" - list of ignored servers for ping in hangar
      "hangar"/"onlineServers"/"ignoredServers" - list of ignored servers for online in hangar
      "hangar"/"carousel"/"showUsedSlots" - show used slots count in the "Buy slot" cell
      "hangar"/"carousel"/"showTotalSlots" - show total slots count in the "Buy tank" cell
```
______________________________

### XVM 6.2.0
```
  * adaptation to WoT 0.9.13
  * XVM API 4.0
  * added options:
      "battle"/"camera"/"noScroll" - disable switching to sniper mode by mouse wheel
      "battle"/"camera"/"<mode>"/"dynamicCameraEnabled" - enable/disable dynamic camera
      "battle"/"minimapDeadSwitch" - switching between players on the minimap after death
```
______________________________

### XVM 6.1.6.1
```
  * removed minimap square
  * added global macros:
      {{my-veh-id}}, {{my-vehicle}}, {{my-vehiclename}}, {{my-vehicle-short}}, {{my-vtype}},
      {{my-vtype-l}}, {{my-vtype-key}}, {{c:my-vtype}}, {{my-battletier-min}},
      {{my-battletier-max}}, {{my-nation}}, {{my-level}}, {{my-rlevel}}
  * allow global macros usage in the minimap circles and lines
  * added config section "battle"/"camera" for camera settings (zoom)
  * new option "sounds"/"sixthSenseRudy" - sixth sense sound for Rudy
  * bugs fixed
```
______________________________

### XVM 6.1.6
```
  * adaptation to WoT 0.9.12
  * added options:
      "carousel"/"scrollingSpeed" - carousel scrolling speed
      "carousel"/"backgroundAlpha" - background transparency
```
______________________________

### XVM 6.1.5
```
  * minimap label settings was completely reworked. See minimapLabels.xc file.
  * "mapSize" config section moved to the root of the "minimap" and "minimapAlt" sections
  * "revealed" renamed to "spotted" everywhere
  * added option "minimap"/"iconAlpha" - vehicle type icons transparency on minimap
  * added macros:
      {{vtype-key}}     - vehicle type table key value
      {{sys-color-key}} - key value for system color table
    these macros can be useful in conjunction with {{.}} macro
  * increased config version to 6.1.0
  * personal missions: added "Incomplete" filter (Started + Improve)
```
______________________________

### XVM 6.1.4.3
```
  * fixed displaying of current base in the capture bar
  * fixed displaying of dynamic squads on the minimap and vehicle markers
```
______________________________

### XVM 6.1.4.2
```
  * update for WoT minipatch
```
______________________________

### XVM 6.1.4.1
```
  * bug fixes and optimization
  * new options:
      "sounds"/"fireAlert" - fire alarm sound
      "sounds"/"ammoBay" - alarm sound after ammo bay is damaged
```
______________________________

### XVM 6.1.4
```
  * adaptation to WoT 0.9.10
  * carousel: added sorting on "winRate"
  * removed obsoleted option "fragCorrelation"/"sortByType"
  * added options in "battleLoading" and "statisticForm" sections:
      "removeVehicleLevel" - disable vehicle level indicator.
      "removeVehicleTypeIcon" - disable vehicle type icon. This space will be used for vehicle field.
      "squadIconOffsetXLeft" - X offset for allies squad icons
      "squadIconOffsetXRight" - X offset for enemies squad icons field
      "nameFieldOffsetXLeft" - X offset for allies player names field
      "nameFieldOffsetXRight" - X offset for enemies player names field
      "vehicleFieldOffsetXLeft" - X offset for allies vehicle names field
      "vehicleFieldOffsetXRight" - X offset for enemies vehicle names field
      "vehicleIconOffsetXLeft" - X offset for allies vehicle icons
      "vehicleIconOffsetXRight" - X offset for enemies vehicle icons
  * added section "carousel"/"filtersPadding" - spacing between filters cells.
  * added options:
      "hangar"/"barracksShowFlags" - show flags in barracks
      "hangar"/"barracksShowSkills" - show skills in barracks
  * in players panel modes added option "vehicleLevelAlpha" - transparency of vehicle level
```
______________________________

### XVM 6.1.3.1
```
  * bug fixes and optimization
  * xvm_online and xvm_ping: minimalLength now expands the value length
  * xvm_squad: showing min and max battle tier for squad
  * xvm_contacts: tooltips uses native form
  * new options:
      "tooltips"/"tooltipsDelay" - delay in tooltips appearance
      in hangar and login, for pingServers and onlineServers added:
          "serverColor" - color for server name and delimiter
          "errorString" - text to show in case of error
      "hangar"/"serverInfo"/"shiftY" - shift Y position of server info
```
______________________________

### XVM 6.1.3
```
  * adaptation to WoT 0.9.9
  * new feature: similar to servers ping, added servers online (login page and hangar)
  * new feature: mark tanks as "reserve", it will be hidden unless set in filters
  * renamed config option: blockVehicleIfNoAmmo -> blockVehicleIfLowAmmo
  * new options:
      "hangar"/"lowAmmoPercentage" - Below this percentage ammo is low. (0 - 100)
      in hangar and login, for pingServers and onlineServers added:
          "hAlign", "vAlign" - horizontal and vertical alignments
          "showTitle" - show title of list
          "showServerName" - show server names in list
          "minimalLength" - expand each field to this amount of symbols (for example: "US East:     12345")
          "markCurrentServer" - mark current server in the list (not available at login screen)
      "battle"/"fragCorrelation"/"sortByType" - sort markers in frags panel by type
```
______________________________

### XVM 6.1.2.3
```
  * update for WoT 0.9.8.1 #62
  * fixed battle results window
```
______________________________

### XVM 6.1.2.1
```
  * added new filter to the tank carousel: remove "domination"
  * personal missions: added "Hide with honors" and "Started" filters and saving filter settings
  * bugs fixed
  * performance optimization
```
______________________________

### XVM 6.1.2
```
  * adaptation to WoT 0.9.8.1
  * config loading refactoring
  * new options:
      "crewReturnByDefault" - return crew check box is selected by default
      "enableEquipAutoReturn" - removable equipment auto-return (Camouflage net, Stereoscope, Toolbox)
      "minimap"/"showCameraLineAfterDeath" - show camera line after death
      "minimap"/"minimapAimIcon" - path to icon for arty aim
      "hangar"/"blockVehicleIfNoAmmo" - make vehicle not ready for battle if less than 20% ammo loaded
      "minimap"/"minimapAimIconScale" - scale factor for the minimap aim icon
  * option "playersPanel"/"removeSquadIcon" moved into panel mode settings (sections "short", "medium", "medium2", "large")
  * removed obsoleted option "fragCorrelation"/"hideTeamTextFields"
```
______________________________

### XVM 6.1.1.1
```
  * added embedded fonts 'dynamic' and 'dynamic2' with various indicators
  * added crew auto-return for Stronghold/Team Battles vehicle selections
  * localization files were updated
```
______________________________

### XVM 6.1.1
```
  * in extra-fields in the players panels added "enabled" parameter with global macros support
  * added section hangar/serverInfo for changing server info visibility
  * added parameters in carousel config: fields/statusText and fields/clanLock
  * performance optimization and some bugfixes
  * added macros {{xr}}, {{c:xr}}, {{a:xr}} - same as {{r}} but always in XVM Scale
  * new option:
      "suppressCarouselTooltips" - suppress the tooltips in carousel
  * macro {{language}} renamed to {{flag}}, flags images folder renamed from "lang" to "flags"
  * added embedded font 'vtype' with vehicle types symbols
```
______________________________

### XVM 6.1.0.1
```
  * added new section in config sounds.xc, where you can setup extra sounds
  * bugs fixed
  * added some languages in the personal cabinet
  * new option:
      "showAliveNotFrags" - show quantity of alive instead of dead in frags panel. Original idea/code by yaotzinv: http://koreanrandom.com/forum/topic/18671-/
  * added sorting criterion for carusel: premium
  * changing status of gold/free exp locks updates their availability in open windows
  * in hangar tooltips added elevation arc limits for side and rear directions of the tank
```
______________________________

### XVM 6.1.0
```
  * adaptation to WoT 0.9.7
  * XFW-3.0.0
  * per-vehicle rating (xTE) enabled ({{xte}}, {{c:xte}}, {{a:xte}} macros)
  * new carousel macros {{v.xte}} and {{v.c_xte}} for per-vehicle rating
  * new option "userInfo"/"showXTEColumn" - Show xTE column in the vehicle list
  * added new section in config tooltips.xc, where you can choose desired tooltips for each type of vehicle
  * in tank tooltips added feature of custom text and camo coefficients data
  * in barracks added nation flag for tanksman and their skills
  * added embedded fonts: 'xvm' (symbol) and 'mono' (monospace), recommended for default use
  * new options:
      "enableGoldLocker" - enable locker for gold
      "enableFreeXpLocker" - enable locker for free XP
      "defaultBoughtForCredits" - Use credits instead of gold as default currency for ammo and equipment
      "combineIcons" - in tank tooltips combine icons of equipment and optional modules
      "hideBottomText" - in tank tooltips hide text at bottom showing quantity of used equipment etc.
  * new macro {{.}} for config value substitution: {{.path.to.config.value}}
      ex. {{.language}}, {{.def.mycolors.ally}}
  * new macro {{ally}} returns 'ally' for ally team and empty for enemy team
  * new macro {{nation}} returns vehicle nation
  * added new feature of sorting tanks in carousel from config (carousel.xc)
  * in battle, in HE tooltip added explosion radius
  * option "hangar"/"autoPutPreviousCrewInTanks" renamed to "hangar"/"enableCrewAutoReturn"
  * when "enableCrewAutoReturn" enabled, the checkbox is shown in the hangar for enabling/disabling
    crew auto return. Checkbox settings are stored for each tank separately.
  * added macros {{r}}, {{c:r}}, {{a:r}} - player's rating
    (type of rating can be selected in the personal cabinet: https://modxvm.com/)
  * added macro {{r_size}} - size of the {{r}} macro value (can be useful for fields formatting)
  * macros renamed:
      {{rating}} => {{winrate}}
      {{t-rating}} => {{t-winrate}}
  * colors and alpha sections renamed: "rating" => "winrate"
```
______________________________

### XVM 6.0.2
```
  * new option "hangar"/"autoPutPreviousCrewInTanks" - automatically put previous crew upon vehicle change in hangar
  * added global macro {{my-frags}}
```
______________________________

### XVM 6.0.1
```
  * added new macro {{battletype}} - current battle type
  * added "texts"/"battletype" section with text replacements for {{battletype}} macro
  * added "texts"/"topclan" section with text replacements for {{topclan}} macro
  * added new carousel macros:
      {{v.xpToElite}} - XP required for elite vehicle
      {{v.xpToEliteLeft}} - XP left to gain for elite vehicle
      {{v.freeXP}} - free XP
  * macros formatting:
      added "'" flag for thousands separator (hangar only)
      added "match" part for value matching ({{battletype=clan?CLAN WAR}})
        allowed operators: =, !=, >, >=, <, <=
  * added option "minimap"/"labels"/"units"/"antiAliasType" - text fields antialias type.
  * new option "battle"/"allowSpottedStatus" - enable {{spotted}} macro in players panels and minimap.
    WARNING: performance expensive
  * new option "hangar"/"allowExchangeXPInTechTree" - consider the exchange of experience with gold in tech tree
  * new option "battle"/"sixthSenseIcon" - path to sixth sense icon ("" for original icon).
```
______________________________

### XVM 6.0.0.3
```
  * bugs fixed
```
______________________________

### XVM 6.0.0
```
  * adaptation to Wot 0.9.6
  * XFW: XVM Framework
  * new mod xvm_quests for personal missions.
    currently implemented new filters and saving filters settings
  * added config section for winChance colors: "colors"/"winChance"
  * win chance calclulation changed - use standard normal distrubution for chance result.
    source: http://forum.worldoftanks.eu/index.php?/topic/468409-/
  * added "texts"/"xvmuser" section with text replacements for {{xvm-user}} macro.
    available values: "on", "off", "none".
  * added new mod xvm_export, and config section "export".
  * top clans icons now taken from the XVM server and tops list is updated daily.
  * added macro {{clanrank}} - Global map clan rating
    values from 1 to 1000, and "persist" for persistent clans (WG administration and XVM friends)
    detailed info: http://worldoftanks.eu/leaderboard/clans/
  * added macro {{topclan}} - returns "top" for top clans, 'persist' for persistent clans, empty for other
```
______________________________

### XVM 5.5.1.1
```
  * fixed Application.swf
```
______________________________

### XVM 5.5.1
```
  * added new macros:
      {{xvm-user}} - value 'on' for XVM users with stat in battle enabled,
        value 'off' for XVM users with stat in battle disabled, else empty
  * bugs fixed
```
______________________________

### XVM 5.5.0
```
  * adaptation to Wot 0.9.5
  * macro in macro allowed: {{xvm-stat?{{alive?80|30}}|0}}
  * added texts/spotted section with text replacements for vehicle spotted status.
    available values:
      for usual vehicle: "neverSeen", "lost", "revealed", "dead"
      for arty: "neverSeen_arty", "lost_arty", "revealed_arty", "dead_arty"
  * added new macros:
      {{language}} - player's client language
      {{region}} - current game region (RU, EU, NA, ASIA, KR, CN, CT)
      {{spotted}} with values from texts/spotted section
      {{c:spotted}}, {{a:spotted}} for color and transparency by spotted status
  * removed section "playersPanel"/"enemySpottedMarker" (use extra-fields with {{spotted}} macro instead)
  * added new option to extra-fields: "bindToIcon" - if enabled, x position is bound to vehicle icon (default false)
```
______________________________

### XVM 5.4.1.3
```
  * new in-battle macros:
      {{selected}} - value 'sel' for selected player, empty for others
      {{xvm-stat}} - value 'stat' is statistic is active, empty if not
      {{position}} - position of the player in the beginning of the battle (1-15)
  * added individual system colors for bases:
      "colors"/"system"/"ally_base" and "colors"/"system"/"enemy_base"
  * added option "playersPanel"/"removeSelectedBackground" - disable background of the selected player
  * added option "autoReloadConfig" - monitor res_mods/xvm/configs/ directory for changes and
    automatically reload config (currently only in hangar). Disabled by default, can reduce performance.
```
______________________________

### XVM 5.4.1.2
```
  * fixed small bugs
  * show capturing base number for battles with more then one base
    WARNING: There are changes in the localization files
  * added option "minimap"/"hideCameraTriangle" - hide camera direction green triangle
```
______________________________

### XVM 5.4.1.1
```
  * fixed bug with online services activation
```
______________________________

### XVM 5.4.1
```
  * adaptation to Wot 0.9.4
```
______________________________

### XVM 5.4.0.2
```
  * fixed bug with online services setting
```
______________________________

### XVM 5.4.0
```
  * new mod: xvm-comments, allow to change nicks of the friends and add comments.
  * removed section "rating" - replaced with network services settings in the personal cabinet
  * removed options "showChances", "showChancesLive" - moved to personal cabinet
  * changed token location, now it is stored in the user preferences:
      %APPDATA%\Wargaming.net\WorldOfTanks\xvm\
    You need to reactivate XVM services (use "Add client" button in the personal cabinet on the
    https://modxvm.com site). You can remove res_mods/xvm/db/ folder.
  * added option "battleLoading"/"darkenNotReadyIcon" for customize icons are not ready players
  * added options "pingServers"/"leading" and "pingServers"/"topmost"
  * carousel: added macro {{v.selected}}, returns 'sel' for selected, empty for others
  * playersPanel: in extra-fields added options "scaleX" and "scaleY"
```
______________________________

### XVM 5.3.6.1
```
  * fixed bug when xvm.xc is absent
```
______________________________

### XVM 5.3.6
```
  * many bugs fixed
  * macro {{gun-marks}} changed to {{marksOnGun}}, section "gunmarks" changed to "marksOnGun",
    option "allowGunMarksInPanelsAndMinimap" changed "allowMarksOnGunInPanelsAndMinimap"
    for unification
  * changed macro value: {{v.hitsRatio}} is in percents now
  * added macro {{v.c_hitsRatio}} and colors section "hitsRatio"
  * added macro {{v.c_damageRating}} and colors section "damageRating"
  * added option "onHold" to the hotkeys settings for alternative minimap and players panel mode
  * added option "hangar"/"clock"/"bgImage" for background image in clock
  * macros {{alive}}, {{ready}}, {{player}}, {{tk}}, {{squad}}, {{squad-num}}, {{hp-max}} works in the
    battle loading screen
```
______________________________

### XVM 5.3.5
```
  * adaptation to WoT 0.9.3
  * dmg-kind values changed:
      shot, fire, ramming, world_collision, death_zone, drowning, other
  * new sections:
      "hangar"/"carousel" - extended tank carousel settings
      "hangar"/"clock" - hangar clock settings
  * removed options:
      "hangar"/"masteryMarkInCarousel"
      "hangar"/"hideTutorial"
  * new options:
      "battleResults"/"showTotalExperience" - Display total experience in After Battle Screen
      "battleResults"/"showCrewExperience" - Display crew experience in After Battle Screen
  * player icon by accountId - loading from \res_mods\xvm\res\clanicons\ID\
    Search order is:
      id -> nick -> clan -> clan/default.png -> nick/default.png
```
______________________________

### XVM 5.3.4
```
  * new macros:
      {{ready}}, returns "ready" when player loaded to the game and empty if not
      {{gun-marks}}, return count of the marks on gun for spotted vehicles
  * new option "battle"/"allowGunMarksInPanelsAndMinimap" - enable {{gun-marks}}
    macro in players panels and minimap. WARNING: performance expensive
  * added "texts"/"gunMarks" config section
  * added ability to disable some modes in the players panels
  * new section "minimapAlt" for alternative minimap mode (disabled by default)
  * localization:
      added {{l10n:Not ready}}
  * "hotkeys" section updated:
      - added key bindings for minimap and players panel alt mode
      - full keyboard can be used
      ATTENTION: key codes were changed
  * disabled color fogging of {{c:*}} macros for dead vehicles
    use {{alive}} macro with alpha:
      <font color='{{c:xwn}}' alpha='{{alive?#FF|#80}}'>{{xwn}}</font>
  * section turretMarkers moved to "markers"/"turretMarkers"
```
______________________________

### XVM 5.3.3
```
  * adaptation to WoT 0.9.2
  * new macros:
      {{player}}, returns "pl" for current player and empty string for others
      {{tk}}, returns "tk" for teamkiller and empty string for others
      {{wgr}}, {{c:wgr}}, {{a:wgr}}, {{xwgr}}, {{c:xwgr}}, {{a:xwgr}} for WG rating
  * macros extended:
      {{l10n:<id>}} now works in PlayersPanel
  * new option:
      "playersPanel"/"altMode" - mode with Alt key pressed
  * localization:
      added {{l10n:Destroyed}} and {{l10n:No data}}
```
______________________________

### XVM 5.3.2
```
  * new options: "captureBar"/"allyColor", "captureBar"/"enemyColor"
```
______________________________

### XVM 5.3.1
```
  * adaptation to WoT 0.9.1
  * show actual view range, gun reload time and signal range in the tank params in hangar
```
______________________________

### XVM 5.3.0
```
  [MAJOR UPDATES]
  * new macros formatting (see readme-en.txt)
      {{name[%[flag][width][.prec]type][~suf][|def]}}
      name  - macro name
      flag  - "-" for left align, else right align
              "0" for filling with leading zeros
      width - minimum width
      prec  - maximum width for lines or number of digits after comma for numbers
      type  - type (s - string, d - decimal, f - float, ...)
      suf   - suffix added at the end
      def   - default value, set when value is absent:
    details: http://en.wikipedia.org/wiki/Printf
    for example:
      {{name%-16.16s}}      - cut names longer 10 chars, and fill names shorter 10 chars and align left
      {{kb%4.01f~k|----}}   - width 4 chars, exactly 1 char after comma, align right
                              if kb==null, display "----"
  * config version increased to 5.1.0

  [NEW FUNCTIONS]
  * dynamic circles on the minimap. Options:
      "minimap"/"circles"/"artillery" - maximum range of fire for artillery
      "minimap"/"circles"/"shell" - maximum range of shooting for autocannon and semi-automatic cannon
      "minimap"/"circles"/"view" - view range (dynamically changes when switching binocular telescope)
      "minimap"/"circles"/"major" - removed, replaced with "view" section
    Omegaice's code was used for this component
  * new options in "playersPanel" for extra text fields
  * new options in "playersPanel" for frags formatting
  * new option "playersPanel"/"startMode" for initial players panels mode
  * new option "battle"/allowHpInPanelsAndMinimap" - enable {{hp}}, {{hp-ratio}}, {{hp-max}}
    macros in players panels and minimap. WARNING: performance expensive

  [MACROS]
  * new macros:
      {{frags}} - current frags
      {{alive}} - 'alive' for alive, '' for dead
      {{battletier}} - guessed current battle tier
      {{squad-num}} - squad number or null if not in squad
  * macros extended: {{hp:XX}} and {{hp-max:XX}} return value normalized to XX for current battle tier
    ex.: {{hp:300}} - will return 300 for HP=700 at tier-5 battle, and for HP=3000 at tier-11 battle.
  * macros extended: value replacement - {{macro?rep}}
    ex.: "alpha": "{{alive?80|0}}" - set alpha to 80 for alive and 0 for dead
  * changed value of macro {{squad}} from '1' to 'sq'
  * removed macro {{vehicle-type}} as duplication of {{vehicle}}
  * removed macro {{vehicle-name}} as duplication of {{vehiclename}}
  * removed macro {{short-nick}} and option "minimap"/"nickShrink" as replaced by {{nick%.5s}}

  [OTHER]
  * source code now stored on http://dev.modxvm.com/
```
______________________________

### XVM 5.2.1
```
  * adaptation to WoT 0.9.0

  [NEW FUNCTIONS]
  * new option "login"/"saveLastServer" - save last server (disabled by default)
  * localization: New rules for localization submission. Details: https://code.google.com/p/wot-xvm/wiki/LocalizingXVM

  [FIXES]
  * players panels was not shown after battle loading
  * fixed displaying of elements on minimap
```
______________________________

### XVM 5.2.0
```
  [MAJOR UPDATES]
  * main config file (xvm.xc) moved to res_mods/xvm/configs
  * statistics must be enabled in the personal cabinet on the https://modxvm.com/ site

  [NEW FUNCTIONS]
  * localization: added Chinese (Simplified)
  * stat: use an encrypted connection.
  * added new special scheme name for <img> tag: xvm:// - path relative to res_mods/xvm folder
      for example: <img src='xvm://configs/my/icons/foo.png'>

  [OTHER]
  * stat: changed address of the stats server (now https://stat.modxvm.com/)
  * option "battle"/"useStandardMarkers" moved to "markers"/"useStandardMarkers"
  * option "battle"/"removePanelsModeSwitcher" moved to "playersPanel"/"removePanelsModeSwitcher"
  * config version increased to 5.0.2
```
______________________________

### XVM 5.1.0
```
  * adaptation to WoT 0.8.11

  [NEW FUNCTIONS]
  * new options:
      (battleLoading|battleResults|statisticForm)/"showBattleTier" - show battle tier

  [OTHER]
  * default WN rating changed to WN8
  * renamed option "statisticForm"/"showChancesExp" to "showChancesLive"
```
______________________________

### XVM 5.0.2
```
  * adaptation to WoT 0.8.10

  [NEW FUNCTIONS]
  * new options:
      "battleResults"/"showTotals" - Show totals for your battle efficiency in first page
      "hangar"/"hidePricesInTechTree" - Hide price button in tech tree
      "hangar"/"masteryMarkInTankCarousel" - Show mastery mark in tank carousel
      "hangar"/"masteryMarkInTechTree" - Show mastery mark in tech tree
      "userInfo"/"showExtraDataInProfile" - Show extra data in profile (experimental)
  * added macros: {{wn6}}, {{wn8}, {{c:wn6}}, {{c:wn8}}, {{a:wn6}}, {{a:wn8}},
      {{xwn6}}, {{xwn8}}, {{c:xwn6}}, {{c:xwn8}}, {{a:xwn6}}, {{a:xwn8}},
  * macros {{wn}}, {{c:wn}}, {{a:wn}}, {{xwn}}, {{c:xwn}}, {{a:xwn}} are deprecated
  * login screen: input fields accept only the required characters
  * localization: added Chinese (Taiwan), Malay and Portuguese languages

  [OTHER]
  * changed vehicle names format in config
```
______________________________

### XVM 5.0.1
```
  * adaptation to WoT 0.8.9

  [NEW FUNCTIONS]
  * tech tree, tank carousel: show mark of mastery
  * localization: added Japanese language, Brazilian Portuguese language
  * new options:
      "login"/"confirmOldReplays" - Auto confirm old replays playing

  [MACROS]
  * squad: added macros {{vtype-l}}

  [FIXES]
  * many fixes
```
______________________________

### XVM 5.0.0-test5
```
  * adaptation to WoT 0.8.8

  [NEW FUNCTIONS]
  * possibility of editing nickname field in battleloading, Tab:
    formatLeftNick, formatRightNick
  * new options:
      "login"/"skipIntro" - Skip intro movie
      "login"/"autologin" - Auto enter to the game
      "userInfo"/"startPage" - Initial page userinfo window (default: 4)
      "battleResults"/"showNetIncome" - Display net income of credits in After Battle Screen
      "battleResults"/"showExtendedInfo" - Display shots precision and damage in After Battle Screen
      "userInfo"/"defaultFilterValue" - default value for the filter text input
  * possibility of editing format of vehicle info field in squad window:
      "squad"/"formatInfoField"
  * ability to configure different sets of icons to the left and right panels, markers of allies and enemies:
      "iconset"/"battleLoadingAlly", "iconset"/"battleLoadingEnemy" - for battle loading
      "iconset"/"playersPanelAlly", "iconset"/"playersPanelEnemy"   - for players panel
      "iconset"/"statisticFormAlly", "iconset"/"statisticFormEnemy" - for Tab window
      "iconset"/"vehicleMarkerAlly", "iconset"/"vehicleMarkerEnemy" - for vehicle markers
  * pinger: add wine support. For activation execute
    ln -s `which ping` ~/.wine/drive_c/ping.exe
  * localization: added Romanian, Bulgarian, Danish, Italian, Norwegian, Serbian, Slovak and Turkish languages
  * localization: added Polish, French readme

  [MACROS]
  * added macros {{c:avglvl}}, {{a:avglvl}}
  * squad: added macros {{level}}, {{rlevel}}, {{vtype}}, {{battletier-min}}, {{battletier-max}}

  [FIXES]
  * fixed "sixth sense" icon wrong positioning
  * minimap: fixed enemy teamkiller color
  * markers: fixed drowned vehicle type icon color

  [OTHER]
  * new platform - AS3+Python
  * xvm-stat, Dokan and .NET Framework is not required now. Please, delete xvm-stat.exe.
  * removed TWR rating
  * config version increased to 5.0.0
  * statistic is disabled in the config by default
  * changed clock format in battleloading (http://php.net/date)
  * config: "finalStatistic" section renamed to "battleResults"
  * removed "battleResults"/"sortColumn" option, build in since 0.8.8
  * removed options:
      "login"/"showPingOnGameLoading"
      "userInfo"/"showEColumn"
      "squad"/"romanNumbers"
      "squad"/"leftLvlBorder"
      "squad"/"rightLvlBorder"
  * renamed fields in iconset: "iconset"/"battleLoading", "iconset"/"playersPanel", "iconset"/"statisticForm", "iconset"/"vehicleMarker"
  * renamed fields "formatLeft", "formatRight" in battleloading, Tab
```
______________________________

### XVM 4.1.1
```
  [NEW FUNCTIONS]
  * localization: added Finnish, French, German, Hungarian, Korean, Polish, Spanish and Vietnamese translations
  * localization: macros for translating text in config, removed language dependency from config
  * hitlog: rows in HP Left panel can be formatted
  * xvm-stat: /priority parameter
  * minimap: support vehicle names from vehicleNames.xc
  * minimap: short vehicle names from vehicleNames.xc

  [FIXES]
  * minimap: fixed labels for asian region
  * stock\top turret marker: removed incorrect markers at some SPGs
  * squad window: fixed missing info for some vehicles
  * squad window: text field with vehicle tier no longer creates artefacts

  [OTHER]
  * automation: XVM nightly builds http://nightly.modxvm.com/
```
______________________________

### XVM 4.1.0
```
  [NEW FUNCTIONS]
  * new options:
      "login"/"pingServers"/"showPingOnGameLoading" - show ping during game loading, before login screen
      "userInfo/"showFilters" - show tank filters
      "userInfo/"filterFocused" - set the default focus to the filter text input
      "userInfo/"sortColumn" - number of column for sorting
        1 - Level, 2 - Type, 3 - Nation, 4 - Name, 5 - E, 6 - Fights, 7 - Wins, 8 - Class mark
        Sort order: >0 - default, <0 - inverse
      "hangar"/"xwnInCompany" - show XWN instead of XEFF in company windows
      language - language used in mod (support translation files in xvm/l10n/)
      "hangar"/"widgetsEnabled" - enable hangar widgets. Currently, only clock is available.
  * minimap: new label types - wrecks, teamkillers, lost allies
  * localization: XVM now using external files for translation
  * localization: added Belarusian, Ukranian and Czech translations
  * snippets - extended battle elements settings. "battle"/"elements" section was changed.
    details is here: http://www.koreanrandom.com/forum/topic/1761-snippets/ (Russian)
    xvm-stat 1.6.1 or higher required

  [FIXES]
  * minimap: label of observer vehicle is no longer rotating with icon
  * minimap: some interface object are no longer overlapping zoomed minimap
  * minimap: fixed players death log list positioning while minimap is zoomed
  * minimap: fixed work when there is only one player in enemy team
  * hitlog: damage to drowned units is not taken into account anymore

  [OTHER]
  * minimap: shapes attached to vehicles are removed on player death
  * minimap: code refactoring
  * minimap: labels are detached from icons to lower layer
  * minimap: shapes work in all locales without xvm-stat.exe
  * squad window: work in all locales
```
______________________________

### XVM 4.0.0
```
  * adaptation to WoT 0.8.6

  [NEW FUNCTIONS]
  * transparency statistics macros ({{a:xwn}},...)
  * ability to set colors for vehicle type markers (macros for dynamic colors can be used)
  * new option: "hangar"/"hideTutorial"
  * filter by tanks in the own hangar in the Achievements window
  * separate settings for self and squadman damage text
  * filter by tank name in the Achievements window
  * new option: "userInfo"/"inHangarFilterEnabled" - enable "In hangar" check box by default
  * switch in user info window: [show] in hangar, player tanks, all tanks
  * expertPanel mod; see battle.xc
  * cluster response time table at login and hangar (ping);
    "pingServers" section at login.xc and  hangar.xc config files
  * hitlog: shows enemy HP left (markers which were visible) on Alt press;
    hitlog.xc: "hpLeft": "true"
  * show ping at the game loading screen; "login"/"pingServers"

  [FIXES]
  * fixed rare condition when wrong minimap lost marker was deleted
  * minimap zoom: disabled while chatting; hotkeys.xc config comment about supported keys is updated
  * minimap: fix issues at Fisherman's bay map for EN\US locale users without xvm-stat.exe
  * some other fixes

  [OTHER]
  * new config format (now config is loading from res_mods/xvm/xvm.xc)
  * removed legacy support for OTMData.xml config
  * config version changed to 4.0.0
  * special scheme name for <img> tag: xvmres:// - path relative to res_mods/xvm/res folder
      for example: <img src='xvmres://icons/foo.png'>
  * minimap: deustch locale support without xvm-stat.exe
```
______________________________

### XVM 3.5.0
```
  * adaptation to WoT 0.8.5

  [NEW FUNCTIONS]
  * squad window: show info about tank
  * enemy spotted status at right side panel
  * crew: crew loading mod (author: Lemaxho)
  * added button in company window for enabling automatic loading data
  * implemented ability to disable "Allies | Enemies" text fields under score panel
    - upper level section "fragCorrelation" at xvm config file

  [FIXES]
  * fixed mouse cursor with minimap zoom by Ctrl press
  * fixed endless loop when stat is not available
  * capture bar: tweak
  * minimap: added new map Pearl River to map recognition system
  * score panel updated
  * fixed sorting in After Battle stats
  * fixed win chances with test tanks
  * other fixes

  [MINIMAP]
  * minimap enabled by default
  * zoom minimap by key pressing;
    see sections "minimap":{"zoom" and "hotkeys":{ at XVM.xvmconf
  * 1000m square implemented
  * 1km square switch for artillery
  * xvm-stat.exe is not necessary for map recongnition for RU, NA/EN, CH locales
  * {{vehicle-name}} macro returns vehicle system name - usa-M24_Chaffee
  * smoothed superHeavyTank and all tank wrecks icons
  * zoom size memory fixed
  * world map battle fix
  * "iconScale" now does not affect capture bases

  [OTHER]
  * xvm-stat protocol reworked
    ATTENTION: XVM Stat 1.4.0 ot higher required
  * user statistics in hangar enabled by default
  * markers: auto size text fields
  * updated per-vehicle statistics data (added new tanks)
  * minimap: zoom minimap on Ctrl press disabled by default
  * updated clan icons
```
______________________________

### XVM 3.4.2
```
  * minimap fix: minimal map size
  * minimap fix: map size glitched when WoT window was resized or Alt+Tab-ed
```
______________________________

### XVM 3.4.1
```
  * bugfix
```
______________________________

### XVM 3.4.0
```
  * adaptation to WoT 0.8.4

  [MACROS]
  * new macros:
      {{avglvl}} - average level of tanks
      {{wn}}, {{c:wn}} - WN6 rating: http://www.koreanrandom.com/forum/topic/2575-/
      {{xeff}}, {{xwn}}, {{c:xeff}}, {{c:xwn}} - two-digits rating value
        using "XVM Scale"
        explanation: http://www.koreanrandom.com/forum/topic/2625-/page-15#entry35340 (in Russian)
      {{twr}}, {{c:twr}} - tourist1984 win rate:
        http://www.koreanrandom.com/forum/topic/2389-/
      {{vehiclename}} for internal vehicle name like "usa-M24_Chaffee"
        can be used in the text fields:
        "<img src='img://gui/maps/icons/vehicle/contour/{{vehiclename}}.png'>"
      {{clannb}} - clan name without brackets

  [NEW FUNCTIONS]
  * minimap mod
  * userInfo mod (with functions from morotopitek's mod)
  * teamMemberRenderer mod
  * finalStatistic mod (with functions from morotopitek's mod).
  * new win chance formula by TurinDeNar:
      http://www.koreanrandom.com/forum/topic/2598-/

  [CONFIG]
  * added colors setup sections: "colors"/"wn", "colors"/"twr"
  * added colors setup section: "colors"/"x" for XVM Scale colors
  * added section finalStatistic for final statistic window settings
  * added parameter: "hitLog"/"defaultHeader" - default header format (before first hit)
  * cnanged efficiency in the default config:
      was: {{eff:4}}, now: {{xwn}}

  [FIXES]
  * fixed {{c:system}} macro
  * fixed {{nick}} macro in the medium2 players panel mode
  * fixed statistics loading in the Fog Of War mode

  [CAPTURE BAR]
  * capture bar: fixed "enabled":false
  * capture bar: fixed number of tanks capturing for Tank Company encounter battles
  * capture bar: capturers number fix

  [OTHER]
  * updated statistic data for new vehicles
```
______________________________

### XVM 3.3.1
```
  * hitlog extremely oversized symbols fix
```
______________________________

### XVM 3.3.0
```
  * release for WoT 0.8.3
```
______________________________

### XVM 3.3.0-test1
```
  * capture bar: fixed wrong capturers number calculation for encounter
  * macro {{c:dmg}} can be used in health bar
  * default sorting by exp in Final Statistics
  * adaptation to WoT 0.8.3.CT2
```
______________________________

### XVM 3.2.1-test1
```
  * capmod: fixed capture bar fill at 100%
  * code optimization
  * updating per-vehicle efficiency formula:
      TEFF: E
      0..299: 1 - very bad player
      300..499: 2 - bad player
      500..699: 3 - poor
      700..899: 4 - below average
      900..1099: 5 - average
      1100..1299: 6 - above average
      1300..1549: 7 - good
      1550..1799: 8 - great
      1800..1999: 9 - master
      2000+: E - Expert (top-100 players on this vehicle)
```
______________________________

### XVM 3.2.0
```
  * adaptation to WoT 0.8.2
  * new vehicles added
  * color palette revised
  * new macros:
      {{tdb}}, {{tdb:4}} - average damage for current tank - damage/battles
      {{tdv}} - average damage efficiency for tank - damage/(battles*maxHP)
      {{tfb}} - average frags per battle for current tank
      {{tsb}} - average number of spotted enemies per battle for current tank
      {{c:tdb}}, {{c:tdv}}, {{c:tfb}}, {{c:tsb}} - dynamic colors for this macros
      {{teff}} - new per-vehicle efficiency
        Discussion: http://www.koreanrandom.com/forum/topic/1643-
      {{c:system}} - use system color instead of override
      {{c:dmg}} - color depended from damage source
  * new value of macro {{e}} (new per-vehicle efficiency in range 0..9)
  * removed macro {{e:3}} (not required)
  * HTML in clock in battle
  * dynamic color and transparency for shadow
  * shadow settings in hitlog
```
______________________________

### XVM 3.1.2
```
  * added capture bar mod
  * fixed standard markers mode
  * do not calculate friendly fire in hitlog
  * improved default major color palette
  * new macros:
      {{name}} - player nickname without clan name
      {{clan}} - clan name with brackets (empty if no clan)
      {{vtype}} - vehicle type
      {{squad}} - value '1' for squadmates, empty for others (in markers)
      {{e}}, {{e:3}} - efficiency / 10 (save 1 char)
  * new config section "texts"/"vtype" for changing vehicle types text
  * fixed display a marker for the tank with the dead crew
  * new option: "rating"/"enableStatisticsLog" allow to enable saving statistics
    to "xvm-stat.log" file
  * show chance to win on final statistic form
```
______________________________

### XVM 3.1.1
```
  * bugfix
```
______________________________

### XVM 3.1.0
```
  * XVM is distributed only in Lite version, without statistics module
  * statistics module was renamed to xvm-stat and distributed in separate package
  * support of HTML in any text field, including vehicle markers
  * win chahce is disabled by default
  * SixthSense.png added to samples
  * updated {{turret}} marker for new and old vehicles
  * stock turret marker added to the default config (after vehicle name)
  * damage animation was improved
  * the default font of floating damage is the same as in the client
  * added new section to config "colors"/"damage", which allows to adjust the color of
    floating damage depending on the source of damage
  * added config section "colors"/"dmg_kind"
  * added macro {{c:dmg_kind}} for dynamic color in depend of damage kind
  * added new section to config "hitLog", which allows to display the log of own hits
  * negative x, y values in hit log settings allow to bind the text to the right
    and bottom edges for the same behavior with different screen resolutions.
    will work only with running xvm-stat!!!
```
______________________________

### XVM 3.0.3
```
  * added possibility to change {{turret}} marker display string
  * fixed {{turret}} marker calculations for a-20, bt-7, d2, m7_med, pziv, t2_med
  * fixed {{turret}} marker significance for Patton and Pershing
  * added possibility to change sixth sense indicator.
    Alternative PNG image should be placed at res_mods/icons/SixthSense.png
```
______________________________

### XVM 3.0.2
```
  * fixed color blind mode
  * wot-xvm-proxy: added /maximized option (run client in maximized window)
```
______________________________

### XVM 3.0.1
```
  * added information for tanks PzKpfwIV Schmalturm, Panther-M10 and СУ-122-44
```
______________________________

### XVM 3.0.0
```
  * xvm was refactored
  * new tank marker {{turret}}:
    Displays symbol is tank has stock turret.
      "*" symbol - stock turret. Cant mount top gun. Subject is highly vulnerable.
      "-" symbol - stock turret. Top gun is possible. Subject is somewhat vulnerable.
      Stock turret can have weaker armor, lower sight distance or slower rotation speed.
      Besides that, tank with stock turret can have weaker crew experience.
  * separate settings for all elements in all states
  * adaptation to WoT 0.8.0
```
______________________________

### XVM 2.5.2
```
  * clan icons was reworked. Now config have only one parameter:
    "battle"/"clanIconsFolder" with path to clan icons root folder. All icons
    are loading automatically from game region subfolder (RU/EU/US/...).
    to add your clan or player icon, just copy icon file to:
      clanicons/[REGION]/clan/ (for clan)
      clanicons/[REGION]/nick/ (for single player)
    also you can create default clan and player icons:
      clanicons/[REGION]/clan/default.png (for default clan)
      clanicons/[REGION]/nick/default.png (for default player)
    search order is:
      nick/<player>.png -> clan/<clan>.png -> clan/default.png -> nick/default.png
  * added config option:
      "battle"/"clanIconsFolder" - root of clan icons folder
  * removed config section:
      "players"
  * config version increased: 1.4.0 => 1.5.0, because clan icons behavior
    was changed
  * full archive with all clans can be downloaded separately:
      http://code.google.com/p/wot-xvm/downloads/detail?name=clanicons-full-ru.zip (RU)
      http://code.google.com/p/wot-xvm/downloads/detail?name=clanicons-full-eu.zip (EU)
      http://code.google.com/p/wot-xvm/downloads/detail?name=clanicons-full-us.zip (US)
  * removed coords grid (parameter battle.drawGrid)
  * statistics enabled by default
  * added {{rlevel}} macro for vehicle level in roman numerals
  * dynamic color and transparency for shadow
  * added "font"/"italic" parameter (values: true/false)
  * added {{c:vtype}} macro and "colors"/"vtype" section for dynamic color by
    vehicle type
  * added color for premium tanks to {{c:vtype}} macro
  * {{c:vtype}} macro can be used in BattleLoading, PlayersPanel and
    StatisticForm
  * added "vehicleNames" config section. Used for vehicle names mapping -
    ability to replace any tank name with own value
```
______________________________

### XVM 2.5.1
```
  * fixed vehicle names in battle loading screen and statistic form
```
______________________________

### XVM 2.5.0
```
  * adaptation to WoT 0.7.5
  * code refactoring
  * fixed bugs in "Fog of War" mode (incomplete)
  * file XVM.log in the game directory contains mod debugging information
  * added options:
      "battle"/"clockFormat" - show the clock on the Debug Panel (near FPS)
      "battleLoading"/"clockFormat" - show the clock on the Battle Loading Screen
      "battle"/"highlightVehicleIcon" - setup highlighting of selected vehicle icon and squad
  * remove option:
      battleLoading"/"showClock" - superseded by "battleLoading"/"clockFormat"
  * macros usage for vehicle text fields in Battle Loading and Statistic Form
  * config version increased: 1.3.0 => 1.4.0, because "battleLoading"/"showClock"
    was replaced with "battleLoading"/"clockFormat" and formatLeft/formatRight
    behavior was changed
  * clock and mod info on battle loading screen moved to the bottom info panel
  * wot-xvm-proxy: added new command line parameter "/noproxy" for disabling
    using of system proxy settings
  * fixed ally icon position using standard markers
  * added experimental chance to win formula
  * editor moved: http://www.koreanrandom.com/forum/topic/1422-/#entry11316
  * BattleTimerBig.swf removed from mod archive
  * changes in chance to win formulas
  * show chance to win on final statistic form
```
______________________________

### XVM 2.4.1
```
  * battle task animation removed
  * added new macros:
      {{t-kb-0}} - kilo-battles with leading zero
      {{t-hb}} - hecto-battles - battles/100
      {{t-hb:3}} - hecto-battles aligned to 3 chars
  * added option:
      markers/*/vehicleIcon/showSpeaker - show speaker even if vehicle type
      icon is disabled
  * removed macros {{c:t-kb}}, use {{c:t-battles}} instead.
  * fixed icon appearing for a moment when vehicle is spotted
```
______________________________

### XVM 2.4
```
  * adaptation to WoT 0.7.4
  * new proxy server
  * added per-vehicle statistics. New macros:
      {{t-kb}}
      {{t-battles}}
      {{t-wins}}
      {{t-rating}}
      {{t-kb:4}}
      {{t-rating:3}}
      {{t-battles:4}}
      {{c:t-rating}}
      {{c:t-kb}}
      {{c:t-battles}}
```
______________________________

### XVM 2.3.1
```
  * fix 2.3 release bugs
```
______________________________

### XVM 2.3
```
  * added new vehicles to win chances calculation
  * fixed bug in swf modification
  * wot-xvm-proxy: added compression of proxy servers requests
  * added top 100 icons for RU clans (http://ivanerr.ru/lt/showclansrating/)
  * default config reworked
  * config editor: https://sites.google.com/site/sirmaxwiki/xvm-editor
    (not all is ready, but can be used)
  * players panel performance optimization on kill
  * separated settings for section "damageText" for alive and dead, last
    damage will be shown with settings from section "dead"
  * dynamically determine maximum request length in depend of game folder
  * wot-xvm-proxy: swf communication protocol changed
  * wot-xvm-proxy: check for another instance
  * fixed text field default settings if not set in config
  * player/clan icons in vehicle markers
  * added option "battle"/"useStandardMarkers", that allow to use standard
    client vehicle markers
  * editor: set default values
  * editor: added new config version settings
  * localization
```
______________________________

### XVM 2.2
```
  * adaptation to WoT 0.7.3
  * updated tank info for win chances calculation
  * vehicle type marker settings may be different for each state
  * empty clan name for showing icons for players without clan
  * in dynamic color "value":0 defines color for not loaded statistic
  * added top clans icons to default configs
  * fixed bug with enemy team killer
  * added config options for separate clan icon coordinates at right size
  * added Lite configs without statistics options
  * wot-xvm-proxy: icon changed (thanks to Vadim M.)
  * own player icons subsection for each server region in config
  * reorder clanicons folder
  * config version increased: 1.2.0 => 1.3.0, because section "players" was
    changed
  * add some more european clans
  * added alternative proxy servers
```
______________________________

### XVM 2.1.1
```
  * fixed bug - missed vehicle name in players panel
```
______________________________

### XVM 2.1
```
  * do not show warning when config is absent.
  * added separated parameters for clan/player icons:
      "battleLoading"/"clanIcon" for battle loading screen
      "statisticForm"/"clanIcon" for battle statistics (when Tab pressed)
      "playersPanel"/"clanIcon" for players panel
  * fixed health bar animation
  * added option battle/removePanelsModeSwitcher for removing panel switcher
  * battle loading screen fields alignment
  * added parameter "removeSquadIcon" for ability of removing squad icon from
    battle loading screen, players panel and Tab key statistic form
  * fixed dynamic transparency
  * fixed player/clan icon in players panel
  * show win chances in statistic form (work only in 15x15 battles)
  * added configs like in standard client
  * fixes in win chances formulas
  * fixed bug when dead enemy tank still have tank icon active.
  * remove empty space in large mode of players panel when squad icon is disabled
  * dynamic color and transparency for all health bar elements in all states
  * optimization of macros with dynamic values
  * fixed health bar z-order
  * optimization of player/clan icon
  * wot-xvm-proxy: added new command line parameter "/noauto" for disabling
    auto running the game
  * added "name" option for text fields in config
  * fixed default configs
  * added option to hide xvm version at top left corner of screen
  * players panels and statistic form optimization (avoid lags)
  * proxy server for EU client is changed
  * added config with English comments
```
______________________________

### XVM 2.0
```
  * adaptation to WoT 0.7.2
  * mod distribution model changed:
      xvm-lite package for mod without players ratio
      xvm-full package for mod with players ratio
  * dynamic color optimization
  * added {{level}} macro for vehicle level
  * always use 'alive' color for damage text with system colors
  * added clock to battle loading screen (can be disabled in config)
  * macros optimization
  * shadows quality improved
  * advanced in-game error reporting
  * text formats in battleLoading, statisticForm and playersPanel split to
    left and right
  * config changed to version 1.2.0. Parameters moved:
      "rating"/"battleLoading" => "battleLoading"
      "rating"/"statisticForm" => "statisticForm"
      "rating"/"playersPanel" => "playersPanel"
      "battle"/"battleLoadingShowClock" => "battleLoading"/"showClock"
      "battle"/"playersPanelAlpha" => "playersPanel"/"alpha"
      "battle"/"playersPanelLargeWidth" => "playersPanel"/"large"/"width"
  * configurable system colors (section colors/system in XVM.xvmconf)
    working with all elements except vehicle type markers
  * configurable formats for name and vehicle text fields in players panel
  * darker color for dead or not loaded players in players panel
  * icons transparency in players panel (parameter "playersPanel"/"iconAlpha")
  * players panel field width changing
  * automatically select the fastest server to connect (currently useful
    only for China servers)
  * added icon sets ("iconset" config section)
  * player/clan icons added
  * win chances calculation added
  * many other fixes
```
______________________________

### XVM 1.7
```
  * merge configs in XVM.xvmconf (with legacy support of OTMData.xml)
  * config version increased to 1.1.0 (with backward compatibility)
  * integrate default config in code
  * added samples configs: \xvm-doc\samples
  * config usage optimization (avoid freezes)
  * optimized text fields creation and usage
  * extended config parsing error reporting at battle loading
  * increased width of vehicle fields in BattleLoading and StatisticForm
  * fixed bug with endless loop when PlayersPanel width is too small
  * fixed player names cutting
  * added new macros for dynamic colors in vehicle markers:
    {{c:hp}}, {{c:hp-ratio}}
  * added macros of dynamic transparency:
    {{a:hp}}, {{a:hp-ratio}}
  * changed JSON parser to fixed version, than is 10x faster that internal
  * wot-xvm-proxy: added autodetection of game version: RU, EU, US, CN1
  * wot-xvm-proxy: added command line options /? and /help for displaying
    usage information
  * wot-xvm-proxy: added command line option /server=(RU|EU|US|CN1|CN2) for
    overriding autodetection
  * wot-xvm-proxy: added china servers support
  * wot-xvm-proxy: added extended debug information with /debug option
  * fixed bug with parsing empty stat data
  * fixed initial icon positioning
  * fixed fields size and position in battle loading screen
  * fixed contour icon color
  * many other bugs fixed
```
______________________________

### XVM 1.6
```
  * speed optimization
  * grid modified
  * fixed .stat link check at startup
  * fixed players names shifting in large panels
  * fixed transaprency error (playersPanelAlpha = 0)
  * cut nick with disabled statistics in large mode
  * fixed 'null' when data is not available
  * fixed vehicle level position with disabled mirroring
  * added option to load enemy stats in Fog of War (experimental).
  * some other bugs fixed
```
______________________________

### XVM 1.5
```
  * fixed playing replays with spaces in the file name
  * fixed damage fading in health bar
  * configurable players panel transparency
  * set players names width in panels in large mode
  * some other bugs fixed
```
______________________________

### XVM 1.4
```
  * working only with player id
  * macroses was added in markers: {{kb}}, {{battles}}, {{wins}}, {{eff}}, {{rating}}
  * statistics formatting added
  * added macroses for dynamic colors: {{c:eff}}, {{c:rating}}, {{c:kb}}
  * config parameter changed:
      "rating"/"playersPanel"/"colorizeMiddle" -> "rating"/"playersPanel"/"middleColor"
  * added section "rating"/"colors" into config for setting up border values
    and color values for dynamic colors
  * fixed PostmortemTips hiding
  * added new version notification at battle loading screen
  * config parameter renamed and behavoir inverted to avoid mistakes:
      "battle"/"disableMirroredVehicleIcons" -> "battle"/"mirroredVehicleIcons"
  * force stats loading after 1 sec (for 12x12 battles or FogOfWar)
  * added stat macros: {kb:3}}, {{rating:3}}, {{eff:4}} - useful for aligning columns
    using monospace fonts
```
______________________________

### XVM 1.3
```
  * simple installation. Added wot-xvm-proxy.exe.
  * it is able to work with id or nicks.
```
______________________________

### XVM 1.2
```
  * comments was added to config file XVM.xvmconf
  * proxy server and protocol are changed
  * XML was changed to JSON (except legacy OTMData.xml)
```
______________________________

### XVM 1.1
```
  * fixed ally health bar color with system colors
```
______________________________

### XVM 1.0
```
  First release
