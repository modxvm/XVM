/**
 * Capture bar.
 * Полоса захвата.
 */
{
  "captureBar": {
    // false - disable.
    // false - отключить.
    "enabled": true,
    // Y value (34 for vanilla client).
    // Значение Y (34 для чистого клиента).
    "y": 65,
    // Change the distance between capture bars.
    // Изменение расстояния между полосами захвата.
    "distanceOffset": 0,
    // Hide capture progress bar.
    // Спрятать полосу прогресса захвата.
    "hideProgressBar": false,
    // Enemies capturing ally base.
    // Противник захватывает базу союзников.
    "enemy": {
      // Capture bar color (default: use system color).
      // Цвет полосы захвата (по умолчанию используется системный цвет).
      "color": null,
      // Title textfield (center).
      // Текстовое поле с заголовком (среднее).
      "title": {
        // X offset.
        // Смещение по X.
        "x": 0,
        // Y offset.
        // Смещение по Y.
        "y": -1,
        // Text format.
        // Формат текста.
        "format": "<font size='15' color='#FFFFFF'>{{l10n:allyBaseCapture}}</font> <font size='14' color='#F0F0F0'>({{cap.points}})</font>",
        // Full capture text format.
        // Формат текста при полном захвате.
        "done": "<font size='15' color='#FFCC66'>{{l10n:allyBaseCaptured}}</font> <font size='14' color='#F0F0F0'>({{cap.points}})</font>",
        // Shadow options.
        // Параметры тени.
        "shadow": {
          // false - no shadow.
          // false - без тени.
          "enabled": false,
          "distance": 0,       // (in pixels)    / offset distance / дистанция смещения
          "angle": 0,          // (0.0 .. 360.0) / offset angle    / угол смещения
          "color": "0x000000", // "0xXXXXXX"     / color           / цвет
          "alpha": 35,         // (0 .. 100)     / opacity         / прозрачность
          "blur": 3,           // (0.0 .. 255.0) / blur            / размытие
          "strength": 1        // (0.0 .. 255.0) / intensity       / интенсивность
        }
      },
      // Vehicles count textfield (left).
      // Текстовое поле с количеством танков (слева).
      "players": {
        "x": -225,
        "y": 0,
        "format": "<font face='xvm' size='15' color='#FFFFFF'>&#x113;</font>  <font color='#FFCC66'><b>{{cap.tanks}}</b></font>",
        "done": "<font face='xvm' size='15' color='#FFFFFF'>&#x113;</font>  <font color='#FFCC66'><b>{{cap.tanks}}</b></font>",
        "shadow": {
          "color": "0x000000",
          "alpha": 35,
          "blur": 3,
          "strength": 1
        }
      },
      // Timer textfield (right).
      // Текстовое поле с таймером (справа).
      "timer": {
        "x": 200,
        "y": 0,
        "format": "<font face='xvm' size='15' color='#FFFFFF'>&#x114;</font>  <font color='#FFCC66'><b>{{cap.time}}</b></font>",
        "done": "<font face='xvm' size='15' color='#FFFFFF'>&#x114;</font>  <font color='#FFCC66'><b>{{cap.time}}</b></font>",
        "shadow": {
          "color": "0x000000",
          "alpha": 35,
          "blur": 3,
          "strength": 1
        }
      },
      // Background field.
      // Фоновое поле.
      "background": {
        "x": 0,
        "y": 0,
        "format": "",
        "done": "",
        "shadow": {
          "enabled": false,
          "color": "0x000000",
          "alpha": 75,
          "blur": 5,
          "strength": 2
        }
      }
    },
    // Allies capturing enemy base.
    // Союзники захватывают базу противника.
    "ally": {
      "color": null,
      "title": {
        "$ref": { "path":"captureBar.enemy.title" },
        "format": "<font size='15' color='#FFFFFF'>{{l10n:enemyBaseCapture}}</font> <font size='14' color='#F0F0F0'>({{cap.points}})</font>",
        "done": "<font size='15' color='#FFCC66'>{{l10n:enemyBaseCaptured}}</font> <font size='14' color='#F0F0F0'>({{cap.points}})</font>"
      },
      "players": ${"captureBar.enemy.players"},
      "timer": ${"captureBar.enemy.timer"},
      "background": ${"captureBar.enemy.background"}
    },
    // Base capture blocked.
    // Захват базы заблокирован.
    "block": {
      "color": null,
      "title": {
        "$ref": { "path":"captureBar.enemy.title" },
        "format": "<font size='15' color='#FFFFFF'>{{l10n:baseCaptureBlocked}}</font> <font size='14' color='#F0F0F0'>({{cap.points}})</font>"
      },
      "players": ${"captureBar.enemy.players"},
      "timer": ${"captureBar.enemy.timer"},
      "background": ${"captureBar.enemy.background"}
    }
  }
}
