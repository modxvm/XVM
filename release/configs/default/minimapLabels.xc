/**
 * Minimap labels.
 * Надписи на миникарте.
 */
{
  // Textfields for tanks on minimap.
  // Текстовые поля для танков на миникарте.
  // TODO: documentation
  //  {
  //    "flags": [ "player", "ally", "squadman", "enemy", "teamKiller", "lost", "spotted", "alive", "dead" ],
  //    "format": "...",
  //    "shadow": { ... },
  //    "alpha": "...",
  //    "position": { ... },
  //    "antiAliasType": "advanced" // normal/advanced
  //  }
  "defaultItem": {
    "flags": [ "player", "ally", "squadman", "enemy", "teamKiller", "lost", "spotted", "alive", "dead" ],
    "shadow": { "distance": 0, "angle": 45, "color": "0x000000", "alpha": 80, "blur": 3, "strength": 4 },
    "alpha": 100,
    "x": 0,
    "y": 0,
    "width": 100,
    "height": 40,
    "align": "left",
    "valign": "top",
    "antiAliasType": "advanced",
    "bgColor": null,
    "borderColor": null
  },
  "labels": {
    "data": {
      "colors": {
        "txt": {
          "ally_alive":          "#C8FFA6",
          "ally_dead":           "#6E8C5B",
          "ally_blowedup":       "#6E8C5B",
          "squadman_alive":      "#FFD099",
          "squadman_dead":       "#997C5C",
          "squadman_blowedup":   "#997C5C",
          "teamKiller_alive":    "#A6F8FF",
          "teamKiller_dead":     "#5B898C",
          "teamKiller_blowedup": "#5B898C",
          "enemy_alive":         "#FCA9A4",
          "enemy_dead":          "#996763",
          "enemy_blowedup":      "#996763"
        },
        "dot": {
          "ally_alive":          "#96FF00",
          "ally_dead":           "#004D00",
          "ally_blowedup":       "#004D00",
          "squadman_alive":      "#FFB964",
          "squadman_dead":       "#663800",
          "squadman_blowedup":   "#663800",
          "teamKiller_alive":    "#00EAFF",
          "teamKiller_dead":     "#043A40",
          "teamKiller_blowedup": "#043A40",
          "enemy_alive":         "#F50800",
          "enemy_dead":          "#4D0300",
          "enemy_blowedup":      "#4D0300"
        },
        "lost_dot": {
          "ally_alive":          "#B4E595",
          "ally_dead":           "#004D00",
          "ally_blowedup":       "#004D00",
          "squadman_alive":      "#E5BB8A",
          "squadman_dead":       "#663800",
          "squadman_blowedup":   "#663800",
          "teamKiller_alive":    "#00D2E5",
          "teamKiller_dead":     "#043A40",
          "teamKiller_blowedup": "#043A40",
          "enemy_alive":         "#E59995",
          "enemy_dead":          "#4D0300",
          "enemy_blowedup":      "#4D0300"
        }
      },
      "vtype": {
        "LT":  "<font face='xvm'>&#x3A;</font>",
        "MT":  "<font face='xvm'>&#x3B;</font>",
        "HT":  "<font face='xvm'>&#x3F;</font>",
        "TD":  "<font face='xvm'>&#x2E;</font>",
        "SPG": "<font face='xvm'>&#x2D;</font>"
      }
    },
    "enabled": true,
    "formats": [
      // "spotted", "alive"
      //   "ally", "enemy", "squadman", "teamKiller"
      {
        "$ref": { "path":"defaultItem" },
        "flags": [ "ally", "enemy", "squadman", "teamKiller", "spotted", "alive" ],
        "format": "<font size='8' color='{{.minimap.labels.data.colors.txt.{{sys-color-key}}}}'>{{vehicle}}</font>",
        "x": 3,
        "y": -2
      },
      //   "squadman"
      {
        "$ref": { "path":"defaultItem" },
        "flags": [ "squadman", "spotted", "alive" ],
        "format": "<font size='8' color='{{.minimap.labels.data.colors.txt.{{sys-color-key}}}}'><i>{{name%.5s}}</i></font>",
        "x": 3,
        "y": 8
      },
      // "lost", "alive"
      //   "ally", "enemy", "squadman", "teamKiller"
      {
        "$ref": { "path":"defaultItem" },
        "flags": [ "ally", "enemy", "squadman", "teamKiller", "lost", "alive" ],
        "format": "<font face='Arial' size='17' color='{{.minimap.labels.data.colors.lost_dot.{{sys-color-key}}}}'>{{.minimap.labels.data.vtype.{{vtype-key}}}}</font>",
        "alpha": 70
      },
      {
        "$ref": { "path":"defaultItem" },
        "flags": [ "ally", "enemy", "squadman", "teamKiller", "lost", "alive" ],
        "format": "<font size='8' color='{{.minimap.labels.data.colors.txt.{{sys-color-key}}}}'><i>{{vehicle}}</i></font>",
        "alpha": 70,
        "x": -5,
        "y": -11
      },
      //   "squadman"
      {
        "$ref": { "path":"defaultItem" },
        "flags": [ "squadman", "lost", "alive" ],
        "format": "<font size='8' color='{{.minimap.labels.data.colors.txt.{{sys-color-key}}}}'><i>{{name%.5s}}</i></font>",
        "alpha": 70,
        "x": -5,
        "y": -3
      },
      // "dead"
      //   "ally", "enemy", "squadman", "teamKiller"
      {
        "$ref": { "path":"defaultItem" },
        "flags": [ "ally", "enemy", "squadman", "teamKiller", "dead" ],
        "format": "<font face='Arial' size='17' color='{{.minimap.labels.data.colors.dot.{{sys-color-key}}}}'>{{.minimap.labels.data.vtype.{{vtype-key}}}}</font>",
        "shadow": { "$ref": { "path":"defaultItem.shadow" }, "strength": 3 },
        "alpha": 50,
        "x": -5,
        "y": -11
      },
      //   "squadman"
      {
        "$ref": { "path":"defaultItem" },
        "flags": [ "squadman", "dead" ],
        "format": "<font size='8' color='{{.minimap.labels.data.colors.txt.{{sys-color-key}}}}'><i>{{name%.5s}}</i></font>",
        "shadow": { "$ref": { "path":"defaultItem.shadow" }, "strength": 3 },
        "alpha": 50,
        "x": -5,
        "y": -3
      }
    ]
  }
}
