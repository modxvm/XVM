/**
 * Parameters for hangar
 * Параметры ангара
 */
{
  "hangar": {
    // hangar type: null (default), "premium", "basic"
    // тип ангара: null (по умолчанию), "premium", "basic"
    "hangarType": null,
    // Hangar camera settings
    // Настройки камеры в ангаре
    "camera": {
      // Minumim distance
      // Минимальное расстояние
      "minDistance": 6.5,
      // Maximum distance
      // Максимальное расстояние
      "maxDistance": 12,
      // Start distance
      // Начальное расстояние
      "startDistance": 11,
      // Camera zoom sensitivity (lower is slower)
      // Чувствительность приближения камеры (меньше - медленнее)
      "zoomSensitivity": 1
    },
    // Show "Buy premium" button
    // Показать кнопку "Купить премиум"
    "showBuyPremiumButton": true,
    // Show "Premium shop" button
    // Показать кнопку "Премиум магазин"
    "showPremiumShopButton": true,
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
      // Cмещение по оси X
      "offsetX": 0,
      // Y offset
      // Cмещение по оси Y
      "offsetY": 0
    },
    // true - Enable crew auto return function
    // true - Включить функцию автовозврата экипажа
    "enableCrewAutoReturn": true,
    // true - Return crew check box is selected by default
    // true - Включить галочку возврата экипажа по умолчанию
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
      // Cмещение по оси X
      "offsetX": 0,
      // Y offset
      // Cмещение по оси Y
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
      // Cмещение по оси X
      "offsetX": 0,
      // Y offset
      // Cмещение по оси Y
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
      // Cмещение по оси X
      "offsetX": 0,
      // Y offset
      // Cмещение по оси Y
      "offsetY": 0
    },
    // true - Use credits instead of gold as default currency for ammo and equipment
    // true - Использовать кредиты, а не золото как валюту по умолчанию для снарядов и снаряжения
    "defaultBoughtForCredits": false,
    // true - Enable removable equipment auto return (Camouflage net, Stereoscope, Toolbox)
    // true - Включить автовозврат съемного оборудования (Маскировочная сеть, Стереотруба, Ящик с инструментами)
    "enableEquipAutoReturn": false,
    // true - Make vehicle not ready for battle if low ammo
    // true - Сделать машину не готовой к битве если мало снарядов
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
    // true - Hide price button in tech tree
    // true - Прятать кнопку с ценой в дереве исследований
    "hidePricesInTechTree": false,
    // true - Show mastery mark in tech tree
    // true - Показывать знак мастерства в дереве исследований
    "masteryMarkInTechTree": true,
    // true - Allow to consider the exchange of experience with gold in tech tree
    // true - Разрешить учитывать обмен опыта за золото в дереве исследований
    "allowExchangeXPInTechTree": true,
    // true - Show flags in barracks
    // true - Показывать флаги в казарме
    "barracksShowFlags": true,
    // true - Show skills in barracks
    // true - Показывать умения в казарме
    "barracksShowSkills": true,
    // Ping servers
    // Пинг серверов
    "pingServers": {
      // true - Enable display of ping to the servers
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
        // Mark current server in the list, possible options: "none" (don't mark), "normal", "bold", "italic", "underline"
        // Выделять текущий сервер в списке, доступные опции: "none" (не выделять), "normal", "bold", "italic", "underline"
        "markCurrentServer": "bold",
        // Color for server name and delimiter (for example, "0x8080FF"). Empty string "" - use same color as online value
        // Цвет для названия сервера и разделителя (например, "0x8080FF"). Пустая строка "" - использовать цвет значения онлайна
        "serverColor": ""
      },
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
      // true - Enable display online of servers
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
        // Mark current server in the list, possible options: "none" (don't mark), "normal", "bold", "italic", "underline"
        // Выделять текущий сервер в списке, доступные опции: "none" (не выделять), "normal", "bold", "italic", "underline"
        "markCurrentServer": "bold",
        // Color for server name and delimiter (for example, "0x8080FF"). Empty string "" - use same color as online value
        // Цвет для названия сервера и разделителя (например, "0x8080FF"). Пустая строка "" - использовать цвет значения онлайна
        "serverColor": ""
      },
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
