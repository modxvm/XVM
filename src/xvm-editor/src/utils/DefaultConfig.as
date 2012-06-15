/**
 * ...
 * @author sirmax2
 */
package utils
{
import utils.Defines;

// TODO: translate comments to English

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
        // false - отключить зеркалирование иконок танков (полезно для альтернативных иконок)
        mirroredVehicleIcons: true,
        // false - отключить всплывающую внизу панель после смерти
        showPostmortemTips: true,
        // true - убрать переключатель режимов мышкой
        removePanelsModeSwitcher: false,
        // true - включить отображение сетки координат (может быть полезным для настройки)
        drawGrid: false,
        // true - отключить отображение версии xvm в верхнем левом углу экрана
        hideXVMVersion: false,
        // true - использовать стандартные маркеры клиента (не работает)
        useStandardMarkers: false
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
        showChances: true,
        // true - убрать отображение иконки взвода
        removeSquadIcon: false,
        // параметры иконки игрока/клана
        clanIcon: { show: true, x: 0, y: 6, xr: NaN, yr: NaN, h: 16, w: 16, alpha: 90 },
        // формат отображения (допускаются макроподстановки)
        formatLeft: "<font color='{{c:kb}}'>{{kb}}</font> <font color='{{c:eff}}'>{{eff}}</font> <font color='{{c:rating}}'>{{rating}}</font>",
        formatRight: "<font color='{{c:rating}}'>{{rating}}</font> <font color='{{c:eff}}'>{{eff}}</font> <font color='{{c:kb}}'>{{kb}}</font>"
      },
      statisticForm: {
        // true - включить отображение шансов на победу
        showChances: true,
        // true - убрать отображение иконки взвода
        removeSquadIcon: false,
        // параметры иконки игрока/клана
        clanIcon: { show: true, x: 0, y: 6, xr: NaN, yr: NaN, h: 16, w: 16, alpha: 90 },
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
        clanIcon: { show: true, x: 0, y: 6, xr: NaN, yr: NaN, h: 16, w: 16, alpha: 90 },
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
      players: players
    };

    return a;
  }

  public static function get shadow_100(): Object
  {
    return {
      alpha: 100,
      color: "0x000000",
      angle: 45,
      distance: 1,
      size: 2,
      strength: 100
    }
  }

  public static function get shadow_200(): Object
  {
    return {
      alpha: 100,
      color: "0x000000",
      angle: 45,
      distance: 1,
      size: 2,
      strength: 200
    }
  }

  public static function get shadow_250(): Object
  {
    return {
      alpha: 100,
      color: "0x000000",
      angle: 45,
      distance: 1,
      size: 2,
      strength: 250
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
      showSpeaker: false,
      x: 0,
      y: -16,
      alpha: 100,
      color: null,
      maxScale: 100,
      scaleX: 0,
      scaleY: 16,
      shadow: shadow_250
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
    return {
      visible: false,
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
      shadow: shadow_250,
      speed: 2,
      maxRange: 40,
      damageMessage: "{{dmg}}",
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
      shadow: shadow_100,
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
      shadow: shadow_100,
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
      alpha: 75,
      color: "{{c:eff}}",
      font: font_12b,
      shadow: shadow_200,
      format: "{{rating}}"
    }
  }

  public static function get players(): Array
  {
    return [
      { root: "../../../clanicons", folders: "RU,EU,NA,CT" },
      { folder: "RU", players: [
          { nick: "sirmax2",    icon: "XVM.png" },
          { nick: "0x01",       icon: "XVM.png" },
          { clan: "[WG]",       icon: "WG.png" },
          { clan: "[WG-A]",     icon: "WG.png" },
          { clan: "[WTMOD]",    icon: "WTMOD.png" },
          { clan: "[WGST]",     icon: "WGST.png" },
          { clan: "[S_O_R]",    icon: "sor.png" },
          { clan: "[TD42]",     icon: "td42.png"},
          { clan: "[TD42A]",    icon: "td42.png"},
          { clan: "[TD42B]",    icon: "td42.png"},
          { clan: "[TD42R]",    icon: "td42.png"},
          { clan: "[BEES]",     icon: "bees.png"},
          { clan: "[HIVE]",     icon: "bees.png"},
          { clan: "[LAIR]",     icon: "bees.png"},
          { clan: "[CAIM]",     icon: "caim.png"},
          { clan: "[CAIM2]",    icon: "caim.png"},
          { clan: "[DEFS]",     icon: "defs.png"},
          { clan: "[DEFS2]",    icon: "defs2.png"},
          { clan: "[ENOT]",     icon: "enot.png" },
          { clan: "[FRS",       icon: "frs.png" },
          { clan: "[G_O_W]",    icon: "gow.png" },
          { clan: "[_GOW_]",    icon: "gow.png" },
          { clan: "[G_0_W]",    icon: "gow.png" },
          { clan: "[G-O-W]",    icon: "gow.png" },
          { clan: "[GREEN]",    icon: "green.png" },
          { clan: "[GREEH]",    icon: "green.png" },
          { clan: "[GRN-R]",    icon: "GRN-R.png" },
          { clan: "[H4RD",      icon: "h4rd.png" },
          { clan: "[IR0NT]",    icon: "iron.png" },
          { clan: "[KO3AK",     icon: "kozak.png" },
          { clan: "[OLENI",     icon: "oleni.png" },
          { clan: "[0_0",       icon: "oo.png" },
          { clan: "[PZE]",      icon: "pze.png" },
          { clan: "[PZE-N]",    icon: "pze.png" },
          { clan: "[PZE-O]",    icon: "pze.png" },
          { clan: "[PZE-B]",    icon: "pze.png" },
          { clan: "[PZE-G]",    icon: "pze.png" },
          { clan: "[RATTE]",    icon: "ratte.png" },
          { clan: "[PATTE]",    icon: "patte.png" },
          { clan: "[RKKA]",     icon: "rkka.png" },
          { clan: "[RKKA3]",    icon: "rkka.png" },
          { clan: "[RKKA4]",    icon: "rkka.png" },
          { clan: "[SB_F]",     icon: "SB_F.png" },
          { clan: "[SB--K]",    icon: "SB--K.png" },
          { clan: "[SB-E]",     icon: "SB-E.png" },
          { clan: "[SB-H]",     icon: "SB-H.png" },
          { clan: "[SB_K]",     icon: "SB_K.png" },
          { clan: "[STAL1]",    icon: "stal.png" },
          { clan: "[STAL2]",    icon: "stal.png" },
          { clan: "[STAL3]",    icon: "stal.png" },
          { clan: "[STAL6]",    icon: "stal.png" },
          { clan: "[STAL7]",    icon: "stal.png" },
          { clan: "[STAL_]",    icon: "stal.png" },
          { clan: "[3STAL]",    icon: "stal.png" },
          { clan: "[STAL5]",    icon: "stal.png" },
          { clan: "[STAL0]",    icon: "stal.png" },
          { clan: "[STALX]",    icon: "stal.png" },
          { clan: "[STAL9]",    icon: "stal.png" },
          { clan: "[8STAL]",    icon: "stal.png" },
          { clan: "[TAIP",      icon: "taip.png" },
          { clan: "[VES]",      icon: "ves.png"},
          { clan: "[V_E_S]",    icon: "ves.png"},
          { clan: "[XOVER",     icon: "xover.png" },
          { clan: "[SAM]",      icon: "samurai.png" },
          { clan: "[NSTR]",     icon: "nstr.png" },
          { clan: "[DARK_]",    icon: "da.png" },
          { clan: "[AMIG0]",    icon: "amigo.png" },
          { clan: "[B-SKY]",    icon: "bsky.png" },
          { clan: "[_E_]",      icon: "e.png" },
          { clan: "[CWOT",      icon: "cwot.png" },
          { clan: "[BTR]",      icon: "btr.png" },
          { clan: "[BTR2]",     icon: "btr.png" },
          { clan: "[CHESS]",    icon: "chess.png" },
          { clan: "[4S-B]",     icon: "4S-B.png" },
          { clan: "[URFO]",     icon: "urfo.png" },
          { clan: "[URF0]",     icon: "urfo.png" },
          { clan: "[W_R]",      icon: "wr.png" },
          { clan: "[PIKET]",    icon: "PIKET.png" },
          { clan: "[-KNI-]",    icon: "kni.png" },
          { clan: "[GUEST]",    icon: "guest.png" },
          { clan: "[_CT_]",     icon: "st.png" },
          { clan: "[C0BRA]",    icon: "cobra.png" },
          { clan: "[COBRA]",    icon: "cobra.png" },
          { clan: "[GRXOA]",    icon: "xover.png" },
          { clan: "[JAZZ]",     icon: "jazz.png" },
          { clan: "[ZB]",       icon: "zb.png" },
          { clan: "[ZB-A]",     icon: "zb.png" },
          { clan: "[--S--]",    icon: "s.png" },
          { clan: "[TGD]",      icon: "tgd.png" },
          { clan: "[LA]",       icon: "la.png" },
          { clan: "[RED]",      icon: "RED.png" },
          { clan: "[RED-E]",    icon: "RED.png" },
          { clan: "[RED-N]",    icon: "RED.png" },
          { clan: "[RED-S]",    icon: "RED.png" },
          { clan: "[RED-W]",    icon: "RED.png" },
          { clan: "[RED-Z]",    icon: "RED.png" },
          { clan: "[RED-A]",    icon: "RED.png" },
          { clan: "[RED-L]",    icon: "RED.png" },
          { clan: "[RED-Y]",    icon: "RED.png" },
          { clan: "[RED-K]",    icon: "redk.png" },
          { clan: "[RED_W]",    icon: "red-b.png" },
          { clan: "[RED_A]",    icon: "aces.png" },
          { clan: "[RED_K]",    icon: "RED.png" },
          { clan: "[RED-J]",    icon: "RED.png" },
          { clan: "[RED-F]",    icon: "red-b.png" },
          { clan: "[RED]",      icon: "RED.png" },
          { clan: "[RED-0]",    icon: "red-b.png" },
          { clan: "[RED-U]",    icon: "RED.png" },
          { clan: "[REDMG]",    icon: "RED.png" },
          { clan: "[RED_M]",    icon: "red-b.png" },
          { clan: "[RED-B]",    icon: "red-b.png" },
          { clan: "[RED-Q]",    icon: "red-b.png" },
          { clan: "[TIRED]",    icon: "tired.png" },
          { clan: "[YKT]",      icon: "ykt.png" },
          { clan: "[NOMAD]",    icon: "nomad.png" },
          { clan: "[OOPS",      icon: "oops.png" },
          { clan: "[GAD]",      icon: "gad.png" },
          { clan: "[LJ",        icon: "lj.png" },
          { clan: "[1CLUB]",    icon: "fc.png" },
          { clan: "[-TAU-]",    icon: "tau.png" },
          { clan: "[_WVW_]",    icon: "WVW.png" },
          { clan: "[VND]",      icon: "VND.png" },
          { clan: "[_GS_]",     icon: "GS.png" },
          { clan: "[SHDS]",     icon: "sh.png" },
          { clan: "[RGR]",      icon: "RGR.png" },
          { clan: "[RGR-2]",    icon: "RGR.png" },
          { clan: "[MAMTH]",    icon: "mmth.png" },
          { clan: "[YOKO]",     icon: "yoko.png" },
          { clan: "[SITH]",     icon: "SITH.png" },
          { clan: "[TG74]",     icon: "tg74.png" },
          { clan: "[LOL]",      icon: "lol.png" },
          { clan: "[AWA]",      icon: "awa.png" },
          { clan: "[NOD]",      icon: "nod.png" },
          { clan: "[MCDAC]",    icon: "MCDAC.png" },
          { clan: "[LADY]",     icon: "lady.png" }
        ]
      },
      { folder: "EU", players: [
          { nick: "Yoyo117",    icon: "XVM.png" },
          { nick: "sirmax2",    icon: "XVM.png" },
          { clan: "[INC-A]",    icon: "inc-a.png" },
          { clan: "[WG]",       icon: "WG.png" },
          { clan: "[OM]",       icon: "om.png" },
          { clan: "[OM-V]",     icon: "om-v.png" },
          { clan: "[OM-X]",     icon: "om-x.png" },
          { clan: "[OM-BC]",    icon: "ombc.png" },
          { clan: "[PTS]",      icon: "pts.png" },
          { clan: "[V-V-V]",    icon: "vvv.png" },
          { clan: "[HARD]",     icon: "hard.png" },
          { clan: "[HARDS]",    icon: "hards.png" },
          { clan: "[HARD2]",    icon: "hard2.png" },
          { clan: "[1SBP]",     icon: "1sbp.png" },
          { clan: "[2SBP]",     icon: "2sbp.png" },
          { clan: "[3SBP]",     icon: "3sbp.png" },
          { clan: "[EPIC]",     icon: "epic.png" },
          { clan: "[MARS]",     icon: "mars.png" },
          { clan: "[PMHC]",     icon: "pmhc.png" },
          { clan: "[PMHC2]",    icon: "pmhc2.png" },
          { clan: "[MUMMY]",    icon: "mummy.png" },
          { clan: "[ISTI]",     icon: "isti.png" },
          { clan: "[ISTI2]",    icon: "isti2.png" },
          { clan: "[ISTI3]",    icon: "isti3.png" },
          { clan: "[ISTI4]",    icon: "isti3.png" },
          { clan: "[EPA]",      icon: "epa.png" },
          { clan: "[WT]",       icon: "wt.png" },
          { clan: "[VVT]",      icon: "wt.png" },
          { clan: "[VVTF]",     icon: "wt.png" },
          { clan: "[DID]",      icon: "did.png" },
          { clan: "[DIDO]",     icon: "dido.png" },
          { clan: "[JOD]",      icon: "jod.png" },
          { clan: "[-BR-]",     icon: "br.png" },
          { clan: "[CSA]",      icon: "csa.png" },
          { clan: "[CSA-",      icon: "csa.png" },
          { clan: "[BIA]",      icon: "bia.png" },
          { clan: "[BIA-2]",    icon: "bia2.png" },
          { clan: "[NOB]",      icon: "nob.png" },
          { clan: "[SLF]",      icon: "slf.png" },
          { clan: "[SLF2]",     icon: "slf2.png" },
          { clan: "[ODV]",      icon: "odv.png" },
          { clan: "[-SB-]",     icon: "-sb-.png" },
          { clan: "[SB-R]",     icon: "sbr.png" },
          { clan: "[SB_2]",     icon: "sb2.png" },
          { clan: "[1PADX]",    icon: "1padx.png" },
          { clan: "[JNA]",      icon: "jna.png" },
          { clan: "[EES]",      icon: "ees.png" },
          { clan: "[EES2]",     icon: "ees.png" },
          { clan: "[-AX-]",     icon: "ax.png" },
          { clan: "[PX]",       icon: "px.png" },
          { clan: "[TAC]",      icon: "tac.png" },
          { clan: "[ASEET]",    icon: "aseet.png" },
          { clan: "[PRT]",      icon: "prt.png" },
          { clan: "[IC]",       icon: "ic.png" },
          { clan: "[EFE]",      icon: "efe.png" },
          { clan: "[ANV]",      icon: "anv.png" },
          { clan: "[HUHN]",     icon: "huhn.png" },
          { clan: "[BR1]",      icon: "br1.png" },
          { clan: "[507]",      icon: "507.png" },
          { clan: "[G-A-D]",    icon: "g-a-d.png" },
          { clan: "[FROG]",     icon: "frog.png" },
          { clan: "[-ANV-]",    icon: "-anv-.png" },
          { clan: "[FROG1]",    icon: "frog1.png" },
          { clan: "[-RPD-]",    icon: "-rpd-.png" },
          { clan: "[G-A-A]",    icon: "g-a-a.png" },
          { clan: "[SBG]",      icon: "sbg.png" },
          { clan: "[130]",      icon: "130.png" },
          { clan: "[5O3]",      icon: "5o3.png" },
          { clan: "[PVE]",      icon: "pve.png" },
          { clan: "[OPNV]",     icon: "opnv.png" },
          { clan: "[RADAU]",    icon: "radau.png" },
          { clan: "[BIH]",      icon: "bih.png" },
          { clan: "[D-R-K]",    icon: "d-r-k.png" },
          { clan: "[SRSLY]",    icon: "srsly.png" },
          { clan: "[DTT]",      icon: "dtt.png" },
          { clan: "[GM-K]",     icon: "gm-k.png" },
          { clan: "[S-G]",      icon: "s-g.png" },
          { clan: "[BG-DH]",    icon: "bg-dh.png" },
          { clan: "[VI]",       icon: "vi.png" },
          { clan: "[FROG2]",    icon: "frog2.png" },
          { clan: "[GS_]",      icon: "gs_.png" },
          { clan: "[205TH]",    icon: "205th.png" },
          { clan: "[GBP]",      icon: "gbp.png" },
          { clan: "[DEI]",      icon: "dei.png" },
          { clan: "[SIS]",      icon: "sis.png" },
          { clan: "[FBFU]",     icon: "fbfu.png" },
          { clan: "[GOH]",      icon: "goh.png" },
          { clan: "[-PHX-]",    icon: "-phx-.png" },
          { clan: "[KKC]",      icon: "kkc.png" },
          { clan: "[7PZD]",     icon: "7pzd.png" },
          { clan: "[GTT]",      icon: "gtt.png" },
          { clan: "[-PRC-]",    icon: "-prc-.png" },
          { clan: "[-BD-]",     icon: "-bd-.png" },
          { clan: "[SIEG]",     icon: "sieg.png" },
          { clan: "[BTC]",      icon: "btc.png" },
          { clan: "[DLA]",      icon: "dla.png" },
          { clan: "[G-A-B]",    icon: "g-a-b.png" },
          { clan: "[DGW-E]",    icon: "dgw-e.png" },
          { clan: "[-69-]",     icon: "-69-.png" },
          { clan: "[STS]",      icon: "sts.png" },
          { clan: "[RED-R]",    icon: "red-r.png" },
          { clan: "[GOLD]",     icon: "gold.png" },
          { clan: "[RT]",       icon: "rt.png" },
          { clan: "[A-P]",      icon: "a-p.png" },
          { clan: "[-XII-]",    icon: "-xii-.png" },
          { clan: "[FAIL]",     icon: "fail.png" },
          { clan: "[-SGL-]",    icon: "-sgl-.png" },
          { clan: "[VTEPS]",    icon: "vteps.png" },
          { clan: "[LAS]",      icon: "las.png" },
          { clan: "[SAO]",      icon: "sao.png" },
          { clan: "[S-D]",      icon: "s-d.png" },
          { clan: "[PPKI]",     icon: "ppki.png" },
          { clan: "[-LTU-]",    icon: "-ltu-.png" },
          { clan: "[RDR]",      icon: "rdr.png" },
          { clan: "[POP]",      icon: "pop.png" },
          { clan: "[13D]",      icon: "13d.png" },
          { clan: "[K-_-K]",    icon: "k-_-k.png" },
          { clan: "[FAFE]",     icon: "fafe.png" },
          { clan: "[XX0XX]",    icon: "xx0xx.png" },
          { clan: "[13DF]",     icon: "13df.png" },
          { clan: "[EUC-1]",    icon: "euc-1.png" },
          { clan: "[210]",      icon: "210.png" },
          { clan: "[D-BS]",     icon: "d-bs.png" },
          { clan: "[GUD]",      icon: "gud.png" },
          { clan: "[LECA]",     icon: "leca.png" },
          { clan: "[-AK-]",     icon: "-ak-.png" },
          { clan: "[TGM]",      icon: "tgm.png" },
          { clan: "[1-IS]",     icon: "1-is.png" },
          { clan: "[CZPIP]",    icon: "czpip.png" }
        ]
      },
      { folder: "NA", players: [
          { nick: "sirmax",     icon: "XVM.png" },
          { clan: "[WGA]",      icon: "WG.png" }
        ]
      },
      { folder: "CT", players: [
          { nick: "sirmax2_RU", icon: "XVM.png" },
          { nick: "0x01_RU",    icon: "XVM.png" },
          { nick: "Yoyo117_EU", icon: "XVM.png" },
          { clan: "[WG]",       icon: "WG.png" }
        ]
      }
    ];
  }
}
}
