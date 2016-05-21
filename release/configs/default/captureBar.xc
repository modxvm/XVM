/**
 * Capture bar.
 * Полоса захвата.
 */
{
  "captureBar": {
    // false - Disable
    // false - Отключить
    "enabled": true,
    // Change the distance between capture bars
    // Изменение расстояния между полосами захвата
    "distanceOffset": 0,
    // Enemies capturing ally base
    // Противник захватывает базу союзников
    "enemy": {
      // Сapture bar color (default: use system color)
      // Цвет полосы захвата (по умолчанию используется системный цвет)
      "сolor": null,
      // Title textfield (upper-center)
      // Текстовое поле с заголовком (сверху, среднее)
      "title": {
        // X offset
        // Смещение по X
        "x": 0,
        // Y offset
        // Смещение по Y
        "y": -3,
        // Text format
        // Формат текста
        "format": "<font size='15' color='#FFFFFF'>{{l10n:allyBaseCapture}}</font>",
        // Full capture text format
        // Формат текста при полном захвате
        "done": "<font size='17' color='#FFCC66'>{{l10n:allyBaseCaptured}}</font>",
        // Fields shadow
        // Тень полей
        "shadow": {
          // Цвет.
          "color": "0x000000",
          // Opacity 0-100
          // Прозрачность 0-100
          "alpha": 50,
          // Blur 0-255; 6 is recommended
          // Размытие 0-255; 6 рекомендовано
          "blur": 6,
          // Intensity 0-255; 3 is recommended
          // Интенсивность 0-255; 3 рекомендовано
          "strength": 3
        }
      },
      // Vehicles count textfield (upper-left)
      // Текстовое поле с количеством танков (сверху, слева)
      "players": {
        "x": 0,
        "y": -1,
        "format": "<font color='#FFCC66'><font size='20' face='xvm'>&#x113;</font>  <b>{{cap.tanks}}</b></font>",
        "done": "<font color='#FFCC66'><font size='20' face='xvm'>&#x113;</font>  <b>{{cap.tanks}}</b></font>",
        "shadow": {
          "color": "0x000000",
          "alpha": 50,
          "blur": 6,
          "strength": 3
        }
      },
      // Timer textfield (upper-right)
      // Текстовое поле с таймером (сверху, справа)
      "timer": {
        "x": 0,
        "y": -1,
        "format": "<font color='#FFCC66'><font size='15' face='xvm'>&#x114;</font>  <b>{{cap.time}}</b></font>",
        "done": "<font color='#FFCC66'><font size='15' face='xvm'>&#x114;</font>  <b>{{cap.time}}</b></font>",
        "shadow": {
          "color": "0x000000",
          "alpha": 50,
          "blur": 6,
          "strength": 3
        }
      },
      // Capture points textfield (lower)
      // Текстовое поле с очками захвата (снизу)
      "points": {
        "x": 0,
        "y": 0,
        "format": "<font size='15' color='#FFFFFF'>{{cap.points}}</font>",
        "done": "<font size='15' color='#FFFFFF'>{{cap.points}}</font>",
        "shadow": {
          "color": "0x000000",
          "alpha": 50,
          "blur": 6,
          "strength": 3
        }
      }
    },
    // Allies capturing enemy base
    // Союзники захватывают базу противника
    "ally": {
      "сolor": null,
      "title": {
        "$ref": { "path":"captureBar.enemy.title" },
        "format": "<font size='15' color='#FFFFFF'>{{l10n:enemyBaseCapture}}</font>",
        "done": "<font size='17' color='#FFCC66'>{{l10n:enemyBaseCaptured}}</font>"
      },
      "players": ${"captureBar.enemy.players"},
      "timer": ${"captureBar.enemy.timer"},
      "points": ${"captureBar.enemy.points"}
    }
  }
}
