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
    return
    {
      configVersion: Defines.CONFIG_VERSION,
      editorVersion: Defines.EDITOR_VERSION,
      definition: {
        author: "sirmax2",
        description: "Default settings for XVM",
        url: "http://code.google.com/p/wot-xvm/",
        date: (new Date()).toString(),
        gameVersion: Defines.WOT_VERSION,
        modMinVersion: Defines.XVM_VERSION
      },
      battle: {
        /* false - отключить зеркалирование иконок танков (полезно для альтернативных иконок) */
        mirroredVehicleIcons: true,
        /* false - отключить всплывающую внизу панель после смерти */
        showPostmortemTips: true,
        /* 0..100 - задает прозрачность "ушей". 0 - прозрачные, 100 - не прозрачные */
        playersPanelAlpha: 100,
        /* 0..170 - задает ширину поля имени игрока в "ушах" в широком режиме. По умолчанию: 170 */
        playersPanelLargeWidth: 170,
        /* true - включить отображение сетки координат (может быть полезным для настройки) */
        drawGrid: false
      },
      rating: {
        /* true - включить отображение статистики. Глобальный переключатель - без него модуль статистики будет везде отключен. */
        showPlayersStatistics: false,
        /* true - включить загрузку данных по противникам в "тумане войны" */
        loadEnemyStatsInFogOfWar: false,
        battleLoading: {
          /* false - отключить отображение статистики в окне загрузки боя */
          show: true,
          /* формат отображения (допускаются макроподстановки) */
          format: "<font color='{{c:kb}}'>{{kb}}</font> <font color='{{c:eff}}'>{{eff}}</font> <font color='{{c:rating}}'>{{rating}}</font>"
        },
        playersPanel: {
          /* false - отключить отображение статистики в широких ушах */
          show: true,
          /* формат отображения */
          format: "<font color='{{c:eff}}'>{{rating}}</font>",
          /* цвет в средних ушах. Чтобы оставить стандартный, необходимо удалить значение */
          middleColor: "{{c:eff}}"
        },
        statisticForm: {
          /* false - отключить отображение статистики в окне статистики боя (по клавише Tab) */
          show: true,
          /* формат отображения */
          format: "<font color='{{c:kb}}'>{{kb}}</font> <font color='{{c:eff}}'>{{eff}}</font> <font color='{{c:rating}}'>{{rating}}</font>"
        }
      },
      colors: {
        /* values - from min to max, colors are for values 'lesser then ...' */
        eff: [
          { value: 600,  color: 0xDD0000 },
          { value: 900,  color: 0xDD3333 },
          { value: 1200, color: 0xFFCC33 },
          { value: 1500, color: 0x99FF33 },
          { value: 1800, color: 0x33FF33 },
          { value: 9999, color: 0xCC66CC }
        ],
        rating: [
          { value: 42,  color: 0xDD0000 },
          { value: 46,  color: 0xDD3333 },
          { value: 49,  color: 0xDDDD33 },
          { value: 51,  color: 0xFFCC33 },
          { value: 53,  color: 0x99FF33 },
          { value: 57,  color: 0x33FF33 },
          { value: 101, color: 0xCC66CC }
        ],
        kb: [
          { value: 1,   color: 0xDD0000 },
          { value: 3,   color: 0xDD3333 },
          { value: 5,   color: 0xFFCC33 },
          { value: 8,   color: 0x99FF33 },
          { value: 12,  color: 0x33FF33 },
          { value: 999, color: 0xCC66CC }
        ],
        hp: [
          { value: 200,  color: 0xDD0000 },
          { value: 400,  color: 0xDD3333 },
          { value: 1000, color: 0xFFCC33 },
          { value: 9999, color: 0xFFFFFF }
        ],
        hp_ratio: [
          { value: 10,  color: 0xDD0000 },
          { value: 25,  color: 0xDD3333 },
          { value: 50,  color: 0xFFCC33 },
          { value: 101, color: 0xFFFFFF }
        ]
      },
      alpha: {
        /* values - from min to max, transparency are for values 'lesser then ...' */
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
      }
    };
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
