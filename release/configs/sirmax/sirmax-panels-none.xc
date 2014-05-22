{
  "def": {
    "c1": "0x1878B0",
    "c2": "0xC48E19",
    "tc": "0xE5E4E4"
  },
  "leftPanel": {
    "x": 0,
    "y": 65,
    "width": 300,
    "height": 28,
    "formats": [
      //"<img src='xvm://configs/sirmax/img/panel-bg-l-{{alive|dead}}.png' width='318' height='28'>",
      "<img src='xvm://configs/sirmax/img/panel-bg-l-alive.png' width='318' height='28'>",
      { "x": 24, "y": 2, "h": 25, "w": "{{hp-max:230}}", "bgColor": 0, "alpha": "{{alive?50|0}}" },
      { "x": 24, "y": 2, "h": 25, "w": "{{hp:230}}", "bgColor": ${"def.c1"}, "alpha": 60 },
      { "x": 0, "w": 3, "y": 2, "h": 25, "bgColor": ${"def.c1"}, "alpha": "{{alive?80|0}}" },
      { "x": 9, "valign": "center", "format": "<font size='17' color='#E5E4E4'><b>{{frags|0}}</b></font>", "alpha": "{{alive?100|50}}", "shadow": {} },
      { "x": 31, "valign": "center", "format": "<font size='15' color='#E5E4E4'><b>{{name%.20s~..}}</b></font>", "alpha": "{{alive?100|50}}", "shadow": {} },
      { "x": 261, "valign": "center", "format": "<font size='15' color='#E5E4E4'><b>{{hp%4s|----}}</b></font>", "alpha": "{{alive?100|50}}", "shadow": {} },
      { "x": 300, "src": "xvm://res/contour/HARDicons/{{vehiclename}}.png" },
      {}
    ]
  },
  "rightPanel": {
    "x": 0,
    "y": 65,
    "width": 300,
    "height": 28,
    "formats": [
      "<img src='xvm://configs/sirmax/img/panel-bg-r-{{alive|dead}}.png' width='318' height='28'>",
      { "x": 24, "y": 2, "h": 25, "w": "{{hp-max:230}}", "bgColor": 0, "alpha": "{{alive?50|0}}" },
      { "x": 24, "y": 2, "h": 25, "w": "{{hp:230}}", "bgColor": ${"def.c2"}, "alpha": 60 },
      { "x": 0, "w": 3, "y": 2, "h": 25, "bgColor": ${"def.c2"}, "alpha": "{{alive?80|0}}" },
      { "x": 9, "valign": "center", "format": "<font size='17' color='#E5E4E4'><b>{{frags|0}}</b></font>", "alpha": "{{alive?100|50}}", "shadow": {} },
      { "x": 31, "valign": "center", "format": "<font size='15' color='#E5E4E4'><b>{{name%.20s~..}}</b></font>", "alpha": "{{alive?100|50}}", "shadow": {} },
      { "x": 261, "valign": "center", "format": "<font size='15' color='#E5E4E4'><b>{{hp%4s|----}}</b></font>", "alpha": "{{alive?100|50}}", "shadow": {} },
      { "x": 300, "src": "xvm://res/contour/HARDicons/{{vehiclename}}.png" },
      {}
    ]
  }
}
