/**
 * Minimap labels.
 * Надписи на миникарте.
 */
{
  // Textfields for tanks on minimap.
  // Текстовые поля для танков на миникарте.
  // TODO: documentation
  //  {
  //    "flags": [ "player", "ally", "squad", "enemy", "teamKiller", "lost", "spotted", "alive", "dead" ],
  //    "format": "...",
  //    "shadow": { ... },
  //    "alpha": "...",
  //    "position": { ... },
  //    "antiAliasType": "advanced" // normal/advanced
  //  }
  "defaultItem": {
    "flags": [ "player", "ally", "squad", "enemy", "teamKiller", "lost", "spotted", "alive", "dead" ],
    "shadow": { "enabled": true, "color": "0x000000", "distance": 0, "angle": 45, "alpha": 80, "blur": 3, "strength": 4 },
    "alpha": 100,
    "x": 0,
    "y": 0,
    "width": 100,
    "height": 40,
    "align": "left",
    "antiAliasType": "advanced"
  },
  "labels": {
    "data": {
      "colors": {
        "txt": {
          "ally_alive":          "0xC8FFA6",
          "ally_dead":           "0x6E8C5B",
          "ally_blowedup":       "0x6E8C5B",
          "squadman_alive":      "0xFFD099",
          "squadman_dead":       "0x997C5C",
          "squadman_blowedup":   "0x997C5C",
          "teamKiller_alive":    "0xA6F8FF",
          "teamKiller_dead":     "0x5B898C",
          "teamKiller_blowedup": "0x5B898C",
          "enemy_alive":         "0xFCA9A4",
          "enemy_dead":          "0x996763",
          "enemy_blowedup":      "0x996763"
        },
        "dot": {
          "ally_alive":          "0xC8FFA6",
          "ally_dead":           "0x004D00",
          "ally_blowedup":       "0x004D00",
          "squadman_alive":      "0xFFD099",
          "squadman_dead":       "0x663800",
          "squadman_blowedup":   "0x663800",
          "teamKiller_alive":    "0xA6F8FF",
          "teamKiller_dead":     "0x043A40",
          "teamKiller_blowedup": "0x043A40",
          "enemy_alive":         "0xFCA9A4",
          "enemy_dead":          "0x4D0300",
          "enemy_blowedup":      "0x4D0300"
        },
        "lost_dot": {
          "ally_alive":          "0xB4E595",
          "ally_dead":           "0x004D00",
          "ally_blowedup":       "0x004D00",
          "squadman_alive":      "0xE5BB8A",
          "squadman_dead":       "0x663800",
          "squadman_blowedup":   "0x663800",
          "teamKiller_alive":    "0x00D2E5",
          "teamKiller_dead":     "0x043A40",
          "teamKiller_blowedup": "0x043A40",
          "enemy_alive":         "0xE59995",
          "enemy_dead":          "0x4D0300",
          "enemy_blowedup":      "0x4D0300"
        }
      },
      "vtype": {
        "LT": "&#x3A;",
        "MT": "&#x3B;",
        "HT": "&#x3F;",
        "TD": "&#x2E;",
        "SPG": "&#x2D;"
      }
    },
    "formats": [
      // "spotted", "alive"
      //   "ally", "enemy", "squad", "teamKiller"
      {
        "$ref": { "path":"defaultItem" },
        "flags": [ "ally", "enemy", "squad", "teamKiller", "spotted", "alive" ],
        "format": "<font size='8' color='{{c:system:minimap.labels.data.colors.txt}}'>{{vehicle}}</font>",
        "x": 3,
        "y": -2
      },
      //   "squad"
      {
        "$ref": { "path":"defaultItem" },
        "flags": [ "squad", "spotted", "alive" ],
        "format": "<font size='8' color='{{c:system:minimap.labels.data.colors.txt}}'><i>{{name%.5s}}</i></font>",
        "x": 3,
        "y": 8
      },
      // "lost", "alive"
      //   "ally", "enemy", "squad", "teamKiller"
      {
        "$ref": { "path":"defaultItem" },
        "flags": [ "ally", "enemy", "squad", "teamKiller", "lost", "alive" ],
        "format": "<font face='Arial' size='17' color='{{c:system:minimap.labels.data.colors.lost_dot}}'>{{.minimap.labels.data.vtype.{{vtype}}}}</font>",
        "alpha": 70
      },
      {
        "$ref": { "path":"defaultItem" },
        "flags": [ "ally", "enemy", "squad", "teamKiller", "lost", "alive" ],
        "format": "<font size='8' color='{{c:system:minimap.labels.data.colors.txt}}'><i>{{vehicle}}</i></font>",
        "alpha": 70,
        "x": -5,
        "y": -11
      },
      //   "squad"
      {
        "$ref": { "path":"defaultItem" },
        "flags": [ "squad", "lost", "alive" ],
        "format": "<font size='8' color='{{c:system:minimap.labels.data.colors.txt}}'><i>{{name%.5s}}</i></font>",
        "alpha": 70,
        "x": -5,
        "y": -3
      },
      // "dead"
      //   "ally", "enemy", "squad", "teamKiller"
      {
        "$ref": { "path":"defaultItem" },
        "flags": [ "ally", "enemy", "squad", "teamKiller", "lost", "alive" ],
        "format": "<font face='Arial' size='17' color='{{c:system:minimap.labels.data.colors.dot}}'>{{.minimap.labels.data.vtype.{{vtype}}}}</font>",
        "shadow": { "$ref": { "path":"defaultItem.shadow" }, "strength": 3 },
        "alpha": 50,
        "x": -5,
        "y": -11
      },
      //   "squad"
      {
        "$ref": { "path":"defaultItem" },
        "flags": [ "squad", "dead" ],
        "format": "<font size='8' color='{{c:system:minimap.labels.data.colors.txt}}'><i>{{name%.5s}}</i></font>",
        "shadow": { "$ref": { "path":"defaultItem.shadow" }, "strength": 3 },
        "alpha": 50,
        "x": -5,
        "y": -3
      }
    ]
  }
}
