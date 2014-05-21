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
    "iconAlpha": 100,
    // true - Disable Platoon icons.
    // true - убрать отображение иконки взвода.
    "removeSquadIcon": false,
    // true - Remove the Players Panel mode switcher (buttons for changing size).
    // true - убрать переключатель режимов ушей мышкой.
    "removePanelsModeSwitcher": false,
    // Start panels mode. Possible values: "none", "short", "medium", "medium2", "large".
    // Начальный режим ушей. Возможные значения: "none", "short", "medium", "medium2", "large".
    "startMode": "large",
    // Display options for Team/Clan logos (see battleLoading.xc).
    // Параметры отображения иконки игрока/клана (см. battleLoading.xc).
    "clanIcon": {
      "show": true,
      "x": 0,
      "y": 6,
      "xr": 0,
      "yr": 6,
      "w": 16,
      "h": 16,
      "alpha": 90
    },
    // Enemy spotted status marker at right side panel.
    // This feature depends on enabled XVM minimap mod
    // Маркер статуса засвета в правой боковой панели списка игроков.
    // Фича зависит от включенного XVM мода миникарты
    "enemySpottedMarker": {
      // false - Disable.
      // false - отключить.
      "enabled": false,
      // Offset relative to level icon (by X, Y).
      // Смещение относительно иконки уровня танка (по X, Y).
      "Xoffset": 15,
      "Yoffset": 0,
      // Формат.
      "format": {
        // Never seen this enemy.
        // Этот враг никогда не светился.
        "neverSeen": "<font face='$FieldFont' size='24' color='#DEDEDE'>*</font>",
        // This enemy was seen at least once.
        // Этот враг светился хотя бы один раз и отмечен на миникарте как потерянный.
        "lost": "",
        // Enemy currently revealed at minimap.
        // Виден на миникарте прямо сейчас.
        "revealed": "",
        // Dead enemy.
        // Уничтоженный враг.
        "dead": "",
        // Artillery specific values.
        // Специфичные значения для артиллерии.
        "artillery": {
          "neverSeen": "<font face='$FieldFont' size='24' color='#DEDEDE'>*</font>",
          "lost": "",
          "revealed": "",
          "dead": ""
        }
      }
    },
    // Options for the "none" panels - empty panels.
    // Режим ушей "none" - пустые уши.
    "none": {
      // Extra fields.
      // Дополнительные поля.
      "extraFields": {
        "leftPanel": {
          "x": 0, // from left side of screen
          "y": 65,
          "width": 350,
          "height": 25,
          // Set of formats for left panel
          // Набор форматов для левой панели
          // example:
          // "format": [
          //   // simple format (just a text)
          //   "{{nick}}",
          //   // extended format
          //   { "x": 20, "y": 10, "border": 1, "borderColor": "0xFFFFFF", "format": "{{nick}}" }
          //   // fields available for extended format (all fields are optional):
          //   //   "format"
          //   //
          //   //   "x" (macros allowed)
          //   //   "y" (macros allowed)
          //   //   "w" (macros allowed)
          //   //   "h" (macros allowed)
          //   //   "alpha" (0..100) (macros allowed)
          //   //   "rotation" (0..360) (macros allowed)
          //   //
          //   //   "align" (left(*default for left panel), center, right(*default for right panel))
          //   //   "valign" (top(*), bottom, center)
          //   //   "borderColor" (macros allowed)
          //   //   "bgColor" (macros allowed)
          //   //   "antiAliasType" (advanced(*) or normal
          //   //   "shadow": {
          //   //     "distance" (in pixels)
          //   //     "angle"    (0.0 .. 360.0)
          //   //     "color"
          //   //     "alpha"    (0.0 .. 1.0)
          //   //     "blur"     (0.0 .. 255.0)
          //   //     "strength" (0.0 .. 255.0)
          //   //    }
          // ]
          "formats": []
        },
        "rightPanel": {
          "x": 0, // from right side of screen
          "y": 65,
          "width": 350,
          "height": 25,
          // Set of formats for right panel (extended format supported, see above)
          // Набор форматов для правой панели (поддерживается расширенный формат, см. выше)
          "formats": []
        }
      }
    },
    // Options for the "short" panels - panels with frags and vehicle icon.
    // Режим ушей "short" - короткие уши (фраги и иконка танка).
    "short": {
      // Extra fields. Each field have size 350x25. Fields are placed one above the other.
      // Дополнительные поля. Каждое поле имеет размер 350x25. Поля располагаются друг над другом.
      // Set of formats for left panel (extended format supported, see above)
      // Набор форматов для левой панели (поддерживается расширенный формат, см. выше)
      "extraFieldsLeft": [],
      // Set of formats for right panel (extended format supported, see above)
      // Набор форматов для правой панели (поддерживается расширенный формат, см. выше)
      "extraFieldsRight": []
    },
    // Options for the "medium" panels - the first of the medium panels.
    // Режим ушей "medium" - первые средние уши в игре.
    "medium": {
      // Minimum width of the player's name column, 0-250. Default is 46.
      // Минимальная ширина поля имени игрока, 0-250. По умолчанию: 46.
      "width": 46,
      // Display format for the left panel (macros allowed, see readme-en.txt).
      // Формат отображения для левой панели (допускаются макроподстановки, см. readme-ru.txt).
      "formatLeft": "<font color='{{c:xwn8}}'>{{nick}}</font>",
      // Display format for the right panel (macros allowed, see readme-en.txt).
      // Формат отображения для правой панели (допускаются макроподстановки, см. readme-ru.txt).
      "formatRight": "<font color='{{c:xwn8}}'>{{nick}}</font>",
      // Extra fields. Each field have size 350x25. Fields are placed one above the other.
      // Дополнительные поля. Каждое поле имеет размер 350x25. Поля располагаются друг над другом.
      // Set of formats for left panel (extended format supported, see above)
      // Набор форматов для левой панели (поддерживается расширенный формат, см. выше)
      "extraFieldsLeft": [],
      // Set of formats for right panel (extended format supported, see above)
      // Набор форматов для правой панели (поддерживается расширенный формат, см. выше)
      "extraFieldsRight": []
    },
    // Options for the "medium2" panels - the second of the medium panels.
    // Режим ушей "medium2" - вторые средние уши в игре.
    "medium2": {
      // Maximum width of the vehicle name column, 0-250. Default is 65.
      // Максимальная ширина названия танка, 0-250. По умолчанию: 65.
      "width": 65,
      // Display format for the left panel (macros allowed, see readme-en.txt).
      // Формат отображения для левой панели (допускаются макроподстановки, см. readme-ru.txt).
      "formatLeft": "<font color='{{c:xwn8}}'>{{vehicle}}</font>",
      // Display format for the right panel (macros allowed, see readme-en.txt).
      // Формат отображения для правой панели (допускаются макроподстановки, см. readme-ru.txt).
      "formatRight": "<font color='{{c:xwn8}}'>{{vehicle}}</font>",
      // Extra fields. Each field have size 350x25. Fields are placed one above the other.
      // Дополнительные поля. Каждое поле имеет размер 350x25. Поля располагаются друг над другом.
      // Set of formats for left panel (extended format supported, see above)
      // Набор форматов для левой панели (поддерживается расширенный формат, см. выше)
      "extraFieldsLeft": [],
      // Set of formats for right panel (extended format supported, see above)
      // Набор форматов для правой панели (поддерживается расширенный формат, см. выше)
      "extraFieldsRight": []
    },
    // Options for the "large" panels - the widest panels.
    // Режим ушей "large" - широкие уши в игре.
    "large": {
      // Minimum width of the player's name column, 0-250. Default is 170.
      // Минимальная ширина имени игрока, 0-250. По умолчанию: 170.
      "width": 170,
      // Display format for player nickname (macros allowed, see readme-en.txt).
      // Формат отображения имени игрока (допускаются макроподстановки, см. readme-ru.txt).
      "nickFormatLeft": "<font color='{{c:xwn8}}'>{{xwn8}}</font> {{nick}}",
      "nickFormatRight": "{{nick}} <font color='{{c:xwn8}}'>{{xwn8}}</font>",
      // Display format for vehicle name (macros allowed, see readme-en.txt).
      // Формат отображения названия танка (допускаются макроподстановки, см. readme-ru.txt).
      "vehicleFormatLeft": "{{vehicle}}",
      "vehicleFormatRight": "{{vehicle}}",
      // Extra fields. Each field have size 350x25. Fields are placed one above the other.
      // Дополнительные поля. Каждое поле имеет размер 350x25. Поля располагаются друг над другом.
      // Set of formats for left panel (extended format supported, see above)
      // Набор форматов для левой панели (поддерживается расширенный формат, см. выше)
      "extraFieldsLeft": [],
      // Set of formats for right panel (extended format supported, see above)
      // Набор форматов для правой панели (поддерживается расширенный формат, см. выше)
      "extraFieldsRight": []
    }
  }
}
