{
  "def": {
    "c1": "0x1878B0",
    "c2": "0xC48E19",
    "tc": "0xE5E4E4"
  },
  "leftPanel": {
    "x": 0,
    "y": 30,
    "width": 380,
    "height": 28,
    "formats": [
      // for tests
      //{ "width": 1, "height": 23, "bgColor": "0xFFFFFF" },
      //{ "x": 400, "y": 0,  "width": 1, "height": 10, "bgColor": "0xFFFFFF" },
      //{ "x": 410, "y": 0,  "width": 2, "height": 10, "bgColor": "0xFFFFFF" },
      //{ "x": 420, "y": 0,  "width": 3, "height": 10, "bgColor": "0xFFFFFF" },
      //{ "x": 430, "y": 0,  "width": 4, "height": 10, "bgColor": "0xFFFFFF" },
      //{ "x": 450, "y": 0,  "width": 5, "height": 1, "bgColor": "0xFFFFFF" },
      //{ "x": 450, "y": 5,  "width": 5, "height": 2, "bgColor": "0xFFFFFF" },
      //{ "x": 450, "y": 10, "width": 5, "height": 3, "bgColor": "0xFFFFFF" },
      //{ "x": 450, "y": 15, "width": 5, "height": 4, "bgColor": "0xFFFFFF" },
      //{ "x": 460, "y": 0,  "width": 1, "height": 10, "borderColor": "0x00FF00" },
      //{ "x": 470, "y": 0,  "width": 2, "height": 10, "borderColor": "0x00FF00" },
      //{ "x": 480, "y": 0,  "width": 3, "height": 10, "borderColor": "0x00FF00" },
      //{ "x": 490, "y": 0,  "width": 4, "height": 10, "borderColor": "0x00FF00" },
      //{ "x": 500, "y": 0,  "width": 5, "height": 1, "borderColor": "0x00FF00" },
      //{ "x": 500, "y": 5,  "width": 5, "height": 2, "borderColor": "0x00FF00" },
      //{ "x": 500, "y": 10, "width": 5, "height": 3, "borderColor": "0x00FF00" },
      //{ "x": 500, "y": 15, "width": 5, "height": 4, "borderColor": "0x00FF00" },

      //{ "x": 350, "y": 5, "height": 13, "width": 146, "src": "cfg://sirmax/img/hp-bg.png" },
      //{ "x": 350, "y": 5, "height": 14, "width": "{{hp-ratio:150}}", "src": "cfg://sirmax/img/hp-{{squad?squad|ally}}-{{alive}}.png" },

      { "src": "cfg://sirmax/img/panel-bg-l-{{alive|dead}}.png" },
      { "x": 25, "y": 2, "height": 24, "width": "{{hp-max:230}}", "bgColor": 0, "alpha": "{{alive?50|0}}" },
      { "x": 25, "y": 2, "height": 24, "width": "{{hp:230}}", "bgColor": ${"def.c1"}, "alpha": 60 },
      { "x": 0, "width": 3, "y": 2, "height": 24, "bgColor": ${"def.c1"}, "alpha": "{{alive?80|0}}" },
      { "x": 14, "height": 28, ""align": "center", "valign": "center", "format": "<font size='17' color='#E5E4E4'><b>{{frags|0}}</b></font>", "alpha": "{{alive?100|50}}", "shadow": {} },
      { "x": 31, "height": 28, "valign": "center", "format": "<font size='15' color='#E5E4E4'><b>{{name%.20s~..}}</b></font>", "alpha": "{{alive?100|50}}", "shadow": {} },
      { "x": 275, "height": 28, "align": "center", "valign": "center", "format": "<font size='15' color='#E5E4E4'><b>{{hp|----}}</b></font>", "alpha": "{{alive?100|50}}", "shadow": {} },
      { "x": 300, "src": "cfg://../../res/contour/Master_XH/{{vehiclename}}.png", "highlight": "{{tk?true|false}}", "alpha": "{{alive?100|50}}" },
      { "$ref": { "file":"../default/playersPanel.xc", "path":"clanIcon" }, "x": 349 },
      { "$ref": { "file":"../default/playersPanel.xc", "path":"xvmUserMarker" }, "x": 295, "enabled": true },
      { "$ref": { "file":"../default/playersPanel.xc", "path":"xmqpServiceMarker" }, "x": 371 },
      {}
    ]
  },
  "rightPanel": {
    "x": 0,
    "y": 30,
    "width": 380,
    "height": 28,
    "formats": [
      // for tests
      //{ "width": 1, "height": 23, "bgColor": "0xFFFFFF" },
      //{ "x": 400, "y": 0,  "width": 1, "height": 10, "bgColor": "0xFFFFFF" },
      //{ "x": 410, "y": 0,  "width": 2, "height": 10, "bgColor": "0xFFFFFF" },
      //{ "x": 420, "y": 0,  "width": 3, "height": 10, "bgColor": "0xFFFFFF" },
      //{ "x": 430, "y": 0,  "width": 4, "height": 10, "bgColor": "0xFFFFFF" },
      //{ "x": 450, "y": 0,  "width": 5, "height": 1, "bgColor": "0xFFFFFF" },
      //{ "x": 450, "y": 5,  "width": 5, "height": 2, "bgColor": "0xFFFFFF" },
      //{ "x": 450, "y": 10, "width": 5, "height": 3, "bgColor": "0xFFFFFF" },
      //{ "x": 450, "y": 15, "width": 5, "height": 4, "bgColor": "0xFFFFFF" },

      //{ "x": 350, "y": 5, "height": 13, "width": 146, "src": "cfg://sirmax/img/hp-bg.png" },
      //{ "x": 350, "y": 5, "height": 14, "width": "{{hp-ratio:150}}", "src": "cfg://sirmax/img/hp-enemy-{{alive}}.png" },

      { "src": "cfg://sirmax/img/panel-bg-r-{{alive|dead}}.png" },
      { "x": 25, "y": 2, "height": 24, "width": "{{hp-max:230}}", "bgColor": 0, "alpha": "{{alive?50|0}}" },
      { "x": 25, "y": 2, "height": 24, "width": "{{hp:230}}", "bgColor": ${"def.c2"}, "alpha": 60 },
      { "x": 0, "width": 3, "y": 2, "height": 24, "bgColor": ${"def.c2"}, "alpha": "{{alive?80|0}}" },
      { "x": 14, "height": 28, "align": "center", "valign": "center", "format": "<font size='17' color='#E5E4E4'><b>{{frags|0}}</b></font>", "alpha": "{{alive?100|50}}", "shadow": {} },
      { "x": 31, "height": 28, "valign": "center", "format": "<font size='15' color='#E5E4E4'><b>{{name%.20s~..}}</b></font>", "alpha": "{{alive?100|50}}", "shadow": {} },
      { "x": 275, "height": 28, "align": "center", "valign": "center", "format": "<font size='15' color='#E5E4E4'><b>{{hp|----}}</b></font>", "alpha": "{{alive?100|50}}", "shadow": {} },
      { "x": 300, "src": "cfg://../../res/contour/Master_XH/{{vehiclename}}.png", "highlight": "{{tk?true|false}}", "alpha": "{{alive?100|50}}" },
      { "$ref": { "file":"../default/playersPanel.xc", "path":"clanIcon" }, "x": 354 },
      { "$ref": { "file":"../default/playersPanel.xc", "path":"xvmUserMarker" }, "x": 300, "enabled": true },
      { "$ref": { "file":"../default/playersPanel.xc", "path":"enemySpottedMarker" }, "x": 376 },
      {}
    ]
  }
}
