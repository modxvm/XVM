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
      // for debug
      //{
      //  "flags": [ "player", "ally", "squadman", "enemy", "teamKiller", "neverSeen", "lost", "spotted", "alive", "dead" ],
      //  "x": 0, "y": 0, "align": "center", "valign": "center", "layer": "top", "antiAliasType": "normal", "shadow": { },
      //  "borderColor": null,
      //  "textFormat": { "font": "xvm", "size": 8, "align": "center", "valign": "center" },
      //  "format": "<font color='{{.minimap.labelsData.colors.dot.{{sys-color-key}}}}'>&#x44;</font>"
      //},
      //${ "../default/minimapLabelsTemplates.xc":"def.vtypeSpotted" },
      //${ "../default/minimapLabelsTemplates.xc":"def.vehicleDead" },
      //${ "../default/minimapLabelsTemplates.xc":"def.nickDead" },

      ${"my_items.txt_player_alive_mog"},
      {
        "$ref": { "file":"../default/minimapLabelsTemplates.xc", "path":"def.vehicleSpotted" },
        //"shadow": { "color": "{{c:hp-ratio}}", "alpha": 80, "blur": 2, "strength": 4 },
        "format": "<font face='$TitleFont' size='6' color='{{t-battles>19?{{c:r|#666666}}|#666666}}'><b>{{marksOnGun|*}}</b></font><font size='8' color='{{.minimap.labelsData.colors.txt.{{sys-color-key}}}}'>{{vehicle-short}}</font>"
      },
      ${ "../default/minimapLabelsTemplates.xc":"def.nickSpotted" },
      ${ "../default/minimapLabelsTemplates.xc":"def.vtypeLost" },
      {
        "$ref": { "file":"../default/minimapLabelsTemplates.xc", "path":"def.vehicleLost" },
        "format": "<font face='$TitleFont' size='6' color='{{t-battles>19?{{c:r|#666666}}|#666666}}'><b>{{marksOnGun|*}}</b></font><font size='8' color='{{.minimap.labelsData.colors.txt.{{sys-color-key}}}}'><i>{{vehicle-short}}</i></font>"
      },
      ${ "../default/minimapLabelsTemplates.xc":"def.nickLost" },
      ${ "../default/minimapLabelsTemplates.xc":"def.vtypeDead" },
      ${ "../default/minimapLabelsTemplates.xc":"def.nickDead" },
      ${ "../default/minimapLabelsTemplates.xc":"def.xmqpEvent" }
    ]
  }
}
