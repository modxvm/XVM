{
  "configVersion": "6.1.0",
  "autoReloadConfig": true,
  //"language": "pl",
  "def": {
    "formatNick": "{{name%.20s~..}}<font alpha='#A0'>{{clan}}</font>",
    "formatVehicle": "<font face='Consolas' size='11'><img src='xvm://res/icons/xvm/xvm-user-{{xvm-user}}.png'><img src='xvm://res/icons/flags/{{flag|default}}.png' width='16' height='11'><font color='{{c:avglvl|#666666}}'>{{avglvl%d|-}}</font> <font color='{{t-battles>19?{{c:xte|#666666}}|#666666}}'>{{xte|--}}</font>|<font color='{{c:xwgr|#666666}}'>{{xwgr|--}}</font>|<font color='{{c:xeff|#666666}}'>{{xeff|--}}</font>|<font color='{{c:xwn8|#666666}}'>{{xwn8|--}}</font> <font color='{{c:kb|#666666}}'>{{kb%2d~k|--k}}</font></font>",
    //"formatVehicle": "{{vehicle}}",

    "pingServers": {
      "enabled": true,
      //"y": 70,
      "ignoredServers": ["RU4", "RU8", "RU9"],
      "showTitle": false,
      "updateInterval": 5000
    },
    "onlineServers": {
      "enabled": true,
      "x": 5,
      "y": 80,
      "hAlign": "left",
      "ignoredServers": ["RU4", "RU8", "RU9"],
      //"topmost": true,
      "showTitle": false
    },
    "__stub__": null
  },
  "hotkeys": {
    //"minimapZoom": { "enabled": true, "keyCode": 29, "onHold": true },
    //"minimapAltMode": { "enabled": true, "keyCode": 29, "onHold": true },
    "playersPanelAltMode": { "enabled": true, "keyCode": 56 }, // LAlt
    //"markersAltMode":      { "enabled": false, "onHold": false },
    "__stub__": {}
  },
  "elements": [
    //${"sirmax-snippet-pp.xc":"."}, // players panels
    //${"sirmax-snippet-bt.xc":"."}, // battle timer
    ${"sirmax-snippet-test.xc":"."}
  ],
  "login": {
    //"skipIntro": false,
    "saveLastServer": true,
    "autologin": true,
    //"confirmOldReplays": true,
    "pingServers": ${"def.pingServers"},
    "onlineServers": ${"def.onlineServers"}
  },
  "hangar": {
    "enableGoldLocker": true,
    "enableFreeXpLocker": true,
    "defaultBoughtForCredits": true,
    "hidePricesInTechTree": true,
    "masteryMarkInTechTree": true,
    "allowExchangeXPInTechTree": false,
    "blockVehicleIfNoAmmo": true,
    //"enableCrewAutoReturn": false,
    //"crewReturnByDefault": true,
    "enableEquipAutoReturn": true,
    "showShootRangeTooltip": true,
    "widgetsEnabled": true,
    "pingServers": {
      "$ref": { "path":"def.pingServers" },
      "x": 5
    },
    "carousel": ${"sirmax-carousel.xc":"carousel"},
    "clock": {
      //"x": 100,
      //"y": 5,
      //"format": "<font face='$FieldFont'><font size='26'> {{H}}:{{m%02d}} {{AM?a.m.|p.m.}}</font></font>"
    },
    "serverInfo": {
      //"enabled": false,
      "alpha": 75
    }
  },
  "userInfo": {
    "inHangarFilterEnabled": true,
    "startPage": 4,
    "sortColumn": 3,
    //"sortColumn": -9,
    //"showXTEColumn": false,
    "defaultFilterValue": "+all -premium -master -arty"
  },
  "squad": {
    //"enabled": true,
    //"romanNumbers": false,
    //"showClan": false,
    "formatInfoField": "{{rlevel}}"
  },
  "battle": {
    "mirroredVehicleIcons": false,
    "showPostmortemTips": false,
    "highlightVehicleIcon": false,
    //"allowSpottedStatus": false,
    "allowHpInPanelsAndMinimap": true,
    "allowMarksOnGunInPanelsAndMinimap": true,
    "clanIconsFolder": "clanicons",
    "sixthSenseIcon": "cfg://sirmax/img/SixthSense.png",
    "elements": ${"elements"},
    "minimapDeadSwitch": true,
    "camera": {
      "enabled": true,
      "noScroll": true,
      "arcade": {
        "distRange": [2, 50],
        "startDist": 30,
        "scrollSensitivity": 2.5,
        "dynamicCameraEnabled": false
      },
      "postmortem": {
        "distRange": [2, 100],
        "startDist": 30,
        "scrollSensitivity": 2.5,
        "dynamicCameraEnabled": false
      },
      "strategic": {
        "distRange": [30, 250],
        "dynamicCameraEnabled": false
      },
      "sniper": {
        "zooms": [2, 4, 8, 16],
        "dynamicCameraEnabled": false,
        "zoomIndicator": {
          //"x": -100,
          //"y": 0,
          //"width": 100,
          //"height": 40,
          //"alpha": 100,
          //"align": "left",
          //"valign": "center",
          //"bgColor": null,
          //"borderColor": "0xFFFF00",
          //"shadow": { "distance": 0, "angle": 45, "color": "0x000000", "alpha": 80, "blur": 2, "strength": 4 },
          //"format": "<font face='$FieldFont' size='20'>frags:{{my-frags}} x{{zoom}}</font>",
          "enabled": true,
          "__stub__": null
        }
      }
    }
  },
  "fragCorrelation": {
    //"showAliveNotFrags": true
  },
  "captureBar": {
    //"enabled": false,
    //"allyColor": "0xFFFF00",
    //"enemyColor": "0x00FFFF",
    //"ally": { "primaryTitleFormat":   "<font size='15' color='#FFFFFF'>{0} {{extra}}</font>" },
    "__stub__": null
  },
  "battleLoading": {
    "showBattleTier": true,
    //"removeSquadIcon": true,
    "removeVehicleLevel": true,
    "removeVehicleTypeIcon": true,
    //"nameFieldShowBorder": true,
    //"vehicleFieldShowBorder": true,
    //"squadIconOffsetXLeft": "{{xvm-stat?-32|0}}",
    //"squadIconOffsetXRight": "{{xvm-stat?-32|0}}",
    //"nameFieldOffsetXLeft": "{{xvm-stat?-32|0}}",
    //"nameFieldWidthDeltaLeft": 10,
    //"nameFieldOffsetXRight": "{{xvm-stat?-32|0}}",
    //"nameFieldWidthDeltaRight": 10,
    //"vehicleFieldOffsetXLeft": 10,
    //"vehicleFieldWidthDeltaLeft": 10,
    //"vehicleFieldOffsetXRight": 10,
    //"vehicleFieldWidthDeltaRight": 10,
    //"vehicleIconOffsetXLeft": 4,
    //"vehicleIconOffsetXRight": 4,
    "clanIcon": { "show": true, "x": -345, "xr": -345, "y": 4, "h": 16, "w": 16, "alpha": 90 },
    //"clanIcon": { "show": true, "x": 4, "xr": 4, "y": 6, "h": 16, "w": 16, "alpha": 90 },
    "formatLeftNick":  ${"def.formatNick"},
    "formatRightNick":  ${"def.formatNick"},
    "formatLeftVehicle":  ${"def.formatVehicle"},
    "formatRightVehicle": ${"def.formatVehicle"}
  },
  "battleLoadingTips": {
    "showBattleTier": true,
    //"removeSquadIcon": true,
    "removeVehicleLevel": true,
    "removeVehicleTypeIcon": true,
    //"nameFieldShowBorder": true,
    //"vehicleFieldShowBorder": true,
    "squadIconOffsetXLeft": -80,
    "squadIconOffsetXRight": -80,
    "nameFieldOffsetXLeft": -80,
    "nameFieldWidthDeltaLeft": 40,
    "nameFieldOffsetXRight": -80,
    "nameFieldWidthDeltaRight": 40,
    //"vehicleFieldOffsetXLeft": 10,
    "vehicleFieldWidthDeltaLeft": 10,
    //"vehicleFieldOffsetXRight": 10,
    "vehicleFieldWidthDeltaRight": 10,
    "clanIcon": { "show": true }
  },
  "statisticForm": {
    "showBattleTier": true,
    //"removeSquadIcon": true,
    "removeVehicleLevel": true,
    "removeVehicleTypeIcon": true,
    //"nameFieldShowBorder": true,
    //"vehicleFieldShowBorder": true,
    //"fragsFieldShowBorder": true,
    //"squadIconOffsetXLeft": -32,
    //"squadIconOffsetXRight": -32,
    //"nameFieldOffsetXLeft": -10,
    //"nameFieldOffsetXRight": -10,
    //"vehicleFieldOffsetXLeft": 8,
    //"vehicleFieldOffsetXRight": 8,
    //"vehicleIconOffsetXLeft": 4,
    //"vehicleIconOffsetXRight": 4,
    "clanIcon": { "show": true, "x": -345, "xr": -345, "y": 4, "h": 16, "w": 16, "alpha": 90 },
    //"clanIcon": { "show": true, "x": 4, "xr": 4, "y": 6, "h": 16, "w": 16, "alpha": 90 },
    "formatLeftNick":  ${"def.formatNick"},
    "formatRightNick":  ${"def.formatNick"},
    "formatLeftVehicle":  ${"def.formatVehicle"},
    "formatRightVehicle": ${"def.formatVehicle"}
  },
  "playersPanel": ${"sirmax-panels.xc":"."},
  "battleResults": {
    "startPage": 1,
    "sortColumn": 5,
    "showCrewExperience": true,
    "showTotals": true,
    "showBattleTier": true
  },
  "minimap": ${"sirmax-minimap.xc":"minimap"},
  "minimapAlt": ${"sirmax-minimap.xc":"minimapAlt"},
  "hitLog": {
    "visible": true,
    "x": 235,
    "y": -230,
    "w": 500,
    "h": 230,
    "lines": 20,
    "direction": "down",
    "insertOrder": "end",
    "groupHitsByPlayer": true,
    "deadMarker": "<font face='xvm'>\u002B</font>",
    "blowupMarker": "<font face='xvm'>\u007C</font>",
//  TEST
//    "formatHistory": "<textformat tabstops='[20,50,90,150]'><font size='12'>#19</font>:<tab>9999<tab>| 2222<tab>| ramming<tab>| {{n}} {{n-player}} {{nick}}</textformat>",
    "defaultHeader": "<textformat leading='-2'><font color='#CCCCCC'>Total:</font> <font size='13'>#0</font></textformat>",
    "formatHeader":  "<textformat leading='-2'><font color='#CCCCCC'>Total:</font> <font size='13'>#{{n}}</font> <b>{{dmg-total}}</b>  <font color='#CCCCCC'>Last:</font> <font color='{{c:dmg-kind}}'><b>{{dmg}}</b></font></textformat>",
    "formatHistory": "<textformat leading='-4' tabstops='[20,50,90,150]'><font size='12'>\u00D7{{n-player}}:</font><tab>{{dmg-player}}<tab>| <font color='{{c:dmg-kind}}'>{{dmg}}</font><tab>| <font color='{{c:dmg-kind}}'>{{dmg-kind}}</font><tab>| <font color='{{c:vtype}}'>{{vehicle}} {{dead}}</font></textformat>"
  },
  "markers": ${"sirmax-markers.xc":"."},
  "alpha": {
    "hp": [
      { "value": 350,  "alpha": 100 },
      { "value": 500,  "alpha": 50 },
      { "value": 9999, "alpha": 0 }
    ],
    "hp_ratio": [
      { "value": 1, "alpha": "00" },
      { "value": 10, "alpha": "100" },
      { "value": 20, "alpha": "75" },
      { "value": 50, "alpha": "00" },
      { "value": 101, "alpha": "00" }
    ]
  },
  "iconset": {
    "battleLoadingAlly": "../../../../res/contour/Master_XH",
    "battleLoadingEnemy": "../../../../res/contour/Master_XH",
    //"battleLoadingAlly": "../../../../res/contour/block",
    //"battleLoadingEnemy": "../../../../res/contour/block",
    "statisticFormAlly": "../../../../res/contour/Master_XH",
    "statisticFormEnemy": "../../../../res/contour/Master_XH",
    //"statisticFormAlly": "../../../../res/contour/block",
    //"statisticFormEnemy": "../../../../res/contour/block",
    "playersPanelAlly":  "../../../../res/contour/Master_XH",
    "playersPanelEnemy":  "../../../../res/contour/Master_XH",
    "vehicleMarker": "../../../../res/contour/Aslain"
  },
  "vehicleNames": {
    "ussr-T-34": { "name": "т-34.", "short": "т-34" },
    "usa-T34_hvy": { "name": "т34.", "short": "т34" },
    "ussr-KV-1s": { "name": "квас", "short": "квс" }
  },
  "texts": {
    //"vtype": { "LT":  "ЛТ" },
    "marksOnGun": { "_0": "*", "_1": "1", "_2": "2", "_3": "3" }
  },
  "colors": {
    "system": {
      //"ally_alive":          "0x029CF5",
      //"enemy_alive":         "0xFFBB28",
      //"ally_dead":           "0x029CF5",
      //"enemy_dead":          "0xFFBB28"
      //"ally_base":           "0xFFFF80",
      //"enemy_base":          "0x8080FF"
    },
    "damage": {
      //"enemy_allytk_hit":      "0x00EAFF",
      //"enemy_allytk_kill":     "0x00EAFF"
    }
  },
  "export": {
    "fps": {
      //"enabled": true
    }
  },
  "definition": {
    "author": "sirmax2",
    "description": "Sirmax's settings for XVM",
    "url": "http://www.modxvm.com/",
    "date": "10.10.2012",
    "gameVersion": "0.8.0",
    "modMinVersion": "3.0.4"
  },
  "sounds": {
    //"sixthSense": "/xvm/xvm/sixthsense"
    "sixthSense": "/GUI/notifications_FX/task_part_complete"
  },
  "consts": { "VM_COEFF_VMM_DEAD": 0.75 }
}
