{
  "configVersion": "6.1.0",
  "autoReloadConfig": true,
  //"language": "pl",
  "def": {
    "formatNick": "{{name%.20s~..}}<font alpha='#A0'>{{clan}}</font>",
    "formatVehicle": "<font face='Consolas' size='11'><img src='xvm://res/icons/xvm/xvm-user-{{xvm-user|none}}.png'><img src='xvm://res/icons/flags/{{flag|default}}.png' width='16' height='11'><font color='{{c:avglvl|#666666}}'>{{avglvl%d|-}}</font> <font color='{{t-battles>19?{{c:xte|#666666}}|#666666}}'>{{xte|--}}</font>|<font color='{{c:xwgr|#666666}}'>{{xwgr|--}}</font>|<font color='{{c:xeff|#666666}}'>{{xeff|--}}</font>|<font color='{{c:xwn8|#666666}}'>{{xwn8|--}}</font> <font color='{{c:kb|#666666}}'>{{kb%2d~k|--k}}</font></font>",
    //"formatVehicle": "{{vehicle}}",

    "pingServers": {
      "enabled": true,
      //"y": 70,
      "ignoredServers": ["RU4", "RU8", "RU9", "RU10"],
      "showTitle": false,
      "updateInterval": 5000
    },
    "onlineServers": {
      "enabled": true,
      "x": 5,
      "y": 80,
      "hAlign": "left",
      "ignoredServers": ["RU4", "RU8", "RU9"],
      "layer": "top",
      "showTitle": false
    },
    "__stub__": null
  },
  "hotkeys": {
    //"minimapZoom": { "enabled": true, "keyCode": 56, "onHold": true },
    //"minimapAltMode": { "enabled": true, "keyCode": 56, "onHold": true },
    "playersPanelAltMode": { "enabled": true, "keyCode": 56, "onHold": true }, // LAlt
    //"markersAltMode":      { "enabled": false, "onHold": false },
    "__stub__": {}
  },
  "elements": [
    //${"sirmax-snippet-pp.xc":"."}, // players panels
    //${"sirmax-snippet-bt.xc":"."}, // battle timer
    ${"sirmax-snippet-test.xc":"."}
  ],
  "login": {
    "saveLastServer": true,
    "autologin": true,
    "confirmOldReplays": true,
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
    "crewMaxPerksCount": 10,
    "enableEquipAutoReturn": true,
    "widgetsEnabled": true,
    "pingServers": {
      "$ref": { "path":"def.pingServers" },
      "x": 5
    },
    "carousel": ${"sirmax-carousel.xc":"carousel"},
    "clock": {
      //"layer": "bottom",
      //"x": -200,
      //"y": 70
      //"format": "<font face='$FieldFont'><font size='26'> {{H}}:{{m%02d}} {{AM?a.m.|p.m.}}</font></font>"
    },
    //"showBuyPremiumButton": false,
    //"showPremiumShopButton": false,
    "serverInfo": {
      "enabled": false
      //"alpha": 75,
      //"rotation": 0,
      //"shiftX": 0,
      //"shiftY": 0
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
    "clanIconsFolder": "../../../../res/clanicons",
    "sixthSenseIcon": "cfg://sirmax/img/SixthSense.png",
    "sixthSenseDuration": 3000,
    "elements": ${"elements"},
    //"minimapDeadSwitch": false,
    "camera": {
      "enabled": true,
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
        //"zooms": [2, 4, 5, 6, 8, 13, 16, 22, 33, 44],
        //"startZoom": 4,
        "dynamicCameraEnabled": false,
        "zoomIndicator": {
          //"x": -100,
          //"y": 0,
          //"width": 100,
          //"height": 40,
          //"alpha": 100,
          //"align": "left",
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
    //"distanceOffset": -20,
    //"hideProgressBar": true,
    "enemy": {
      "title": {
        //"format": "<font size='15' color='#FFFFFF'>{{l10n:allyBaseCapture}}</font>"
      },
      "players": {
        //"format": "<font color='#FFCC66'><font size='15' face='xvm'>&#x113;</font>  <b>{{cap.tanks}}</b></font>"
      },
      "timer": {
        //"format": "<font color='#FFCC66'><font size='15' face='xvm'>&#x114;</font>  <b>{{cap.time}}</b></font>"
      },
      "points": {
        //"format": "<font size='15' color='#FFFFFF'>{{cap.points}}</font>"
      }
    },
    "__stub__": null
  },
  "battleLoading": {
    "showBattleTier": true,
    //"removeSquadIcon": true,
    //"vehicleIconAlpha": 30,
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
    "formatLeftNick":  ${"def.formatNick"},
    "formatRightNick":  ${"def.formatNick"},
    "formatLeftVehicle":  ${"def.formatVehicle"},
    "formatRightVehicle": ${"def.formatVehicle"}
  },
  "battleLoadingTips": {
    "showBattleTier": true,
    //"removeSquadIcon": true,
    //"vehicleIconAlpha": 30,
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
    "vehicleFieldWidthDeltaRight": 10
  },
  "statisticForm": {
    "showBattleTier": true,
    //"removeSquadIcon": true,
    //"vehicleIconAlpha": 30,
    "removeVehicleLevel": true,
    "removeVehicleTypeIcon": true,
    //"removePlayerStatusIcon": true,
    //"nameFieldShowBorder": true,
    //"vehicleFieldShowBorder": true,
    //"fragsFieldShowBorder": true,
    "nameFieldOffsetXLeft": -20,
    "nameFieldOffsetXRight": -20,
    "nameFieldWidthLeft": 200,
    "nameFieldWidthRight": 200,
    "vehicleFieldOffsetXLeft": 30,
    "vehicleFieldOffsetXRight": 30,
    "vehicleFieldWidthLeft": 200,
    "vehicleFieldWidthRight": 200,
    //"fragsFieldOffsetXLeft": 30,
    //"fragsFieldOffsetXRight": 30,
    //"fragsFieldWidthLeft": 100,
    //"fragsFieldWidthRight": 100,
    "squadIconOffsetXLeft": -18,
    "squadIconOffsetXRight": -10,
    //"vehicleIconOffsetXLeft": 4,
    //"vehicleIconOffsetXRight": 4,
    "formatLeftNick":  ${"def.formatNick"},
    "formatRightNick":  ${"def.formatNick"},
    "formatLeftVehicle":  ${"def.formatVehicle"},
    "formatRightVehicle": ${"def.formatVehicle"},
    "formatLeftFrags": "{{frags}}",
    "formatRightFrags": "{{frags}}",
    "extraFieldsLeft": [
      // for tests
      //{ "width": 1, "height": 23, "bgColor": "0xFFFFFF" },
      //{ "x": 25, "width": 1, "height": 23, "bgColor": "0xFFFFFF" },
      //{ "x": -1, "y": 2, "width": 5, "height": 22, "bgColor": "0x800600", "borderColor": "0x000000", "bindToIcon": true },
      //{ "width": 1, "height": 23, "bindToIcon": true, "bgColor": "0xFFFFFF" },
      //{ "x": 100, "scaleX": 1, "src": "img://gui/maps/icons/vehicle/contour/{{vehiclename}}.png" },
      //{ "x": 0, "src": "cfg://sirmax/img/MinimapAim.png" },
      //{ "x": 0, "bindToIcon": true, "src": "cfg://sirmax/img/MinimapAim.png" },
      //
      ${"../default/statisticForm.xc":"templates.clanIcon"}
    ],
    "extraFieldsRight": [
      // for tests
      //{ "width": 1, "height": 23, "bgColor": "0xFFFFFF" },
      //{ "x": 25, "width": 1, "height": 23, "bgColor": "0xFFFFFF" },
      //{ "x": -1, "y": 2, "width": 5, "height": 22, "bgColor": "0x800600", "borderColor": "0x000000", "bindToIcon": true },
      //{ "width": 1, "height": 23, "bindToIcon": true, "bgColor": "0xFFFFFF" },
      //{ "x": 100, "y":15, "scaleX": -1, "src": "img://gui/maps/icons/vehicle/contour/{{vehiclename}}.png" },
      //{ "x": 0, "src": "cfg://sirmax/img/MinimapAim.png" },
      //{ "x": 0, "bindToIcon": true, "src": "cfg://sirmax/img/MinimapAim.png" },
      //
      ${"../default/statisticForm.xc":"templates.clanIcon"}
    ],
    "__stub__": {}
  },
  "playersPanel": ${"sirmax-panels.xc":"."},
  "battleResults": {
    "startPage": 1,
    "sortColumn": 5,
    "showCrewExperience": true,
    //"showTotals": false,
    "showBattleTier": true
  },
  "minimap": ${"sirmax-minimap.xc":"minimap"},
  "minimapAlt": ${"sirmax-minimap.xc":"minimapAlt"},
  "hitLog": {
    //"insertOrder": "begin",
    "groupHitsByPlayer": true,
    "deadMarker": "<font face='xvm'>\u002B</font>",
    "blowupMarker": "<font face='xvm'>\u007C</font>",
//  TEST
//    "formatHistory": "<textformat tabstops='[20,50,90,150]'><font size='12'>#19</font>:<tab>9999<tab>| 2222<tab>| ramming<tab>| {{hitlog.n}} {{hitlog.n-player}} {{nick}}</textformat>",
    "defaultHeader": "<textformat leading='-2'><font color='#CCCCCC'>Total:</font> <font size='13'>#0</font></textformat>",
    "formatHeader":  "<textformat leading='-2'><font color='#CCCCCC'>Total:</font> <font size='13'>#{{hitlog.n}}</font> <b>{{hitlog.dmg-total}}</b>  <font color='#CCCCCC'>Last:</font> <font color='{{c:dmg-kind}}'><b>{{dmg}}</b></font></textformat>",
    "formatHistory": "<textformat leading='-4' tabstops='[20,50,90,150]'><font size='12'>\u00D7{{hitlog.n-player}}:</font><tab>{{hitlog.dmg-player}}<tab>| <font color='{{c:dmg-kind}}'>{{dmg}}</font><tab>| <font color='{{c:dmg-kind}}'>{{dmg-kind}}</font><tab>| <font color='{{c:vtype}}'>{{vehicle}} {{hitlog.dead}}</font></textformat>"
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
    "playersPanelLeftAtlas": "../../../../res/atlases/BattleAtlasLeft",
    "playersPanelRightAtlas": "../../../../res/atlases/BattleAtlasRight",
    "fullStatsLeftAtlas": "../../../../res/atlases/BattleAtlasLeft",
    "fullStatsRightAtlas": "../../../../res/atlases/BattleAtlasRight",
    "vehicleMarkerAllyAtlas": "../../../../res/atlases/vehicleMarkerAtlasAlly",
    "vehicleMarkerEnemyAtlas": "../../../../res/atlases/vehicleMarkerAtlasEnemy"
  },
  "vehicleNames": {
    "ussr-T-34": { "name": "т-34.", "short": "т-34" },
    "usa-T34_hvy": { "name": "т34.", "short": "т34" },
    "ussr-KV-1s": { "name": "квас", "short": "квс" }
  },
  "texts": {
    //"vtype": { "LT":  "ЛТ" },
    "marksOnGun": { "_0": "*", "_1": "1", "_2": "2", "_3": "3" },
    "battletype": {
      "rated_sandbox": "rated_sandbox"
    }
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
    //"enabled": false,
    //"logSoundEvents": true,
    "soundMapping": {
      //"xvm_sixthSense": "lightbulb",
      //"xvm_sixthSenseRudy": "",
      //"xvm_fireAlert": "",
      //"xvm_ammoBay": "",
      "xvm_enemySighted": "xvm_enemySighted",
      //"carousel": "",
      "__stub__": null
    }
  },
  "xmqp": {
    //"minimapDrawLineThickness": 2.5,
    //"minimapDrawColor": null,
    //"minimapDrawAlpha": 80,
    //"minimapDrawTime": 7
  },
  "tooltips": {
    //"hideSimplifiedVehParams": false
  },
  "battleLabels": ${"sirmax-battleLabels.xc":"."},
  "consts": {
      "VM_COEFF_VMM_DEAD": 0.75
  }
}
