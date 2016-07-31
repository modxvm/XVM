/**
 * Capture bar.
 * Полоса захвата.
 */
{
  "captureBar": {
    // false - Disable
    // false - Отключить
    "enabled": true,
    // Y value (34 for vanilla client)
    // Значение Y (34 для чистого клиента)
    "y": 65,
    // Change the distance between capture bars
    // Изменение расстояния между полосами захвата
    "distanceOffset": 0,
    // Hide capture progress bar
    // Спрятать полосу прогресса захвата
    "hideProgressBar": false,
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
        "done": "<font size='15' color='#FFCC66'>{{l10n:allyBaseCaptured}}</font>",
        // Shadow options
        // Параметры тени
        "shadow": {
          // false - no shadow
          // false - без тени
          "enabled": true,
          "distance": 0,             // (in pixels)     / offset distance / дистанция смещения
          "angle": 0,                // (0.0 .. 360.0)  / offset angle    / угол смещения
          "color": "0x000000",       // "0xXXXXXX"      / color           / цвет
          "alpha": 75,               // (0 .. 100)      / opacity         / прозрачность
          "blur": 5,                 // (0.0 .. 255.0)  / blur            / размытие
          "strength": 2              // (0.0 .. 255.0)  / intensity       / интенсивность
        }
      },
      // Vehicles count textfield (upper-left)
      // Текстовое поле с количеством танков (сверху, слева)
      "players": {
        "x": 0,
        "y": -1,
        "format": "<font face='xvm' size='15' color='#FFFFFF'>&#x113;</font>  <font color='#FFCC66'><b>{{cap.tanks}}</b></font>",
        "done": "<font face='xvm' size='15' color='#FFFFFF'>&#x113;</font>  <font color='#FFCC66'><b>{{cap.tanks}}</b></font>",
        "shadow": {
          "color": "0x000000",
          "alpha": 75,
          "blur": 5,
          "strength": 2
        }
      },
      // Timer textfield (upper-right)
      // Текстовое поле с таймером (сверху, справа)
      "timer": {
        "x": 0,
        "y": -1,
        "format": "<font face='xvm' size='15' color='#FFFFFF'>&#x114;</font>  <font color='#FFCC66'><b>{{cap.time}}</b></font>",
        "done": "<font face='xvm' size='15' color='#FFFFFF'>&#x114;</font>  <font color='#FFCC66'><b>{{cap.time}}</b></font>",
        "shadow": {
          "color": "0x000000",
          "alpha": 75,
          "blur": 5,
          "strength": 2
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
          "alpha": 75,
          "blur": 5,
          "strength": 2
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
        "done": "<font size='15' color='#FFCC66'>{{l10n:enemyBaseCaptured}}</font>"
      },
      "players": ${"captureBar.enemy.players"},
      "timer": ${"captureBar.enemy.timer"},
      "points": ${"captureBar.enemy.points"}
    }
  }
}
