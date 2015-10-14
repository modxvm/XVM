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
  "items": {
    "vtype": {
      "$ref": { "path":"defaultItem" },
      "flags": [ "ally", "enemy", "squadman", "teamKiller", "spotted", "alive" ],
      "format": "<font size='12' color='{{.minimap.labels_data.colors.dot.{{sys-color-key}}}}'>{{.minimap.labels_data.vtype.{{vtype-key}}}}</font>",
      //"borderColor": "0xFFFF00",
      "align": "center",
      "valign": "center",
      "antiAliasType": "normal"
    },
    "vtype_lost_or_dead": {
      "$ref": { "path":"items.vtype" },
      "flags": [ "ally", "enemy", "squadman", "teamKiller", "lost" ],
      "format": "<font size='12' color='{{.minimap.labels_data.colors.lost_dot.{{sys-color-key}}}}'>{{.minimap.labels_data.vtype.{{vtype-key}}}}</font>",
      "alpha": 70
    },
    // txt
    "txt_spotted_alive": {
      "$ref": { "path":"defaultItem" },
      "flags": [ "ally", "enemy", "squadman", "teamKiller", "spotted", "alive" ],
      "format": "<font size='8' color='{{.minimap.labels_data.colors.txt.{{sys-color-key}}}}'>{{vehicle}}</font>",
      //"borderColor": "0x00FFFF",
      "x": 3,
      "y": -2
    },
    "txt_spotted_alive_squadman": {
      "$ref": { "path":"defaultItem" },
      "flags": [ "squadman", "spotted", "alive" ],
      "format": "<font size='8' color='{{.minimap.labels_data.colors.txt.{{sys-color-key}}}}'><i>{{name%.5s}}</i></font>",
      "x": 3,
      "y": 6
    },
    "txt_lost_alive": {
      "$ref": { "path":"defaultItem" },
      "flags": [ "ally", "enemy", "squadman", "teamKiller", "lost", "alive" ],
      "format": "<font size='8' color='{{.minimap.labels_data.colors.txt.{{sys-color-key}}}}'><i>{{vehicle}}</i></font>",
      "alpha": 70,
      "x": 3,
      "y": -2
    },
    "txt_lost_alive_squadman": {
      "$ref": { "path":"defaultItem" },
      "flags": [ "squadman", "lost", "alive" ],
      "format": "<font size='8' color='{{.minimap.labels_data.colors.txt.{{sys-color-key}}}}'><i>{{name%.5s}}</i></font>",
      "alpha": 70,
      "x": 3,
      "y": 6
    },
    "txt_dead_squadman": {
      "$ref": { "path":"defaultItem" },
      "flags": [ "squadman", "dead" ],
      "format": "<font size='8' color='{{.minimap.labels_data.colors.txt.{{sys-color-key}}}}'><i>{{name%.5s}}</i></font>",
      "shadow": { "$ref": { "path":"defaultItem.shadow" }, "strength": 3 },
      "alpha": 50,
      "x": 3,
      "y": -2
    }
  },
  "labels": {
    "enabled": true,
    "formats": [
      // vehicle merker
      //${"items.vtype"},
      ${"items.vtype_lost_or_dead"},
      // txt
      ${"items.txt_spotted_alive"},
      ${"items.txt_spotted_alive_squadman"},
      ${"items.txt_lost_alive"},
      ${"items.txt_lost_alive_squadman"},
      ${"items.txt_dead_squadman"}
    ]
  }
}
