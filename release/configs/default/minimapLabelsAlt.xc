/**
 * Minimap labels (alternative mode).
 * Надписи на миникарте (альтернативный режим).
 */
{
  // Textfields for units on minimap.
  // Текстовые поля юнитов на миникарте.
  "labels": {
    // Format set (extended format supported, see extra-field.txt).
    // Набор форматов (поддерживается расширенный формат, см. extra-field.txt).
    "formats": [
      //${ "minimapLabelsTemplates.xc":"def.vtypeSpotted" },
      ${ "minimapLabelsTemplates.xc":"def.vehicleSpottedCompany" },
      ${ "minimapLabelsTemplates.xc":"def.nickSpottedCompany" },
      ${ "minimapLabelsTemplates.xc":"def.xmqpEvent" },
      ${ "minimapLabelsTemplates.xc":"def.vtypeLost" },
      ${ "minimapLabelsTemplates.xc":"def.vehicleLost" },
      ${ "minimapLabelsTemplates.xc":"def.nickLost" },
      ${ "minimapLabelsTemplates.xc":"def.vtypeDead" },
      ${ "minimapLabelsTemplates.xc":"def.vehicleDead" },
      ${ "minimapLabelsTemplates.xc":"def.nickDead" }
    ]
  }
}