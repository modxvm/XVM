{
  "formats": [
    {
      //"enabled": false,
      "x": "{{py:xvm_debug_get_x|0}}",
      "y": "{{py:xvm_debug_get_y|0}}",
      "width": 250,
      "height": 160,
      "alpha": 70,
      "updateEvent": "PY(xvm_debug_update)",
      "src": "img://gui/maps/icons/vehicle/unique/germany-G105_T-55_NVA_DDR.png",
      "mouseEvents": {
        //"click": "xvm_debug_click",
        "mouseDown": "xvm_debug_mouseDown",
        "mouseUp": "xvm_debug_mouseUp",
        //"mouseOver": "xvm_debug_mouseOver",
        //"mouseOut": "xvm_debug_mouseOut",
        //"mouseWheel": "xvm_debug_mouseWheel",
        "mouseMove": "xvm_debug_mouseMove"
      }
    },
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
      //"updateEvent": "PY(test)",
      "height": 150,
      "format": "{{py:vinfo.name}}\nRT: {{py:vinfo.gun_reload}}\nVR: {{py:vinfo.vision_radius}}",
      "$ref": { "file":"../default/battleLabelsTemplates.xc", "path":"def.test2" }
    },
    {
      "x": 235,
      "y": 0,
      "height": 230,
      "screenVAlign": "bottom",
      "updateEvent": "ON_DAMAGE_CAUSED",
      "format": "{{hitlog-header}}\n{{hitlog-body}}",
      //"updateEvent": "ON_PANEL_MODE_CHANGED", "x": "{{pp.mode=0?400|{{py:math.sum({{pp.widthLeft}},50)}}}}", "y": 65, "screenVAlign": "top",
      "$ref": { "file":"../default/battleLabelsTemplates.xc", "path":"def.hitlogHeader" }
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
      "height": 30,
      "updateEvent": "ON_PLAYERS_HP_CHANGED,ON_VEHICLE_DESTROYED",
      "$ref": { "file":"../default/battleLabelsTemplates.xc", "path":"def.totalHP" }
    }
  ]
}
