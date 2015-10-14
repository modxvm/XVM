{
  "my_items": {
    "txt_spotted_alive_mog": {
      "$ref": { "file":"../default/minimapLabelsTemplates.xc", "path":"def.defaultItem" },
      "flags": [ "player", "ally", "enemy", "squadman", "teamKiller", "alive" ],
      "format": "<font face='$TitleFont' size='6' color='{{t-battles>19?{{c:r|#666666}}|#666666}}'>{{marksOnGun|*}}</font>",
      "x": 3,
      "y": -6,
      "antiAliasType": "normal"
    }
  },
  "labels": {
    "formats": [
      // txt
      ${"my_items.txt_spotted_alive_mog"},

      ${ "../default/minimapLabelsTemplates.xc":"def.nickSpotted" },
      ${ "../default/minimapLabelsTemplates.xc":"def.vehicleSpotted" },
      ${ "../default/minimapLabelsTemplates.xc":"def.nickLost" },
      ${ "../default/minimapLabelsTemplates.xc":"def.vehicleLost" },
      ${ "../default/minimapLabelsTemplates.xc":"def.vtypeLost" },
      ${ "../default/minimapLabelsTemplates.xc":"def.nickDead" },
      ${ "../default/minimapLabelsTemplates.xc":"def.vtypeDead" }

    ]
  }
}
