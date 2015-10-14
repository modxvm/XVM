{
  "my_items": {
    "txt_spotted_alive_mog": {
      "$ref": { "file":"../default/minimapLabels.xc", "path":"defaultItem" },
      "flags": [ "player", "ally", "enemy", "squadman", "teamKiller", "alive" ],
      "format": "<font face='$TitleFont' size='8' color='{{t-battles>19?{{c:r|#666666}}|#666666}}'>{{marksOnGun=-?*|{{marksOnGun|*}}}}</font>",
      "x": -5,
      "y": -2,
      "antiAliasType": "normal"
    }
  },
  "labels": {
    "formats": [
      // vehicle merker
      ${"../default/minimapLabels.xc":"items.vtype_lost_or_dead"},
      // txt
      ${"my_items.txt_spotted_alive_mog"},
      ${"../default/minimapLabels.xc":"items.txt_spotted_alive"},
      ${"../default/minimapLabels.xc":"items.txt_spotted_alive_squadman"},
      ${"../default/minimapLabels.xc":"items.txt_lost_alive"},
      ${"../default/minimapLabels.xc":"items.txt_lost_alive_squadman"},
      ${"../default/minimapLabels.xc":"items.txt_dead_squadman"}
    ]
  }
}
