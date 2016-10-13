/**
  * Macros used in damageLog:
  * Макросы используемые в damageLog:
   
    {{number}}            - line number / номер строки.
    {{dmg}}               - received damage / полученный урон.
    {{dmg-kind}}          - received damage kind (attack, fire, ramming, ...) / вид полученного урона (атака, пожар, таран, ...).
    {{c:dmg-kind}}        - color depending on received damage kind / цвет в зависимости от вида полученного урона.
    {{type-shell}}        - shell kind / тип снаряда.
    {{vtype}}             - vehicle type / тип техники.
    {{vehicle}}           - vehicle name / название техники.
    {{c:vtype}}           - color depending on vehicle type / цвет в зависимости от типа техники.
    {{c:team-dmg}}        - color depending on damage source (ally , enemy) / цвет в зависимости от источника урона (союзник, противник).
    {{c:costShell}}       - color depending on shell kind (gold, credits) / цвет в зависимости от типа снаряда (золото, кредиты).
    {{name}}              - nickname player who caused the damage / никнейм игрока, нанесшего урон.
    {{critical-hit}}      - critical hit / критическое попадание.
    {{c:hit-effects}}     - color depending on hit kind (with damage, ricochet, no penetration, no damage) / цвет в зависимости от вида попадания (с уроном, рикошет, не пробито, без урона).
    {{costShell}}         - text depending on shell kind (gold, credits) / текст в зависимости от типа снаряда (золото, кредиты).
    {{comp-name}}         - name part of vehicle that was hit (turret, body, chassis, gun) / название части техники, в которую было попадание (башня, корпус, шасси, орудие).
    {{splash-hit}}        - text when hit by splash of shell (HE) / текст при попадание осколков снаряда (ОФ).
    {{clan}}              - clan name with brackets (empty if no clan) / название клана в скобках (пусто, если игрок не в клане).
    {{level}}             - vehicle level / уровень техники.
    {{clannb}}            - clan name without brackets / название клана без скобок.
    {{clanicon}}          - macro with clan embed image path value / макрос со значением пути эмблемы клана.
*/

{
  "damageLog": {
    "log": {
      // Received damage kind (macro {{dmg-kind}}).
      // Вид полученного урона (макрос {{dmg-kind}}).
      "dmg-kind": {
        "shot": "{{type-shell}}", //"<font face='xvm'>&#x50;</font>",
        "fire": "<font face='xvm'>&#x51;</font>", 
        "ramming": "<font face='xvm'>&#x52;</font>",
        "world_collision": "<font face='xvm'>&#x53;</font>",
        "death_zone": "DZ",
        "drowning": "Dr",
        "gas_attack": "GA",
        "overturn": "<font face='xvm'>&#x112;</font>",
        "art_attack": "<font face='xvm'>&#x110;</font>",
        "air_strike": "<font face='xvm'>&#x111;</font>"
      },
      // Color depending on received damage kind (macro {{c:dmg-kind}}).
      // Цвет в зависимости от вида полученного урона (макрос {{c:dmg-kind}}).
      "c:dmg-kind": { 
        "shot": "{{c:hit-effects}}",
        "fire": "#FF6655", 
        "ramming": "#998855",
        "world_collision": "#228855",
        "death_zone": "#CCCCCC",
        "drowning": "#CCCCCC",
        "gas_attack": "#CCCCCC",
        "overturn": "#CCCCCC",
        "art_attack": "#CCCCCC",
        "air_strike": "#CCCCCC"
      },    
      // Shell kind (macro {{type-shell}}).
      // Тип снарядов (макрос {{type-shell}}).
      "type-shell": {
        "armor_piercing": "{{l10n:AP}}",
        "high_explosive": "{{l10n:HE}}",
        "armor_piercing_cr": "{{l10n:APC}}",
        "armor_piercing_he": "{{l10n:APH}}",
        "hollow_charge": "{{l10n:HC}}"
      },
      // Vehicle type (macro {{vtype}}).
      // Тип техники (макрос {{vtype}}).
      "vtype": {
        "mediumTank": "<font face='xvm'>&#x3B;</font>",
        "lightTank": "<font face='xvm'>&#x3A;</font>",
        "heavyTank": "<font face='xvm'>&#x3F;</font>",
        "AT-SPG": "<font face='xvm'>&#x2E;</font>",
        "SPG": "<font face='xvm'>&#x2D;</font>"
      },
      // Color depending on vehicle type (macro {{c:vtype}}).
      // Цвет в зависимости от типа техники (макрос {{c:vtype}}).
      "c:vtype":{
        "mediumTank": "#FFF198",
        "lightTank": "#A2FF9A",
        "heavyTank": "#FFACAC",
        "AT-SPG": "#A0CFFF",
        "SPG": "#EFAEFF"
      },
      // Text at hits no damage (ricochet, no penetration, no damage) (macro {{dmg}}).
      // Текст при попаданиях без урона (рикошет, не пробито, без урона) (макрос {{dmg}}).
      "hit-effects": {
        "intermediate_ricochet": "рикошет",
        "final_ricochet": "рикошет",
        "armor_not_pierced": "не пробито",
        "armor_pierced_no_damage": "без урона"
      },
      // Color depending on hit kind (with damage, ricochet, no penetration, no damage) (macro {{c:hit-effects}}).
      // Цвет в зависимости от вида попадания (с уроном, рикошет, не пробито, без урона) (макрос {{c:hit-effects}}).
      "c:hit-effects": {
        "armor_pierced": "#FF4D3C",
        "intermediate_ricochet": "#CCCCCC",
        "final_ricochet": "#CCCCCC",
        "armor_not_pierced": "#CCCCCC",
        "armor_pierced_no_damage": "#CCCCCC"
      },
      // Designation of critical hits (macro {{critical-hit}}).
      // Обозначение критического попадания (макрос {{critical-hit}}).
      "critical-hit":{
        "critical": "*",
        "no-critical": ""
      },
      // Designation of hit by splash of shell (HE). (macro {{splash-hit}}).
      // Обозначение попадание осколков снаряда (ОФ). (макрос {{splash-hit}}).
      "splash-hit":{
        "splash": "<font face='xvm'>&#x2C;</font>",
        "no-splash": ""
      },
      // Name part of vehicle (macro {{comp-name}}).
      // Название частей техники (макрос {{comp-name}}).
      "comp-name":{
        "turret": "башня",
        "hull": "корпус",
        "chassis": "шасси",
        "gun": "орудие"
      },
      // Color depending on damage source (ally , enemy) (macro {{c:team-dmg}}).
      // Цвет в зависимости от источника урона (союзник, противник, сам себе) (макрос {{c:team-dmg}}).
      "c:team-dmg":{
        "team-dmg": "#00EAFF",
        "no-team-dmg": "#CCCCCC",
        "player": "#228855"
      },
      // Text depending on cost shell (gold, credits) (macro {{costShell}}).
      // Текст в зависимости от стоимости снаряда (золото, кредиты) (макрос {{costShell}}).
      "costShell":{
        "gold-shell": "",
        "silver-shell": ""
      },
      // Color depending on shell kind (gold, credits) (macro {{c:costShell}}).
      // Цвет в зависимости от типа снаряда (золото, кредиты) (макрос {{c:costShell}}).
      "c:costShell":{
        "gold-shell": "#FFCC66",
        "silver-shell": "#CCCCCC"
      },
      
      // true - show hits without damage in log, false - not to show.
      // true - отображать в логе попадания без урона, false - не отображать.
      "showHitNoDamage": true, 
      
      // Damage log format.
      // Формат лога повреждений.
      "formatHistory": "<textformat tabstops='[30,115,150,163]'><font size='12'>{{number}}.</font><tab><font color='{{c:dmg-kind}}'>{{dmg}}{{critical-hit}}{{splash-hit}}<tab>{{dmg-kind}}</font><tab><font color='{{c:vtype}}'>{{vtype}}</font><tab><font color='{{c:team-dmg}}'>{{vehicle}}</font></textformat>",
      
      // Damage log format with the left Alt key.
      // Формат лога повреждений c нажатой левой клавиши Alt.
      "formatHistoryAlt": "<textformat tabstops='[30,115,150]'><font size='12'>{{number}}.</font><tab><font color='{{c:dmg-kind}}'>{{dmg}}{{critical-hit}}{{splash-hit}}<tab>{{dmg-kind}}</font><tab><font color='{{c:team-dmg}}'>{{name}}</font></textformat>"
    },
    "lastHit": {
      "$ref": { "path":"damageLog.log" },
      
      // Display time of last attack (seconds).
      // Время отображения последнего урона (в секундах).
      "timeDisplayLastHit": 7,
      
      // Last damage format.
      // Формат последнего урона.
      "formatLastHit": "<font size='36' color='{{c:dmg-kind}}'>{{dmg}}</font>"
    },
    "timeReload": {
      "$ref": { "path":"damageLog.log" },
      
      // Reload timer format.
      // Формат таймера перезарядки.
      "formatTimer": "<font face='xvm'>&#x114;</font>  {{timer}} сек.   [ <font color='{{c:team-dmg}}'>{{vehicle}}</font> ]",
      
      // Reload timer format (after reload).
      // Формат таймера перезарядки (после перезарядки).
      "formatTimerAfterReload": "<font face='xvm'>&#x114;</font>   [ <font color='{{c:team-dmg}}'>{{vehicle}}</font> ]  перезаряжен",
      
      // Display time "formatTimerAfterReload".
      // Время отображения "formatTimerAfterReload".
      "timeTextAfterReload": 5
    }
  }
}