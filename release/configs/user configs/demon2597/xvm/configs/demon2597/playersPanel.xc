/**
 * Parameters of the Players Panels ("ears").
 * Параметры панелей игроков ("ушей").
 */
{
  "playersPanel": {
    // Opacity percentage of the panels. 0 - transparent, 100 - opaque.
    // Прозрачность в процентах ушей. 0 - прозрачные, 100 - не прозрачные.
    "alpha": 40,
    // Opacity percentage of icons in the panels. 0 - transparent ... 100 - opaque.
    // Прозрачность в процентах иконок в ушах. 0 - прозрачные, 100 - не прозрачные.
    "iconAlpha": 100,
    // true - Disable Platoon icons.
    // true - убрать отображение иконки взвода.
    "removeSquadIcon": false,
    // Display options for Team/Clan logos (see battleLoading.xc).
    // Параметры отображения иконки игрока/клана (см. battleLoading.xc).
    "clanIcon": {
      "show": false,
      "x": 0,
      "y": 6,
      "xr": 0,
      "yr": 6,
      "w": 16,
      "h": 16,
      "alpha": 90
    },
    // Enemy spotted status marker at right side panel.
    // Маркер статуса засвета в правой боковой панели списка игроков.
    "enemySpottedMarker": {
      // false - Disable.
      // false - отключить.
      "enabled": true,
      // Offset relative to level icon (by X, Y).
      // Смещение относительно иконки уровня танка (по X, Y).
      "Xoffset": -44,
      "Yoffset": -6,
      // Формат.
      "format": {
        // Never seen this enemy.
        // Этот враг никогда не светился.
         "neverSeen": "<img src='xvmres://demon2597/img/neverseen.png' width='23' height='20'>",
        // This enemy was seen atleast once.
        // Этот враг светился хотя бы один раз и отмечен на миникарте как потерянный.
        "lost": "",
        // Enemy currently revealed at minimap.
        // Виден на миникарте прямо сейчас.
         "revealed": "<img src='xvmres://demon2597/img/revealed.png' width='23' height='20'>",
        // Dead enemy.
        // Уничтоженный враг.
        "dead": "",
        // Artillery specific values.
        // Специфичные значения для артиллерии.
        "artillery": {
           "neverSeen": "<img src='xvmres://demon2597/img/neverseen.png' width='23' height='20'>",
          "lost": "",
           "revealed": "<img src='xvmres://demon2597/img/revealed.png' width='23' height='20'>",
          "dead": ""
        }
      }
    },
    // Options for the "medium" panels - the first of the medium panels.
    // Режим ушей "medium" - первые средние уши в игре.
    "medium": {
      // Width of the player's name column, 0-250. Default is 46.
      // Ширина поля имени игрока, 0-250. По умолчанию: 46.
      "width": 130,
      // Display format for the left panel (macros allowed, see readme-en.txt).
      // Формат отображения для левой панели (допускаются макроподстановки, см. readme-ru.txt).
      "formatLeft": "  <font color='{{c:xeff}}'>{{name}}</font> <font size='13' >{{clannb}}</font>",
      // Display format for the right panel (macros allowed, see readme-en.txt).
      // Формат отображения для правой панели (допускаются макроподстановки, см. readme-ru.txt).
      "formatRight": "<font size='13' >{{clannb}}</font> <font color='{{c:xeff}}'>{{name}}</font>  <font size='0'>."
    },
    // Options for the "medium2" panels - the second of the medium panels.
    // Режим ушей "medium2" - вторые средние уши в игре.
    "medium2": {
      // Width of the vehicle name column, 0-250. Default is 65.
      // Ширина поля названия танка, 0-250. По умолчанию: 65.
      "width": 20,
      // Display format for the left panel (macros allowed, see readme-en.txt).
      // Формат отображения для левой панели (допускаются макроподстановки, см. readme-ru.txt).
      "formatLeft": "<font face='PartnerCondensed Mono'  color='{{c:xeff}}'>{{xeff}}</font>",
      // Display format for the right panel (macros allowed, see readme-en.txt).
      // Формат отображения для правой панели (допускаются макроподстановки, см. readme-ru.txt).
      "formatRight": "<font face='PartnerCondensed Mono'  color='{{c:xeff}}'>{{xeff}}</font>"
    },
    // Options for the "large" panels - the widest panels.
    // Режим ушей "large" - широкие уши в игре.
    "large": {
      // Width of the player's name column, 0-250. Default is 170.
      // Ширина поля имени игрока, 0-250. По умолчанию: 170.
      "width": 140,
      // Display format for player nickname (macros allowed, see readme-en.txt).
      // Формат отображения имени игрока (допускаются макроподстановки, см. readme-ru.txt).
      "nickFormatLeft": "<font face='PartnerCondensed Mono' size='13' color='{{c:kb}}'>{{kb:3}}</font> {{name}} <font size='13' color='#FFCC66'>{{clannb}}</font>",
      "nickFormatRight": "<font size='13' color='#FFCC66'>{{clannb}}</font> {{name}} <font face='PartnerCondensed Mono' size='13' color='{{c:kb}}'>{{kb:3}}</font>",
      // Display format for vehicle name (macros allowed, see readme-en.txt).
      // Формат отображения названия танка (допускаются макроподстановки, см. readme-ru.txt).
      "vehicleFormatLeft": "<font face='PartnerCondensed Mono'  color='{{c:xeff}}'>{{xeff}}</font>",
      "vehicleFormatRight": "<font face='PartnerCondensed Mono'  color='{{c:xeff}}'>{{xeff}}</font>"
    }
  }
}
