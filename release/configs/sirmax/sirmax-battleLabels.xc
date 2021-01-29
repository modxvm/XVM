{
  "def": {
    "test": {
      "enabled": true,
      "hotKeyCode": 36,
      "updateEvent": "ON_TARGET_IN,ON_TARGET_OUT",
      "y": -70,
      "width": 310,
      "height": 50,
      "alpha": 70,
      "screenHAlign": "center",
      "screenVAlign": "bottom",
      "bgColor": "0x000000",
      "borderColor": "0x101009",
      "shadow": { "distance": 1, "angle": 90, "alpha": 80, "strength": 8},
      "textFormat": { "color": "0x60FF00", "size": 15, "align": "center", "marginLeft": 2, "marginRight": 2},
      "format": "<font color='#FFFFFF'><b>Info text field (XTE: <font color='{{c:xte}}'>{{xte}}</font>)</b></font><br/>Battle tier:<font color='#ff1aff'> {{battletier}}</font> <p align='right'>Vehicle: <font color='#ff1aff'>{{vehicle}}</font> (<font color='{{c:t-winrate}}'>{{t-winrate%2d}}%</font>)</p>"
    }
  },
  "formats": [
      ${ "../default/battleLabelsTemplates.xc":"def.hitLogBackground" },
      ${ "../default/battleLabelsTemplates.xc":"def.hitLogBody" },
      ${ "../default/battleLabelsTemplates.xc":"def.totalHP" },
      ${ "../default/battleLabelsTemplates.xc":"def.avgDamage" },
      ${ "../default/battleLabelsTemplates.xc":"def.mainGun" },
      ${ "../default/battleLabelsTemplates.xc":"def.damageLogBackground"},
      ${ "../default/battleLabelsTemplates.xc":"def.damageLog" },
      ${ "../default/battleLabelsTemplates.xc":"def.lastHit" },
      ${ "../default/battleLabelsTemplates.xc":"def.fire" },
      ${ "../default/battleLabelsTemplates.xc":"def.totalEfficiency" }
  ]
}
