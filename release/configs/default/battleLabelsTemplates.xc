﻿/**
 * Battle inteface text fields.
 * Текстовые поля боевого интерфейса.
 */
{
  // Definitions.
  // Шаблоны.
  "def": {
    // Log of applied damage.
    // Лог нанесенного урона.
    "hitLog": {
      "enabled": true,
      "updateEvent": "PY(ON_HIT_LOG), ON_PANEL_MODE_CHANGED",
      "x": "{{pp.mode=0?5|{{py:sum({{pp.widthLeft}},{{py:xvm.hitLog_x}})}}}}",
      "y": "{{pp.mode=0?90|{{py:xvm.hitLog_y}}}}",
      "width": 500,
      "height": 1000,
      "layer": "bottom",
      "textFormat": { "color": "0xF4EFE8", "size": 15},
      "format": "{{py:xvm.hitLog}}",
      "mouseEvents": {
        "mouseDown": "hitLog_mouseDown",
        "mouseUp": "hitLog_mouseUp",
        "mouseMove": "hitLog_mouseMove"
      }
    },
    // Background of the log of applied damage.
    // Подложка лога нанесенного урона.
    "hitLogBackground": {
      "enabled": false,
      "$ref": { "path":"def.hitLog" },
      "format": "{{py:xvm.hitLog_Background}}"
    },
    // Total hp indicator.
    // Индикатор общего HP команд.
    "totalHP": {
      "enabled": true,
      "updateEvent": "PY(ON_UPDATE_HP)",
      "x": 0,
      "y": 30,
      "screenHAlign": "center",
      "align": "center",
      "shadow": { "distance": 1, "angle": 90, "alpha": 80, "blur": 5, "strength": 1.5 },
      "textFormat": { "font": "mono", "size": 18, "align": "center" },
      "format": "{{py:xvm.total_hp.text}}"
    },
    // Avg damage on current vehicle.
    // Средний урон на текущей технике.
    "avgDamage": {
      "enabled": true,
      "updateEvent": "PY(ON_UPDATE_HP)",
      "x": -170,
      "y": 30,
      "screenHAlign": "center",
      "align": "right",
      "shadow": { "distance": 1, "angle": 90, "alpha": 80, "blur": 5, "strength": 1.5 },
      "textFormat": { "size": 15, "align": "center" },
      "format": "{{py:xvm.total_hp.avgDamage('{{l10n:avgDamage}}: ',{{py:xvm.totalDamage}})}}"
    },
    // Threshold necessary for achievements "High caliber".
    // Порог необходимый для получения достижения "Основной калибр".
    "mainGun": {
      "enabled": true,
      "updateEvent": "PY(ON_UPDATE_HP)",
      "x": 170,
      "y": 30,
      "screenHAlign": "center",
      "shadow": { "distance": 1, "angle": 90, "alpha": 80, "blur": 5, "strength": 1.5 },
      "textFormat": { "size": 15, "align": "center" },
      "format": "{{py:xvm.total_hp.mainGun('{{l10n:mainGun}}: ',{{py:xvm.totalDamage}})}}"
    },
    // Log of the received damage (see damageLog.xc).
    // Лог полученного урона (см. damageLog.xc).
    "damageLog": {
      "enabled": true,
      "updateEvent": "PY(ON_HIT)",
      "x": "{{py:xvm.damageLog.dLog_x}}",
      "y": "{{py:xvm.damageLog.dLog_y}}",
      "width": 300,
      "height": 210,
      "layer": "bottom",
      "screenVAlign": "bottom",
      "shadow": { 
        "distance": "{{py:xvm.damageLog.dLog_shadow('distance')}}",
        "angle": "{{py:xvm.damageLog.dLog_shadow('angle')}}",
        "color": "{{py:xvm.damageLog.dLog_shadow('color')}}",
        "alpha": "{{py:xvm.damageLog.dLog_shadow('alpha')}}",
        "blur": "{{py:xvm.damageLog.dLog_shadow('blur')}}",
        "strength": "{{py:xvm.damageLog.dLog_shadow('strength')}}",
        "hideObject": "{{py:xvm.damageLog.dLog_shadow('hideObject')}}",
        "inner": "{{py:xvm.damageLog.dLog_shadow('inner')}}",
        "knockout": "{{py:xvm.damageLog.dLog_shadow('knockout')}}",
        "quality": "{{py:xvm.damageLog.dLog_shadow('quality')}}" 
      },
      "textFormat": { "color": "0xF4EFE8", "size": 16 },
      "format": "{{py:xvm.damageLog.dLog}}",
      "mouseEvents": {
        "mouseDown": "dLog_mouseDown",
        "mouseUp": "dLog_mouseUp",
        "mouseMove": "dLog_mouseMove",
        "mouseWheel": "dLog_mouseWheel"
      }
    },
    // Background of the log of the received damage (see damageLog.xc).
    // Подложка лога полученного урона (см. damageLog.xc).    
    "damageLogBackground": {
      "enabled": false,
      "$ref": { "path":"def.damageLog" },
      "format": "{{py:xvm.damageLog.dLogBackground}}"
    },    
    // Display the last damage (hit) (see damageLog.xc).
    // Отображение последнего урона (попадания) (см. damageLog.xc).
    "lastHit": {
      "enabled": true,
      "updateEvent": "PY(ON_LAST_HIT)",
      "x": "{{py:xvm.damageLog.lastHit_x}}",
      "y": "{{py:xvm.damageLog.lastHit_y}}",
      "width": 200,
      "height": 100,
      "layer": "bottom",
      "screenHAlign": "center",
      "screenVAlign": "center",
      "shadow": { 
        "distance": "{{py:xvm.damageLog.lastHit_shadow('distance')}}",
        "angle": "{{py:xvm.damageLog.lastHit_shadow('angle')}}",
        "color": "{{py:xvm.damageLog.lastHit_shadow('color')}}",
        "alpha": "{{py:xvm.damageLog.lastHit_shadow('alpha')}}",
        "blur": "{{py:xvm.damageLog.lastHit_shadow('blur')}}",
        "strength": "{{py:xvm.damageLog.lastHit_shadow('strength')}}",
        "hideObject": "{{py:xvm.damageLog.lastHit_shadow('hideObject')}}",
        "inner": "{{py:xvm.damageLog.lastHit_shadow('inner')}}",
        "knockout": "{{py:xvm.damageLog.lastHit_shadow('knockout')}}",
        "quality": "{{py:xvm.damageLog.lastHit_shadow('quality')}}" 
      },
      "textFormat": {"align": "center", "color": "0xF4EFE8", "size": 16 },
      "format": "{{py:xvm.damageLog.lastHit}}",
      "mouseEvents": {
        "mouseDown": "lastHit_mouseDown",
        "mouseUp": "lastHit_mouseUp",
        "mouseMove": "lastHit_mouseMove"
      }
    },
    "fire": {
      "enabled": false,
      "updateEvent": "PY(ON_FIRE)",
      "x": 120,
      "y": 200,
      "width": 200,
      "height": 100,
      "alpha": "{{py:xvm.damageLog.fire}}",
      "layer": "bottom",
      "screenHAlign": "center",
      "screenVAlign": "center",
      "shadow": { "distance": 1, "angle": 90, "alpha": 80, "blur": 5, "strength": 3 },
      "textFormat": {"align": "center", "color": "0xF4EFE8", "size": 16 },
      "format": "ПОЖАР"
    },
    "totalEfficiency": {
      "enabled": true,
      "updateEvent": "PY(ON_TOTAL_EFFICIENCY), ON_PANEL_MODE_CHANGED",
      "x": "{{pp.mode=0?5|{{py:sum({{pp.widthLeft}},50)}}}}",
      "y": "{{pp.mode=0?65|35}}",
      "width": "{{py:xvm.isStuns?350|260}}",
      "height": 22,
      "textFormat": { "size": 16 },
      "format": "<textformat tabstops='[65,130,196,261]' leading='-2' ><img src='xvm://res/icons/Efficiency/damage.png' vspace='-2'> <font color='{{py:xvm.totalDamage>0?{{py:xvm.totalDamageColor}}}}'>{{py:xvm.totalDamage}}</font><tab><img src='xvm://res/icons/Efficiency/assist.png' vspace='-2'> {{py:xvm.totalAssist}}<tab><img src='xvm://res/icons/Efficiency/reflect.png' vspace='-2'> {{py:xvm.totalBlocked}}<tab><img src='xvm://res/icons/Efficiency/discover.png' vspace='-2'> {{py:xvm.detection}}<tab><img src='xvm://res/icons/Efficiency/stun.png' vspace='-2'> {{py:xvm.totalStun}}</textformat>"
    },
    // Rewritable timer format.
    // Перезаписываемый формат таймера.
    "repairTimeItem": {
      "width": 47,
      "height": 40,
      "screenHAlign": "left",
      "screenVAlign": "bottom",
      "shadow": { "distance": 1, "angle": 90, "alpha": 90, "blur": 5, "strength": 4 },
      "textFormat": { "color": "0xF4EFE8", "size": 17, "align": "center", "valign": "center" }
    },
    // Repair timer for engine.
    // Таймер ремонта двигателя.
    "repairTimeEngine": {
      "$ref": { "path":"def.repairTimeItem" },
      "enabled": true,
      "updateEvent": "PY(ON_ENGINE_UPDATE)",
      "x": 4,
      "y": -147,
      "format": "<b>{{py:repairTimeEngine}}</b>"
    },
    // Repair timer for gun.
    // Таймер ремонта орудия.
    "repairTimeGun": {
      "$ref": { "path":"def.repairTimeItem" },
      "enabled": true,
      "updateEvent": "PY(ON_GUN_UPDATE)",
      "x": 4,
      "y": -69,
      "format": "<b>{{py:repairTimeGun}}</b>"
    },
    // Repair timer for turret rotator.
    // Таймер ремонта механизма поворота башни.
    "repairTimeTurret": {
      "$ref": { "path":"def.repairTimeItem" },
      "enabled": true,
      "updateEvent": "PY(ON_TURRETROTATOR_UPDATE)",
      "x": 4,
      "y": -30,
      "format": "<b>{{py:repairTimeTurret}}</b>"
    },
    // Repair timer for complex-items (chassis\wheels).
    // Таймер ремонта для гусениц\колёс.
    "repairTimeComplex": {
      "$ref": { "path":"def.repairTimeItem" },
      "enabled": true,
      "updateEvent": "PY(ON_COMPLEX_UPDATE)",
      "x": 177,
      "y": -147,
      "format": "<b>{{py:repairTimeComplex}}</b>"
    },
    // Repair timer for surveying device.
    // Таймер ремонта приборов наблюдения.
    "repairTimeSurveying": {
      "$ref": { "path":"def.repairTimeItem" },
      "enabled": true,
      "updateEvent": "PY(ON_SURVEYINGDEVICE_UPDATE)",
      "x": 177,
      "y": -108,
      "format": "<b>{{py:repairTimeSurveying}}</b>"
    },
    // Repair timer for radio.
    // Таймер ремонта радиостанции.
    "repairTimeRadio": {
      "$ref": { "path":"def.repairTimeItem" },
      "enabled": true,
      "updateEvent": "PY(ON_RADIO_UPDATE)",
      "x": 177,
      "y": -69,
      "format": "<b>{{py:repairTimeRadio}}</b>"
    }
  }
}
