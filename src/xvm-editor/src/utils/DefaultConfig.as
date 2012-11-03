/**
 * ...
 * @author sirmax2
 */
package utils
{
import utils.Defines;

public class DefaultConfig
{
  public static function get config(): Object
  {
    var d:Date = new Date();
    var a:Object =
    {
      configVersion: Defines.CONFIG_VERSION,
      editorVersion: Defines.EDITOR_VERSION,
      definition: {
        author: "sirmax2",
        description: "Default settings for XVM",
        url: "http://code.google.com/p/wot-xvm/",
        date: (d.getDate() < 10 ? "0" : "") + d.getDate() + "." +
          (d.getMonth() < 9 ? "0" : "") + (d.getMonth() + 1) + "." + d.getFullYear(),
        gameVersion: Defines.WOT_VERSION,
        modMinVersion: Defines.XVM_VERSION
      },
      battle: {
        mirroredVehicleIcons: true,      // Set false for alternative tank icon mirroring.
        showPostmortemTips: true,        // Popup tooltip panel after death.
        removePanelsModeSwitcher: false, // Set true to hide mouse modes switcher.
	highlightVehicleIcon: true,      // False - disable highlighting of selected vehicle icon and squad.
	hideXVMVersion: false,           // Hide version label at upper left corner.
        useStandardMarkers: false,       // Use original wot markers.
	// Show the clock on the Debug Panel (near FPS).
	// Format: Y:year, M:month, D:day, H:hour, N:minutes, S:seconds.
        clockFormat: "H:N",
        clanIconsFolder: "../../../clanicons", // Folder with clan icons
        // Visual elements
        elements: {
          // x - X position
          // y - Y position
          // w - width
          // h - height
          // a - alpha
          // ha - horizontal align
          // va - vertical align
          // debug - draw border, element name and geometry
          // x, y values can be:
          //   null - use default client value
          //   -xxxx..xxxx
          //   xx.xx%
          // ha values can be:
          //   null - use default client value
          //   1 - left
          //   2 - right
          // va values can be:
          //   null - use default client value
          //   1 - top
          //   2 - bottom
          minimap:               { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
          playerMessangersPanel: { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
          leftPanel:             { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
          rightPanel:            { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
          switcher_mc:           { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
          fragCorrelationBar:    { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
          debugPanel:            { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
          battleTimer:           { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
          damagePanel:           { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
          sixthSenseIndicator:   { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
          vehicleErrorsPanel:    { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
          messenger:             { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
          damageInfoPanel:       { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
          timerBig:              { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
          deathZoneTimer:        { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
          overturnedTimer:       { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
          drownTimer:            { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
          langBarPanel:          { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
          consumablesPanel:      { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
          vehicleMessagesPanel:  { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false },
          teamBasesPanel:        { x:null, y:null, w:null, h:null, ha:null, va:null, a:null, debug:false }
        }
      },
      rating: {
        showPlayersStatistics: true,     // Global switch. Handles whole statisctics module.
        loadEnemyStatsInFogOfWar: true   // Load players data in "fog of war".
      },
      battleLoading: {
        // Show clock at Battle Loading Screen.
	// ### Is there a clock:on\off switch variable supposed to be? ###
	// A: No, it is possible to set clockFormat: "" to disable clock.

	// Format: Y:year, M:month, D:day, H:hour, N:minutes, S:seconds.
        clockFormat: "H:N:S",
        showChances: false,     // Show game round win chances percentage.
        showChancesExp: false,  // Show experimental "chance to win" formula.
        removeSquadIcon: false, // Hide squad icon.
        // Playes/clan icon parameters.
        clanIcon: { show: true, x: 0, y: 6, xr: NaN, yr: NaN, h: 16, w: 16, alpha: 90 },
        // Dispay format. Macro-substitutiones allowed.
        formatLeft: "{{vehicle}} <font color='{{c:kb}}'>{{kb}}</font> <font color='{{c:eff}}'>{{eff}}</font> <font color='{{c:rating}}'>{{rating}}</font>",
        formatRight: "<font color='{{c:rating}}'>{{rating}}</font> <font color='{{c:eff}}'>{{eff}}</font> <font color='{{c:kb}}'>{{kb}}</font> {{vehicle}}"
      },
      statisticForm: {
        showChances: false,     // Show game round win chances percentage.
        showChancesExp: false,  // Show experimental "chance to win" formula.
        removeSquadIcon: false, // Hide squad icon.
        // Playes/clan icon parameters.
        clanIcon: { show: true, x: 0, y: 6, xr: NaN, yr: NaN, h: 16, w: 16, alpha: 90 },
        // Dispay format.
        formatLeft: "{{vehicle}} <font color='{{c:kb}}'>{{kb}}</font> <font color='{{c:eff}}'>{{eff}}</font> <font color='{{c:rating}}'>{{rating}}</font>",
        formatRight: "<font color='{{c:rating}}'>{{rating}}</font> <font color='{{c:eff}}'>{{eff}}</font> <font color='{{c:kb}}'>{{kb}}</font> {{vehicle}}"
      },
      playersPanel: {
        alpha: 60,              // Side panel transparency. 0 - transparent, 100 - opaque.
        iconAlpha: 100,         // Side panel icons transparency. 0 - transparent, 100 - opaque.
        removeSquadIcon: false, // Hide squad icon.
        // Playes/clan icon parameters.
        clanIcon: { show: true, x: 0, y: 6, xr: NaN, yr: NaN, h: 16, w: 16, alpha: 90 },
        // Medium1 mode.
        medium: {
          // 0..250 - player name field width.
          width: 46,
          // Dispay format.
          formatLeft: "<font color='{{c:eff}}'>{{nick}}</font>",
          formatRight: "<font color='{{c:eff}}'>{{nick}}</font>"
        },
        // Medium2 mode.
        medium2: {
          // 0..250 - player name field width.
          width: 65,
          // Dispay format.
          formatLeft: "<font color='{{c:eff}}'>{{vehicle}}</font>",
          formatRight: "<font color='{{c:eff}}'>{{vehicle}}</font>"
        },
        // Large mode.
        large: {
          // 0..250 - player name field width.
          width: 170,
          // Dispay format.
          nickFormatLeft: "<font color='{{c:eff}}'>{{rating}}</font> {{nick}}",
          nickFormatRight: "{{nick}} <font color='{{c:eff}}'>{{rating}}</font>",
          vehicleFormatLeft: "<font color='{{c:rating}}'>{{vehicle}}</font>",
          vehicleFormatRight: "<font color='{{c:rating}}'>{{vehicle}}</font>"
        }
      },
      turretMarkers: {
        highVulnerability: "*",
        lowVulnerability: "'"
      },
      captureBar: {
        enabled: true,
        primaryTitleFormat:   "<font size='16' color='#000000'>Base capture! {{extra}}</font>",
        secondaryTitleFormat: "<font size='16' color='#000000'>{{points}}</font>",
        captureDoneFormat:    "<font size='16' color='#000000'>Captured!</font>",
        extra: "Capturers: <b>{{tanks}}</b> Timeleft: <b>{{time}}<b>",
        primaryTitleOffset: 7,
        shadow: {
          color: "0xEEEEEE",
          alpha: 75,
          blur: 15,
          strength: 3
        }
      },
      hitLog: {
        visible: true,
        x: 270,
        y: 7,
        w: 200,
        h: 100,
        lines: 0,
        direction: "down",
        insertOrder: "end",
        groupHitsByPlayer: false,
        // Substitution for {{dead}} macro when player is dead
        deadMarker: "<font face='Wingdings'>N</font>",
        blowupMarker: "<font face='Wingdings'>M</font>",
        formatHeader: "<font color='#CCCCCC'>Hits:</font> <font size='13'>#{{n}}</font> <font size='1{{nick}}'><b>{{dmg-total}}</b>  <font color='#CCCCCC'>Last:</font> <font color='{{c:dmg-kind}}'><b>{{dmg}}</b> {{dead}}</font></font>",
        formatHistory: "<textformat leading='-4' tabstops='[20,50,90,150]'><font size='12'>\u00D7{{n-player}}:</font><tab>{{dmg-player}}<tab>| <font color='{{c:dmg-kind}}'>{{dmg}}</font><tab>| <font color='{{c:dmg-kind}}'>{{dmg-kind}}</font><tab>| <font color='{{c:vtype}}'>{{vehicle}} {{dead}}</font></textformat>"
      },
      markers: {
        ally: {
          alive: {
            normal: {
              vehicleIcon: vi,
              healthBar: hb_alive,
              damageText: dmg,
              contourIcon: ci,
              clanIcon: clanIcon,
              levelIcon: li,
              actionMarker: am,
              textFields: [ vehicleName_alive, currentHealth ]
            },
            extended: {
              vehicleIcon: vi,
              healthBar: hb_alive,
              damageText: dmg,
              contourIcon: ci,
              clanIcon: clanIcon,
              levelIcon: li,
              actionMarker: am,
              textFields: [ playerName_alive, healthRatio, ratingText ]
            }
          },
          dead: {
            normal: {
              vehicleIcon: vi,
              healthBar: hb_dead,
              damageText: dmg,
              contourIcon: ci,
              clanIcon: clanIcon,
              levelIcon: li,
              actionMarker: am,
              textFields: [  ]
            },
            extended: {
              vehicleIcon: vi,
              healthBar: hb_dead,
              damageText: dmg,
              contourIcon: ci,
              clanIcon: clanIcon,
              levelIcon: li,
              actionMarker: am,
              textFields: [ playerName_dead, vehicleName_dead ]
            }
          }
        },
        enemy: {
          alive: {
            normal: {
              vehicleIcon: vi,
              healthBar: hb_alive,
              damageText: dmg,
              contourIcon: ci,
              clanIcon: clanIcon,
              levelIcon: li,
              actionMarker: am,
              textFields: [ vehicleName_alive, currentHealth ]
            },
            extended: {
              vehicleIcon: vi,
              healthBar: hb_alive,
              damageText: dmg,
              contourIcon: ci,
              clanIcon: clanIcon,
              levelIcon: li,
              actionMarker: am,
              textFields: [ playerName_alive, healthRatio, ratingText ]
            }
          },
          dead: {
            normal: {
              vehicleIcon: vi,
              healthBar: hb_dead,
              damageText: dmg,
              contourIcon: ci,
              clanIcon: clanIcon,
              levelIcon: li,
              actionMarker: am,
              textFields: [  ]
            },
            extended: {
              vehicleIcon: vi,
              healthBar: hb_dead,
              damageText: dmg,
              contourIcon: ci,
              clanIcon: clanIcon,
              levelIcon: li,
              actionMarker: am,
              textFields: [ playerName_dead, vehicleName_dead ]
            }
          }
        }
      },
      colors: {
        system: {
          ally_alive_normal:		"0x96FF00",
          ally_alive_blind:		"0x96FF00",
          ally_dead_normal:		"0x009900",
          ally_dead_blind:		"0x009900",
          ally_blowedup_normal:		"0x007700",
          ally_blowedup_blind:		"0x007700",
          squadman_alive_normal:	"0xFFB964",
          squadman_alive_blind:		"0xFFFF00",
          squadman_dead_normal:		"0xCA7000",
          squadman_dead_blind:		"0xAAAA00",
          squadman_blowedup_normal:	"0xA45A00",
          squadman_blowedup_blind:	"0x888800",
          teamKiller_alive_normal:	"0x00EAFF",
          teamKiller_alive_blind:	"0x00EAFF",
          teamKiller_dead_normal:	"0x097783",
          teamKiller_dead_blind:	"0x097783",
          teamKiller_blowedup_normal:	"0x096A75",
          teamKiller_blowedup_blind:	"0x096A75",
          enemy_alive_normal:		"0xF50800",
          enemy_alive_blind:		"0x8379FE",
          enemy_dead_normal:		"0x840500",
          enemy_dead_blind:		"0x47407A",
          enemy_blowedup_normal:	"0x5A0401",
          enemy_blowedup_blind:		"0x3B365F"
        },
        // src: ally, squadman, enemy, unknown, player
        // dst: ally, squadman, allytk, enemytk, enemy
        damage: {
          ally_ally_hit:		"0x00EAFF",
          ally_ally_kill:		"0x00EAFF",
          ally_ally_blowup:		"0x00EAFF",
          ally_squadman_hit:		"0x00EAFF",
          ally_squadman_kill:		"0x00EAFF",
          ally_squadman_blowup:		"0x00EAFF",
          ally_enemy_hit:		"0xF50800",
          ally_enemy_kill:		"0xF50800",
          ally_enemy_blowup:		"0xF50800",
          ally_allytk_hit:		"0x00EAFF",
          ally_allytk_kill:		"0x00EAFF",
          ally_allytk_blowup:		"0x00EAFF",
          ally_enemytk_hit:		"0xF50800",
          ally_enemytk_kill:		"0xF50800",
          ally_enemytk_blowup:		"0xF50800",
          squadman_ally_hit:		"0x00EAFF",
          squadman_ally_kill:		"0x00EAFF",
          squadman_ally_blowup:		"0x00EAFF",
          squadman_squadman_hit:	"0x00EAFF",
          squadman_squadman_kill:	"0x00EAFF",
          squadman_squadman_blowup:	"0x00EAFF",
          squadman_enemy_hit:		"0xF50800",
          squadman_enemy_kill:		"0xF50800",
          squadman_enemy_blowup:	"0xF50800",
          squadman_allytk_hit:		"0x00EAFF",
          squadman_allytk_kill:		"0x00EAFF",
          squadman_allytk_blowup:	"0x00EAFF",
          squadman_enemytk_hit:		"0xF50800",
          squadman_enemytk_kill:	"0xF50800",
          squadman_enemytk_blowup:	"0xF50800",
          enemy_ally_hit:		"0x96FF00",
          enemy_ally_kill:		"0x96FF00",
          enemy_ally_blowup:		"0x96FF00",
          enemy_squadman_hit:		"0xFFB964",
          enemy_squadman_kill:		"0xFFB964",
          enemy_squadman_blowup:	"0xFFB964",
          enemy_enemy_hit:		"0xF50800",
          enemy_enemy_kill:		"0xF50800",
          enemy_enemy_blowup:		"0xF50800",
          enemy_allytk_hit:		"0x96FF00",
          enemy_allytk_kill:		"0x96FF00",
          enemy_allytk_blowup:		"0x96FF00",
          enemy_enemytk_hit:		"0xF50800",
          enemy_enemytk_kill:		"0xF50800",
          enemy_enemytk_blowup:		"0xF50800",
          unknown_ally_hit:		"0x96FF00",
          unknown_ally_kill:		"0x96FF00",
          unknown_ally_blowup:		"0x96FF00",
          unknown_squadman_hit:		"0xFFB964",
          unknown_squadman_kill:	"0xFFB964",
          unknown_squadman_blowup:	"0xFFB964",
          unknown_enemy_hit:		"0xF50800",
          unknown_enemy_kill:		"0xF50800",
          unknown_enemy_blowup:		"0xF50800",
          unknown_allytk_hit:		"0x96FF00",
          unknown_allytk_kill:		"0x96FF00",
          unknown_allytk_blowup:	"0x96FF00",
          unknown_enemytk_hit:		"0xF50800",
          unknown_enemytk_kill:		"0xF50800",
          unknown_enemytk_blowup:	"0xF50800",
          player_ally_hit:		"0xFFDD33",
          player_ally_kill:		"0xFFDD33",
          player_ally_blowup:		"0xFFDD33",
          player_squadman_hit:		"0xFFDD33",
          player_squadman_kill:		"0xFFDD33",
          player_squadman_blowup:	"0xFFDD33",
          player_enemy_hit:		"0xFFDD33",
          player_enemy_kill:		"0xFFDD33",
          player_enemy_blowup:		"0xFFDD33",
          player_allytk_hit:		"0xFFDD33",
          player_allytk_kill:		"0xFFDD33",
          player_allytk_blowup:		"0xFFDD33",
          player_enemytk_hit:		"0xFFDD33",
          player_enemytk_kill:		"0xFFDD33",
          player_enemytk_blowup:	"0xFFDD33"
        },
        dmg_kind: {
          attack: "0xFFAA55",
          fire: "0xFF6655",
          ramming: "0x998855",
          world_collision: "0x998855",
          other: "0xCCCCCC"
        },
        vtype: {
          LT:  "0xA2FF9A",        // Color for light tanks
          MT:  "0xFFF198",        // Color for medium tanks
          HT:  "0xFFACAC",        // Color for heavy tanks
          SPG: "0xEFAEFF",        // Color for arty
          TD:  "0xA0CFFF",        // Color for tank destroyers
          premium: "0xFFCC66",    // Color for premium tanks
          usePremiumColor: false  // Enable/disable premium color usage
        },
        // values - from min to max, colors are for values 'lesser then ...'
        hp: [
          { value: 200,  color: "0xDD0000" },
          { value: 400,  color: "0xDD3333" },
          { value: 1000, color: "0xFFCC33" },
          { value: 9999, color: "0xFFFFFF" }
        ],
        hp_ratio: [
          { value: 10,  color: "0xDD0000" },
          { value: 25,  color: "0xDD3333" },
          { value: 50,  color: "0xFFCC33" },
          { value: 101, color: "0xFFFFFF" }
        ],
        eff: [
          { value: 600,  color: "0xDD0000" },
          { value: 900,  color: "0xDD3333" },
          { value: 1200, color: "0xFFCC33" },
          { value: 1500, color: "0x99FF33" },
          { value: 1800, color: "0x33FF33" },
          { value: 9999, color: "0xCC66CC" }
        ],
        rating: [
          { value: 45,  color: "0xDD3333" },
          { value: 48,  color: "0xDDDD33" },
          { value: 51,  color: "0xFFCC33" },
          { value: 53,  color: "0x99FF33" },
          { value: 57,  color: "0x33FF33" },
          { value: 101, color: "0xCC66CC" }
        ],
        kb: [
          { value: 1,   color: "0xDD0000" },
          { value: 3,   color: "0xDD3333" },
          { value: 5,   color: "0xFFCC33" },
          { value: 8,   color: "0x99FF33" },
          { value: 12,  color: "0x33FF33" },
          { value: 999, color: "0xCC66CC" }
        ],
        t_battles: [
          { value: 100,  color: "0xDD0000" },
          { value: 200,  color: "0xDD3333" },
          { value: 300,  color: "0xFFCC33" },
          { value: 500,  color: "0x99FF33" },
          { value: 800,  color: "0x33FF33" },
          { value: 9999, color: "0xCC66CC" }
        ]
      },
      alpha: {
        // values - from min to max, transparency are for values 'lesser then ...'
        eff: [
          { value: 900,  alpha: 100 },
          { value: 1200, alpha: 100 },
          { value: 9999, alpha: 100 }
        ],
        rating: [
          { value: 49,  alpha: 100 },
          { value: 53,  alpha: 100 },
          { value: 101, alpha: 100 }
        ],
        kb: [
          { value: 2,   alpha: 100 },
          { value: 10,  alpha: 100 },
          { value: 999, alpha: 100 }
        ],
        hp: [
          { value: 200,  alpha: 100 },
          { value: 400,  alpha: 80 },
          { value: 1000, alpha: 60 },
          { value: 9999, alpha: 40 }
        ],
        hp_ratio: [
          { value: 10,  alpha: 100 },
          { value: 25,  alpha: 80 },
          { value: 50,  alpha: 60 },
          { value: 101, alpha: 40 }
        ]
      },
      iconset: {
        battleLoading: "../maps/icons/vehicle/contour",
        statisticForm: "../maps/icons/vehicle/contour",
        playersPanel:  "../maps/icons/vehicle/contour",
        vehicleMarker: "../maps/icons/vehicle/contour"
      },
      consts: consts,
      vehicleNames: VehicleInfo.getVehicleNamesData()
    };

    return a;
  }

  public static function get shadow_150(): Object
  {
    return {
      alpha: 100,
      color: "0x000000",
      angle: 90,
      distance: 0,
      size: 4,
      strength: 150
    }
  }

  public static function get shadow_200(): Object
  {
    return {
      alpha: 100,
      color: "0x000000",
      angle: 90,
      distance: 0,
      size: 6,
      strength: 200
    }
  }

  public static function get font_11b(): Object
  {
    return {
      name: "$FieldFont",
      size: 11,
      align: "center",
      bold: true,
      italic: false
    }
  }

  public static function get font_13(): Object
  {
    return {
      name: "$FieldFont",
      size: 13,
      align: "center",
      bold: false,
      italic: false
    }
  }

  public static function get font_18(): Object
  {
    return {
      name: "$FieldFont",
      size: 18,
      align: "center",
      bold: false,
      italic: false
    }
  }

  // vehicleIcon
  public static function get vi(): Object
  {
    return {
      visible: true,
      showSpeaker: false,
      x: 0,
      y: -16,
      alpha: 100,
      color: null,
      maxScale: 100,
      scaleX: 0,
      scaleY: 16,
      shadow: shadow_200
    }
  }

  // healthBar
  public static function get hb_alive(): Object
  {
    return {
      visible: true,
      x: -41,
      y: -33,
      alpha: 100,
      color: null,
      lcolor: null,
      width: 80,
      height: 12,
      border: {
        alpha: 30,
        color: "0x000000",
        size: 1
      },
      fill: {
        alpha: 30
      },
      damage: {
        alpha: 80,
        color: null,
        fade: 1
      }
    }
  }

  public static function get hb_dead(): Object
  {
    var hb:Object = hb_alive;
    hb.visible = false;
    return hb;
  }

  // damageText
  public static function get dmg(): Object
  {
    return {
      visible: true,
      x: 0,
      y: -67,
      alpha: 100,
      color: null,
      font: font_18,
      shadow: shadow_200,
      speed: 2,
      maxRange: 40,
      damageMessage: "{{dmg}}",
      blowupMessage: "Blown-up!"
    }
  }

  // contourIcon
  public static function get ci(): Object
  {
    return {
      visible: false,
      x: 6,
      y: -65,
      alpha: 100,
      color: null,
      amount: 0
    }
  }

  // clanIcon
  public static function get clanIcon(): Object
  {
    return {
      visible: false,
      x: 0,
      y: -67,
      w: 16,
      h: 16,
      alpha: 100
    }
  }

  // levelIcon
  public static function get li(): Object
  {
    return {
      visible: false,
      x: 0,
      y: -21,
      alpha: 100
    }
  }

  // actionMarker
  public static function get am(): Object
  {
    return {
      visible: true,
      x: 0,
      y: -67,
      alpha: 100
    }
  }

  /**
   * TEXT FIELDS
   */

  // playerName
  public static function get playerName_alive(): Object
  {
    return {
      name: "Player Name",
      visible: true,
      x: 0,
      y: -36,
      alpha: 100,
      color: null,
      font: font_13,
      shadow: shadow_200,
      format: "{{nick}}"
    }
  }

  public static function get playerName_dead(): Object
  {
    return {
      name: "Player Name",
      visible: true,
      x: 0,
      y: -34,
      alpha: 80,
      color: null,
      font: font_13,
      shadow: shadow_200,
      format: "{{nick}}"
    }
  }

  // vehicleName
  public static function get vehicleName_alive(): Object
  {
    return {
      name: "Vehicle Name",
      visible: true,
      x: 0,
      y: -36,
      alpha: 100,
      color: null,
      font: font_13,
      shadow: shadow_200,
      format: "{{vehicle}}{{turret}}"
    }
  }

  public static function get vehicleName_dead(): Object
  {
    return {
      name: "Vehicle Name",
      visible: true,
      x: 0,
      y: -20,
      alpha: 80,
      color: null,
      font: font_13,
      shadow: shadow_200,
      format: "{{vehicle}}"
    }
  }

  // currentHealth
  public static function get currentHealth(): Object
  {
    return {
      name: "Current Health",
      visible: true,
      x: 0,
      y: -20,
      alpha: 100,
      color: "0xFFFFFF",
      font: font_11b,
      shadow: shadow_150,
      format: "{{hp}} / {{hp-max}}"
    }
  }

  // healthRatio
  public static function get healthRatio(): Object
  {
    return {
      name: "Health Ratio",
      visible: true,
      x: 0,
      y: -20,
      alpha: 100,
      color: "0xFFFFFF",
      font: font_11b,
      shadow: shadow_150,
      format: "{{hp-ratio}}%"
    }
  }

  // ratingText
  public static function get ratingText(): Object
  {
    return {
      name: "Rating",
      visible: true,
      x: 0,
      y: -46,
      alpha: 100,
      color: "{{c:rating}}",
      font: font_11b,
      shadow: shadow_150,
      format: "{{rating}}"
    }
  }

  public static function get consts(): Object
  {
    return {
      AVG_GWR: 48,  // Average GWR. Source: http://wot-news.com/stat/server/ru/norm/en
      AVG_EFF: 900, // Average Efficiency. Source: http://wot-news.com/index.php/stat/calc/en
      AVG_BATTLES: 1000 // Averate number of battles. Source: http://wot-news.com/stat/server/ru/norm/en
    };
  }
}

}
