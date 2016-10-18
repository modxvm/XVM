/**
  * Macros used in damageLog:
  * Макросы используемые в damageLog:
   
    {{number}}            - line number / номер строки.
    {{dmg}}               - received damage / полученный урон.
    {{dmg-kind}}          - kind of the received damage (attack, fire, ramming, ...) / вид полученного урона (атака, пожар, таран, ...).
    {{c:dmg-kind}}        - color depending on the kind of damage / цвет в зависимости от вида полученного урона.
    {{type-shell}}        - shell kind / тип снаряда.
    {{vtype}}             - vehicle type / тип техники.
    {{vehicle}}           - vehicle name / название техники.
    {{c:vtype}}           - color depending on vehicle type / цвет в зависимости от типа техники.
    {{c:team-dmg}}        - color depending on damage source (ally , enemy, self damage) / цвет в зависимости от источника урона (союзник, противник, урон по себе).
    {{c:costShell}}       - color depending on shell kind (gold, credits) / цвет в зависимости от типа снаряда (золото, кредиты).
    {{name}}              - nickname player who caused the damage / никнейм игрока, нанесшего урон.
    {{critical-hit}}      - critical hit / критическое попадание.
    {{c:hit-effects}}     - color depending on hit kind (with damage, ricochet, not penetrated, no damage) / цвет в зависимости от вида попадания (с уроном, рикошет, не пробито, без урона).
    {{costShell}}         - text depending on shell kind (gold, credits) / текст в зависимости от типа снаряда (золото, кредиты).
    {{comp-name}}         - name part of vehicle that was hit (turret, body, suspension, gun) / название части техники, в которую было попадание (башня, корпус, ходовая, орудие).
    {{clan}}              - clan name with brackets (empty if no clan) / название клана в скобках (пусто, если игрок не в клане).
    {{level}}             - vehicle level / уровень техники.
    {{clannb}}            - clan name without brackets / название клана без скобок.
    {{clanicon}}          - macro with clan embed image path value / макрос со значением пути эмблемы клана.
    {{squad-num}}         - number of squad (1,2,...), empty if not in squad / номер взвода (1,2,...), пусто - если игрок не во взводе
    {{hit-effects}}       - TO DO / вид попадания
    {{dmg-ratio}}         - TO DO / полученный урон в процентах
*/

{
  "damageLog": {
    // Log of the received damage.
    // Лог полученного урона.
    "log": {
      // Kind of the received damage (macro {{dmg-kind}}).
      // Вид полученного урона (макрос {{dmg-kind}}).
      "dmg-kind": {
        "shot": "{{type-shell}}", //"<font face='xvm'>&#x50;</font>", // shot / попадание
        "fire": "<font face='xvm'>&#x51;</font>",                     // fire / пожар
        "ramming": "<font face='xvm'>&#x52;</font>",                  // ramming / таран
        "world_collision": "<font face='xvm'>&#x53;</font>",          // world collision / столкновение с объектами, падение
        "drowning": "Dr",                                             // drowning / утопление
        "overturn": "<font face='xvm'>&#x112;</font>",                // overturn / опрокидывание
        "death_zone": "DZ",                                           // death zone / смертельная зона
        "gas_attack": "GA",                                           // gas attack / газовая атака
        "splash": "<font face='xvm'>&#x2C;</font>",                   // TO DO / урон оскоками
        "art_attack": "<font face='xvm'>&#x110;</font>",              // art attack / артиллерийская поддержка
        "air_strike": "<font face='xvm'>&#x111;</font>"               // air strike / поддержка авиации
      },
      // Color depending on the kind of damage (macro {{c:dmg-kind}}).
      // Цвет в зависимости от вида полученного урона (макрос {{c:dmg-kind}}).
      "c:dmg-kind": {
        "shot": "{{c:hit-effects}}",  // shot / попадание
        "fire": "#FF6655",            // fire / пожар
        "ramming": "#998855",         // ramming / таран
        "world_collision": "#228855", // world collision / столкновение с объектами, падение
        "drowning": "#CCCCCC",        // drowning / утопление
        "overturn": "#CCCCCC",        // overturn / опрокидывание
        "death_zone": "#CCCCCC",      // death zone / смертельная зона
        "gas_attack": "#CCCCCC",      // gas attack / газовая атака
        "splash": "#CCCCCC",
        "art_attack": "#CCCCCC",      // art attack / артиллерийская поддержка
        "air_strike": "#CCCCCC"       // air strike / поддержка авиации
      },   
      // Shell kind (macro {{type-shell}}).
      // Тип снарядов (макрос {{type-shell}}).
      "type-shell": {
        "armor_piercing": "{{l10n:armor_piercing}}",       // armor piercing / бронебойный
        "high_explosive": "{{l10n:high_explosive}}",       // high explosive / осколочно-фугасный
        "armor_piercing_cr": "{{l10n:armor_piercing_cr}}", // armor piercing composite rigid / бронебойный подкалиберный
        "armor_piercing_he": "{{l10n:armor_piercing_he}}", // armor piercing high explosive / бронебойно-фугасный
        "hollow_charge": "{{l10n:hollow_charge}}",          // high explosive anti-tank / кумулятивный
        "not_shell": ""
      },
      // Vehicle type (macro {{vtype}}).
      // Тип техники (макрос {{vtype}}).
      "vtype": {
        "mediumTank": "<font face='xvm'>&#x3B;</font>", // medium tank / средний танк
        "lightTank": "<font face='xvm'>&#x3A;</font>",  // light tank / лёгкий танк
        "heavyTank": "<font face='xvm'>&#x3F;</font>",  // heavy tank / тяжёлый танк
        "AT-SPG": "<font face='xvm'>&#x2E;</font>",     // tank destroyer / ПТ-САУ
        "SPG": "<font face='xvm'>&#x2D;</font>",         // SPG / САУ
        "not_vehicle": ""                               // TO DO / другая техника
      },
      // Color depending on vehicle type (macro {{c:vtype}}).
      // Цвет в зависимости от типа техники (макрос {{c:vtype}}).
      "c:vtype":{
        "mediumTank": "#FFF198", // medium tank / средний танк
        "lightTank": "#A2FF9A",  // light tank / лёгкий танк
        "heavyTank": "#FFACAC",  // heavy tank / тяжёлый танк
        "AT-SPG": "#A0CFFF",     // tank destroyer / ПТ-САУ
        "SPG": "#EFAEFF",         // SPG / САУ
        "not_vehicle": "#CCCCCC" // TO DO / другая техника
      },
      // TO DO
      // вид попадания (макрос {{hit-effects}}).
      "hit-effects": {
        "armor_pierced": "{{dmg}}",                                   // TO DO / пробитие
        "intermediate_ricochet": "{{l10n:intermediate_ricochet}}",    // ricochet (intermediate) / рикошет (промежуточный)
        "final_ricochet": "{{l10n:final_ricochet}}",                  // ricochet / рикошет
        "armor_not_pierced": "{{l10n:armor_not_pierced}}",            // not penetrated / не пробито
        "armor_pierced_no_damage": "{{l10n:armor_pierced_no_damage}}" // no damage / без урона
      },
      // Color depending on hit kind (with damage, ricochet, no penetration, no damage) (macro {{c:hit-effects}}).
      // Цвет в зависимости от вида попадания (с уроном, рикошет, не пробито, без урона) (макрос {{c:hit-effects}}).
      "c:hit-effects": {
        "armor_pierced": "#FF4D3C",          // penetrated (damage) / пробито (урон)
        "intermediate_ricochet": "#CCCCCC",  // ricochet (intermediate) / рикошет (промежуточный)
        "final_ricochet": "#CCCCCC",         // ricochet / рикошет
        "armor_not_pierced": "#CCCCCC",      // not penetrated / не пробито
        "armor_pierced_no_damage": "#CCCCCC" // no damage / без урона
      },
      // Designation of critical hit (macro {{critical-hit}}).
      // Обозначение критического попадания (макрос {{critical-hit}}).
      "critical-hit":{
        "critical": "*",  // critical hit / попадание с критическим повреждением
        "no-critical": "" // without critical hit / попадание без критического повреждения
      },
      // Name part of vehicle (macro {{comp-name}}).
      // Название частей техники (макрос {{comp-name}}).
      "comp-name":{
        "turret": "{{l10n:turret}}",   // turret / башня
        "hull": "{{l10n:hull}}",       // body / корпус
        "chassis": "{{l10n:chassis}}", // suspension / ходовая
        "gun": "{{l10n:gun}}"          // gun / орудие
      },
      // Color depending on damage source (ally , enemy, self damage) (macro {{c:team-dmg}}).
      // Цвет в зависимости от источника урона (союзник, противник, урон по себе) (макрос {{c:team-dmg}}).
      "c:team-dmg":{
        "team-dmg": "#00EAFF",    // ally / союзник
        "no-team-dmg": "#CCCCCC", // enemy / противник
        "player": "#228855"       // self damage / урон по себе
      },
      // Text depending on cost shell (gold, credits) (macro {{costShell}}).
      // Текст в зависимости от стоимости снаряда (золото, кредиты) (макрос {{costShell}}).
      "costShell":{
        "gold-shell": "",  // gold / золото
        "silver-shell": "" // credits / кредиты
      },
      // Color depending on shell kind (gold, credits) (macro {{c:costShell}}).
      // Цвет в зависимости от типа снаряда (золото, кредиты) (макрос {{c:costShell}}).
      "c:costShell":{
        "gold-shell": "#FFCC66",  // gold / золото
        "silver-shell": "#CCCCCC" // credits / кредиты
      },
      // true - show hits without damage in log, false - not to show.
      // true - отображать в логе попадания без урона, false - не отображать.
      "showHitNoDamage": true, 
      // true - to add and display in a log in one line of damage from the fire
      // true - суммировать и отображать в логе в одной строке повреждения от пожара
      "groupDamagesFromFire": true,
      // Damage log format.
      // Формат лога повреждений.
      "formatHistory": "<textformat tabstops='[30,115,150,163]'><font size='12'>{{number}}.</font><tab><font color='{{c:dmg-kind}}'>{{hit-effects}}{{critical-hit}}{{splash-hit}}<tab>{{dmg-kind}}</font><tab><font color='{{c:vtype}}'>{{vtype}}</font><tab><font color='{{c:team-dmg}}'>{{vehicle}}</font></textformat>",
      // Damage log format with the left Alt key.
      // Формат лога повреждений c нажатой левой клавиши Alt.
      "formatHistoryAlt": "<textformat tabstops='[30,115,150]'><font size='12'>{{number}}.</font><tab><font color='{{c:dmg-kind}}'>{{hit-effects}}{{critical-hit}}{{splash-hit}}<tab>{{dmg-kind}}</font><tab><font color='{{c:team-dmg}}'>{{name}}</font></textformat>"
    },
    // Display the last damage (hit).
    // Отображение последнего урона (попадания).
    "lastHit": {
      "$ref": { "path":"damageLog.log" }, 
      // Display duration of last attack (seconds).
      // Продолжительность отображения последнего урона (в секундах).
      "timeDisplayLastHit": 7,
      // Last damage format.
      // Формат последнего урона.
      "formatLastHit": "<font size='36' color='{{c:dmg-kind}}'>{{hit-effects}}</font>"
    },
    // Timer reload (value is not accurate, and consistent with the standard characteristics of vehicle).
    // Таймер перезарядки (значение не точное, и соответствует стандартным характеристикам техники).
    "timeReload": {
      "$ref": { "path":"damageLog.log" },
      // Reload timer format.
      // Формат таймера перезарядки.
      "formatTimer": "<font face='xvm'>&#x114;</font>  {{timer}} {{l10n:sec}}.   [ <font color='{{c:team-dmg}}'>{{vehicle}}</font> ]",
      // Reload timer format (after reload).
      // Формат таймера перезарядки (после перезарядки).
      "formatTimerAfterReload": "<font face='xvm'>&#x114;</font>   [ <font color='{{c:team-dmg}}'>{{vehicle}}</font> ]  {{l10n:reloaded}}",
      // Display duration "formatTimerAfterReload" (seconds).
      // Продолжительность отображения "formatTimerAfterReload" (в секундах).
      "timeTextAfterReload": 5
    }
  }
}