{
  "formats": [
    {
      //"enabled": false,
      "hotKeyCode": 36, // J
      //"height": 150,
      "visibleOnHotKey": "false",
      "$ref": { "file":"../default/battleLabelsTemplates.xc", "path":"def.test2" }
    },
    {
      //"enabled": false,
      "hotKeyCode": 36, // J
      "updateEvent": "ON_TARGET_IN",
      "height": 150,
      "format": "{{py:vinfo.name()}}\nRT: {{py:vinfo.gun_reload()}}\nVR: {{py:vinfo.vision_radius()}}",
      "$ref": { "file":"../default/battleLabelsTemplates.xc", "path":"def.test2" }
    },
    {
      "x": 235,
      "y": 0,
      "width": 500,
      "height": 230,
      "screenVAlign": "bottom",
      //"updateEvent": "ON_PANEL_MODE_CHANGED", "x": "{{pp.mode=0?400|{{py:math.sum({{pp.widthLeft}},50)}}}}", "y": 65, "screenVAlign": "top",
      "$ref": { "file":"../default/battleLabelsTemplates.xc", "path":"def.hitlog" }
    },
    {
      "enabled": true,
      //"borderColor": "0xFF0000",
      //"width": 200,
      //"height": 20,
      "format": "{{xvm-stat?{{l10n:Team strength}}: {{py:xvm.team_strength('{{allyStrengthStatic}}','{{enemyStrengthStatic}}')}} / {{py:xvm.team_strength('{{allyStrengthLive}}','{{enemyStrengthLive}}')}}|--}}",
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
