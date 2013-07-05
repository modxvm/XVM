/**
 * Parameters for login screen
 * Параметры экрана логина
 */
{
  "fontStyle": {		// Разные цвета в зависимости от времени отклика сервера
        "my": {			// Вариант 1
		  "$ref": { "file": "hangar.xc", "path": "hangar.pingServers.fontStyle" },
		  "size": 20, // Размер
          "bold": true,  // Жирный
			"color": {		// Разные цвета в зависимости от времени отклика сервера
			  "great": "0x00FF21",	// Отличный	оригинал = 0x33FFCC, мое = 0x00FF21, рейтинг = 0xD042F3
			  "good": "0x0094FF",	// Хороший	оригинал = 0x99FF33, мое = 0x0094FF, рейтинг = 0x60FF00
			  "poor": "0xFF006E",	// Так себе	оригинал = 0xFFFF33, мое = 0xFF006E, рейтинг = 0xFE7903
			  "bad": "0xFF6A00"		// Плохой	оригинал = 0xFF7733, мое = 0xFF6A00, рейтинг = 0xFE0E00
			}
		},
		"my2": {		// Вариант 2
		  "$ref": { "file": "hangar.xc", "path": "hangar.pingServers.fontStyle" },
		  "size": 20, // Размер
          "bold": true,  // Жирный
			"color": {
			  "great": "0xD042F3",
			  "good": "0x60FF00",
			  "poor": "0xFE7903",
			  "bad": "0xFE0E00"
		  }
		}
  },

  "login": {
    // Ping servers; works only with xvm-stat.exe
    // Пинг серверов; работает только с xvm-stat.exe
    "pingServers": {
      "$ref": { "file": "hangar.xc", "path": "hangar.pingServers" },
      // true - Enable display of ping to the servers
      // true - показывать пинг до серверов
      "enabled": true,
      // Axis field coordinates
      // Положение поля по осям
      "x": 15,
      "y": 30,
      "maxRows": 4,
	  "fontStyle": {
	  "$ref": { "file": "login.xc", "path": "fontStyle.my2" }	// ВНУТРИНИЕ ОБРАЩЕНИЕ К "fontStyle"
	  }
    }
  }
}