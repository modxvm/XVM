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
  //    "css": "...",
  //    "format": "...",
  //    "shadow": { ... },
  //    "alpha": "...",
  //    "position": { ... },
  //    "antiAliasType": "advanced" // normal/advanced
  //  }
  "defaultItem": {
    "flags": [ "player", "ally", "squad", "enemy", "teamKiller", "lost", "spotted", "alive", "dead" ],
    "css": "font-family:$FieldFont; font-size:8px;",
    "shadow": { "enabled": true, "color": "0x000000", "distance": 0, "angle": 45, "alpha": 80, "blur": 3, "strength": 4 },
    "alpha": 100,
    "pos": { "x": 0, "y": 0 },
    "antiAliasType": "advanced"
  },
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
  "labels": [
    // "spotted", "alive"
    //   "ally", "enemy", "squad", "teamKiller"
    {
      "$ref": { "path":"defaultItem" },
      "flags": [ "ally", "enemy", "squad", "teamKiller", "spotted", "alive" ],
      "format": "<font color='{{c:system:minimap.colors.txt}}'>{{vehicle}}</font>",
      "position": { "x": 3, "y": -2 }
    },
    //   "squad"
    {
      "$ref": { "path":"defaultItem" },
      "flags": [ "squad", "spotted", "alive" ],
      "format": "<i>{{name%.5s}}</i>",
      "position": { "x": 3, "y": 8 }
    },
    // "lost", "alive"
    //   "ally", "enemy", "squad", "teamKiller"
    {
      "$ref": { "path":"defaultItem" },
      "flags": [ "ally", "enemy", "squad", "teamKiller", "lost", "alive" ],
      "css": "font-family:Arial; font-size:17px; color:{{c:system:minimap.colors.lost_dot}};",
      "format": "{{vehicle-class}}",
      "alpha": 70,
    },
    {
      "$ref": { "path":"defaultItem" },
      "flags": [ "ally", "enemy", "squad", "teamKiller", "lost", "alive" ],
      "format": "<i>{{vehicle}}</i>",
      "alpha": 70,
      "position": { "x": -5, "y": -11 }
    },
    //   "squad"
    {
      "$ref": { "path":"defaultItem" },
      "flags": [ "squad", "lost", "alive" ],
      "format": "<i>{{name%.5s}}</i>",
      "alpha": 70,
      "position": { "x": -5, "y": -3 }
    },
    // "dead"
    //   "ally", "enemy", "squad", "teamKiller"
    {
      "$ref": { "path":"defaultItem" },
      "flags": [ "ally", "enemy", "squad", "teamKiller", "lost", "alive" ],
      "css": "font-family:Arial; font-size:17px; color:{{c:system:minimap.colors.dot}};",
      "format": "{{vehicle-class}}",
      "shadow": { "$ref": { "path":"defaultItem.shadow" }, "strength": 3 },
      "alpha": 50,
      "position": { "x": -5, "y": -11 }
    },
    //   "squad"
    {
      "$ref": { "path":"defaultItem" },
      "flags": [ "squad", "dead" ],
      "css": ".txt{font-family:$FieldFont; font-size:8px; color:#997C5C;} .dot{font-family:Arial; font-size:17px; color:#663800;}",
      "format": "<font color='{{c:system:minimap.colors.txt}}'><i>{{name%.5s}}</i></font>",
      "shadow": { "$ref": { "path":"defaultItem.shadow" }, "strength": 3 },
      "alpha": 50,
      "position": { "x": -5, "y": -3 }
    }
  ]
}
