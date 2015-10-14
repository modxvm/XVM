{
  "defaultItem": {
    "flags": [ "player", "ally", "squadman", "enemy", "teamKiller", "lost", "spotted", "alive", "dead" ],
    "shadow": { "enabled": true, "color": "0x000000", "distance": 0, "angle": 45, "alpha": 80, "blur": 3, "strength": 4 },
    "alpha": 100,
    "x": 0,
    "y": 0,
    "width": 100,
    "height": 40,
    "align": "left",
    "valign": "top",
    "antiAliasType": "advanced"
  },
  //TODO
  //"ally":       "<textformat leading='-15'><span class='mm_a'>{{vehicle-short}}\n<font color='{{t-battles>9?{{c:r|#666666}}|#666666}}' alpha='{{alive?#FF|#80}}'>{{marksOnGun|*}}</font></span></textformat>",
  //"teamkiller": "<textformat leading='-15'><span class='mm_t'>{{vehicle-short}}\n<font color='{{t-battles>9?{{c:r|#666666}}|#666666}}' alpha='{{alive?#FF|#80}}'>{{marksOnGun|*}}</font></span></textformat>",
  //"enemy":      "<textformat leading='-15'><span class='mm_e'>{{vehicle-short}}\n<font color='{{t-battles>9?{{c:r|#666666}}|#666666}}' alpha='{{alive?#FF|#80}}'>{{marksOnGun|*}}</font></span></textformat>"
  "items": {
    "dot": {
      "$ref": { "path":"defaultItem" },
      "flags": [ "ally", "enemy", "squadman", "teamKiller", "spotted", "alive", "dead" ],
      "format": "<font size='12' color='{{.minimap.labels.data.colors.dot.{{sys-color-key}}}}'>{{.minimap.labels.data.vtype.{{vtype-key}}}}</font>",
      //"borderColor": "0xFFFF00",
      "align": "center",
      "valign": "center",
      "antiAliasType": "normal"
    },
    "dot_lost": {
      "$ref": { "path":"items.dot" },
      "flags": [ "ally", "enemy", "squadman", "teamKiller", "lost", "alive" ],
      "format": "<font size='12' color='{{.minimap.labels.data.colors.lost_dot.{{sys-color-key}}}}'>{{.minimap.labels.data.vtype.{{vtype-key}}}}</font>",
      "alpha": 70
    }
  },
  "labels": {
    "formats": [
      // vehicle merker
      ${"items.dot"},
      ${"items.dot_lost"},
      // "spotted", "alive"
      //   "ally", "enemy", "squadman", "teamKiller"
      {
        "$ref": { "path":"defaultItem" },
        "flags": [ "ally", "enemy", "squadman", "teamKiller", "spotted", "alive" ],
        "format": "<font size='8' color='{{.minimap.labels.data.colors.txt.{{sys-color-key}}}}'>{{vehicle}}</font>",
        //"borderColor": "0x00FFFF",
        "x": 3,
        "y": -2
      },
      //   "squadman"
      {
        "$ref": { "path":"defaultItem" },
        "flags": [ "squadman", "spotted", "alive" ],
        "format": "<font size='8' color='{{.minimap.labels.data.colors.txt.{{sys-color-key}}}}'><i>{{name%.5s}}</i></font>",
        "x": 3,
        "y": 6
      },
      // "lost", "alive"
      //   "ally", "enemy", "squadman", "teamKiller"
      {
        "$ref": { "path":"defaultItem" },
        "flags": [ "ally", "enemy", "squadman", "teamKiller", "lost", "alive" ],
        "format": "<font size='8' color='{{.minimap.labels.data.colors.txt.{{sys-color-key}}}}'><i>{{vehicle}}</i></font>",
        "alpha": 70,
        "x": 3,
        "y": -2
      },
      //   "squadman"
      {
        "$ref": { "path":"defaultItem" },
        "flags": [ "squadman", "lost", "alive" ],
        "format": "<font size='8' color='{{.minimap.labels.data.colors.txt.{{sys-color-key}}}}'><i>{{name%.5s}}</i></font>",
        "alpha": 70,
        "x": 3,
        "y": 6
      },
      // "dead"
      //   "squadman"
      {
        "$ref": { "path":"defaultItem" },
        "flags": [ "squadman", "dead" ],
        "format": "<font size='8' color='{{.minimap.labels.data.colors.txt.{{sys-color-key}}}}'><i>{{name%.5s}}</i></font>",
        "shadow": { "$ref": { "path":"defaultItem.shadow" }, "strength": 3 },
        "alpha": 50,
        "x": 3,
        "y": -2
      }
    ]
  }
}
