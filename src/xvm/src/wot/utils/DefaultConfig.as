/**
 * ...
 * @author sirmax2
 */
import wot.utils.Defines;

// TODO: translate comments to English

class wot.utils.DefaultConfig
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
        // false - отключить зеркалирование иконок танков (полезно для альтернативных иконок)
        mirroredVehicleIcons: true,
        // false - отключить всплывающую внизу панель после смерти
        showPostmortemTips: true,
        // true - убрать переключатель режимов мышкой
        removePanelsModeSwitcher: false,
        // true - включить отображение сетки координат (может быть полезным для настройки)
        drawGrid: false,
        // true - отключить отображение версии xvm в верхнем левом углу экрана
        hideXVMVersion: false
      },
      rating: {
        // true - включить отображение статистики. Глобальный переключатель - без него модуль статистики будет везде отключен.
        showPlayersStatistics: false,
        // true - включить загрузку данных по противникам в "тумане войны"
        loadEnemyStatsInFogOfWar: false
      },
      battleLoading: {
        // false - выключить отображение часов на экране загрузки боя
        showClock: true,
        // true - включить отображение шансов на победу
        showChances: false,
        // true - убрать отображение иконки взвода
        removeSquadIcon: false,
        // параметры иконки игрока/клана
        clanIcon: { show: true, x: 60, y: 4, h: 16, w: 16, alpha: 100 },
        // формат отображения (допускаются макроподстановки)
        formatLeft: "<font color='{{c:kb}}'>{{kb}}</font> <font color='{{c:eff}}'>{{eff}}</font> <font color='{{c:rating}}'>{{rating}}</font>",
        formatRight: "<font color='{{c:rating}}'>{{rating}}</font> <font color='{{c:eff}}'>{{eff}}</font> <font color='{{c:kb}}'>{{kb}}</font>"
      },
      statisticForm: {
        // true - включить отображение шансов на победу
        showChances: false,
        // true - убрать отображение иконки взвода
        removeSquadIcon: false,
        // параметры иконки игрока/клана
        clanIcon: { show: true, x: 60, y: 4, h: 16, w: 16, alpha: 100 },
        // формат отображения
        formatLeft: "<font color='{{c:kb}}'>{{kb}}</font> <font color='{{c:eff}}'>{{eff}}</font> <font color='{{c:rating}}'>{{rating}}</font>",
        formatRight: "<font color='{{c:rating}}'>{{rating}}</font> <font color='{{c:eff}}'>{{eff}}</font> <font color='{{c:kb}}'>{{kb}}</font>"
      },
      playersPanel: {
        // 0..100 - задает прозрачность "ушей". 0 - прозрачные, 100 - не прозрачные
        alpha: 60,
        // 0..100 - задает прозрачность иконок в "ушах". 0 - прозрачные, 100 - не прозрачные
        iconAlpha: 100,
        // true - убрать отображение иконки взвода
        removeSquadIcon: false,
        // параметры иконки игрока/клана
        clanIcon: { show: false, x: 60, y: 4, h: 16, w: 16, alpha: 100 },
        // режим medium1
        medium: {
          // 0..250 - задает ширину поля имени игрока. По умолчанию: 46
          width: 46,
          // формат отображения
          formatLeft: "<font color='{{c:eff}}'>{{nick}}</font>",
          formatRight: "<font color='{{c:eff}}'>{{nick}}</font>"
        },
        // режим medium2
        medium2: {
          // 0..250 - задает ширину поля имени игрока. По умолчанию: 65
          width: 65,
          // формат отображения
          formatLeft: "<font color='{{c:eff}}'>{{vehicle}}</font>",
          formatRight: "<font color='{{c:eff}}'>{{vehicle}}</font>"
        },
        // режим large
        large: {
          // 0..250 - задает ширину поля имени игрока. По умолчанию: 170
          width: 170,
          // формат отображения
          nickFormatLeft: "<font color='{{c:eff}}'>{{rating}}</font> {{nick}}",
          nickFormatRight: "{{nick}} <font color='{{c:eff}}'>{{rating}}</font>",
          vehicleFormatLeft: "<font color='{{c:rating}}'>{{vehicle}}</font>",
          vehicleFormatRight: "<font color='{{c:rating}}'>{{vehicle}}</font>"
        }
      },
      markers: {
        ally: {
          alive: {
            normal: {
              vehicleIcon: vi,
              healthBar: hb_alive,
              damageText: dmg,
              contourIcon: ci,
              levelIcon: li,
              actionMarker: am,
              textFields: [ vehicleName_alive, currentHealth ]
            },
            extended: {
              vehicleIcon: vi,
              healthBar: hb_alive,
              damageText: dmg,
              contourIcon: ci,
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
              levelIcon: li,
              actionMarker: am,
              textFields: [  ]
            },
            extended: {
              vehicleIcon: vi,
              healthBar: hb_dead,
              damageText: dmg,
              contourIcon: ci,
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
              levelIcon: li,
              actionMarker: am,
              textFields: [ vehicleName_alive, currentHealth ]
            },
            extended: {
              vehicleIcon: vi,
              healthBar: hb_alive,
              damageText: dmg,
              contourIcon: ci,
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
              levelIcon: li,
              actionMarker: am,
              textFields: [  ]
            },
            extended: {
              vehicleIcon: vi,
              healthBar: hb_dead,
              damageText: dmg,
              contourIcon: ci,
              levelIcon: li,
              actionMarker: am,
              textFields: [ playerName_dead, vehicleName_dead ]
            }
          }
        }
      },
      colors: {
        system: {
          ally_alive_normal: "0x96FF00",
          ally_alive_blind: "0x96FF00",
          ally_dead_normal: "0x009900",
          ally_dead_blind: "0x009900",
          ally_blowedup_normal: "0x007700",
          ally_blowedup_blind: "0x007700",
          squadman_alive_normal: "0xFFB964",
          squadman_alive_blind: "0xFFFF00",
          squadman_dead_normal: "0xCA7000",
          squadman_dead_blind: "0xAAAA00",
          squadman_blowedup_normal: "0xA45A00",
          squadman_blowedup_blind: "0x888800",
          teamKiller_alive_normal: "0x00EAFF",
          teamKiller_alive_blind: "0x00EAFF",
          teamKiller_dead_normal: "0x097783",
          teamKiller_dead_blind: "0x097783",
          teamKiller_blowedup_normal: "0x096A75",
          teamKiller_blowedup_blind: "0x096A75",
          enemy_alive_normal: "0xF50800",
          enemy_alive_blind: "0x8379FE",
          enemy_dead_normal: "0x840500",
          enemy_dead_blind: "0x47407A",
          enemy_blowedup_normal: "0x5A0401",
          enemy_blowedup_blind: "0x3B365F"
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
          { value: 42,  color: "0xDD0000" },
          { value: 46,  color: "0xDD3333" },
          { value: 49,  color: "0xDDDD33" },
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
      players: [
        { nick: "sirmax2", icon: "../../../clanicons/XVM.png" },
        { nick: "0x01",    icon: "../../../clanicons/XVM.png" },
        { clan: "[WG]",    icon: "../../../clanicons/WG.png" },
        { clan: "[WG-A]",  icon: "../../../clanicons/WG.png" },
        { clan: "[WTMOD]", icon: "../../../clanicons/WTMOD.png" },
        { clan: "[WGST]",  icon: "../../../clanicons/WGST.png" }
      ]
    };

    return a;
  }

  public static function get shadow_60(): Object
  {
    return {
      alpha: 100,
      color: "0x000000",
      angle: 45,
      strength: 60,
      distance: 1,
      size: 1
    }
  }

  public static function get shadow_120(): Object
  {
    return {
      alpha: 100,
      color: "0x000000",
      angle: 45,
      strength: 120,
      distance: 1,
      size: 1
    }
  }

  public static function get shadow_200(): Object
  {
    return {
      alpha: 100,
      color: "0x000000",
      angle: 45,
      strength: 200,
      distance: 1,
      size: 1
    }
  }

  public static function get font_11b(): Object
  {
    return {
      name: "$FieldFont",
      size: 11,
      align: "center",
      bold: true
    }
  }

  public static function get font_12b(): Object
  {
    return {
      name: "$FieldFont",
      size: 12,
      align: "center",
      bold: true
    }
  }

  public static function get font_13(): Object
  {
    return {
      name: "$FieldFont",
      size: 13,
      align: "center",
      bold: false
    }
  }

  public static function get font_13b(): Object
  {
    return {
      name: "$FieldFont",
      size: 13,
      align: "center",
      bold: true
    }
  }

  public static function get font_14b(): Object
  {
    return {
      name: "$FieldFont",
      size: 14,
      align: "center",
      bold: true
    }
  }

  // vehicleIcon
  public static function get vi(): Object
  {
    return {
      visible: true,
      x: 0,
      y: -16,
      alpha: 100,
      color: null,
      maxScale: 100,
      scaleX: 0,
      scaleY: 16,
      shadow: shadow_120
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
      height: 11,
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
    return {
      visible: false,
      x: -41,
      y: -33,
      alpha: 100,
      color: null,
      lcolor: null,
      width: 80,
      height: 11,
      border: {
        alpha: 30,
        color: "0x000000",
        size: 1
      },
      fill: {
        alpha: 30,
        color: null
      },
      damage: {
        alpha: 80,
        color: null,
        fade: 1
      }
    }
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
      font: font_14b,
      shadow: shadow_200,
      speed: 2,
      maxRange: 40,
      damageMessage: "-{{dmg}}",
      blowupMessage: "Blow-up!"
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
      shadow: shadow_120,
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
      shadow: shadow_120,
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
      shadow: shadow_120,
      format: "{{vehicle}}"
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
      shadow: shadow_120,
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
      shadow: shadow_60,
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
      shadow: shadow_60,
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
      y: -50,
      alpha: 75,
      color: "{{c:eff}}",
      font: font_12b,
      shadow: shadow_120,
      format: "{{rating}}"
    }
  }
}
