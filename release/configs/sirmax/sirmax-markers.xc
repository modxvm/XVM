{
  //"enabled": false,
  "def": {
    "markersStat": "<b><font face='$TitleFont' size='8' color='{{t-battles>19?#FFFFFF|#666666}}'>{{marksOnGun|*}}</font> <font face='Symbol' color='#CCCCCC' size='11'><font color='{{t-battles>19?{{c:xte|#666666}}|#666666}}'>·</font> <font color='{{c:xeff}}'>·</font> <font color='{{c:xwn8}}'>·</font></font></b>",
    "markersStatAlt": "<b><font face='$TitleFont' size='8' color='{{t-battles>19?#FFFFFF|#666666}}'>{{marksOnGun|*}}</font> <font face='$FieldFont' size='12'><font color='{{t-battles>19?{{c:xte|#666666}}|#666666}}'>{{xte|--}}({{py:xvm.xvm2sup('{{xte}}')|--}})</font> <font color='{{c:xeff}}'>{{xeff|--}}</font> <font color='{{c:xwn8}}'>{{xwn8|--}}</font></font></b>",

    "damageMessageAlive": "{{dmg}}",
    "damageMessageAllyDead": "({{dmg}})",
    "damageMessageEnemyDead": "<textformat leading='-5'>({{dmg}})<br>{{vehicle}}</textformat>",

    "markers": {
      "vehicleIconColor": null,
      //"vehicleIconColor": "{{c:xwn8}}",
      "ally": {
      },
      "enemy": {

      }
    },

    "__stub__": null
  },
  "ally": {
    "alive": {
      "normal": {
        "vehicleIcon": {
          //"maxScale": 50,
          "color": ${"def.markers.vehicleIconColor"}
        },
        "contourIcon": {
          //"enabled": true,
          "x": 0,
          "y": -85,
          "alpha": 100,
          "color": null,
          "amount": 0
        },
        "healthBar": {
          "enabled": true,
          "x": -21, "y": -23, "width": 40, "height": 3, "alpha": 100,
          "border": { "color": "0x000000", "alpha": 50, "size": 1 },
          "fill": { "alpha": 80 },
          "damage": { "color": null, "alpha": 30, "fade": 1 }
        },
        "damageText": {
          "y": -55,
          "damageMessage": ${"def.damageMessageAlive"}
        },
        "damageTextPlayer": ${"ally.alive.normal.damageText"},
        "damageTextSquadman": ${"ally.alive.normal.damageText"},
        "actionMarker": {
          "y": -55
        },
        "textFields": [
          {
            "enabled": true,
            "name": "Vehicle Name",
            "x": 0, "y": -26,
            "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 2, "distance": 0, "size": 3 },
            "format": "<font face='$FieldFont' size='13'>{{vehicle}}{{turret}}</font>"
          },
          {
            "enabled": true,
            "name": "Rating marks",
            "x": 0, "y": -40,
            "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 1.5, "distance": 0, "size": 3 },
            "textFormat": { "name": "Symbol" },
            "format": ${"def.markersStat"}
          },
          {
            "enabled": true,
            "name": "Dynamic HP",
            "x": 0, "y": -43, "alpha": "{{a:hp}}",
            "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 1.5, "distance": 0, "size": 3 },
            "format": "<font face='$FieldFont' size='11' color='{{c:hp}}'><b>{{hp}}</b></font>"
          }
        ]
      },
      "extended": {
        "vehicleIcon": {
          //"maxScale": 75,
          "color": ${"def.markers.vehicleIconColor"}
        },
        "contourIcon": {
          //"enabled": true,
          "x": 0,
          "y": -85,
          "alpha": 75,
          "color": null,
          "amount": 30
        },
        "healthBar": {
          "enabled": true,
          "x": -21, "y": -23, "width": 40, "height": 3, "alpha": 100,
          "border": { "color": "0x000000", "alpha": 50, "size": 1 },
          "fill": { "alpha": 80 },
          "damage": { "color": null, "alpha": 30, "fade": 1 }
        },
        "damageText": {
          "y": -55,
          "damageMessage": ${"def.damageMessageAlive"}
        },
        "damageTextPlayer": ${"ally.alive.extended.damageText"},
        "damageTextSquadman": ${"ally.alive.extended.damageText"},
        "actionMarker": {
          "y": -55
        },
        "clanIcon": {
          "enabled": true,
          "x": 0,
          "y": -67
        },
        "textFields": [
          {
            "enabled": true,
            "name": "Player Name",
            "x": 0, "y": -26,
            "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 2, "distance": 0, "size": 3 },
            "format": "<font face='$FieldFont' size='13'>{{nick}}</font>"
          },
          {
            "enabled": true,
            "name": "HP",
            "x": 0, "y": -38,
            "textFormat": { "color": "0xD9FFB3" },
            "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 1.5, "distance": 0, "size": 3 },
            "format": "<font face='$FieldFont' size='11'><b>{{hp}} / {{hp-max}}</b></font>"
          },
          {
            "enabled": true,
            "name": "Tank Rating",
            "x": 0, "y": -52, "alpha": 75,
            "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 1.5, "distance": 0, "size": 3 },
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
        "damageTextPlayer": ${"ally.dead.normal.damageText"},
        "damageTextSquadman": ${"ally.dead.normal.damageText"},
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
        "damageTextPlayer": ${"ally.dead.extended.damageText"},
        "damageTextSquadman": ${"ally.dead.extended.damageText"},
        "actionMarker": {
          "y": -55
        },
        "textFields": [
          {
            "enabled": true,
            "name": "Vehicle Name",
            "x": 0, "y": -18, "alpha": 80,
            "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 2, "distance": 0, "size": 3 },
            "format": "<font face='$FieldFont' size='13'><font color='#7BEC37'>{{vehicle}}</font></font>"
          },
          {
            "enabled": true,
            "name": "Player Name",
            "x": 0, "y": -32, "alpha": 80,
            "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 2, "distance": 0, "size": 3 },
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
          //"maxScale": 50,
          "color": ${"def.markers.vehicleIconColor"}
        },
        "contourIcon": {
          "enabled": false,
          "x": 0,
          "y": -65,
          "alpha": 100,
          "color": null,
          "amount": 50
        },
        "healthBar": {
          "enabled": true,
          "x": -21, "y": -23, "width": 40, "height": 3, "alpha": 100,
          "border": { "color": "0x000000", "alpha": 50, "size": 1 },
          "fill": { "alpha": 80 },
          "damage": { "color": null, "alpha": 30, "fade": 1 }
        },
        "damageText": {
          "y": -55,
          //"shadow": { "color": null },
          "damageMessage": ${"def.damageMessageAlive"}
        },
        "damageTextPlayer": ${"enemy.alive.normal.damageText"},
        "damageTextSquadman": ${"enemy.alive.normal.damageText"},
        "actionMarker": {
          "y": -55
        },
        "textFields": [
          {
            "enabled": true,
            "name": "Vehicle Name",
            "x": 0, "y": -26,
            "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 2, "distance": 0, "size": 3 },
            "format": "<font face='$FieldFont' size='13'>{{vehicle}}{{turret}}</font>"
          },
          {
            "enabled": true,
            "name": "Rating marks",
            "x": 0, "y": -40,
            "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 1.5, "distance": 0, "size": 3 },
            "textFormat": { "name": "Symbol" },
            "format": ${"def.markersStat"}
          },
          {
            "enabled": true,
            "name": "HP",
            "x": 0, "y": -43, "alpha": "{{a:hp}}",
            "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 1.5, "distance": 0, "size": 3 },
            "format": "<font face='$FieldFont' size='11' color='{{c:hp}}'><b>{{hp}}</b></font>"
          }
        ]
      },
      "extended": {
        "vehicleIcon": {
          //"maxScale": 75,
          "color": ${"def.markers.vehicleIconColor"}
        },
        "contourIcon": {
          "enabled": false,
          "x": 0,
          "y": -65,
          "alpha": 100,
          "color": null,
          "amount": 50
        },
        "healthBar": {
          "enabled": true,
          "x": -21, "y": -23, "width": 40, "height": 3, "alpha": 100,
          "border": { "color": "0x000000", "alpha": 50, "size": 1 },
          "fill": { "alpha": 80 },
          "damage": { "color": null, "alpha": 30, "fade": 1 }
        },
        "damageText": {
          "y": -55,
          "damageMessage": ${"def.damageMessageAlive"}
        },
        "damageTextPlayer": ${"enemy.alive.extended.damageText"},
        "damageTextSquadman": ${"enemy.alive.extended.damageText"},
        "actionMarker": {
          "y": -55
        },
        "clanIcon": {
          "enabled": true,
          "x": 0,
          "y": -67
        },
        "textFields": [
          {
            "enabled": true,
            "name": "Player Name",
            "x": 0, "y": -26,
            "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 2, "distance": 0, "size": 3 },
            "format": "<font face='$FieldFont' size='13'>{{nick}}</font>"
          },
          {
            "enabled": true,
            "name": "HP",
            "x": 0, "y": -38,
            "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 1.5, "distance": 0, "size": 3 },
            "format": "<font face='$FieldFont' size='11' color='{{c:hp-ratio}}'><b>{{hp}} / {{hp-max}}</b></font>"
          },
          {
            "enabled": true,
            "name": "Tank Rating",
            "x": 0, "y": -52, "alpha": 75,
            "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 1.5, "distance": 0, "size": 3 },
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
        "damageTextPlayer": ${"enemy.dead.normal.damageText"},
        "damageTextSquadman": ${"enemy.dead.normal.damageText"},
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
        "damageTextPlayer": ${"enemy.dead.extended.damageText"},
        "damageTextSquadman": ${"enemy.dead.extended.damageText"},
        "actionMarker": {
          "y": -55
        },
        "textFields": [
          {
            "enabled": true,
            "name": "Vehicle Name",
            "x": 0, "y": -18, "alpha": 80,
            "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 2, "distance": 0, "size": 3 },
            "format": "<font face='$FieldFont' size='13'><font color='#EC3737'>{{vehicle}}</font></font>"
          },
          {
            "enabled": true,
            "name": "Player Name",
            "x": 0, "y": -32, "alpha": 80,
            "shadow": { "alpha": 100, "color": "0x000000", "angle": 0, "strength": 2, "distance": 0, "size": 3 },
            "format": "<font face='$FieldFont' size='13'><font color='#FF6E0C'>{{nick}}</font></font>"
          }
        ]
      }
    }
  }
}
