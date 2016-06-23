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
    "nickFormatLeft": "        {{r_size=2?|{{r_size=4?   |    }}}}{{name%.20s~..}}<font alpha='#A0'>{{clan}}</font>",
    "nickFormatRight": "{{name%.20s~..}}<font alpha='#A0'>{{clan}}</font>{{r_size=2?|{{r_size=4?   |    }}}}       &nbsp;",
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
      //{ "w": 1, "h": 23, "bgColor": "0xFFFFFF" },
      //{ "x": 100, "scaleX": 1, "src": "img://gui/maps/icons/vehicle/contour/{{vehiclename}}.png" },

      //{ "x": 3, "src": "cfg://sirmax/img/x.swfD:\work\wot-xvm\release\configs\sirmax\img\marksOnGun\x.png " },
      { "x": 3, "src": "cfg://sirmax/img/marksOnGun/x.png " },

      //{ "w": 3,  "y": 2, "valign": "center", "h": 21, "bgColor": ${"def.c1"}, "alpha": "{{alive?75|0}}" },
      ${"../default/playersPanel.xc":"xmqpServiceMarker"},
      { "x": 6,  "y": 1, "align": "center", "bindToIcon": true, "alpha": "{{x-enabled?{{x-sense-on?70|30}}|0}}", "format": "<font color='#FFFFFF' face='xvm' size='23'>&#x70;</font>", "shadow": {} },
      { "x": "{{r_size=2?13|{{r_size=4?16|19}}}}", "y": 0, "valign": "center", "align": "center", "format": "<font color='{{t-battles>19?{{c:r|#666666}}|#666666}}' alpha='{{alive?#FF|#80}}'>{{r_size=2?{{r}}|{{r%d}}}}</font>", "shadow": {} },
      { "x": "{{r_size=2?23|{{r_size=4?32|36}}}}", "y": 2, "valign": "center", "h": 21, "w": "{{hp-max:120}}", "bgColor": 0, "alpha": 40 },
      { "x": "{{r_size=2?23|{{r_size=4?32|36}}}}", "y": 2, "valign": "center", "h": 21, "w": "{{hp:120}}", "bgColor": ${"def.c1"}, "alpha": 50 },
      { "x": -75, "y": 5, "bindToIcon": true, "src": "xvm://res/icons/xvm/xvm-user-{{xvm-user}}.png" },
      {}
    ],
    "extraFieldsRight": [
      // for tests
      //{ "w": 1, "h": 23, "bgColor": "0xFFFFFF" },
      //{ "x": "25", "y": 0,  "align": "left",   "w": 20, "h": 5, "bgColor": "0xFF0F0F", "alpha": 50 },
      //{ "x": "15", "y": 5,  "align": "center", "w": 20, "h": 5, "bgColor": "0x0FFF0F", "alpha": 50 },
      //{ "x": "5",  "y": 10, "align": "right",  "w": 20, "h": 5, "bgColor": "0x0F0FFF", "alpha": 50 },

      { "w": 3,  "y": 2, "valign": "center", "h": 21, "bgColor": ${"def.c2"}, "alpha": "{{alive?75|0}}" },
      { "x": "{{r_size=2?13|{{r_size=4?20|21}}}}", "y": 0, "valign": "center", "align": "center", "format": "<font color='{{t-battles>19?{{c:r|#666666}}|#666666}}' alpha='{{alive?#FF|#80}}'>{{r_size=2?{{r}}|{{r%d}}}}</font> </font>", "shadow": {} },
      { "x": "{{r_size=2?23|{{r_size=4?33|38}}}}", "y": 2, "valign": "center", "h": 21, "w": "{{hp-max:120}}", "bgColor": 0, "alpha": 40 },
      { "x": "{{r_size=2?23|{{r_size=4?33|38}}}}", "y": 2, "valign": "center", "h": 21, "w": "{{hp:120}}", "bgColor": ${"def.c2"}, "alpha": 50 },
      { "x": -75, "y": 5, "bindToIcon": true, "src": "xvm://res/icons/xvm/xvm-user-{{xvm-user}}.png" },
      { "x": 6,  "y": 1, "align": "center", "bindToIcon": true, "alpha": "{{a:spotted}}", "format": "<font color='{{c:spotted}}'>{{spotted}}</font>", "shadow": {} },
      {}
    ],
    "width": 120
  },
  "medium": {
    //"enabled": false,
    "width": 80,
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
    "enabled": false,
    "width": 80,
    //"removeSquadIcon": true,
    "vehicleLevelAlpha": 0,
    "vehicleFormatLeft": "<font color='{{c:xwn8}}' alpha='{{alive?#FF|#80}}'>{{vehicle}}</font>",
    "vehicleFormatRight": "<font color='{{c:xwn8}}' alpha='{{alive?#FF|#80}}'>{{vehicle}}</font>",
    "__stub__": null
  },
  "short": {
    //"enabled": false,
    //"width": 80,
    "vehicleLevelAlpha": 70,
    //"removeSquadIcon": true,
    "__stub__": null
  },
  "none": {
    //"enabled": false,
    //"layout": "horizontal",
    "extraFields": ${"sirmax-panels-none.xc":"."}
  },
  "alpha": 50,
  //"iconAlpha": 50,
  //"removeSelectedBackground": true,
  "removePanelsModeSwitcher": true,
  "clanIcon": { "show": true, "x": 4, "y": 6, "h": 16, "w": 16, "alpha": 90 }
}
