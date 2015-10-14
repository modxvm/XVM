{
  "my_items": {
    "txt_player_alive_mog": {
      "$ref": { "file":"../default/minimapLabelsTemplates.xc", "path":"def.defaultItem" },
      "flags": [ "player", "alive" ],
      "format": "<font face='$TitleFont' size='6' color='{{t-battles>19?{{c:r|#666666}}|#666666}}'><b>{{marksOnGun|*}}</b></font>",
      "x": 0,
      "y": 0
    }
  },
  "labels": {
    "formats": [
      // txt
      ${"my_items.txt_player_alive_mog"},
      {
        "$ref": { "file":"../default/minimapLabelsTemplates.xc", "path":"def.vehicleSpotted" },
        "format": "<font face='$TitleFont' size='6' color='{{t-battles>19?{{c:r|#666666}}|#666666}}'><b>{{marksOnGun|*}}</b></font><font size='8' color='{{.minimap.labelsData.colors.txt.{{sys-color-key}}}}'>{{vehicle-short}}</font>",
        "x": 0,
        "y": -2
      },
      ${ "../default/minimapLabelsTemplates.xc":"def.nickSpotted" },
      ${ "../default/minimapLabelsTemplates.xc":"def.vtypeLost" },
      {
        "$ref": { "file":"../default/minimapLabelsTemplates.xc", "path":"def.vehicleLost" },
        "format": "<font face='$TitleFont' size='6' color='{{t-battles>19?{{c:r|#666666}}|#666666}}'><b>{{marksOnGun|*}}</b></font><font size='8' color='{{.minimap.labelsData.colors.txt.{{sys-color-key}}}}'><i>{{vehicle-short}}</i></font>",
        "x": 0,
        "y": -2
      },
      ${ "../default/minimapLabelsTemplates.xc":"def.nickLost" },
      ${ "../default/minimapLabelsTemplates.xc":"def.vtypeDead" },
      ${ "../default/minimapLabelsTemplates.xc":"def.nickDead" }
    ]
  }
}
