/**
 * Author: demon2597
 * http://www.koreanrandom.com/forum/topic/2172-5361-51014-demon2597-config-ru-en-more/
 */
{
  "def": {
    "textFieldShadow": { "color": "{{v.premium?0x994400|0x000000}}", "alpha": 0.8, "blur": 2, "strength": 2, "distance": 0, "angle": 0 }
  },
  "carousel": {
    //"enabled": false,
    //"zoom": 0.75,
    "rows": 2,
    "padding": { "horizontal": 5, "vertical": 5 },
    //"scrollingSpeed": 30,
    "backgroundAlpha": 30,
    "filtersPadding": { "horizontal": 11, "vertical": 10 },
    "alwaysShowFilters": true,
    //"suppressCarouselTooltips": true,
    //"hideBuyTank": true,
    //"hideBuySlot": true,
    //"showUsedSlots": true,
    "showTotalSlots": true,
    "sorting_criteria": ["level", "nation", "type"],
    "filters": {
      //"nation":   { "enabled": false },
      //"type":     { "enabled": false },
      //"favorite": { "enabled": false },
      //"gameMode": { "enabled": false },
      //"level":    { "enabled": false },
      //"prefs":    { "enabled": false },
      "__stub__": {}
    },
    "fields": {
      "tankType":       { "visible": true,  "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      "level":          { "visible": false, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      "multiXp":        { "visible": true,  "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      "xp":             { "visible": true,  "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      //"tankName":       { "visible": false, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      "statusText":     { "visible": true,  "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      "statusTextBuy":  { "visible": true,  "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      "clanLock":       { "visible": true,  "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      "activateButton": { "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
      "__stub__": {}
    },
    "extraFields": [
        { "x": 140, "y": 15, "w": 50, "h": 40, "align": "right", "format": "{{v.xpToElite?{{v.earnedXP%'d|0}} {{v.xpToEliteLeft<1000?<font color='#88FF88' size='20'><b>|<font color='#CCCCCC' size='12'>}}({{v.xpToEliteLeft%'d}})</font>}}", "shadow": {} },
        { "x": 140, "y": 17, "src": "img://gui/maps/icons/library/XpIcon.png" },

        { "x": 135, "y": 57, "w": 25, "h": 25, "src": "img://gui/maps/icons/library/proficiency/class_icons_{{v.mastery}}.png" },

        { "x": 140, "y": 40, "src": "cfg://sirmax/img/marksOnGun/{{v.marksOnGun|empty}}.png" },
        { "x": 147, "y": "{{v.marksOnGun?38|37}}", "align": "center",
          "format": "<b><font size='9' color='#C8C8B5'>{{v.marksOnGun}}</font></b></font>",
          "shadow": {}
        },
        { "x": 140, "y": "{{v.marksOnGun?38|37}}", "align": "right",
          "format": "<font size='13' color='{{v.c_damageRating}}'>{{v.damageRating%.2f~%}}</font>",
          "shadow": ${ "def.textFieldShadow" }
        },

        { "x": 21, "y": 0,
          "format": "<b><font size='12' color='#C8C8B5'><font face='Arial'>{{v.rlevel}}</font>  {{v.battletiermin}}-{{v.battletiermax}}</font></b>",
          "shadow": ${ "def.textFieldShadow" }
        },

        { "x": 0, "y": 15, "w": 22, "h": 22, "src": "img://gui/maps/icons/library/dossier/wins40x32.png" },
        { "x": 21, "y": 15,
          "format": "<b><font size='12' color='{{v.c_winrate}}'>{{v.winrate%2d~%}}</font></b>",
          "shadow": ${ "def.textFieldShadow" }
        },

        { "x": 0, "y": 33, "w": 22, "h": 22, "src": "img://gui/maps/icons/library/dossier/avgDamage40x32.png" },
        { "x": 21, "y": 35,
          "format": "<b><font size='12' color='{{v.c_wn8effd}}'>{{v.wn8effd%0.2f}}</font></b>",
          "shadow": ${ "def.textFieldShadow" }
        },

        { "x": 0, "y": 51, "w": 22, "h": 22, "src": "img://gui/maps/icons/library/dossier/techRatio40x32.png" },
        { "x": 21, "y": 53,
          "format": "<b><font face='mono' size='12' color='{{v.battles>9?{{v.c_xte|#666666}}|#666666}}'>{{v.xte|--}}</font></b>",
          "shadow": ${ "def.textFieldShadow" }
        },

        //{ "x": 158, "y": 77, "align": "right", "alpha": "{{v.premium?100|0}}",
        //  "format": "<font size='15' color='#FEA659'>{{v.name}}</font>",
        //  "shadow": { "color": "0xFC3700", "alpha": 1, "blur": 10, "strength": 2, "distance": 0, "angle": 0 }
        //},

        //{ "x": 158, "y": 77, "align": "right", "alpha": "{{v.premium?0|100}}",
        //  "format": "<font size='15' color='#C8C8B5'>{{v.name}}</font>",
        //  "shadow": { "color": "0x73734C", "alpha": 0.8, "blur": 6, "strength": 2, "distance": 0, "angle": 0 }
        //},

        { "x": -2, "y": -1, "h": 100, "w": "164", "bgColor": "{{v.selected?#FFA759|#000000}}", "alpha": "{{v.selected?15|0}}" },

        {}
    ]
  }
}
