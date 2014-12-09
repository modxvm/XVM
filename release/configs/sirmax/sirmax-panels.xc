{
  //"startMode": "none",
  //"altMode": "short",
  "def": {
    "c1": "0x13C313",
    "c2": "0xFF0F0F"
  },
  "large": {
    "nickFormatLeft": "        {{name%.20s~..}}<font alpha='#A0'>{{clan}}</font>",
    "nickFormatRight": "{{name%.20s~..}}<font alpha='#A0'>{{clan}}</font>       &nbsp;",
    "vehicleFormatLeft": "{{hp}} / {{hp-max}}",
    "vehicleFormatRight": "{{hp}} / {{hp-max}}",
    //"vehicleFormatLeft": "<font color='{{c:rating}}' alpha='{{alive?#FF|#80}}'>{{vehicle}}</font>",
    //"vehicleFormatRight": "<font color='{{c:rating}}' alpha='{{alive?#FF|#80}}'>{{vehicle}}</font>",
    //"fragsFormatLeft": "{{frags|0}}",
    //"fragsFormatRight": "{{frags|0}}",
    "extraFieldsLeft": [
      // for tests
      //{ "w": 1, "h": 23, "bgColor": "0xFFFFFF" },
      //{ "x": 100, "scaleX": 1, "src": "img://gui/maps/icons/vehicle/contour/{{vehiclename}}.png" },

      { "x": 23, "y": 2, "valign": "center", "h": 21, "w": "{{hp-max:120}}", "bgColor": 0, "alpha": 40 },
      { "x": 23, "y": 2, "valign": "center", "h": 21, "w": "{{hp:120}}", "bgColor": ${"def.c1"}, "alpha": 50 },
      { "w": 3,  "y": 2, "valign": "center", "h": 21, "bgColor": ${"def.c1"}, "alpha": "{{alive?75|0}}" },
      { "x": 13, "y": 2, "valign": "center", "align": "center", "format": "<font color='{{c:xwn8}}' alpha='{{alive?#FF|#80}}'>{{xwn8|--}}</font>", "shadow": {} },
      //{ "x": 0, "y": 5, "align": "center", "valign": "top", "bindToIcon": true, "format": "{{spotted}}", "shadow": {} },
      {}
    ],
    "extraFieldsRight": [
      // for tests
      //{ "w": 1, "h": 23, "bgColor": "0xFFFFFF" },
      //{ "x": "25", "y": 0,  "align": "left",   "w": 20, "h": 5, "bgColor": "0xFF0F0F", "alpha": 50 },
      //{ "x": "15", "y": 5,  "align": "center", "w": 20, "h": 5, "bgColor": "0x0FFF0F", "alpha": 50 },
      //{ "x": "5",  "y": 10, "align": "right",  "w": 20, "h": 5, "bgColor": "0x0F0FFF", "alpha": 50 },

      { "x": 23, "y": 2, "valign": "center", "h": 21, "w": "{{hp-max:120}}", "bgColor": 0, "alpha": 40 },
      { "x": 23, "y": 2, "valign": "center", "h": 21, "w": "{{hp:120}}", "bgColor": ${"def.c2"}, "alpha": 50 },
      { "w": 3,  "y": 2, "valign": "center", "h": 21, "bgColor": ${"def.c2"}, "alpha": "{{alive?75|0}}" },
      { "x": 13, "y": 2, "valign": "center", "align": "center", "format": "<font color='{{c:xwn8}}' alpha='{{alive?#FF|#80}}'>{{xwn8|--}}</font>", "shadow": {} },
      { "x": 0, "y": 5, "align": "center", "valign": "top", "bindToIcon": true, "format": "{{spotted}}", "shadow": {} },
      {}
    ],
    "width": 120
  },
  "medium": {
    "width": 120,
    "formatLeft": "<font color='{{c:xwn8}}' alpha='{{alive?#FF|#80}}'>{{nick}}</font>",
    "formatRight": "<font color='{{c:xwn8}}' alpha='{{alive?#FF|#80}}'>{{nick}}</font>"
  },
  "medium2": {
    "width": 120,
    "formatLeft": "<font color='{{c:xwn8}}' alpha='{{alive?#FF|#80}}'>{{vehicle}}</font>",
    "formatRight": "<font color='{{c:xwn8}}' alpha='{{alive?#FF|#80}}'>{{vehicle}}</font>"
  },
  "short": {
    //"width": 120
  },
  "none": {
    //"layout": "horizontal",
    "extraFields": ${"sirmax-panels-none.xc":"."}
  },
  "alpha": 50,
  //"iconAlpha": 50,
  "removeSquadIcon": true,
  //"removeSelectedBackground": true,
  "removePanelsModeSwitcher": true,
  "clanIcon": { "show": true, "x": 4, "y": 6, "h": 16, "w": 16, "alpha": 90 }
}
