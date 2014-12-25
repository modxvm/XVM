/**
 * Author: demon2597
 * http://www.koreanrandom.com/forum/topic/2172-5361-51014-demon2597-config-ru-en-more/
 */
{
  "def": {
    "textFieldShadow": { "color": "{{v.premium?0x994400|0x000000}}", "alpha": 0.8, "blur": 2, "strength": 2, "distance": 0, "angle": 0 }
  },
  "carousel": {
    "enabled": true,
    "zoom": 1,
    "rows": 2,
    "padding": { "horizontal": 5, "vertical": 5 },
    "alwaysShowFilters": true,
    "hideBuyTank": false,
    "hideBuySlot": false,
    "filters": {
      "nation":   { "enabled": true },
      "type":     { "enabled": true },
      "level":    { "enabled": true },
      "favorite": { "enabled": true },
      "prefs":    { "enabled": true },
      "__stub__": {}
    },
    "fields": {
      "tankType": { "visible": true,  "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      "level":    { "visible": false, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      "multiXp":  { "visible": true,  "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      "xp":       { "visible": true,  "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      "tankName": { "visible": false, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      "__stub__": {}
    },
    "extraFields": [
        { "x": 140, "y": 15, "w": 50, "h": 20, "align": "right", "format": "{{v.earnedXP%d}}" },
        { "x": 140, "y": 17, "src": "img://gui/maps/icons/library/XpIcon.png" },
        { "x": 135, "y": 57, "w": 25, "h": 25, "src": "img://gui/maps/icons/library/proficiency/class_icons_{{v.mastery}}.png"
        },
        { "x": 4, "y": 20, "src": "xvm://configs/sirmax/img/marksOnGun/{{v.marksOnGun|x}}.png"
        },
        { "x": 11, "y": "{{v.marksOnGun?18|17}}", "align": "center",
          "format": "<b><font size='9' color='#C8C8B5'>{{v.marksOnGun|x}}</font></b>",
          "shadow": ${ "def.textFieldShadow" }
        },
        { "x": 21, "y": 0,
          "format": "<b><font size='12' color='#C8C8B5'><font face='Arial'>{{v.rlevel}}</font>  {{v.battletiermin}}-{{v.battletiermax}}</font></b>",
          "shadow": ${ "def.textFieldShadow" }
        },
        { "x": 21, "y": 15,
          "format": "<b><font size='12' color='{{v.c_winrate}}'>{{v.winrate%2d~%}}</font></b>",
          "shadow": ${ "def.textFieldShadow" }
        },
        { "x": 158, "y": 77, "align": "right", "alpha": "{{v.premium?100|0}}",
          "format": "<font size='15' color='#FEA659'>{{v.name}}</font>",
          "shadow": { "color": "0xFC3700", "alpha": 1, "blur": 10, "strength": 2, "distance": 0, "angle": 0 }
        },
        { "x": 158, "y": 77, "align": "right", "alpha": "{{v.premium?0|100}}",
          "format": "<font size='15' color='#C8C8B5'>{{v.name}}</font>",
          "shadow": { "color": "0x73734C", "alpha": 0.8, "blur": 6, "strength": 2, "distance": 0, "angle": 0 }
        },
        { "x": -2, "y": -1, "h": 100, "w": "164", "bgColor": "{{v.selected?#FFA759|#000000}}", "alpha": "{{v.selected?15|0}}" },
        {}
    ]
  }
}
