{
  "configVersion": "5.0.0",
  "def": {
    //"standardMarkers": true,
    "standardMarkers": false,

    "formatNick":  "{{name}}{{clan}}",
    //"formatNick":  "<font color='#123456'>{{clan}}</font>{{name}}",
    "formatVehicle":  "<font face='Consolas' size='11'><font color='{{c:avglvl}}'>{{avglvl}}</font> <font face='Symbol' color='#111111'><b><font color='{{c:tdv}}'>·</font><font color='{{c:tfb}}'>·</font><font color='{{c:tsb}}'>·</font></b></font> <font color='{{c:e}}'>{{e}}</font>|<font color='{{c:xeff}}'>{{xeff}}</font>|<font color='{{c:xwn}}'>{{xwn}}</font> <font color='{{c:kb}}'>{{kb:3}}</font></font>",

    "markersStat": "<b><font face='Symbol' color='#CCCCCC' size='11'><font color='{{c:t-battles}}'>·</font> <font color='{{c:e}}'>·</font> <font color='{{c:xeff}}'>·</font> <font color='{{c:xwn}}'>·</font></font></b>",
    "markersStatAlt": "<b><font face='$FieldFont' size='12'><font color='{{c:t-battles}}'>{{t-hb}}</font> <font color='{{c:e}}'>{{teff}}</font> <font color='{{c:xeff}}'>{{xeff}}</font> <font color='{{c:xwn}}'>{{xwn}}</font> <font color='{{c:rating}}'>{{rating}}</font></font></b>",

    "damageMessageAlive": "{{dmg}}",
    "damageMessageAllyDead": "({{dmg}})",
    "damageMessageEnemyDead": "<textformat leading='-5'>({{dmg}})<br>{{vehicle}}</textformat>",

    "pingServers": { "enabled": true, "updateInterval": 5000 },

    "markers": {
      "vehicleIconColor": null,
      //"vehicleIconColor": "{{c:xwn}}",
      "ally": {
      },
      "enemy": {

      }
    },

    "__stub__": null
  },
  "elements": [
    ${"sirmax-snippet-test.xc":"."},
//    ${"sirmax-snippet-pp.xc":"."},  // players panels
    ${"sirmax-snippet-bt.xc":"."} // battle timer
  ],
  "definition": {
    "author": "sirmax2",
    "description": "Sirmax's settings for XVM",
    "url": "http://code.google.com/p/wot-xvm/",
    "date": "10.10.2012",
    "gameVersion": "0.8.0",
    "modMinVersion": "3.0.4"
  },
  "login": {
    "pingServers": ${"def.pingServers"}
  },
  "hangar": {
    "hideTutorial": true,
    "widgetsEnabled": true,
    "pingServers": {
      "$ref": { "path":"def.pingServers" },
      "x": 5
    }
  },
  "userInfo": {
     "inHangarFilterEnabled": true,
     "showEColumn": true,
     "sortColumn": -1
  },
  "squad": {
    "enabled": true,
    "romanNumbers": true,
    "showClan": true,
    "leftLvlBorder": ""
  },
  "battle": {
    "mirroredVehicleIcons": false,
    "showPostmortemTips": false,
    "removePanelsModeSwitcher": true,
    "highlightVehicleIcon": false,
    "useStandardMarkers": ${"def.standardMarkers"},
    "clanIconsFolder": "clanicons",
    "elements": ${"elements"}
  },
  "rating": {
    "showPlayersStatistics": true,
    "loadEnemyStatsInFogOfWar": true,
    "enableStatisticsLog": true,
    "enableUserInfoStatistics": true,
    "enableCompanyStatistics": true
  },
  "fragCorrelation": {
    "hideTeamTextFields": true
  },
  "hotkeys": {
    "minimapZoom": { "enabled": false, "onHold": true, "keyCode": 17 }
  },

  "battleLoading": {
    "showChances": true,
    "showChancesExp": true,
    "removeSquadIcon": false,
    "clanIcon": { "show": true, "x": 4, "y": 6, "h": 16, "w": 16, "alpha": 90 },
    "formatLeftNick":  ${"def.formatNick"},
    "formatRightNick":  ${"def.formatNick"},
    "formatLeftVehicle":  ${"def.formatVehicle"},
    "formatRightVehicle": ${"def.formatVehicle"}
  },
  "statisticForm": {
    "showChances": true,
    "showChancesExp": true,
    "clanIcon": { "show": true, "x": 4, "y": 6, "h": 16, "w": 16, "alpha": 90 },
    "formatLeftNick":  ${"def.formatNick"},
    "formatRightNick":  ${"def.formatNick"},
    "formatLeftVehicle":  ${"def.formatVehicle"},
    "formatRightVehicle": ${"def.formatVehicle"}
  },
  "playersPanel": {
    "alpha": 50,
    "initialMode": "short",
    "removeSquadIcon": true,
    "clanIcon": { "show": true, "x": 4, "y": 6, "h": 16, "w": 16, "alpha": 90 },
    "medium": {
      "width": 120,
      "formatLeft": "<font color='{{c:xwn}}'>{{nick}}</font>",
      "formatRight": "<font color='{{c:xwn}}'>{{nick}}</font>"
    },
    "medium2": {
      "width": 120,
      "formatLeft": "<font color='{{c:xwn}}'>{{vehicle}}</font>",
      "formatRight": "<font color='{{c:xwn}}'>{{vehicle}}</font>"
    },
    "large": {
      "width": 120,
      "nickFormatLeft": "<font color='{{c:xwn}}'>{{xwn}}</font> {{name}}<font color='#cccccc'>{{clan}}</font>",
      "nickFormatRight": "{{name}}<font color='#cccccc'>{{clan}}</font> <font color='{{c:xwn}}'>{{xwn}}</font>",
      "vehicleFormatLeft": "",
      "vehicleFormatRight": ""
    },
    "enemySpottedMarker": {
      "enabled": true,
      "format": {
        "neverSeen": "<font face='$FieldFont' size='24' color='#999999'>*</font>",
        "lost": "<font face='$FieldFont' size='24' color='#DDDDDD'>*</font>",
        "revealed": "<font face='$FieldFont' size='24' color='#00DE00'>*</font>",
        "dead": "<font face='$FieldFont' size='24' color='#222222'>*</font>",
        "artillery": {
          "neverSeen": "<font face='$FieldFont' size='24' color='#999999'>*</font>",
          "lost": "<font face='$FieldFont' size='24' color='#DDDDDD'>*</font>",
          "revealed": "<font face='$FieldFont' size='24' color='#DE0000'>*</font>",
          "dead": "<font face='$FieldFont' size='24' color='#222222'>*</font>"
        }
      }
    }
  },
  "finalStatistic": {
    "startPage": 1,
    "sortColumn": 6,
    "showChances": true,
    "showChancesExp": true
  },
  "minimap": {
    "enabled": true,
    "iconScale": 1,
    "circles": {
        "major": [
            { "enabled": true, "distance": 445, "thickness": 0.3, "alpha": 65, "color": "0xFF3333" },
            { "enabled": true, "distance": 50, "thickness": 1, "alpha": 50, "color": "0xFFFFFF" }
        ]
    },
    "lines": {
      "vehicle": [
         { "enabled": true, "from": -50, "to": 150,  "inmeters": true, "thickness": 1.2,  "alpha": 65, "color": "0xFFFFFF"}
       ],
       "camera": [
         { "enabled": true, "from": 50,  "to": 707,   "inmeters": true, "thickness": 0.7,  "alpha": 65, "color": "0x00BBFF"},
         { "enabled": true, "from": 707, "to": 1463,  "inmeters": true, "thickness": 0.2,  "alpha": 35, "color": "0x00BBFF"},
         { "enabled": true, "from": 445, "to": 446,   "inmeters": true, "thickness": 3,    "alpha": 65, "color": "0x00BBFF"},
         { "enabled": true, "from": 500, "to": 501,   "inmeters": true, "thickness": 3,    "alpha": 65, "color": "0x00BBFF"},
         { "enabled": true, "from": 706, "to": 707,   "inmeters": true, "thickness": 3,    "alpha": 65, "color": "0x00BBFF"}
       ],
       "traverseAngle": [
         { "enabled": true, "from": 50,  "to": 1463,  "inmeters": true, "thickness": 0.5,   "alpha": 65, "color": "0xFFFFFF"}
       ]
    },
    "square" : {
      "enabled": true,
      "artilleryEnabled": false,
      "thickness": 0.7,
      "alpha": 40,
      "color": "0xFFFFFF"
    }
  },
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
    "deadMarker": "<font face='Wingdings'>N</font>",
    "blowupMarker": "<font face='Wingdings'>M</font>",
//  TEST
//    "formatHistory": "<textformat tabstops='[20,50,90,150]'><font size='12'>#19</font>:<tab>9999<tab>| 2222<tab>| ramming<tab>| {{n}} {{n-player}} {{nick}}</textformat>",
    "defaultHeader": "<textformat leading='-2'><font color='#CCCCCC'>Total:</font> <font size='13'>#0</font></textformat>",
    "formatHeader":  "<textformat leading='-2'><font color='#CCCCCC'>Total:</font> <font size='13'>#{{n}}</font> <b>{{dmg-total}}</b>  <font color='#CCCCCC'>Last:</font> <font color='{{c:dmg-kind}}'><b>{{dmg}}</b></font></textformat>",
    "formatHistory": "<textformat leading='-4' tabstops='[20,50,90,150]'><font size='12'>\u00D7{{n-player}}:</font><tab>{{dmg-player}}<tab>| <font color='{{c:dmg-kind}}'>{{dmg}}</font><tab>| <font color='{{c:dmg-kind}}'>{{dmg-kind}}</font><tab>| <font color='{{c:vtype}}'>{{vehicle}} {{dead}}</font></textformat>"
  },
  "markers": {
    "ally": {
      "alive": {
        "normal": {
          "vehicleIcon": {
            "maxScale": 100,
            "color": ${"def.markers.vehicleIconColor"}
          },
          "contourIcon": {
            "visible": false,
            "x": 0,
            "y": -65,
            "alpha": 100,
            "color": null,
            "amount": 30
          },
          "healthBar": {
            "visible": true,
            "x": -21, "y": -23, "width": 40, "height": 3, "alpha": 100,
            "border": { "color": "0x000000", "alpha": 50, "size": 1 },
            "fill": { "alpha": 80 },
            "damage": { "color": null, "alpha": 30, "fade": 1 }
          },
          "damageText": {
            "y": -55,
            "damageMessage": ${"def.damageMessageAlive"}
          },
          "actionMarker": {
            "y": -55
          },
          "textFields": [
            {
              "visible": true,
              "name": "Vehicle Name",
              "x": 0, "y": -26,
              "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 200, "distance": 0, "size": 3 },
              "format": "<font face='$FieldFont' size='13'>{{vehicle}}{{turret}}</font>"
            },
            {
              "visible": true,
              "name": "Rating marks",
              "x": 0, "y": -35,
              "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 150, "distance": 0, "size": 3 },
              "font": { "name": "Symbol" },
              "format": ${"def.markersStat"}
            },
            {
              "visible": true,
              "name": "Dynamic HP",
              "x": 0, "y": -43, "alpha": "{{a:hp}}",
              "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 150, "distance": 0, "size": 3 },
              "format": "<font face='$FieldFont' size='11' color='{{c:hp}}'><b>{{hp}}</b></font>"
            }
          ]
        },
        "extended": {
          "vehicleIcon": {
            "maxScale": 100,
            "color": ${"def.markers.vehicleIconColor"}
          },
          "contourIcon": {
            "visible": false,
            "x": 0,
            "y": -65,
            "alpha": 100,
            "color": null,
            "amount": 50
          },
          "healthBar": {
            "visible": true,
            "x": -21, "y": -23, "width": 40, "height": 3, "alpha": 100,
            "border": { "color": "0x000000", "alpha": 50, "size": 1 },
            "fill": { "alpha": 80 },
            "damage": { "color": null, "alpha": 30, "fade": 1 }
          },
          "damageText": {
            "y": -55,
            "damageMessage": ${"def.damageMessageAlive"}
          },
          "actionMarker": {
            "y": -55
          },
          "clanIcon": {
            "visible": true,
            "x": 0,
            "y": -67
          },
          "textFields": [
            {
              "visible": true,
              "name": "Player Name",
              "x": 0, "y": -26,
              "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 200, "distance": 0, "size": 3 },
              "format": "<font face='$FieldFont' size='13'>{{nick}}</font>"
            },
            {
              "visible": true,
              "name": "HP",
              "x": 0, "y": -38, "color": "0xD9FFB3",
              "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 150, "distance": 0, "size": 3 },
              "format": "<font face='$FieldFont' size='11'><b>{{hp}} / {{hp-max}}</b></font>"
            },
            {
              "visible": true,
              "name": "Tank Rating",
              "x": 0, "y": -52, "alpha": 75,
              "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 150, "distance": 0, "size": 3 },
              "format": ${"def.markersStatAlt"}
            }
          ]
        }
      },
      "dead": {
        "normal": {
          "vehicleIcon": {
            "maxScale": 80,
            "color": ${"def.markers.vehicleIconColor"}
          },
          "damageText": {
            "y": -55,
            "damageMessage": ${"def.damageMessageAllyDead"},
            "blowupMessage": "Blown-up!"
          },
          "actionMarker": {
            "y": -55
          }
        },
        "extended": {
          "vehicleIcon": {
            "maxScale": 80,
            "color": ${"def.markers.vehicleIconColor"}
          },
          "damageText": {
            "y": -55,
            "damageMessage": ${"def.damageMessageAllyDead"},
            "blowupMessage": "Blown-up!"
          },
          "actionMarker": {
            "y": -55
          },
          "textFields": [
            {
              "visible": true,
              "name": "Vehicle Name",
              "x": 0, "y": -18, "alpha": 80,
              "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 200, "distance": 0, "size": 3 },
              "format": "<font face='$FieldFont' size='13'><font color='#7BEC37'>{{vehicle}}</font></font>"
            },
            {
              "visible": true,
              "name": "Player Name",
              "x": 0, "y": -32, "alpha": 80,
              "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 200, "distance": 0, "size": 3 },
              "format": "<font face='$FieldFont' size='13'><font color='#B2EE37'>{{nick}}</font></font>"
            }
          ]
        }
      }
    },
    "enemy": {
      "alive": {
        "normal": {
          "vehicleIcon": {
            "maxScale": 100,
            "color": ${"def.markers.vehicleIconColor"}
          },
          "contourIcon": {
            "visible": false,
            "x": 0,
            "y": -65,
            "alpha": 100,
            "color": null,
            "amount": 50
          },
          "healthBar": {
            "visible": true,
            "x": -21, "y": -23, "width": 40, "height": 3, "alpha": 100,
            "border": { "color": "0x000000", "alpha": 50, "size": 1 },
            "fill": { "alpha": 80 },
            "damage": { "color": null, "alpha": 30, "fade": 1 }
          },
          "damageText": {
            "y": -55,
            "damageMessage": ${"def.damageMessageAlive"}
          },
          "actionMarker": {
            "y": -55
          },
          "textFields": [
            {
              "visible": true,
              "name": "Vehicle Name",
              "x": 0, "y": -26,
              "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 200, "distance": 0, "size": 3 },
              "format": "<font face='$FieldFont' size='13'>{{vehicle}}{{turret}}</font>"
            },
            {
              "visible": true,
              "name": "Rating marks",
              "x": 0, "y": -35,
              "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 150, "distance": 0, "size": 3 },
              "font": { "name": "Symbol" },
              "format": ${"def.markersStat"}
            },
            {
              "visible": true,
              "name": "HP",
              "x": 0, "y": -43, "alpha": "{{a:hp}}",
              "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 150, "distance": 0, "size": 3 },
              "format": "<font face='$FieldFont' size='11' color='{{c:hp}}'><b>{{hp}}</b></font>"
            }
          ]
        },
        "extended": {
          "vehicleIcon": {
            "maxScale": 100,
            "color": ${"def.markers.vehicleIconColor"}
          },
          "contourIcon": {
            "visible": false,
            "x": 0,
            "y": -65,
            "alpha": 100,
            "color": null,
            "amount": 50
          },
          "healthBar": {
            "visible": true,
            "x": -21, "y": -23, "width": 40, "height": 3, "alpha": 100,
            "border": { "color": "0x000000", "alpha": 50, "size": 1 },
            "fill": { "alpha": 80 },
            "damage": { "color": null, "alpha": 30, "fade": 1 }
          },
          "damageText": {
            "y": -55,
            "damageMessage": ${"def.damageMessageAlive"}
          },
          "actionMarker": {
            "y": -55
          },
          "clanIcon": {
            "visible": true,
            "x": 0,
            "y": -67
          },
          "textFields": [
            {
              "visible": true,
              "name": "Player Name",
              "x": 0, "y": -26,
              "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 200, "distance": 0, "size": 3 },
              "format": "<font face='$FieldFont' size='13'>{{nick}}</font>"
            },
            {
              "visible": true,
              "name": "HP",
              "x": 0, "y": -38,
              "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 150, "distance": 0, "size": 3 },
              "format": "<font face='$FieldFont' size='11' color='{{c:hp-ratio}}'><b>{{hp}} / {{hp-max}}</b></font>"
            },
            {
              "visible": true,
              "name": "Tank Rating",
              "x": 0, "y": -52, "alpha": 75,
              "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 150, "distance": 0, "size": 3 },
              "format": ${"def.markersStatAlt"}
            }
          ]
        }
      },
      "dead": {
        "normal": {
          "vehicleIcon": {
            "maxScale": 80,
            "color": ${"def.markers.vehicleIconColor"}
          },
          "damageText": {
            "y": -65,
            "damageMessage": ${"def.damageMessageEnemyDead"},
            "blowupMessage": "<textformat leading='-5'>Blown-up!<br>{{vehicle}}</textformat>"
          },
          "actionMarker": {
            "y": -55
          }
        },
        "extended": {
          "vehicleIcon": {
            "maxScale": 80,
            "color": ${"def.markers.vehicleIconColor"}
          },
          "damageText": {
            "y": -55,
            "damageMessage": ${"def.damageMessageEnemyDead"},
            "blowupMessage": "Blown-up!"
          },
          "actionMarker": {
            "y": -55
          },
          "textFields": [
            {
              "visible": true,
              "name": "Vehicle Name",
              "x": 0, "y": -18, "alpha": 80,
              "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 200, "distance": 0, "size": 3 },
              "format": "<font face='$FieldFont' size='13'><font color='#EC3737'>{{vehicle}}</font></font>"
            },
            {
              "visible": true,
              "name": "Player Name",
              "x": 0, "y": -32, "alpha": 80,
              "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 200, "distance": 0, "size": 3 },
              "format": "<font face='$FieldFont' size='13'><font color='#FF6E0C'>{{nick}}</font></font>"
            }
          ]
        }
      }
    }
  },
  "alpha": {
    "hp": [
      { "value": 350,  "alpha": 100 },
      { "value": 500,  "alpha": 50 },
      { "value": 9999, "alpha": 0 }
    ]
  },
  "iconset": {
    "battleLoading": "contour/HARDicons",
    "statisticForm": "contour/HARDicons",
    "playersPanel":  "contour/HARDicons",
    "vehicleMarker": "contour/Aslain/iconset2"
  },
//  "colors": ${"sirmax-colors.xc":"colors"},
  "consts": { "VM_COEFF_VMM_DEAD": 0.75 }
}
