/**
 * Parameters for hangar
 * Параметры ангара
 */
{
  "hangar": {
    // Show "Buy premium" button
    // Показать кнопку "Купить премиум"
    "showBuyPremiumButton": true,
    // Show "Premium shop" button
    // Показать кнопку "Премиум магазин"
    "showPremiumShopButton": true,
    // Show "General chat" button
    // Показать кнопку "Общий чат"
    "showGeneralChatButton": true,
    // true - enable locker for gold
    // true - включить замок для золота
    "enableGoldLocker": false,
    // true - enable locker for free XP
    // true - включить замок для свободного опыта
    "enableFreeXpLocker": false,
    // Show/hide server info or change its parameters
    // Показать/спрятать информацию о сервере, или изменить ее параметры
    "serverInfo": {
      // Show server info in hangar.
      // Показывать информацию о сервере в ангаре.
      "enabled": true,
      // Transparency in percents [0..100].
      // Прозрачность в процентах [0..100].
      "alpha": 100,
      // Rotation in degrees [0..360].
      // Угол поворота в градусах [0..360].
      "rotation": 0,
      // X offset
      // Смещение по оси X
      "offsetX": 0,
      // Y offset
      // Смещение по оси Y
      "offsetY": 0
    },
    // true - enable crew auto return function
    // true - включить функцию автовозврата экипажа
    "enableCrewAutoReturn": true,
    // true - return crew check box is selected by default
    // true - включить галочку возврата экипажа по умолчанию
    "crewReturnByDefault": false,
    // Number of perks to show without grouping
    // Количество перков, которые отображаются без группировки
    "crewMaxPerksCount": 8,
    // Show/hide common quests button or change its parameters
    // Показать/спрятать кнопку общих задач, или изменить ее параметры
    "commonQuests": {
      // Show common quests button in hangar.
      // Показывать кнопку общих задач в ангаре.
      "enabled": true,
      // Transparency in percents [0..100].
      // Прозрачность в процентах [0..100].
      "alpha": 100,
      // Rotation in degrees [0..360].
      // Угол поворота в градусах [0..360].
      "rotation": 0,
      // X offset
      // Смещение по оси X
      "offsetX": 0,
      // Y offset
      // Смещение по оси Y
      "offsetY": 0
    },
    // Show/hide personal quests button or change its parameters
    // Показать/спрятать кнопку персональных задач, или изменить ее параметры
    "personalQuests": {
      // Show personal quests button in hangar.
      // Показывать кнопку персональных задач в ангаре.
      "enabled": true,
      // Transparency in percents [0..100].
      // Прозрачность в процентах [0..100].
      "alpha": 100,
      // Rotation in degrees [0..360].
      // Угол поворота в градусах [0..360].
      "rotation": 0,
      // X offset
      // Смещение по оси X
      "offsetX": 0,
      // Y offset
      // Смещение по оси Y
      "offsetY": 0
    },
    // Show/hide current vehicle name, type and level or change their parameters
    // Показать/спрятать название, тип и уровень текущего танка, или изменить их параметры
    "vehicleName": {
      // Show current vehicle name, type and level in hangar.
      // Показывать название, тип и уровень текущего танка в ангаре.
      "enabled": true,
      // Transparency in percents [0..100].
      // Прозрачность в процентах [0..100].
      "alpha": 100,
      // Rotation in degrees [0..360].
      // Угол поворота в градусах [0..360].
      "rotation": 0,
      // X offset
      // Смещение по оси X
      "offsetX": 0,
      // Y offset
      // Смещение по оси Y
      "offsetY": 0
    },
    // true - enable removable equipment auto return (Camouflage net, Stereoscope, Toolbox)
    // true - включить автовозврат съемного оборудования (Маскировочная сеть, Стереотруба, Ящик с инструментами)
    "enableEquipAutoReturn": false,
    // true - make vehicle not ready for battle if low ammo
    // true - сделать машину не готовой к битве если мало снарядов
    "blockVehicleIfLowAmmo": false,
    // Below this percentage, ammo is low. (0 - 100)
    // Ниже этого процента, снарядов считается мало. (0 - 100)
    "lowAmmoPercentage": 20,
    // Behavior of the system channel notifications button on new notifications:
    //   none - do nothing
    //   blink - blink button
    //   full - blink and show counter (default client behavior)
    // Поведение кнопки оповещений системного канала при новых оповещениях:
    //   none - ничего не делать
    //   blink - мигать кнопкой
    //   full - мигать и показать счетчик (поведение клиента по-умолчанию)
    "notificationsButtonType": "full",
    // true - hide price button in tech tree
    // true - прятать кнопку с ценой в дереве исследований
    "hidePricesInTechTree": false,
    // true - show mastery mark in tech tree
    // true - показывать знак мастерства в дереве исследований
    "masteryMarkInTechTree": true,
    // true - allow to consider the exchange of experience with gold in tech tree
    // true - разрешить учитывать обмен опыта за золото в дереве исследований
    "allowExchangeXPInTechTree": true,
    // true - show flags in barracks
    // true - показывать флаги в казарме
    "barracksShowFlags": true,
    // true - show skills in barracks
    // true - показывать умения в казарме
    "barracksShowSkills": true,
    // true - restore selected battle type on switching to another server (only random, frontline and rank battle modes)
    // true - восстанавливать выбранный тип боя при переключении на другой сервер (только рандом, Линия Фронта и ранговые бои)
    "restoreBattleType": false,
    // Ping servers
    // Пинг серверов
    "pingServers": {
      // true - enable display of ping to the servers
      // true - показывать пинг до серверов
      "enabled": false,
      // Update interval, in ms
      // Интервал обновления, в мс
      "updateInterval": 10000,
      // Axis field coordinates
      // Положение поля по осям
      "x": 85,
      "y": 52,
      // Horizontal alignment of field at screen ("left", "center", "right").
      // Горизонтальное выравнивание поля на экране ("left", "center", "right").
      "hAlign": "left",
      // Vertical alignment of field at screen ("top", "center", "bottom").
      // Вертикальное выравнивание поля на экране ("top", "center", "bottom").
      "vAlign": "top",
      // Transparency
      // Прозрачность от 0 до 100
      "alpha": 80,
      // If set, draw image at background.
      // Фоновое изображение, если задано.
      // example: "bgImage": "cfg://My/img/my.png",
      "bgImage": null,
      // Server to response time text delimiter
      // Разделитель сервера от времени отклика
      "delimiter": ": ",
      // Maximum number of column rows
      // Максимальное количество строк одной колонки
      "maxRows": 2,
      // Gap between columns
      // Пространство между колонками
      "columnGap": 3,
      // Leading between lines.
      // Пространство между строками
      "leading": 2,
      // layer - "bottom", "normal" (default), "top".
      // слой - "bottom", "normal" (по-умолчанию), "top".
      "layer": "normal",
      // true - show title "Ping"
      // true - показывать заголовок "Пинг"
      "showTitle": true,
      // true - show server names in list
      // true - показывать названия серверов в списке
      "showServerName": true,
      // expand server names to this amount of symbols. recommended to use monospace font if this option is set.
      // расширить названия серверов до данного количества символов. рекомендуется использовать моноширинный шрифт если данная опция задана.
      "minimalNameLength": 4,
      // expand values to this amount of symbols. recommended to use monospace font if this option is set.
      // расширить значения до данного количества символов. рекомендуется использовать моноширинный шрифт если данная опция задана.
      "minimalValueLength": 0,
      // text to show in case of error
      // текст показываемый в случае ошибки
      "errorString": "--",
      // List of ignored servers, for example, ["RU1", "RU3"]
      // Список игнорируемых серверов, например, ["RU1", "RU3"]
      "ignoredServers": [],
      // Text style
      // Стиль текста
      "fontStyle": {
        // Font name
        // Название шрифта
        "name": "$FieldFont",
        "size": 12,         // Размер
        "bold": false,      // Жирный
        "italic": false,    // Курсив
        // Different colors depending on server response time
        // Разные цвета в зависимости от времени отклика сервера
        "color": {
          "great": "0xFFCC66",  // Отличный
          "good":  "0xE5E4E1",  // Хороший
          "poor":  "0x96948F",  // Так себе
          "bad":   "0xD64D4D"   // Плохой
        },
        // Color for server name and delimiter (for example, "0x8080FF"). Empty string "" - use same color as online value
        // Цвет для названия сервера и разделителя (например, "0x8080FF"). Пустая строка "" - использовать цвет значения онлайна
        "serverColor": ""
      },
      // Text format for current server in the list, Flash HTML tags supported. "{server}" for the server value
      // Форматирование текста для текущего сервер в списке. Поддерживаются теги Flash HTML. "{server}" заменяется
      // на значение текущего сервера
      "currentServerFormat": "<b>{server}</b>",
      // Threshold values defining response quality
      // Пороговые значения, определяющие качество отклика
      "threshold": {
        // Below this value response is great
        // До этого значения отклик отличный
        "great": 35,
        // Below this value response is good
        // До этого значения отклик хороший
        "good": 60,
        // Below this value response is poor
        // До этого значения отклик так себе
        "poor": 100
        // Values above define bad response
        // Значения более считаются плохим откликом
      },
      // Shadow options
      // Параметры тени
      "shadow": {
        // false - no shadow
        // false - без тени
        "enabled": true,
        "distance": 0,             // (in pixels)     / offset distance / дистанция смещения
        "angle": 0,                // (0.0 .. 360.0)  / offset angle    / угол смещения
        "color": "0x000000",       // "0xXXXXXX"      / color           / цвет
        "alpha": 70,               // (0 .. 100)      / opacity         / прозрачность
        "blur": 4,                 // (0.0 .. 255.0)  / blur            / размытие
        "strength": 2              // (0.0 .. 255.0)  / intensity       / интенсивность
      }
    },
    "onlineServers": {
      // true - enable display online of servers
      // true - показывать онлайн серверов
      "enabled": false,
      // Axis field coordinates
      // Положение поля по осям
      "x": -3,
      "y": 51,
      // Horizontal alignment of field at screen ("left", "center", "right").
      // Горизонтальное выравнивание поля на экране ("left", "center", "right").
      "hAlign": "right",
      // Vertical alignment of field at screen ("top", "center", "bottom").
      // Вертикальное выравнивание поля на экране ("top", "center", "bottom").
      "vAlign": "top",
      // Transparency
      // Прозрачность от 0 до 100
      "alpha": 80,
      // If set, draw image at background.
      // Фоновое изображение, если задано.
      // example: "bgImage": "cfg://My/img/my.png",
      "bgImage": null,
      // Server to online text delimiter
      // Разделитель сервера от онлайна
      "delimiter": ": ",
      // Maximum number of column rows
      // Максимальное количество строк одной колонки
      "maxRows": 2,
      // Gap between columns
      // Пространство между колонками
      "columnGap": 3,
      // Leading between lines.
      // Пространство между строками
      "leading": 0,
      // layer - "bottom", "normal" (default), "top".
      // слой - "bottom", "normal" (по-умолчанию), "top".
      "layer": "normal",
      // true - show title "Online"
      // true - показывать заголовок "Онлайн"
      "showTitle": true,
      // true - show server names in list
      // true - показывать названия серверов в списке
      "showServerName": true,
      // expand server names to this amount of symbols. recommended to use monospace font if this option is set.
      // расширить названия серверов до данного количества символов. рекомендуется использовать моноширинный шрифт если данная опция задана.
      "minimalNameLength": 4,
      // expand values to this amount of symbols. recommended to use monospace font if this option is set.
      // расширить значения до данного количества символов. рекомендуется использовать моноширинный шрифт если данная опция задана.
      "minimalValueLength": 0,
      // text to show in case of error
      // текст показываемый в случае ошибки
      "errorString": "--k",
      // List of ignored servers, for example, ["RU1", "RU2"]
      // Список игнорируемых серверов, например, ["RU1", "RU2"]
      "ignoredServers": [],
      // Text style
      // Стиль текста
      "fontStyle": {
        // Font name
        // Название шрифта
        "name": "$FieldFont",
        "size": 12,         // Размер
        "bold": false,      // Жирный
        "italic": false,    // Курсив
        // Different colors depending on people online
        // Разные цвета в зависимости от количества игроков
        "color": {
          "great": "0x60ff00",  // Отличный
          "good":  "0xF8F400",  // Хороший
          "poor":  "0xFE7903",  // Так себе
          "bad":   "0xFE0E00"   // Плохой
        },
        // Color for server name and delimiter (for example, "0x8080FF"). Empty string "" - use same color as online value
        // Цвет для названия сервера и разделителя (например, "0x8080FF"). Пустая строка "" - использовать цвет значения онлайна
        "serverColor": ""
      },
      // Text format for current server in the list, Flash HTML tags supported. "{server}" for the server value
      // Форматирование текста для текущего сервер в списке. Поддерживаются теги Flash HTML. "{server}" заменяется
      // на значение текущего сервера
      "currentServerFormat": "<b>{server}</b>",
      // Threshold values defining server online and thus shorter battle queue
      // Пороговые значения, определяющие количество человек онлайн и следовательно меньшую очередь в бой
      "threshold": {
        "great": 30000,
        "good": 10000,
        "poor": 3000
        //below this value the queue might be long
        //ниже этого значения очередь может быть долгой
      },
      // Shadow options
      // Параметры тени
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
    // Parameters for tank carousel
    // Параметры карусели танков
    "carousel": ${"carousel.xc":"carousel"},
    // Parameters for widgets
    // Параметры виджетов
    "widgets": ${"widgets.xc":"widgets.lobby"}
  }
}
