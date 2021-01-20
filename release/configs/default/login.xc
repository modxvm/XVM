/**
 * Parameters for login screen.
 * Параметры экрана логина.
 */
{
  "login": {
    // Auto enter to the game.
    // Автоматический вход в игру.
    "autologin": false,
    // Auto confirm old replays playing.
    // Автоматически подтверждать проигрывание старых реплеев.
    "confirmOldReplays": false,
    // Do not show the specified servers in the servers list, for example, ["RU1", "RU3"].
    // Не показывать заданные серверы в выпадающем списке серверов, например, ["RU1", "RU3"].
    "disabledServers": [],
    // Ping servers.
    // Пинг серверов.
    "pingServers": {
      // true - enable display of ping to the servers.
      // true - показывать пинг до серверов.
      "enabled": false,
      // Update interval, in ms.
      // Интервал обновления, в мс.
      "updateInterval": 10000,
      // Axis field coordinates.
      // Положение поля по осям.
      "x": 5,
      "y": 40,
      // Horizontal alignment of field at screen ("left", "center", "right").
      // Горизонтальное выравнивание поля на экране ("left", "center", "right").
      "hAlign": "left",
      // Vertical alignment of field at screen ("top", "center", "bottom").
      // Вертикальное выравнивание поля на экране ("top", "center", "bottom").
      "vAlign": "top",
      // Transparency (from 0 to 100).
      // Прозрачность (от 0 до 100).
      "alpha": 80,
      // If set, draw image at background.
      // Фоновое изображение, если задано.
      // example: "bgImage": "cfg://My/img/my.png",
      "bgImage": null,
      // Server to response time text delimiter.
      // Разделитель сервера от времени отклика.
      "delimiter": ": ",
      // Maximum number of column rows.
      // Максимальное количество строк одной колонки.
      "maxRows": 3,
      // Gap between columns.
      // Пространство между колонками.
      "columnGap": 10,
      // Leading between lines.
      // Пространство между строками.
      "leading": 0,
      // true - show title "Ping".
      // true - показывать заголовок "Пинг".
      "showTitle": true,
      // true - show server names in list.
      // true - показывать названия серверов в списке.
      "showServerName": true,
      // Expand server names to this amount of symbols. recommended to use monospace font if this option is set.
      // Расширить названия серверов до данного количества символов. рекомендуется использовать моноширинный шрифт если данная опция задана.
      "minimalNameLength": 4,
      // Expand values to this amount of symbols. recommended to use monospace font if this option is set.
      // Расширить значения до данного количества символов. рекомендуется использовать моноширинный шрифт если данная опция задана.
      "minimalValueLength": 0,
      // Text to show in case of error.
      // Текст показываемый в случае ошибки.
      "errorString": "--",
      // List of ignored servers, for example, ["RU1", "RU3"].
      // Список игнорируемых серверов, например, ["RU1", "RU3"].
      "ignoredServers": [],
      // Text style.
      // Стиль текста.
      "fontStyle": {
        // Font name.
        // Название шрифта.
        "name": "$TextFont",
        "size": 12,      // Размер
        "bold": false,   // Жирный
        "italic": false, // Курсив
        // Different colors depending on server response time.
        // Разные цвета в зависимости от времени отклика сервера.
        "color": {
          "great": "0xFFCC66", // Отличный
          "good":  "0xE5E4E1", // Хороший
          "poor":  "0x96948F", // Так себе
          "bad":   "0xD64D4D"  // Плохой
        },
        // Color for server name and delimiter (for example, "0x8080FF"). Empty string "" - use same color as online value.
        // Цвет для названия сервера и разделителя (например, "0x8080FF"). Пустая строка "" - использовать цвет значения онлайна.
        "serverColor": ""
      },
      // Threshold values defining response quality.
      // Пороговые значения, определяющие качество отклика.
      "threshold": {
        // Below this value response is great.
        // До этого значения отклик отличный.
        "great": 35,
        // Below this value response is good.
        // До этого значения отклик хороший.
        "good": 60,
        // Below this value response is poor.
        // До этого значения отклик так себе.
        "poor": 100
        // Values above define bad response.
        // Значения более считаются плохим откликом.
      },
      // Shadow options.
      // Параметры тени.
      "shadow": {
        // false - no shadow.
        // false - без тени.
        "enabled": true,
        "distance": 0,       // (in pixels)    / offset distance / дистанция смещения
        "angle": 0,          // (0.0 .. 360.0) / offset angle    / угол смещения
        "color": "0x000000", // "0xXXXXXX"     / color           / цвет
        "alpha": 70,         // (0 .. 100)     / opacity         / прозрачность
        "blur": 4,           // (0.0 .. 255.0) / blur            / размытие
        "strength": 2        // (0.0 .. 255.0) / intensity       / интенсивность
      }
    },
    "onlineServers": {
      // true - enable display online of servers.
      // true - показывать онлайн серверов.
      "enabled": false,
      // Axis field coordinates.
      // Положение поля по осям.
      "x": -5,
      "y": 40,
      // Horizontal alignment of field at screen ("left", "center", "right").
      // Горизонтальное выравнивание поля на экране ("left", "center", "right").
      "hAlign": "right",
      // Vertical alignment of field at screen ("top", "center", "bottom").
      // Вертикальное выравнивание поля на экране ("top", "center", "bottom").
      "vAlign": "top",
      // Transparency (from 0 to 100).
      // Прозрачность (от 0 до 100).
      "alpha": 80,
      // If set, draw image at background.
      // Фоновое изображение, если задано.
      // example: "bgImage": "cfg://My/img/my.png",
      "bgImage": null,
      // Server to online text delimiter.
      // Разделитель сервера от онлайна.
      "delimiter": ": ",
      // Maximum number of column rows.
      // Максимальное количество строк одной колонки.
      "maxRows": 3,
      // Gap between columns.
      // Пространство между колонками.
      "columnGap": 10,
      // Leading between lines.
      // Пространство между строками.
      "leading": 0,
      // true - show title "Online".
      // true - показывать заголовок "Онлайн".
      "showTitle": true,
      // true - show server names in list.
      // true - показывать названия серверов в списке.
      "showServerName": true,
      // Expand server names to this amount of symbols. recommended to use monospace font if this option is set.
      // Расширить названия серверов до данного количества символов. рекомендуется использовать моноширинный шрифт если данная опция задана.
      "minimalNameLength": 4,
      // Expand values to this amount of symbols. recommended to use monospace font if this option is set.
      // Расширить значения до данного количества символов. рекомендуется использовать моноширинный шрифт если данная опция задана.
      "minimalValueLength": 0,
      // Text to show in case of error.
      // Текст показываемый в случае ошибки.
      "errorString": "--k",
      // List of ignored servers, for example, ["RU1", "RU3"].
      // Список игнорируемых серверов, например, ["RU1", "RU3"].
      "ignoredServers": [],
      // Text style.
      // Стиль текста.
      "fontStyle": {
        // Font name.
        // Название шрифта.
        "name": "$TextFont",
        "size": 12,      // Размер
        "bold": false,   // Жирный
        "italic": false, // Курсив
        // Different colors depending on people online.
        // Разные цвета в зависимости от количества игроков.
        "color": {
          "great": "0xFFCC66", // Отличный
          "good":  "0xE5E4E1", // Хороший
          "poor":  "0x96948F", // Так себе
          "bad":   "0xD64D4D"  // Плохой
        },
        // Color for server name and delimiter (for example, "0x8080FF"). Empty string "" - use same color as online value.
        // Цвет для названия сервера и разделителя (например, "0x8080FF"). Пустая строка "" - использовать цвет значения онлайна.
        "serverColor": ""
      },
      // Threshold values defining server online and thus shorter battle queue.
      // Пороговые значения, определяющие количество человек онлайн и следовательно меньшую очередь в бой.
      "threshold": {
        "great": 30000,
        "good": 10000,
        "poor": 3000
        // Below this value the queue might be long.
        // Ниже этого значения очередь может быть долгой.
      },
      // Shadow options.
      // Параметры тени.
      "shadow": {
        "enabled": true,
        "distance": 0,
        "angle": 0,
        "color": "0x000000",
        "alpha": 70,
        "blur": 4,
        "strength": 2
      }
    },
    // Parameters for widgets
    // Параметры виджетов
    "widgets": ${"widgets.xc":"widgets.login"}
  }
}
