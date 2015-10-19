/**
 * Minimap labels.
 * Надписи на миникарте.
 */
{
  // Textfields for units on minimap.
  // Текстовые поля юнитов на миникарте.
  // TODO: documentation
  //  {
  //    Если не указаны "ally", "squadman", "player", "enemy", "teamKiller", то они не используются.
  //    Если не указаны "lost" и "spotted", то используются оба - и "lost", и "spotted".
  //    Если не указаны "alive", "dead", то используются оба - и "alive", и "dead".
  //    "flags": [ "player", "ally", "squadman", "enemy", "teamKiller", "lost", "spotted", "alive", "dead" ],
  //    "format": "...",
  //    "shadow": { ... },
  //    "alpha": "...",
  //    "x": { ... },
  //    "y": { ... },
  //    "antiAliasType": "normal" // normal/advanced
  //  }
  "labels": {
    "enabled": true,
    // Format set
    // Набор форматов
    "formats": [
      //${ "minimapLabelsTemplates.xc":"def.vtypeSpotted" },
      ${ "minimapLabelsTemplates.xc":"def.vehicleSpotted" },
      ${ "minimapLabelsTemplates.xc":"def.nickSpotted" },
      {
        "$ref": { "file": "minimapLabelsTemplates.xc", "path": "def.nickSpotted" },
        "flags": [ "ally", "teamKiller", "spotted", "alive" ],
        "format": "<font size='{{battletype?8|0}}' color='{{tk?{{.minimap.labelsData.colors.txt.{{sys-color-key}}}}|#BFBFBF}}'><i>{{name%.7s~..}}</i></font>"
      },
      ${ "minimapLabelsTemplates.xc":"def.vtypeLost" },
      ${ "minimapLabelsTemplates.xc":"def.vehicleLost" },
      ${ "minimapLabelsTemplates.xc":"def.nickLost" },
      ${ "minimapLabelsTemplates.xc":"def.vtypeDead" },
      ${ "minimapLabelsTemplates.xc":"def.vehicleDead" },
      ${ "minimapLabelsTemplates.xc":"def.nickDead" }
    ]
  }
}
