{
  //"enabled": false,
  "startMode": "large",
  //"startMode": "{{battletype=regular?medium|{{battletype=rated_sandbox?short|medium2}}}}",
  //"altMode": "{{battletype=regular?large|{{battletype=clan?medium|short}}}}",
  "def": {
    "c1": "0x13C313",
    "c2": "0xFF0F0F"
  },
  "large": {
    //"enabled": false,
    "removeSquadIcon": true,
    "vehicleLevelAlpha": 0,
    "nickFormatLeft": "        {{r_size=2?|{{r_size=4?   |    }}}}{{name%.18s~..}}<font alpha='#A0'>{{clan}}</font>",
    "nickFormatRight": "{{name%.18s~..}}<font alpha='#A0'>{{clan}}</font>{{r_size=2?|{{r_size=4?   |    }}}}       &nbsp;",
    "vehicleFormatLeft": "{{hp|---}} / {{hp-max}}",
    "vehicleFormatRight": "{{hp|---}} / {{hp-max}}",
    //"vehicleFormatLeft": "<font color='{{c:winrate}}' alpha='{{alive?#FF|#80}}'>{{vehicle}}</font>",
    //"vehicleFormatRight": "<font color='{{c:winrate}}' alpha='{{alive?#FF|#80}}'>{{vehicle}}</font>",
    //"vehicleFormatLeft": "<img src='xvm://res/icons/xvm/xvm-user-{{xvm-user|none}}.png' width='9' height='9'>",
    //"vehicleFormatRight": "<img src='xvm://res/icons/xvm/xvm-user-{{xvm-user|none}}.png' width='9' height='9'>",
    //"fragsFormatLeft": "{{frags|0}}",
    //"fragsFormatRight": "{{frags|0}}",
    "extraFieldsLeft": [
      // for tests
      //{ "width": 1, "height": 23, "bgColor": "0xFFFFFF" },
      //{ "width": 1, "height": 23, "bindToIcon": true, "bgColor": "0xFFFFFF" },
      //{ "x": 100, "scaleX": 1, "src": "img://gui/maps/icons/vehicle/contour/{{vehiclename}}.png" },
      //{ "x": 0, "src": "cfg://sirmax/img/MinimapAim.png" },
      //{ "x": 0, "bindToIcon": true, "src": "cfg://sirmax/img/MinimapAim.png" },

      { "y": 2, "width": 3, "height": 21, "valign": "center", "bgColor": ${"def.c1"}, "alpha": "{{alive?75|0}}" },
      { "x": "{{r_size=2?13|{{r_size=4?16|19}}}}", "y": 2, "valign": "center", "height": 21, "align": "center", "format": "<font color='{{t-battles>19?{{c:r|#666666}}|#666666}}' alpha='{{alive?#FF|#80}}'>{{r_size=2?{{r}}|{{r%d}}}}</font>", "shadow": {} },
      { "x": "{{r_size=2?23|{{r_size=4?32|36}}}}", "y": 2, "valign": "center", "height": 21, "width": "{{hp-max:120}}", "bgColor": 0, "alpha": 40 },
      { "x": "{{r_size=2?23|{{r_size=4?32|36}}}}", "y": 2, "valign": "center", "height": 21, "width": "{{hp:120}}", "bgColor": ${"def.c1"}, "alpha": 50 },

      ${"../default/playersPanel.xc":"clanIcon"},
      { "$ref": { "file":"../default/playersPanel.xc", "path":"xvmUserMarker" }, "enabled": true },
      ${"../default/playersPanel.xc":"xmqpServiceMarker"},
      {}
    ],
    "extraFieldsRight": [
      // for tests
      //{ "width": 1, "height": 23, "bgColor": "0xFFFFFF" },
      //{ "width": 1, "height": 23, "bindToIcon": true, "bgColor": "0xFFFFFF" },
      //{ "x": 100, "y":15, "scaleX": -1, "src": "img://gui/maps/icons/vehicle/contour/{{vehiclename}}.png" },
      //{ "x": 0, "src": "cfg://sirmax/img/MinimapAim.png" },
      //{ "x": 0, "bindToIcon": true, "src": "cfg://sirmax/img/MinimapAim.png" },

      { "width": 3,  "y": 2, "valign": "center", "height": 21, "bgColor": ${"def.c2"}, "alpha": "{{alive?75|0}}" },
      { "x": "{{r_size=2?13|{{r_size=4?20|21}}}}", "y": 2, "valign": "center", "height": 21, "align": "center", "format": "<font color='{{t-battles>19?{{c:r|#666666}}|#666666}}' alpha='{{alive?#FF|#80}}'>{{r_size=2?{{r}}|{{r%d}}}}</font> </font>", "shadow": {} },
      { "x": "{{r_size=2?23|{{r_size=4?33|38}}}}", "y": 2, "valign": "center", "height": 21, "width": "{{hp-max:120}}", "bgColor": 0, "alpha": 40 },
      { "x": "{{r_size=2?23|{{r_size=4?33|38}}}}", "y": 2, "valign": "center", "height": 21, "width": "{{hp:120}}", "bgColor": ${"def.c2"}, "alpha": 50 },

      ${"../default/playersPanel.xc":"clanIcon"},
      { "$ref": { "file":"../default/playersPanel.xc", "path":"xvmUserMarker" }, "enabled": true },
      ${"../default/playersPanel.xc":"xmqpServiceMarker"},
      ${"../default/playersPanel.xc":"enemySpottedMarker"},
      {}
    ],
    "nickMinWidth": 120,
    "nickMaxWidth": 180,
    "standardFields": [ "nick", "vehicle", "frags" ]
  },
  "medium": {
    //"enabled": false,
    "nickMinWidth": 80,
    "nickMaxWidth": 80,
    //"standardFields": [ "nick", "vehicle", "frags" ]
    //"removeSquadIcon": true,
    "vehicleLevelAlpha": 0,
    "nickFormatLeft": "<font color='{{c:xwn8}}' alpha='{{alive?#FF|#80}}'>{{nick}}</font>",
    "nickFormatRight": "<font color='{{c:xwn8}}' alpha='{{alive?#FF|#80}}'>{{nick}}</font>",
    //"extraFieldsLeft": [
    //],
    //"extraFieldsRight": [
    //],
    "__stub__": null
  },
  "medium2": {
    //"enabled": false,
    "vehicleWidth": 80,
    //"standardFields": [ "nick", "vehicle", "frags" ]
    //"removeSquadIcon": true,
    "vehicleLevelAlpha": 0,
    "vehicleFormatLeft": "<font color='{{c:xwn8}}' alpha='{{alive?#FF|#80}}'>{{vehicle}}</font>",
    "vehicleFormatRight": "<font color='{{c:xwn8}}' alpha='{{alive?#FF|#80}}'>{{vehicle}}</font>",
    //"extraFieldsLeft": [
    //],
    //"extraFieldsRight": [
    //],
    "__stub__": null
  },
  "short": {
    //"enabled": false,
    "fragsWidth": 20,
    //"standardFields": [ "nick", "vehicle", "frags" ]
    "vehicleLevelAlpha": 70,
    //"removeSquadIcon": true,
    //"extraFieldsLeft": [
    //],
    //"extraFieldsRight": [
    //],
    "__stub__": null
  },
  "none": {
    //"enabled": false,
    "expandAreaWidth": 40,
    //"layout": "horizontal",
    "extraFields": ${"sirmax-panels-none.xc":"."}
  },
  "alpha": 50,
  //"iconAlpha": 50,
  //"removeSelectedBackground": true,
  "removePanelsModeSwitcher": true
}
