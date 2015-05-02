{
  "def": {
    "c1": "0x1878B0",
    "c2": "0xC48E19",
    "tc": "0xE5E4E4"
  },
  "leftPanel": {
    "x": 0,
    "y": 65,
    "width": 380,
    "height": 28,
    "formats": [
      // for tests
      //{ "w": 1, "h": 23, "bgColor": "0xFFFFFF" },
      //{ "x": 400, "y": 0,  "w": 1, "h": 10, "bgColor": "0xFFFFFF" },
      //{ "x": 410, "y": 0,  "w": 2, "h": 10, "bgColor": "0xFFFFFF" },
      //{ "x": 420, "y": 0,  "w": 3, "h": 10, "bgColor": "0xFFFFFF" },
      //{ "x": 430, "y": 0,  "w": 4, "h": 10, "bgColor": "0xFFFFFF" },
      //{ "x": 450, "y": 0,  "w": 5, "h": 1, "bgColor": "0xFFFFFF" },
      //{ "x": 450, "y": 5,  "w": 5, "h": 2, "bgColor": "0xFFFFFF" },
      //{ "x": 450, "y": 10, "w": 5, "h": 3, "bgColor": "0xFFFFFF" },
      //{ "x": 450, "y": 15, "w": 5, "h": 4, "bgColor": "0xFFFFFF" },
      //{ "x": 460, "y": 0,  "w": 1, "h": 10, "borderColor": "0x00FF00" },
      //{ "x": 470, "y": 0,  "w": 2, "h": 10, "borderColor": "0x00FF00" },
      //{ "x": 480, "y": 0,  "w": 3, "h": 10, "borderColor": "0x00FF00" },
      //{ "x": 490, "y": 0,  "w": 4, "h": 10, "borderColor": "0x00FF00" },
      //{ "x": 500, "y": 0,  "w": 5, "h": 1, "borderColor": "0x00FF00" },
      //{ "x": 500, "y": 5,  "w": 5, "h": 2, "borderColor": "0x00FF00" },
      //{ "x": 500, "y": 10, "w": 5, "h": 3, "borderColor": "0x00FF00" },
      //{ "x": 500, "y": 15, "w": 5, "h": 4, "borderColor": "0x00FF00" },

      //{ "x": 350, "y": 5, "h": 13, "w": 146, "src": "cfg://sirmax/img/hp-bg.png" },
      //{ "x": 350, "y": 5, "h": 14, "w": "{{hp-ratio:150}}", "src": "cfg://sirmax/img/hp-{{squad?squad|ally}}-{{alive}}.png" },

      { "src": "cfg://sirmax/img/panel-bg-l-{{alive|dead}}.png" },
      { "x": 25, "y": 2, "h": 24, "w": "{{hp-max:230}}", "bgColor": 0, "alpha": "{{alive?50|0}}" },
      { "x": 25, "y": 2, "h": 24, "w": "{{hp:230}}", "bgColor": ${"def.c1"}, "alpha": 60 },
      { "x": 0, "w": 3, "y": 2, "h": 24, "bgColor": ${"def.c1"}, "alpha": "{{alive?80|0}}" },
      { "x": 14, "align": "center", "valign": "center", "format": "<font size='17' color='#E5E4E4'><b>{{frags|0}}</b></font>", "alpha": "{{alive?100|50}}", "shadow": {} },
      { "x": 31, "valign": "center", "format": "<font size='15' color='#E5E4E4'><b>{{name%.20s~..}}</b></font>", "alpha": "{{alive?100|50}}", "shadow": {} },
      { "x": 275, "align": "center", "valign": "center", "format": "<font size='15' color='#E5E4E4'><b>{{hp|----}}</b></font>", "alpha": "{{alive?100|50}}", "shadow": {} },
      { "x": 300, "src": "cfg://../../res/contour/Master_XH/{{vehiclename}}.png", "highlight": "{{tk?true|false}}", "alpha": "{{alive?100|50}}" },
      {}
    ]
  },
  "rightPanel": {
    "x": 0,
    "y": 65,
    "width": 380,
    "height": 28,
    "formats": [
      // for tests
      //{ "w": 1, "h": 23, "bgColor": "0xFFFFFF" },
      //{ "x": 400, "y": 0,  "w": 1, "h": 10, "bgColor": "0xFFFFFF" },
      //{ "x": 410, "y": 0,  "w": 2, "h": 10, "bgColor": "0xFFFFFF" },
      //{ "x": 420, "y": 0,  "w": 3, "h": 10, "bgColor": "0xFFFFFF" },
      //{ "x": 430, "y": 0,  "w": 4, "h": 10, "bgColor": "0xFFFFFF" },
      //{ "x": 450, "y": 0,  "w": 5, "h": 1, "bgColor": "0xFFFFFF" },
      //{ "x": 450, "y": 5,  "w": 5, "h": 2, "bgColor": "0xFFFFFF" },
      //{ "x": 450, "y": 10, "w": 5, "h": 3, "bgColor": "0xFFFFFF" },
      //{ "x": 450, "y": 15, "w": 5, "h": 4, "bgColor": "0xFFFFFF" },

      //{ "x": 350, "y": 5, "h": 13, "w": 146, "src": "cfg://sirmax/img/hp-bg.png" },
      //{ "x": 350, "y": 5, "h": 14, "w": "{{hp-ratio:150}}", "src": "cfg://sirmax/img/hp-enemy-{{alive}}.png" },
     
      { "src": "cfg://sirmax/img/panel-bg-r-{{alive|dead}}.png" },
      { "x": 25, "y": 2, "h": 24, "w": "{{hp-max:230}}", "bgColor": 0, "alpha": "{{alive?50|0}}" },
      { "x": 25, "y": 2, "h": 24, "w": "{{hp:230}}", "bgColor": ${"def.c2"}, "alpha": 60 },
      { "x": 0, "w": 3, "y": 2, "h": 24, "bgColor": ${"def.c2"}, "alpha": "{{alive?80|0}}" },
      { "x": 14, "align": "center", "valign": "center", "format": "<font size='17' color='#E5E4E4'><b>{{frags|0}}</b></font>", "alpha": "{{alive?100|50}}", "shadow": {} },
      { "x": 31, "valign": "center", "format": "<font size='15' color='#E5E4E4'><b>{{name%.20s~..}}</b></font>", "alpha": "{{alive?100|50}}", "shadow": {} },
      { "x": 275, "align": "center", "valign": "center", "format": "<font size='15' color='#E5E4E4'><b>{{hp|----}}</b></font>", "alpha": "{{alive?100|50}}", "shadow": {} },
      { "x": 300, "src": "cfg://../../res/contour/Master_XH/{{vehiclename}}.png", "highlight": "{{tk?true|false}}", "alpha": "{{alive?100|50}}" },
      { "x": 390, "y": 1, "align": "center", "alpha": "{{a:spotted}}", "format": "<font color='{{c:spotted}}'>{{spotted}}</font>", "shadow": {} },
      {}
    ]
  }
}
