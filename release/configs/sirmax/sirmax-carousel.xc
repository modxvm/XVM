﻿/**
 * Author: demon2597
 * https://koreanrandom.com/forum/topic/2172-/
 */
{
  "def": {
    "textFieldShadow": { "color": "{{v.premium?0x994400|0x000000}}", "alpha": 0.8, "blur": 2, "strength": 2, "distance": 0, "angle": 0 }
  },
  "carousel": {
    //"enabled": false,
    "cellType": "normal",
    //"zoom": 0.75,
    "rows": 0,
    //"backgroundAlpha": 0,
    //"slotBackgroundAlpha": 0,
    //"slotBorderAlpha": 0,
    "edgeFadeAlpha": 50,
    //"scrollingSpeed": 2,
    //"suppressCarouselTooltips": true,
    //"hideBuyTank": true,
    //"hideBuySlot": true,
    "showTotalSlots": true,
    //"showUsedSlots": true,
    "enableLockBackground": false,
    //"nations_order": ["ussr", "germany", "usa", "china", "france", "uk", "japan", "czech", "poland", "sweden", "italy"],
    //"types_order":   ["lightTank", "mediumTank", "heavyTank", "AT-SPG", "SPG"],
    //"sorting_criteria": ["nation", "level", "type"],
    "sorting_criteria": ["level", "nation", "type"],
    "filters": {
      //"params":   { "enabled": false },
      //"bonus":    { "enabled": false },
      //"favorite": { "enabled": false },
      "__stub__": {}
    },
    //"filtersPadding": { "horizontal": 5, "vertical": 5 },
    //"suppressCarouselTooltips": false
    "normal": {
      "width": 160,
      "height": 100,
      "gap": 4,
      "fields": {
        //"flag":     { "enabled": true,  "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
        //"tankIcon": { "enabled": true,  "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
        //"tankType": { "enabled": true,  "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
        "level":    { "enabled": false, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
        //"xp":       { "enabled": true,  "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
        //"tankName": { "enabled": true,  "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
        //"rentInfo": { "enabled": true,  "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
        "info":     { "enabled": true,  "dx": 0, "dy": 2, "alpha": 100, "scale": 1 },
        //"infoImg":  { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
        //"infoBuy":  { "enabled": true,  "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
        //"clanLock": { "enabled": true,  "dx": 0, "dy": 0, "alpha": 100 },
        //"price":    { "enabled": true,  "dx": 0, "dy": 0, "alpha": 100 },
        //"actionPrice": { "enabled": true, "dx": 0, "dy": 0, "alpha": 100 },
        //"favorite": { "enabled": true, "dx": 0, "dy": 0, "alpha": 100 },
        "stats":    { "enabled": false, "dx": 0, "dy": 0, "alpha": 100 },
        "__stub__": {}
      },
      "extraFields": [
        // left side

        // level, battle tiers
        { "x": 21, "y": 0, "shadow": ${ "def.textFieldShadow" },
          "textFormat": { "size": 12, "color": "0xC8C8B5", "bold": true }, "antiAliasType": "advanced",
          "format": "<font face='Arial'>{{v.rlevel}}</font>  {{battletype-key!=ranked?{{v.battletiermin}}-{{v.battletiermax}}|{{v.rankCount|0}} + {{v.rankSteps|0}}/{{v.rankStepsTotal|0}}}}" },
        // xte
        { "x": 7, "y": 25, "height": 22, "shadow": ${ "def.textFieldShadow" },
          "valign": "center", "textFormat": { "font": "mono", "size": 12, "bold": true, "valign": "center" }, "antiAliasType": "advanced",
          "format": "{{v.xte?<img src='xvm://res/icons/xvm/8x8t.png'><font size='7'> </font><font color='{{v.battles>9?{{v.c_xte|#666666}}|#666666}}'>{{v.xte}}</font>}}"},
        // avg/top dmg
        { "y": 35, "height": 10, "bgColor": "0xFF4444", "alpha": "{{v.topdmg?30|0}}", "x": 5,
          "width": "{{py:mul({{py:div({{v.avgdmg|None}}, {{v.topdmg|None}})|None}}, 90)}}" },
        { "y": 35, "height": 10, "bgColor": "0x00FF00", "alpha": "{{v.topdmg?30|0}}",
          "x": "{{py:add(5, {{py:mul({{py:div({{v.avgdmg|None}}, {{v.topdmg|None}})|None}}, 90)}})}}",
          "width": "{{py:sub(90, {{py:mul({{py:div({{v.avgdmg|None}}, {{v.topdmg|None}})|None}}, 90)}})}}" },
        { "y": 33, "x": 5, "width": 20, "height": 22, "shadow": ${ "def.textFieldShadow" },
          "format": "<font size='8'>dmg</font>" },
        { "y": 33, "height": 14, "bgColor": "{{v.c_tdb}}", "alpha": "{{v.topdmg?100|0}}", "width": 1,
          "x": "{{py:add(5, {{py:min(90, {{py:mul({{py:div({{v.tdb|0}}, {{v.topdmg|None}})|None}}, 90)}})}})}}" },
        { "y": 31, "x": 20, "width": 75, "height": 22, "shadow": ${ "def.textFieldShadow" },
          "format": "<font size='11' color='{{v.c_tdb}}'>{{v.tdb%d}}</font>" },
        // avg/top frg
        { "y": 50, "height": 10, "bgColor": "0xFF4444", "alpha": "{{v.topfrg?30|0}}", "x": 5,
          "width": "{{py:mul({{py:div({{v.avgfrg|None}}, {{v.topfrg|None}})|None}}, 90)}}" },
        { "y": 50, "height": 10, "bgColor": "0x00FF00", "alpha": "{{v.topfrg?30|0}}",
          "x": "{{py:add(5, {{py:mul({{py:div({{v.avgfrg|None}}, {{v.topfrg|None}})|None}}, 90)}})}}",
          "width": "{{py:sub(90, {{py:mul({{py:div({{v.avgfrg|None}}, {{v.topfrg|None}})|None}}, 90)}})}}" },
        { "y": 48, "x": 7, "width": 20, "height": 22, "shadow": ${ "def.textFieldShadow" },
          "format": "<font size='8'>frg</font>" },
        { "y": 48, "height": 14, "bgColor": "{{v.c_tfb}}", "alpha": "{{v.topfrg?100|0}}", "width": 1,
          "x": "{{py:add(5, {{py:min(90, {{py:mul({{py:div({{v.tfb|0}}, {{v.topfrg|None}})|None}}, 90)}})}})}}" },
        { "y": 46, "x": 20, "width": 75, "height": 22, "shadow": ${ "def.textFieldShadow" },
          "format": "<font size='11' color='{{v.c_tfb}}'>{{v.tfb%0.1f}}</font>" },
        // wn8 exp
        { "y": 65, "height": 10, "bgColor": "0xFF4444", "alpha": "{{v.topdmg?30|0}}", "x": 5,
          "width": "{{py:mul({{py:div({{v.wn8expd|None}}, {{v.topdmg|None}})|None}}, 90)}}" },
        { "y": 65, "height": 10, "bgColor": "0x00FF00", "alpha": "{{v.topdmg?30|0}}",
          "x": "{{py:add(5, {{py:mul({{py:div({{v.wn8expd|None}}, {{v.topdmg|None}})|None}}, 90)}})}}",
          "width": "{{py:sub(90, {{py:mul({{py:div({{v.wn8expd|None}}, {{v.topdmg|None}})|None}}, 90)}})}}" },
        { "y": 63, "x": 5, "width": 20, "height": 22, "shadow": ${ "def.textFieldShadow" },
          "format": "<font size='8'>wn8</font>" },
        { "y": 63, "height": 14, "bgColor": "{{v.c_wn8effd}}", "alpha": "{{v.topdmg?100|0}}", "width": 1,
          "x": "{{py:add(5, {{py:min(90, {{py:mul({{v.wn8effd|0}}, {{py:div({{v.wn8expd|None}}, {{v.topdmg|None}})|None}}, 90)}})}})}}" },
        { "y": 61, "x": 20, "width": 75, "height": 22, "shadow": ${ "def.textFieldShadow" }, "alpha": "{{v.wn8effd?100|0}}",
          "format": "<font size='11' color='{{v.c_wn8effd}}'>{{py:mul({{v.wn8effd|None}}, 100)%d~%}}</font>" },
        // wins
        { "x": 0, "y": 80, "width": 22, "height": 22,
          "src": "{{v.winrate?img://gui/maps/icons/library/dossier/wins40x32.png}}" },
        { "x": 20, "y": 91, "height": 22, "shadow": ${ "def.textFieldShadow" },
          "valign": "center", "textFormat": { "font": "mono", "size": 12, "bold": true }, "antiAliasType": "advanced",
          "format": "<font color='{{v.c_winrate}}'>{{v.winrate%2d~%}}</font>" },
        // battles
        { "x": 40, "y": 78, "width": 22, "height": 22,
          "src": "{{v.winrate?img://gui/maps/icons/library/dossier/battles40x32.png}}" },
        { "x": 60, "y": 91, "height": 22, "shadow": ${ "def.textFieldShadow" },
          "valign": "center", "textFormat": { "font": "mono", "size": 12, "bold": true }, "antiAliasType": "advanced",
          "format": "<font color='{{v.c_battles}}'>{{v.battles%d}}</font>" },

        // right side

        // xp
        { "x": 140, "y": 15,
          "src": "{{v.xpToElite?img://gui/maps/icons/library/XpIcon.png}}" },
        { "x": 140, "y": 13, "width": 100, "height": 40, "shadow": ${ "def.textFieldShadow" },
          "align": "right", "textFormat": { "align": "right" }, "antiAliasType": "advanced",
          "format": "{{v.xpToElite?{{v.earnedXP%'d|0}} {{v.xpToEliteLeft<1000?<font color='#88FF88' size='20'><b>|<font color='#CCCCCC' size='12'>}}({{v.xpToEliteLeft%'d}})</font>}}" },
        // mog
        { "x": 140, "y": 33,
          "src": "cfg://sirmax/img/marksOnGun/{{v.marksOnGun=*?-|{{v.marksOnGun|empty}}}}.png" },
        { "x": 147, "y": 33, "width":14, "height":17, "shadow": ${ "def.textFieldShadow" },
          "align":"center", "valign":"center", "textFormat": { "size": 11, "color": "0xC8C8B5", "bold": true, "align": "center", "valign":"center" }, "antiAliasType": "advanced",
          "format": "{{v.marksOnGun}}" },
        { "x": 140, "y": 31, "height":17, "shadow": ${ "def.textFieldShadow" },
          "align": "right", "valign":"center", "textFormat": { "size": 13, "align": "right", "valign":"center" }, "antiAliasType": "advanced",
          "format": "<font color='{{v.c_damageRating}}'>{{v.damageRating%.2f~%}}</font>" },
        // mastery
        { "x": 135, "y": 57, "width": 25, "height": 25,
          "src": "img://gui/maps/icons/library/proficiency/class_icons_{{v.mastery}}.png" },

        //{ "x": 158, "y": 77, "align": "right", "alpha": "{{v.premium?100|0}}",
        //  "format": "<font size='15' color='#FEA659'>{{v.name}}</font>",
        //  "shadow": { "color": "0xFC3700", "alpha": 1, "blur": 10, "strength": 2, "distance": 0, "angle": 0 }
        //},
        //{ "x": 158, "y": 77, "align": "right", "alpha": "{{v.premium?0|100}}",
        //  "format": "<font size='15' color='#C8C8B5'>{{v.name}}</font>",
        //  "shadow": { "color": "0x73734C", "alpha": 0.8, "blur": 6, "strength": 2, "distance": 0, "angle": 0 }
        //},

        // border
        { "x": 0, "y": 0, "width": 162, "height": 102, "layer":"top", "bgColor": "{{v.selected?#FFA759|#000000}}", "alpha": "{{v.selected?15|0}}" },
        //{ "x": 0, "y": 0, "width": 162, "height": 102, "layer":"top", "borderColor": "0xFFFFFF", "alpha": "{{v.selected?100|0}}" },
        {}
      ]
    },
    "small": {
      "width": 160,
      "height": 35,
      "gap": 4,
      "fields": {
        //"tankType": { "enabled": true,  "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
        //"level":    { "enabled": true,  "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
        //"xp":       { "enabled": true,  "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
        "tankName": { "enabled": true,  "dx": 0, "dy": 3, "alpha": 100, "scale": 0.9 },
        //"info":     { "enabled": true,  "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
        //"infoImg":  { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
        "infoBuy":  { "enabled": true,  "dx": 0, "dy": -8, "alpha": 100, "scale": 1 },
        //"clanLock": { "enabled": true,  "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
        //"price":    { "enabled": true,  "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
        //"actionPrice": { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
        //"favorite": { "enabled": true, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
        "stats": { "enabled": false, "dx": 0, "dy": 0, "alpha": 100, "scale": 1 },
        "__stub__": {}
      },
      "extraFields": [
        // left side

        // mastery
        { "x": 3, "y": 15, "width": 25, "height": 25,
          "src": "img://gui/maps/icons/library/proficiency/class_icons_{{v.mastery}}.png" },
        // xte
        { "x": 25, "y": 27, "height": 25,
          "valign": "center", "textFormat": { "font": "mono", "size": 12, "bold": true, "valign": "center" }, "antiAliasType": "advanced",
          "format": "{{v.xte?<img src='xvm://res/icons/xvm/8x8t.png'><font size='7'></font><font color='{{v.battles>9?{{v.c_xte|#666666}}|#666666}}'>{{v.xte}}</font>}}",
          "shadow": ${ "def.textFieldShadow" }
        },

        // right side

        // mog | xp left
        { "x": 100, "y": 3,
          "src": "{{v.xpToEliteLeft>=1000?cfg://sirmax/img/marksOnGun/{{v.marksOnGun=*?-|{{v.marksOnGun|empty}}}}.png}}" },
        { "x": 107, "y": 3, "width":14, "height":17, "shadow": ${ "def.textFieldShadow" },
          "align":"center", "valign":"center", "textFormat": { "size": 11, "color": "0xC8C8B5", "bold": true, "align": "center", "valign":"center" },
          "format": "{{v.xpToEliteLeft>=1000?{{v.marksOnGun}}}}" },
        { "x": 100, "y": 3, "height":17, "shadow": ${ "def.textFieldShadow" },
          "align": "right", "valign":"center", "textFormat": { "size": 13, "align": "right", "valign":"center" },
          "format": "{{v.xpToEliteLeft>=1000?<font color='{{v.c_damageRating}}'>{{v.damageRating%.2f~%}}</font>}}" },
        { "x": 120, "y": 0, "width": 70, "height": 40, "shadow": ${ "def.textFieldShadow" },
          "align": "right", "textFormat": { "align": "right" }, "antiAliasType": "advanced",
          "format": "{{v.xpToEliteLeft<1000?<font color='#88FF88' size='13'><b>XP Left: {{v.xpToEliteLeft%'d}}</font>}}" },

        // border
        { "x": 0, "y": 0, "width": 162, "height": 37, "layer":"top", "bgColor": "{{v.selected?#FFA759|#000000}}", "alpha": "{{v.selected?15|0}}" },
        //{ "x": 0, "y": 0, "width": 162, "height": 37, "layer":"top", "borderColor": "0xFFFFFF", "alpha": "{{v.selected?100|0}}" },
        {}
      ]
    }
  }
}
