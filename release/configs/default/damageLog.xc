/**
  * Macros used in damageLog:
  * Макросы используемые в damageLog:
   
    {{number}}            - line number / номер строки.
    {{dmg}}               - received damage / полученный урон.
    {{dmg-kind}}          - kind of the received damage (attack, fire, ramming, ...) / вид полученного урона (атака, пожар, таран, ...).
    {{c:dmg-kind}}        - color depending on the kind of damage / цвет в зависимости от вида полученного урона.
    {{type-shell}}        - shell kind / тип снаряда.
    {{c:type-shell}}      - color depending on shell kind / цвет в зависимости от типа снаряда.
    {{vtype}}             - vehicle type / тип техники.
    {{vehicle}}           - vehicle name / название техники.
    {{c:vtype}}           - color depending on vehicle type / цвет в зависимости от типа техники.
    {{c:team-dmg}}        - color depending on damage source (ally , enemy, self damage) / цвет в зависимости от источника урона (союзник, противник, урон по себе).
    {{c:costShell}}       - color depending on cost shell (gold, credits) / цвет в зависимости от стоимости снаряда (золото, кредиты).
    {{name}}              - nickname player who caused the damage / никнейм игрока, нанесшего урон.
    {{critical-hit}}      - critical hit / критическое попадание.
    {{c:hit-effects}}     - color depending on hit kind (with damage, ricochet, not penetrated, no damage) / цвет в зависимости от вида попадания (с уроном, рикошет, не пробито, без урона).
    {{costShell}}         - text depending on cost shell (gold, credits) / текст в зависимости от стоимости снаряда (золото, кредиты).
    {{comp-name}}         - name part of vehicle that was hit (turret, body, suspension, gun) / название части техники, в которую было попадание (башня, корпус, ходовая, орудие).
    {{clan}}              - clan name with brackets (empty if no clan) / название клана в скобках (пусто, если игрок не в клане).
    {{level}}             - vehicle level / уровень техники.
    {{clannb}}            - clan name without brackets / название клана без скобок.
    {{clanicon}}          - macro with clan embed image path value / макрос со значением пути эмблемы клана.
    {{squad-num}}         - number of squad (1,2,...), empty if not in squad / номер взвода (1,2,...), пусто - если игрок не во взводе.
    {{hit-effects}}       - kind of hit / вид попадания.
    {{dmg-ratio}}         - received damage in percent / полученный урон в процентах.
    {{team-dmg}}          - source of damage (ally , enemy, self damage) / источник урона (союзник, противник, урон по себе).
    {{splash-hit}}        - text when hit by splash damage from shell (HE/HESH) / текст при попадании осколков снаряда (ОФ/ХФ).
    {{my-alive}}          - value 'alive' if my vehicle is alive, '' for dead / возвращает 'alive', если я живой, '', если не живой
    {{reloadGun}}         - reloading time of a gun / время перезарядки орудия 
    {{gun-caliber}}       - caliber of a gun / калибр орудия
    {{wn8}}, {{xwn8}}, {{eff}}, {{xeff}}, {{wgr}}, {{xwgr}}, {{xte}}                - statistics macros (see macros.txt) / макросы статистика (смотрите macros_ru.txt)
    {{c:wn8}}, {{c:xwn8}}, {{c:eff}}, {{c:xeff}}, {{c:wgr}}, {{c:xwgr}}, {{c:xte}}  - statistics macros (see macros.txt) / макросы статистика (смотрите macros_ru.txt)
    {{fire-duration}}     - duration of fire ("groupDamagesFromFire" must be enabled to work) / продолжительность пожара (работает только при включенной опции "groupDamagesFromFire")
    {{diff-masses}}       - vehicles weights difference during collision / разность масс техники при столкновении
    {{nation}}            - vehicle nation / нация техники
    {{my-blownup}}         - TO DO / возвращает 'blownup', если взорван боекомплект техники игрока, иначе пусто
*/

{
  "damageLog": {
    // true - disable standard detailed damage.
    // true - отключить стандартный детальный урон.
    "disabledDetailStats": true,
    // true - disable standard summarized damage.
    // true - отключить стандартный суммарный урон.
    "disabledSummaryStats": true,
    // Log of the received damage.
    // Лог полученного урона.
    "log": {
      //TO DO
      //true - разрешено перемещать в бою лог полученного урона, макросы в "x" и "y" не работают
      //false - запрещено перемещать в бою лог полученного урона, макросы в "x" и "y" работают
      "moveInBattle": false,
      "x": 240,
      "y": -23,
      // Kind of the received damage (macro {{dmg-kind}}).
      // Вид полученного урона (макрос {{dmg-kind}}).
      "dmg-kind": {
        "shot": "{{type-shell}}",                            // shot / попадание
        "fire": "<font face='xvm'>&#x51;</font>",            // fire / пожар
        "ramming": "<font face='xvm'>&#x52;</font>",         // ramming / таран
        "world_collision": "<font face='xvm'>&#x53;</font>", // world collision / столкновение с объектами, падение
        "drowning": "Dr",                                    // drowning / утопление
        "overturn": "<font face='xvm'>&#x112;</font>",       // overturn / опрокидывание
        "death_zone": "DZ",                                  // death zone / смертельная зона
        "gas_attack": "GA",                                  // gas attack / газовая атака
        "art_attack": "<font face='xvm'>&#x110;</font>",     // art attack / артиллерийская поддержка
        "air_strike": "<font face='xvm'>&#x111;</font>"      // air strike / поддержка авиации
      },
      // Color depending on the kind of damage (macro {{c:dmg-kind}}).
      // Цвет в зависимости от вида полученного урона (макрос {{c:dmg-kind}}).
      "c:dmg-kind": {
        "shot": "{{c:hit-effects}}",       // shot / попадание
        "fire": "#FF6655",                 // fire / пожар
        "ramming": "#998855",              // ramming / таран
        "world_collision": "#228855",      // world collision / столкновение с объектами, падение
        "drowning": "#CCCCCC",             // drowning / утопление
        "overturn": "#CCCCCC",             // overturn / опрокидывание
        "death_zone": "#CCCCCC",           // death zone / смертельная зона
        "gas_attack": "#CCCCCC",           // gas attack / газовая атака
        "art_attack": "{{c:hit-effects}}", // art attack / артиллерийская поддержка
        "air_strike": "{{c:hit-effects}}"  // air strike / поддержка авиации
      },
      // Designation of hit by splash damage from shell (HE/HESH). (macro {{splash-hit}}).
      // Обозначение попадание осколков снаряда (ОФ/ХФ). (макрос {{splash-hit}}).
      "splash-hit":{
        "splash": "<font face='xvm'>&#x2C;</font>", // splash damage / попадание осколков
        "no-splash": ""                             // no splash damage / нет попадания осколков
      },
      // Shell kind (macro {{type-shell}}).
      // Тип снаряда (макрос {{type-shell}}).
      "type-shell": {
        "armor_piercing": "<font color='{{c:costShell}}'>{{l10n:armor_piercing}}</font>",       // armor piercing / бронебойный
        "high_explosive": "<font color='{{c:costShell}}'>{{l10n:high_explosive}}</font>",       // high explosive / осколочно-фугасный
        "armor_piercing_cr": "<font color='{{c:costShell}}'>{{l10n:armor_piercing_cr}}</font>", // armor piercing composite rigid / бронебойный подкалиберный
        "armor_piercing_he": "<font color='{{c:costShell}}'>{{l10n:armor_piercing_he}}</font>", // armor piercing high explosive / бронебойно-фугасный
        "hollow_charge": "<font color='{{c:costShell}}'>{{l10n:hollow_charge}}</font>",         // high explosive anti-tank / кумулятивный
        "not_shell": ""                                                                         // another source of damage / другой источник урона
      },
      // Color depending on shell kind (macro {{type-shell}}).
      // Цвет в зависимости от типа снаряда (макрос {{type-shell}}).
      "c:type-shell": {
        "armor_piercing": "#CCCCCC",    // armor piercing / бронебойный
        "high_explosive": "#CCCCCC",    // high explosive / осколочно-фугасный
        "armor_piercing_cr": "#CCCCCC", // armor piercing composite rigid / бронебойный подкалиберный
        "armor_piercing_he": "#CCCCCC", // armor piercing high explosive / бронебойно-фугасный
        "hollow_charge": "#CCCCCC",     // high explosive anti-tank / кумулятивный
        "not_shell": "#CCCCCC"          // another source of damage / другой источник урона
      },
      // Vehicle type (macro {{vtype}}).
      // Тип техники (макрос {{vtype}}).
      "vtype": {
        "mediumTank": "<font face='xvm'>&#x3B;</font>", // medium tank / средний танк
        "lightTank": "<font face='xvm'>&#x3A;</font>",  // light tank / лёгкий танк
        "heavyTank": "<font face='xvm'>&#x3F;</font>",  // heavy tank / тяжёлый танк
        "AT-SPG": "<font face='xvm'>&#x2E;</font>",     // tank destroyer / ПТ-САУ
        "SPG": "<font face='xvm'>&#x2D;</font>",        // SPG / САУ
        "not_vehicle": ""                               // another source of damage / другой источник урона
      },
      // Color depending on vehicle type (macro {{c:vtype}}).
      // Цвет в зависимости от типа техники (макрос {{c:vtype}}).
      "c:vtype":{
        "mediumTank": "#FFF198", // medium tank / средний танк
        "lightTank": "#A2FF9A",  // light tank / лёгкий танк
        "heavyTank": "#FFACAC",  // heavy tank / тяжёлый танк
        "AT-SPG": "#A0CFFF",     // tank destroyer / ПТ-САУ
        "SPG": "#EFAEFF",        // SPG / САУ
        "not_vehicle": "#CCCCCC" // another source of damage / другой источник урона
      },
      // Kind of hit (macro {{hit-effects}}).
      // Вид попадания (макрос {{hit-effects}}).
      "hit-effects": {
        "armor_pierced": "{{dmg}}",                                    // penetrated / пробито
        "intermediate_ricochet": "{{l10n:intermediate_ricochet}}",     // ricochet (intermediate) / рикошет (промежуточный)
        "final_ricochet": "{{l10n:final_ricochet}}",                   // ricochet / рикошет
        "armor_not_pierced": "{{l10n:armor_not_pierced}}",             // not penetrated / не пробито
        "armor_pierced_no_damage": "{{l10n:armor_pierced_no_damage}}", // no damage / без урона
        "unknown": "{{l10n:armor_pierced_no_damage}}"                  // unknown / неизвестно
      },
      // Color depending on hit kind (with damage, ricochet, no penetration, no damage) (macro {{c:hit-effects}}).
      // Цвет в зависимости от вида попадания (с уроном, рикошет, не пробито, без урона) (макрос {{c:hit-effects}}).
      "c:hit-effects": {
        "armor_pierced": "#FF4D3C",           // penetrated (damage) / пробито (урон)
        "intermediate_ricochet": "#CCCCCC",   // ricochet (intermediate) / рикошет (промежуточный)
        "final_ricochet": "#CCCCCC",          // ricochet / рикошет
        "armor_not_pierced": "#CCCCCC",       // not penetrated / не пробито
        "armor_pierced_no_damage": "#CCCCCC", // no damage / без урона
        "unknown": "#CCCCCC"                  // unknown / неизвестно
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
        "gun": "{{l10n:gun}}",         // gun / орудие
        "unknown": ""                  // unknown / неизвестно
      },
      // Source of damage (ally , enemy, self damage) (macro {{team-dmg}}).
      // Источник урона (союзник, противник, урон по себе) (макрос {{team-dmg}}).
      "team-dmg":{
        "ally-dmg": "",  // ally / союзник
        "enemy-dmg": "", // enemy / противник
        "player": "",    // self damage / урон по себе
        "unknown": ""    // unknown / неизвестно
      },
      // Color depending on damage source (ally , enemy, self damage) (macro {{c:team-dmg}}).
      // Цвет в зависимости от источника урона (союзник, противник, урон по себе) (макрос {{c:team-dmg}}).
      "c:team-dmg":{
        "ally-dmg": "#00EAFF",  // ally / союзник
        "enemy-dmg": "#CCCCCC", // enemy / противник
        "player": "#228855",    // self damage / урон по себе
        "unknown": "#CCCCCC"    // unknown / неизвестно
      },
      // Text depending on cost shell (gold, credits) (macro {{costShell}}).
      // Текст в зависимости от стоимости снаряда (золото, кредиты) (макрос {{costShell}}).
      "costShell":{
        "gold-shell": "",   // gold / золото
        "silver-shell": "", // credits / кредиты
        "unknown": ""       // unknown / неизвестно
      },
      // Color depending on cost shell (gold, credits) (macro {{c:costShell}}).
      // Цвет в зависимости от стоимости снаряда (золото, кредиты) (макрос {{c:costShell}}).
      "c:costShell":{
        "gold-shell": "#FFCC66",   // gold / золото
        "silver-shell": "#CCCCCC", // credits / кредиты
        "unknown": ""              // unknown / неизвестно
      },
      // true - show hits without damage, false - not to show.
      // true - отображать попадания без урона, false - не отображать.
      "showHitNoDamage": true,
      // true - to summarize the damage from the fire.
      // true - суммировать повреждения от пожара.
      "groupDamagesFromFire": true,
      // true - to summarize the damage by ramming, collisions with objects, falling.
      //        Damage summarized, if applied more than once a second.
      // true - суммировать повреждения от тарана, столкновения с объектами, падения.
      //        Урон суммируется, если наносится чаще одного раза в секунду.
      "groupDamagesFromRamming_WorldCollision": true,
      //TO DO
      //Настройка тени
      "shadow": { 
        "distance": 1,
        "angle": 90,
        "color": "#000000",
        "alpha": 75,
        "blur": 5,
        "strength": 3,
        "hideObject": false,
        "inner": false,
        "knockout": false,
        "quality": 1 
      },
      // Damage log format.
      // Формат лога повреждений.
      "formatHistory": "<textformat tabstops='[30,135,170,185]'><font face='mono' size='12'>{{number%3d~.}}</font><tab><font color='{{c:dmg-kind}}'>{{hit-effects}}{{critical-hit}}{{splash-hit}}<tab>{{dmg-kind}}</font><tab><font color='{{c:vtype}}'>{{vtype}}</font><tab><font color='{{c:team-dmg}}'>{{vehicle}}</font></textformat>"
    },
    // TODO.
    // Подложка лога полученного урона.
    "logBackground": {
      "$ref": { "path":"damageLog.log" },
      // TODO
      // Формат подложки лога повреждений.
      "formatHistory": "<img height='20' width='310' src='xvm://res/icons/damageLog/{{dmg=0?no_dmg|dmg}}.png'>"
    },    
    // TODO.
    // Альтернативный лог полученного урона.
    "logAlt": {
      "$ref": { "path":"damageLog.log" },
      // true - show hits without damage, false - not to show.
      // true - отображать попадания без урона, false - не отображать.
      "showHitNoDamage": true,
      // Damage log format.
      // Формат лога повреждений.
      "formatHistory": "<textformat tabstops='[30,135,170]'><font face='mono' size='12'>{{number%3d~.}}</font><tab><font color='{{c:dmg-kind}}'>{{hit-effects}}{{critical-hit}}{{splash-hit}}<tab>{{dmg-kind}}</font><tab><font color='{{c:team-dmg}}'>{{name}}</font></textformat>"
    },
    // TODO.
    // Подложка альтернативного лога полученного урона.
    "logAltBackground": {
      "$ref": { "path":"damageLog.logAlt" },
      // TODO
      // Формат подложки альтернативного лога полученного урона.
      "formatHistory": "<img height='20' width='310' src='xvm://res/icons/damageLog/{{dmg=0?no_dmg|dmg}}.png'>"
    },    
    // Display the last damage (hit).
    // Отображение последнего урона (попадания).
    "lastHit": {
      "$ref": { "path":"damageLog.log" },
      //TO DO
      //true - разрешено перемещать поле последнего урона в бою, макросы в "x" и "y" не работают
      //false - запрещено перемещать поле последнего урона в бою, макросы в "x" и "y" работают
      "moveInBattle": false,
      "x": -120,
      "y": 200,
      // true - show hits without damage, false - not to show.
      // true - отображать попадания без урона, false - не отображать.
      "showHitNoDamage": true,
      // Display duration (seconds).
      // Продолжительность отображения (секунды).
      "timeDisplayLastHit": 7,
      //TO DO
      //Настройка тени
      "shadow": { 
        "distance": 0,
        "blur": 6,
        "strength": 6,
        "color": "{{dmg=0?#000000|#770000}}"
      },
      // Last damage format.
      // Формат последнего урона.
      "formatLastHit": "<font size='36' color='{{c:dmg-kind}}'>{{hit-effects}}</font>"
    }
  }
}