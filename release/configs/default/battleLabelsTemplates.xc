/**
 * Battle inteface text fields.
 * Текстовые поля боевого интерфейса.
 */
{
  // Definitions (extended format supported, see extra-field.txt).
  // Шаблоны (поддерживается расширенный формат, см. extra-field.txt).
  "def": {
    "hitlogHeader": {
      "enabled": true,
      "updateEvent": "ON_DAMAGE_CAUSED, ON_PANEL_MODE_CHANGED",
      "x": "{{pp.mode=0?5|{{py:math.sum({{pp.widthLeft}},50)}}}}",
      "y": "{{pp.mode=0?65|40}}",
      "width": 500,
      "height": 1000,
      "textFormat": { "color": "0xF4EFE8", "size": 15 },
      "format": "{{hitlog-header}}"
      // Format of the full hitlog (header and body)
      // Формат полного хит-лога (шапка и тело)
      // "format": "{{hitlog-header}}\n{{hitlog-body}}"
    },
    "hitlogBody": {
      "enabled": true,
      "hotKeyCode": 56, "onHold": "true", "visibleOnHotKey": false,
      "updateEvent": "ON_DAMAGE_CAUSED, ON_PANEL_MODE_CHANGED",
      "x": "{{pp.mode=0?5|{{py:math.sum({{pp.widthLeft}},50)}}}}",
      "y": "{{pp.mode=0?85|60}}",
      "width": 500,
      "height": 1000,
      "textFormat": { "color": "0xF4EFE8", "size": 15 },
      "format": "{{hitlog-body}}"
    },
    "totalHP": {
      "enabled": true,
      "updateEvent": "ON_PLAYERS_HP_CHANGED",
      "x": 0,
      "y": 30,
      "screenHAlign": "center",
      "align": "center",
      "shadow": { "distance": 1, "angle": 90, "alpha": 80, "blur": 5, "strength": 1.5 },
      "textFormat": { "font": "mono", "size": 18, "align": "center" },
      "format": "{{py:xvm.total_hp.text}}"
    },
    "avgDamage": {
      "enabled": true,
      "updateEvent": "ON_DAMAGE_CAUSED",
      "x": -170,
      "y": 30,
      "screenHAlign": "center",
      "align": "right",
      "shadow": { "distance": 1, "angle": 90, "alpha": 80, "blur": 5, "strength": 1.5 },
      "textFormat": { "size": 15, "align": "center" },
      "format": "{{py:xvm.total_hp.avgDamage('{{l10n:avgDamage}}: ',{{hitlog.dmg-total}})}}"
    },
    "mainGun": {
      "enabled": true,
      "updateEvent": "ON_DAMAGE_CAUSED, ON_DAMAGE_CAUSED_ALLY",
      "x": 170,
      "y": 30,
      "screenHAlign": "center",
      "shadow": { "distance": 1, "angle": 90, "alpha": 80, "blur": 5, "strength": 1.5 },
      "textFormat": { "size": 15, "align": "center" },
      "format": "{{py:xvm.total_hp.mainGun('{{l10n:mainGun}}: ',{{hitlog.dmg-total}})}}"
    },
    "winChance": {
      "enabled": false,
      "updateEvent": "ON_VEHICLE_DESTROYED",
      "x": 230,
      "y": 2,
      "shadow": { "distance": 1, "angle": 90, "alpha": 80, "blur": 5, "strength": 1.5 },
      "textFormat": { "size": 15 },
      "format": "{{xvm-stat?{{l10n:Team strength}}: {{py:xvm.team_strength('{{allyStrengthStatic}}','{{enemyStrengthStatic}}')}} / {{py:xvm.team_strength('{{allyStrengthLive}}','{{enemyStrengthLive}}')}}}}"
    },
    "damageLog": {
      "enabled": true,
      "updateEvent": "PY(ON_HIT)",
      "x": 240,
      "y": 0,
      "width": 300,
      "height": 233,
      "screenVAlign": "bottom",
      "shadow": { "distance": 1, "angle": 90, "alpha": 80, "blur": 5, "strength": 3 },
      "textFormat": { "color": "0xF4EFE8", "size": 16 },
      "format": "{{py:xvm.damageLog.dLog}}"
    },
    "timerReload": {
      "enabled": true,
      "updateEvent": "PY(ON_TIMER_RELOAD)",
      "x": 240,
      "y": 0,
      "width": 300,
      "height": 252,
      "screenVAlign": "bottom",
      "shadow": { "distance": 1, "angle": 90, "alpha": 80, "blur": 5, "strength": 3 },
      "textFormat": { "color": "0xF4EFE8", "size": 16 },
      "format": "{{py:xvm.damageLog.timerReload}}"
    },
    "lastHit": {
      "enabled": true,
      "updateEvent": "PY(ON_LAST_HIT)",
      "x": -120,
      "y": 200,
      "width": 200,
      "height": 100,
      "screenHAlign": "center",
      "screenVAlign": "center",
      "shadow": { "distance": 1, "angle": 90, "alpha": 80, "blur": 5, "strength": 3 },
      "textFormat": {"align": "center", "color": "0xF4EFE8", "size": 16 },
      "format": "{{py:xvm.damageLog.lastHit}}"
    },
    "fire": {
      "enabled": false,
      "updateEvent": "PY(ON_FIRE)",
      "x": 120,
      "y": 200,
      "width": 200,
      "height": 100,
      "alpha": "{{py:xvm.damageLog.fire}}",
      "screenHAlign": "center",
      "screenVAlign": "center",
      "shadow": { "distance": 1, "angle": 90, "alpha": 80, "blur": 5, "strength": 3 },
      "textFormat": {"align": "center", "color": "0xF4EFE8", "size": 16 },
      "format": "ПОЖАР"
    },
    "test": {
      "enabled": true,
      "y": -170,
      "width": 200,
      "height": 70,
      "alpha": 70,
      "screenHAlign": "center",
      "screenVAlign": "bottom",
      "shadow": { "distance": 1, "angle": 90, "alpha": 80, "strength": 5},
      "textFormat": { "color": "{{battleType=1?0x00FFFF|0xFFFF00}}", "size": 25, "align": "center", "bold": true, "leading": -1, "marginLeft": 2, "marginRight": 2 },
      "format": "This is a demo of XVM text fields on battle interface. You may disable it in battle.xc<br/> Press '<font color='#60FF00'>J</font>' hot-key to show info field"
    },
    "test2": {
      "enabled": true,
      "hotKeyCode": 36,
      "updateEvent": "ON_TARGET_IN,ON_TARGET_OUT",
      "y": -70,
      "width": 310,
      "height": 50,
      "alpha": 70,
      "screenHAlign": "center",
      "screenVAlign": "bottom",
      "bgColor": "0x000000",
      "borderColor": "0x101009",
      "shadow": { "distance": 1, "angle": 90, "alpha": 80, "strength": 8},
      "textFormat": { "color": "0x60FF00", "size": 15, "align": "center", "marginLeft": 2, "marginRight": 2},
      "format": "<font color='#FFFFFF'><b>Info text field (XTE: <font color='{{c:xte}}'>{{xte}}</font>)</b></font><br/>Battle tier:<font color='#ff1aff'> {{battletier}}</font> <p align='right'>Vehicle: <font color='#ff1aff'>{{vehicle}}</font> (<font color='{{c:t-winrate}}'>{{t-winrate%2d}}%</font>)</p>"
    }
  }
}
