{
  "formats": [
    {
      //"enabled": false,
      //"borderColor": "0xFFFF00",
      "$ref": { "file":"../default/battleLabelsTemplates.xc", "path":"def.test" }
    },
    {
      //"enabled": false,
      "hotKeyCode": 36,
      //"height": 150,
      "$ref": { "file":"../default/battleLabelsTemplates.xc", "path":"def.test2" }
    },
    {
      //"enabled": false,
      "hotKeyCode": 36,
      "visibleOnHotKey": "true",
      "height": 150,
      "$ref": { "file":"../default/battleLabelsTemplates.xc", "path":"def.test2" }
    },
    {
      "enabled": true,
      //"borderColor": "0xFF0000",
      "width": 100,
      "height": 30,
      "format": "{{xvm-stat?{{l10n:Chance to win}}: {{chancesStatic}}{{chancesStatic? / |}}{{chancesLive}}|--}}",
      "$ref": { "file":"../default/battleLabelsTemplates.xc", "path":"def.winChance" }
    },
    {
      "enabled": true,
      //"borderColor": "0xFF0000",
      //"y":150,
      "updateEvent": "ON_PLAYERS_HP_CHANGED,ON_VEHICLE_DESTROYED",
      "$ref": { "file":"../default/battleLabelsTemplates.xc", "path":"def.totalHP" }
    }
  ]
}
