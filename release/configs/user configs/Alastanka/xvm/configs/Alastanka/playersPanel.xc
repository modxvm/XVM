/**
 * Parameters of the Players Panels ("ears").
 * Параметры панелей игроков ("ушей").
 */
{
  "playersPanel": {
    // Opacity percentage of the panels. 0 - transparent, 100 - opaque.
    // Прозрачность в процентах ушей. 0 - прозрачные, 100 - не прозрачные.
    "alpha": 60,
    // Opacity percentage of icons in the panels. 0 - transparent ... 100 - opaque.
    // Прозрачность в процентах иконок в ушах. 0 - прозрачные, 100 - не прозрачные.
    "iconAlpha": 90,
    // true - Disable Platoon icons.
    // true - убрать отображение иконки взвода.
    "removeSquadIcon": false,
    // Display options for Team/Clan logos (see battleLoading.xc).
    // Параметры отображения иконки игрока/клана (см. battleLoading.xc).
    "clanIcon": {
      "show": true,
      "x": 90,
      "y": 0,
      "xr": 85,
      "yr": 0,
      "w": 24,
      "h": 24,
      "alpha": 90
    },
    // Enemy spotted status marker at right side panel.
    // This feature depends on enabled XVM minimap mod
    // Маркер статуса засвета в правой боковой панели списка игроков.
    // Фича зависит от включенного XVM мода миникарты
    "enemySpottedMarker": {
      // false - Disable.
      // false - отключить.
      "enabled": true,
      // Offset relative to level icon (by X, Y).
      // Смещение относительно иконки уровня танка (по X, Y).
      "Xoffset": -7,
      "Yoffset": 0,
      // Формат.
      "format": {
        // Never seen this enemy.
        // Этот враг никогда не светился.
        "neverSeen": "<img src='xvmres://icons/ears/1.png' width='20' height='20'>",
        // This enemy was seen atleast once.
        // Этот враг светился хотя бы один раз и отмечен на миникарте как потерянный.
        "lost": "<img src='xvmres://icons/ears/2.png' width='20' height='20'>",
        // Enemy currently revealed at minimap.
        // Виден на миникарте прямо сейчас.
        "revealed": "<img src='xvmres://icons/ears/3.png' width='20' height='20'>",
        // Dead enemy.
        // Уничтоженный враг.
        "dead": "<img src='xvmres://icons/ears/4.png' width='16' height='16'>",
        // Artillery specific values.
        // Специфичные значения для артиллерии.
        "artillery": {
          "neverSeen": "<img src='xvmres://icons/ears/1-.png' width='16' height='16'>",
          "lost": "<img src='xvmres://icons/ears/2-.png' width='16' height='16'>",
          "revealed": "<img src='xvmres://icons/ears/3-.png' width='16' height='16'>",
          "dead": "<img src='xvmres://icons/ears/4-.png' width='16' height='16'>"
        }
      }
    },
    // Options for the "medium" panels - the first of the medium panels.
    // Режим ушей "medium" - первые средние уши в игре.
    "medium": {
      // Width of the player's name column, 0-250. Default is 46.
      // Ширина поля имени игрока, 0-250. По умолчанию: 46.
      "width": 180,
      // Display format for the left panel (macros allowed, see readme-en.txt).
      // Формат отображения для левой панели (допускаются макроподстановки, см. readme-ru.txt).
      "formatLeft": "<font face='Consolas' size='13'><font color='{{c:kb}}'>{{kb:3}}</font> <font color='{{c:wn}}'>{{wn}}</font> <font color='{{c:rating}}'>{{rating:3}}</font><font color='{{c:xwn}}'>[{{xwn}}]</font></font> {{nick}}",
      // Display format for the right panel (macros allowed, see readme-en.txt).
      // Формат отображения для правой панели (допускаются макроподстановки, см. readme-ru.txt).
      "formatRight": "{{nick}} <font face='Consolas' size='13'><font color='{{c:xwn}}'>[{{xwn}}]</font><font color='{{c:rating}}'>{{rating:3}}</font> <font color='{{c:wn}}'>{{wn}}</font> <font color='{{c:kb}}'>{{kb:3}}</font></font>"
    },
    // Options for the "medium2" panels - the second of the medium panels.
    // Режим ушей "medium2" - вторые средние уши в игре.
    "medium2": {
      // Width of the vehicle name column, 0-250. Default is 65.
      // Ширина поля названия танка, 0-250. По умолчанию: 65.
      "width": 272,
      // Display format for the left panel (macros allowed, see readme-en.txt).
      // Формат отображения для левой панели (допускаются макроподстановки, см. readme-ru.txt).
      "formatLeft": "<textformat tabstops='[0,30,72,108,142,170,215]'> <font face='Consolas' size='11'>\t Р-<font color='{{c:e}}'>{{e}}</font>\t Д-<font color='{{c:tdb}}'>{{tdb}}</font>\t Ф-<font color='{{c:tfb}}'>{{tfb}}</font>\t З-<font color='{{c:tsb}}'>{{tsb}}</font>\t П-<font color='{{c:t-rating}}'>{{t-rating:3}}</font>\t Э-<font color='{{c:e}}'>{{teff}}</font>\t Б-<font color='{{c:t-battles}}'>{{t-battles:4}}</font></font></textformat>",
      // Display format for the right panel (macros allowed, see readme-en.txt).
      // Формат отображения для правой панели (допускаются макроподстановки, см. readme-ru.txt).
      "formatRight": "<textformat tabstops='[0,30,72,108,142,170,215]'> <font face='Consolas' size='11'>\t Р-<font color='{{c:e}}'>{{e}}</font>\t Д-<font color='{{c:tdb}}'>{{tdb}}</font>\t Ф-<font color='{{c:tfb}}'>{{tfb}}</font>\t З-<font color='{{c:tsb}}'>{{tsb}}</font>\t П-<font color='{{c:t-rating}}'>{{t-rating:3}}</font>\t Э-<font color='{{c:e}}'>{{teff}}</font>\t Б-<font color='{{c:t-battles}}'>{{t-battles:4}}</font></font></textformat>"
    },
    // Options for the "large" panels - the widest panels.
    // Режим ушей "large" - широкие уши в игре.
    "large": {
      // Width of the player's name column, 0-250. Default is 170.
      // Ширина поля имени игрока, 0-250. По умолчанию: 170.
      "width": 180,
      // Display format for player nickname (macros allowed, see readme-en.txt).
      // Формат отображения имени игрока (допускаются макроподстановки, см. readme-ru.txt).
      "nickFormatLeft": "<font face='Consolas' size='13'><font color='{{c:kb}}'>{{kb:3}}</font> <font color='{{c:wn}}'>{{wn}}</font> <font color='{{c:rating}}'>{{rating:3}}</font><font color='{{c:xwn}}'>[{{xwn}}]</font></font> {{nick}}",
      "nickFormatRight": "{{nick}} <font face='Consolas' size='13'><font color='{{c:xwn}}'>[{{xwn}}]</font><font color='{{c:rating}}'>{{rating:3}}</font> <font color='{{c:wn}}'>{{wn}}</font> <font color='{{c:kb}}'>{{kb:3}}</font></font>",
      // Display format for vehicle name (macros allowed, see readme-en.txt).
      // Формат отображения названия танка (допускаются макроподстановки, см. readme-ru.txt).
      "vehicleFormatLeft": "<font face='Consolas' size='13'><font color='{{c:t-battles}}'>{{t-battles:4}}</font> <font color='{{c:t-rating}}'>{{t-rating:3}}</font></font>{{hp}}",
      "vehicleFormatRight": "{{hp}}<font face='Consolas' size='13'><font color='{{c:t-rating}}'>{{t-rating:3}}</font> <font color='{{c:t-battles}}'>{{t-battles:4}}</font></font>"
    }
  }
}
