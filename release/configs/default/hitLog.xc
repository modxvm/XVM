/**
 * Log of applied damage.
 * For additional settings see battleLabelsTemplates.xc
 * Лог нанесенного урона.
 * Дополнительные настройки см. в battleLabelsTemplates.xc
 *
 * https://kr.cm/f/t/40466/

  Macros used in hitLog:
  Макросы используемые в hitLog:

    {{number}}             - line number / номер строки.
    {{dmg}}                - last damage / последний нанесенный урон.
    {{dmg-kind}}           - type of damage / тип нанесенного урона (атака, пожар, таран, ...).
    {{c:dmg-kind}}         - color by damage kind / цвет по типу урона.
    {{type-shell}}         - shell kind / тип снаряда.
    {{c:type-shell}}       - color by shell kind / цвет по типу снаряда.
    {{vtype}}              - vehicle type / тип техники.
    {{c:vtype}}            - color by vehicle type / цвет по типу техники.
    {{team-dmg}}           - team attachment of the targets / командная принадлежность цели (союзник, противник, урон по себе).
    {{c:team-dmg}}         - color by team attachment of the targets / цвет по командной принадлежности цели (союзник, противник, урон по себе).
    {{costShell}}          - shell currency (gold, credits) / валюта снаряда (золото, кредиты).
    {{c:costShell}}        - color by shell currency / цвет по валюте снаряда.
    {{vehicle}}            - attacker vehicle name (for firing points, the name is taken from the localization files, the "pillbox" parameter) / название техники цели (для огневых точек название берется из файлов локализации, параметр "pillbox").
    {{name}}               - nickname target / никнейм цели.
    {{comp-name}}          - vehicle part that was hit (turret, hull, chassis, gun) / часть техники, в которую было попадание (башня, корпус, ходовая, орудие).
    {{clan}}               - clan name with brackets (empty if no clan) / название клана в скобках (пусто, если игрок не в клане).
    {{level}}              - vehicle level / уровень техники.
    {{clannb}}             - clan name without brackets / название клана без скобок.
    {{clanicon}}           - macro with clan emblem image path value / макрос со значением пути эмблемы клана.
    {{squad-num}}          - number of squad (1,2,...), empty if not in squad / номер взвода (1,2,...), пусто - если игрок не во взводе.
    {{dmg-ratio}}          - last damage in percent / последний нанесенный урон в процентах.
    {{splash-hit}}         - value 'splash', if damage is caused by shell splinters (HE/HESH), empty if not / возвращает 'splash', если урон нанесен осколками снаряда (ОФ/ХФ), иначе пусто.
    {{critical-hit}}       - value 'crit', if critical damage was done, empty if not / возвращает 'crit', если было нанесено критическое повреждение, иначе пусто.
    {{alive}}              - value 'al', if the vehicle after the attack is not destroyed, empty if destroyed / возвращает 'al', если техника после атаки не разрушена, пусто для разрушенной.
    {{wn8}}, {{xwn8}}, {{wtr}}, {{xwtr}}, {{eff}}, {{xeff}}, {{wgr}}, {{xwgr}}, {{xte}}, {{r}}, {{xr}} - statistics macros (see macros.txt) / макросы статистики (смотрите macros_ru.txt).
    {{c:wn8}}, {{c:xwn8}}, {{c:wtr}}, {{c:xwtr}}, {{c:eff}}, {{c:xeff}}, {{c:wgr}}, {{c:xwgr}}, {{c:xte}}, {{c:r}}, {{c:xr}} - color according to the corresponding statistics macro (see macros.txt) / цвет по соответствующему макросу статистики (смотрите macros_ru.txt).
    {{diff-masses}}        - vehicles weights difference during collision / разность масс техники при столкновении.
    {{nation}}             - vehicle nation / нация техники.
    {{blownup}}            - value 'blownup', if target ammoBay is blown up, '' if not / возвращает 'blownup', если взорван боекомплект цели, иначе ''.
    {{type-shell-key}}     - shell kind table key value / название ключа таблицы типа снаряда.
    {{n-player}}           - number of hits for each player / число повреждений по каждому игроку.
    {{dmg-player}}         - sum of hits for each player / суммарный урон по цели.
    {{dmg-ratio-player}}   - total damage to targets in percent / суммарный урон по цели в процентах.
    {{c:dmg-ratio-player}} - color by total damage to targets (set in colors.xc) / цвет по суммарному урону по цели (задается в colors.xc).
    {{dmg-kind-player}}    - all kinds of damage done to targets (attack, fire, ramming, ...) / все типы нанесенного урона по цели (атака, пожар, таран, ...).
    {{dmg-deviation}}      - TODO / отклонение нанесенного урона от номинального урона снаряда в процентах. Возвращает 0.0, если техника была уничтожена выстрелом, или выстрел был фугасом и отклонение составило больше 25%.
    {{vehiclename}}        - vehicle system name (usa-A34_M24_Chaffee) / название техники в системе (usa-A34_M24_Chaffee).
    {{battletype-key}}     - название ключа таблицы типа текущего боя / current battle type table key value.
    {{shell-dmg}}          - shell damage / урон снарядом.
*/

{
  "hitLog": {
    // false - disable.
    // false - отключить.
    "enabled": true,
    // true - show damage by oneself.
    // true - отображать урон по себе.
    "showSelfDamage": true,
    // true - show damage by allies.
    // true - отображать урон по союзникам.
    "showAllyDamage": true,
    // Log of applied damage.
    // Лог нанесенного урона.
    "log": {
      // true - allow to move log in battle and disallow macros for "x" and "y" settings.
      // false - disallow to move log in battle and allow macros for "x" and "y" settings.
      // true - разрешить перемещение лога в бою и запретить макросы в настройках "x" и "y".
      // false - запретить перемещение лога в бою и разрешить макросы в настройках "x" и "y".
      "moveInBattle": false,
      "x": 50,
      "y": 60,
      // true - allow scrolling of the contents of the log.
      // true - разрешить прокрутку содержимого лога.
      "scrollLog": true,
      // Group hits by players name.
      // Группировать попадания по имени игрока.
      "groupHitsByPlayer": true,
      // Number of lines. It is possible to use the macro {{battle type-key}}.
      // Количество строк. Можно использовать макрос {{battletype-key}}.
      "lines": 15,
      // Insert order: false - insert new values to begin, true - add to end.
      // Сортировка попаданий: false - новые значения добавляются сверху, true - снизу.
      "addToEnd": false,
      // Type of damage (macro {{dmg-kind}}).
      // Тип нанесенного урона (макрос {{dmg-kind}}).
      "dmg-kind": {
        "shot":            "<font face='$FieldFont'>{{type-shell}}</font>",          // shot / попадание.
        "fire":            "<font size='6'> </font><font face='xvm'>&#x51;</font>",  // fire / пожар.
        "ramming":         "<font size='6'> </font><font face='xvm'>&#x52;</font>",  // ramming / таран.
        "world_collision": "<font size='6'> </font><font face='xvm'>&#x53;</font>",  // world collision / столкновение с объектами, падение.
        "drowning":        "<font size='6'> </font><font face='xvm'>&#x119;</font>", // drowning / утопление.
        "overturn":        "<font size='6'> </font><font face='xvm'>&#x112;</font>", // overturn / опрокидывание.
        "death_zone":      "DZ",                                                     // death zone / смертельная зона.
        "gas_attack":      "GA",                                                     // gas attack / газовая атака.
        "art_attack":      "<font face='xvm'>&#x110;</font>",                        // art attack / артиллерийская поддержка.
        "air_strike":      "<font face='xvm'>&#x111;</font>"                         // air strike / поддержка авиации.
      },
      // Color by damage kind (macro {{c:dmg-kind}}).
      // Цвет по типу нанесенного урона (макрос {{c:dmg-kind}}).
      "c:dmg-kind": {
        "shot": "#FFAA55",            // shot / попадание.
        "fire": "#FF6655",            // fire / пожар.
        "ramming": "#998855",         // ramming / таран.
        "world_collision": "#228855", // world collision / столкновение с объектами, падение.
        "drowning": "#CCCCCC",        // drowning / утопление.
        "overturn": "#CCCCCC",        // overturn / опрокидывание.
        "death_zone": "#CCCCCC",      // death zone / смертельная зона.
        "gas_attack": "#CCCCCC",      // gas attack / газовая атака.
        "art_attack": "#CCCCCC",      // art attack / артиллерийская поддержка.
        "air_strike": "#CCCCCC"       // air strike / поддержка авиации.
      },
      // Type of damage (macro {{dmg-kind-player}}).
      // Тип нанесенного урона (макрос {{dmg-kind-player}}).
      "dmg-kind-player": {
        "shot":            "<font size='6'> </font><font face='xvm'>&#x50;</font>",  // shot / попадание.
        "fire":            "<font size='6'> </font><font face='xvm'>&#x51;</font>",  // fire / пожар.
        "ramming":         "<font size='6'> </font><font face='xvm'>&#x52;</font>",  // ramming / таран.
        "world_collision": "<font size='6'> </font><font face='xvm'>&#x53;</font>",  // world collision / столкновение с объектами, падение.
        "drowning":        "<font size='6'> </font><font face='xvm'>&#x119;</font>", // drowning / утопление.
        "overturn":        "<font size='6'> </font><font face='xvm'>&#x112;</font>", // overturn / опрокидывание.
        "death_zone":      "DZ",                                                     // death zone / смертельная зона.
        "gas_attack":      "GA",                                                     // gas attack / газовая атака.
        "art_attack":      "<font face='xvm'>&#x110;</font>",                        // art attack / артиллерийская поддержка.
        "air_strike":      "<font face='xvm'>&#x111;</font>"                         // air strike / поддержка авиации.
      },
      // Shell kind (macro {{type-shell}}).
      // Тип снаряда (макрос {{type-shell}}).
      "type-shell": {
        "armor_piercing":    "<font color='{{c:costShell}}' face='$FieldFont'>{{l10n:armor_piercing}}</font>",    // armor piercing / бронебойный.
        "high_explosive":    "<font color='{{c:costShell}}' face='$FieldFont'>{{l10n:high_explosive}}</font>",    // high explosive / осколочно-фугасный.
        "armor_piercing_cr": "<font color='{{c:costShell}}' face='$FieldFont'>{{l10n:armor_piercing_cr}}</font>", // armor piercing composite rigid / бронебойный подкалиберный.
        "armor_piercing_he": "<font color='{{c:costShell}}' face='$FieldFont'>{{l10n:armor_piercing_he}}</font>", // armor piercing high explosive / бронебойно-фугасный.
        "hollow_charge":     "<font color='{{c:costShell}}' face='$FieldFont'>{{l10n:hollow_charge}}</font>",     // high explosive anti-tank / кумулятивный.
        "not_shell": "НД"                                                                                         // another source of damage / другой источник урона.
      },
      // Color by shell kind (macro {{c:type-shell}}).
      // Цвет по типу снаряда (макрос {{c:type-shell}}).
      "c:type-shell": {
        "armor_piercing": "#CCCCCC",    // armor piercing / бронебойный.
        "high_explosive": "#CCCCCC",    // high explosive / осколочно-фугасный.
        "armor_piercing_cr": "#CCCCCC", // armor piercing composite rigid / бронебойный подкалиберный.
        "armor_piercing_he": "#CCCCCC", // armor piercing high explosive / бронебойно-фугасный.
        "hollow_charge": "#CCCCCC",     // high explosive anti-tank / кумулятивный.
        "not_shell": "#CCCCCC"          // another source of damage / другой источник урона.
      },
      // Vehicle type (macro {{vtype}}).
      // Тип техники (макрос {{vtype}}).
      "vtype": {
        "HT": "<font face='xvm'>&#x3F;</font>",          // heavy tank / тяжёлый танк.
        "MT": "<font face='xvm'>&#x3B;</font>",          // medium tank / средний танк.
        "LT": "<font face='xvm'>&#x3A;</font>",          // light tank / лёгкий танк.
        "TD": "<font face='xvm'>&#x2E;</font>",          // tank destroyer / ПТ-САУ.
        "SPG": "<font face='xvm'>&#x2D;</font>",         // SPG / САУ.
        "not_vehicle": "<font face='xvm'>&#x105;</font>" // another source of damage / другой источник урона.
      },
      // Color by vehicle type (macro {{c:vtype}}).
      // Цвет по типу техники (макрос {{c:vtype}}).
      "c:vtype": {
        "HT": "#FFACAC",         // heavy tank / тяжёлый танк.
        "MT": "#FFF198",         // medium tank / средний танк.
        "LT": "#A2FF9A",         // light tank / лёгкий танк.
        "TD": "#A0CFFF",         // tank destroyer / ПТ-САУ.
        "SPG": "#EFAEFF",        // SPG / САУ.
        "not_vehicle": "#CCCCCC" // another source of damage / другой источник урона.
      },
      // Part of vehicle (macro {{comp-name}}).
      // Часть техники (макрос {{comp-name}}).
      "comp-name": {
        "turret": "{{l10n:turret}}",   // turret / башня.
        "hull": "{{l10n:hull}}",       // body / корпус.
        "chassis": "{{l10n:chassis}}", // suspension / ходовая.
        "wheel": "{{l10n:wheel}}",     // wheel / колесо.
        "gun": "{{l10n:gun}}",         // gun / орудие.
        "unknown": ""                  // unknown / неизвестно.
      },
      // Team attachment of the targets (macro {{team-dmg}}).
      // Командная принадлежность цели (макрос {{team-dmg}}).
      "team-dmg": {
        "ally-dmg": "",  // ally / союзник.
        "enemy-dmg": "", // enemy / противник.
        "player": "",    // self damage / урон по себе.
        "unknown": ""    // unknown / неизвестно.
      },
      // Color by team attachment of the targets (macro {{c:team-dmg}}).
      // Цвет по командной принадлежности цели (макрос {{c:team-dmg}}).
      "c:team-dmg": {
        "ally-dmg": "#00EAFF",  // ally / союзник.
        "enemy-dmg": "#CCCCCC", // enemy / противник.
        "player": "#228855",    // self damage / урон по себе.
        "unknown": "#CCCCCC"    // unknown / неизвестно.
      },
      // Shell currency (macro {{costShell}}).
      // Валюта снаряда (макрос {{costShell}}).
      "costShell": {
        "gold-shell": "",   // gold / золото.
        "silver-shell": "", // credits / кредиты.
        "unknown": ""       // unknown / неизвестно.
      },
      // Color by shell currency (macro {{c:costShell}}).
      // Цвет по валюте снаряда (макрос {{c:costShell}}).
      "c:costShell": {
        "gold-shell":   "#FFCC66", // gold / золото.
        "silver-shell": "#CCCCCC", // credits / кредиты.
        "unknown":      "#FFFFFF"  // unknown / неизвестно.
      },
      // List of hits format (macros allowed, see macros.txt).
      // Формат лога попаданий (допускаются макроподстановки, см. macros.txt)
      "formatHistory": "<textformat leading='-4' tabstops='[20,50,90,205]'><font size='12'>\u00D7{{n-player}}:</font><tab><font color='{{c:dmg-kind}}'>{{dmg}}</font><tab>| {{dmg-player}}<tab>|<font color='{{c:vtype}}'>{{vehicle}}</font> <font face='xvm' size='15' color='#FF0000'>{{alive? |{{blownup?&#x7C;|<font size='19'>&#x77;</font>}}}}</font><tab>|{{name%.15s~..}} <font alpha='#A0'>{{clan}}</font></textformat>"
    },
    // Log of applied damage (alternative mode).
    // Лог нанесенного урона (альтернативный режим).
    "logAlt": {
      "$ref": { "path":"hitLog.log" },
      "formatHistory": ""
      //"formatHistory": "<textformat leading='-4' tabstops='[20,50,90,205]'><font size='12'>\u00D7{{n-player}}:</font><tab><font color='{{c:dmg-kind}}'>{{dmg-ratio~%}}</font><tab>| {{dmg-ratio-player~%}}<tab>|<font color='{{c:vtype}}'>{{vehicle}}</font> <font face='xvm' size='15' color='#FF0000'>{{alive? |{{blownup?&#x7C;|<font size='19'>&#x77;</font>}}}}</font><tab>|{{name%.15s~..}} <font alpha='#A0'>{{clan}}</font></textformat>"
    },
    // Background of the log of applied damage.
    // Подложка лога нанесенного урона.
    "logBackground": {
      "$ref": { "path":"hitLog.log" },
      "formatHistory": "<img height='17' width='310' src='xvm://res/icons/damageLog/{{alive?no_dmg|dmg}}.png'>"
    },
    // Background of the log of applied damage (alternative mode).
    // Подложка лога нанесенного урона (альтернативный режим).
    "logAltBackground": {
      "$ref": { "path":"hitLog.log" },
      "formatHistory": ""
      //"<img height='20' width='310' src='xvm://res/icons/damageLog/{{alive?no_dmg|dmg}}.png'>"
    }
  }
}
