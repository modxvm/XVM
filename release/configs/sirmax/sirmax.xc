{
  "configVersion": "5.1.0",
  //"language": "pl",
  "def": {
    "formatNick": "{{name%.20s~..}}<font alpha='#A0'>{{clan}}</font>",
    "formatVehicle": "<font face='Consolas' size='11'><font color='{{c:avglvl|#666666}}'>{{avglvl%d|-}}</font> <font color='{{c:tdv|#666666}}'>{{tdv%0.1f|---}}|<font color='{{c:e|#666666}}'>{{e|-}}</font>|<font color='{{c:xwgr|#666666}}'>{{xwgr|--}}</font>|<font color='{{c:xeff|#666666}}'>{{xeff|--}}</font>|<font color='{{c:xwn8|#666666}}'>{{xwn8|--}}</font> <font color='{{c:kb|#666666}}'>{{kb%2d~k|--k}}</font></font>",
    //"formatVehicle": "{{vehicle}}",
    //"formatVehicle": "<font color='{{c:teff|#666666}}'>{{teff%4d|----}}</font>",

    "pingServers": { "enabled": true, "updateInterval": 5000 },

    "__stub__": null
  },
  "elements": [
    ${"sirmax-snippet-test.xc":"."},
    //${"sirmax-snippet-pp.xc":"."},  // players panels
    ${"sirmax-snippet-bt.xc":"."} // battle timer
  ],
  "definition": {
    "author": "sirmax2",
    "description": "Sirmax's settings for XVM",
    "url": "http://www.modxvm.com/",
    "date": "10.10.2012",
    "gameVersion": "0.8.0",
    "modMinVersion": "3.0.4"
  },
  "login": {
    "skipIntro": true,
    "saveLastServer": true,
    "autologin": true,
    "confirmOldReplays": true,
    "pingServers": ${"def.pingServers"}
  },
  "hangar": {
    "masteryMarkInTechTree": true,
    "hidePricesInTechTree": true,
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
    }
  },
  "userInfo": {
    "inHangarFilterEnabled": true,
    "startPage": 4,
    //"sortColumn": -5,
    "sortColumn": 3,
    "showExtraDataInProfile": true,
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
    "allowHpInPanelsAndMinimap": true,
    "allowMarksOnGunInPanelsAndMinimap": true,
    "clanIconsFolder": "clanicons",
    "elements": ${"elements"}
  },
  "fragCorrelation": {
    "hideTeamTextFields": true
  },
  "captureBar": {
    //"enabled": false,
    //"allyColor": "0xFFFF00",
    //"enemyColor": "0x00FFFF",
    "__stub__": null
  },
  "hotkeys": {
    //"minimapZoom": { "enabled": true, "keyCode": 29, "onHold": true },
    "minimapAltMode": { "enabled": true, "keyCode": 29 },
    //"playersPanelAltMode": { "enabled": true, "keyCode": 29 },
    "__stub__": {}
  },
  "battleLoading": {
    "showBattleTier": true,
    "removeSquadIcon": false,
    "clanIcon": { "show": true, "x": -345, "xr": -345, "y": 4, "h": 16, "w": 16, "alpha": 90 },
    //"clanIcon": { "show": true, "x": 4, "xr": 4, "y": 6, "h": 16, "w": 16, "alpha": 90 },
    "formatLeftNick":  ${"def.formatNick"},
    "formatRightNick":  ${"def.formatNick"},
    "formatLeftVehicle":  ${"def.formatVehicle"},
    "formatRightVehicle": ${"def.formatVehicle"}
  },
  "statisticForm": {
    "showBattleTier": true,
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
    "deadMarker": "<img src='xvm://res/icons/dead.png' width='12' height='12'>",
    "blowupMarker": "<img src='xvm://res/icons/blowedup.png' width='12' height='12'>",
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
      { "value": 1, "alpha": "#00" },
      { "value": 10, "alpha": "#FF" },
      { "value": 20, "alpha": "#BB" },
      { "value": 50, "alpha": "#00" },
      { "value": 101, "alpha": "#00" }
    ]
  },
  "iconset": {
    "battleLoadingAlly": "contour/HARDicons",
    "battleLoadingEnemy": "contour/HARDicons",
    "statisticFormAlly": "contour/HARDicons",
    "statisticFormEnemy": "contour/HARDicons",
    "playersPanelAlly":  "contour/HARDicons",
    "playersPanelEnemy":  "contour/HARDicons",
    "vehicleMarker": "contour/Aslain/iconset2"
  },
  "vehicleNames": {
    "ussr-T-34": { "name": "т-34.", "short": "т-34" },
    "usa-T34_hvy": { "name": "т34.", "short": "т34" },
    "ussr-KV-1s": { "name": "квас", "short": "квс" }
  },
  "texts": {
    //"vtype": { "LT":  "ЛТ" },
    "marksOnGun": { "_0": "0", "_1": "1", "_2": "2", "_3": "3" }
  },
  "colors": {
    "system": {
      //"ally_alive":          "0x029CF5",
      //"enemy_alive":         "0xFFBB28"
      //"ally_base":          "0xFFFF80",
      //"enemy_base":         "0x8080FF"
    },
    "damage": {
      //"enemy_allytk_hit":      "0x00EAFF",
      //"enemy_allytk_kill":     "0x00EAFF"
    }
  },
  "consts": { "VM_COEFF_VMM_DEAD": 0.75 }
}
