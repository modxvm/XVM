{
  //"startMode": "none",
  "large": {
    "nickFormatLeft": "  <font color='{{c:xwn8}}'>{{xwn8|--}}</font>  {{name%.20s~..}}<font alpha='#A0'>{{clan}}</font>",
    "nickFormatRight": "{{name%.20s~..}}<font alpha='#A0'>{{clan}}</font>  <font color='{{c:xwn8}}'>{{xwn8|--}}</font>&nbsp;&nbsp;",
    "vehicleFormatLeft": "{{hp}} / {{hp-max}}",
    "vehicleFormatRight": "{{hp}} / {{hp-max}}",
    //"vehicleFormatLeft": "<font color='{{c:rating}}'>{{vehicle}}</font>",
    //"vehicleFormatRight": "<font color='{{c:rating}}'>{{vehicle}}</font>",
    "extraFieldsLeft": [
      "       <img src='xvm://configs/sirmax/img/_bg.png' width='{{hp-max:150}}' height='22'>",
      //"       <img src='xvm://configs/sirmax/img/_ally_50-{{alive}}.png' width='{{hp:150}}' height='22'>",
      //"<img src='xvm://configs/sirmax/img/_ally_50-{{alive}}.png' width='3' height='22'>",
      { "x": 20, "width": "{{hp:150}}", "height": 22, "src": "xvm://configs/sirmax/img/_enemy_50-{{alive}}.png" },
      //{ "format": "XXX", "x": 50, "width": "{{hp:100}}", "height": 20,
      //  "align": "none", "background": 1, "backgroundColor": "0xFFFF00", "alpha": 50,
      //  "shadow": { "color": "0xFFCCAA", "distance": 1, "angle": 45, "alpha": 70, "blur": 5, "strength": 10 }
      //},
      {}
    ],
    "extraFieldsRight": [
      "<img src='xvm://configs/sirmax/img/_bg.png' width='{{hp-max:150}}' height='22'>       ",
      //"<img src='xvm://configs/sirmax/img/_enemy_50-{{alive}}.png' width='{{hp:150}}' height='22'>       ",
      //"<img src='xvm://configs/sirmax/img/_enemy_50-{{alive}}.png' width='3' height='22'>",
      { "x": 20, "width": "{{hp:150}}", "height": 22, "src": "xvm://configs/sirmax/img/_enemy_50-{{alive}}.png" },
      //{ "format": "YYY", "x": 50, "width": "{{hp:100}}", "height": 20,
      //  "align": "right", "background": 1, "backgroundColor": "0xFFFF00", "alpha": 50,
      //  "shadow": { "color": "0xFFCCAA", "distance": 1, "angle": 45, "alpha": 70, "blur": 5, "strength": 10 }
      //},
      {}
    ],
    "width": 120
  },
  "medium": {
    "width": 120,
    "formatLeft": "<font color='{{c:xwn8}}'>{{nick}}</font>",
    "formatRight": "<font color='{{c:xwn8}}'>{{nick}}</font>"
  },
  "medium2": {
    "width": 120,
    "formatLeft": "<font color='{{c:xwn8}}'>{{vehicle}}</font>",
    "formatRight": "<font color='{{c:xwn8}}'>{{vehicle}}</font>"
  },
  "none": {
    "extraFields": ${"sirmax-panels-none.xc":"."}
  },
  "alpha": 50,
  "removeSquadIcon": true,
  "removePanelsModeSwitcher": true,
  "clanIcon": { "show": true, "x": 4, "y": 6, "h": 16, "w": 16, "alpha": 90 },
  "enemySpottedMarker": {
    "enabled": true,
    "Xoffset": -15,
    "Yoffset": 0,
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
}
