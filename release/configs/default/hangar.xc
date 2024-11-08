/**
 * Parameters for hangar.
 * Параметры ангара.
 */
{
  "hangar": {
    // true - show "Buy premium" button.
    // true - показать кнопку "Купить премиум".
    "showBuyPremiumButton": true,
    // true - show "Premium shop" button.
    // true - показать кнопку "Премиум магазин".
    "showPremiumShopButton": true,
    // true - show "WoT Plus" subscription button.
    // true - показать кнопку подписки "WoT Plus".
    "showWotPlusButton": true,
    // true - show "Create squad" text on the squad creation button.
    // true - показать текст "Создать взвод" на кнопке создания взвода.
    "showCreateSquadButtonText": true,
    // true - show selected battle mode text.
    // true - показать текст с названием выбранного режима боя.
    "showBattleTypeSelectorText": true,
    // true - show "Referral Program" button.
    // true - показать кнопку "Реферальная программа".
    "showReferralButton": true,
    // true - show "General chat" button.
    // true - показать кнопку "Общий чат".
    "showGeneralChatButton": true,
    // false - disable display promo of premium vehicle (on the background in the hangar).
    // false - отключить отображение рекламы премиум техники (на фоне в ангаре).
    "showPromoPremVehicle": true,
    // true - show info windows with the battle results in the "Ranked battle" mode.
    // true - показывать информационное окно результатов боя в режиме "Ранговый бой".
    "showRankedBattleResults": true,
    // true - show info windows when receiving progressive decals.
    // true - показывать информационное окно при получении этапной декали.
    "showProgressiveDecalsWindow": true,
    // true - show battle pass widget in hangar.
    // true - показывать виджет боевого пропуска в ангаре.
    "showBattlePassWidget": true,
    // true - show widget "Daily Quests" in the hangar.
    // true - показывать виджет "Ежедневные задачи" в ангаре.
    "showDailyQuestWidget": true,
    // true - show banner of various events in the hangar.
    // true - показывать баннер различных событий в ангаре.
    "showEventBanner": true,
    // true - show lootbox widget in hangar.
    // true - показывать виджет лутбоксов в ангаре.
    "showLootboxesWidget": true,
    // true - show event tournaments widget in hangar.
    // true - показывать виджет ивентовых турниров в ангаре.
    "showEventTournamentWidget": true,
    // true - show elite levels widget in the hangar.
    // true - показывать виджет уровней элитности в ангаре.
    "showHangarPrestigeWidget": true,
    // true - show elite levels widget in the profile for vehicle statistics.
    // true - показывать виджет уровней элитности в профиле для статистики техники.
    "showProfilePrestigeWidget": true,
    // true - show reward window for unlocking new achievements.
    // true - показывать окно награды за получение новых достижений.
    "showAchievementRewardWindow": true,
    // true - show popups in top right corner for unlocking new achievement.
    // true - показывать всплывающие окна в правом верхнем углу за получение новых достижений.
    "showAchievementPopups": true,
    // "Combat Intelligence" - show/hide notifications in the main window and counters in the menu.
    // "Полевая почта" - показывать/прятать уведомления в главном окне и счетчики в меню.
    "combatIntelligence": {
      // true - show pop-up messages in the hangar.
      // true - отображать всплывающих сообщений в ангаре.
      "showPopUpMessages": true,
      // true - show unread notifications counter in the menu.
      // true - отображать счетчика непрочитанных уведомлений в меню.
      "showUnreadCounter": true
    },
    // Parameters of the "Session statistics" button.
    // Параметры кнопки "Сессионная статистика".
    "sessionStatsButton": {
      // false - disable display "Session statistics" button.
      // false - отключить отображение кнопки "Сессионная статистика".
      "showButton": true,
      // false - disable display the counter of spent battles on the button.
      // false - отключить отображение счетчика проведенных боев на кнопке.
      "showBattleCount": true
    },
    // true - enable locker for gold.
    // true - включить замок для золота.
    "enableGoldLocker": false,
    // true - enable locker for free XP.
    // true - включить замок для свободного опыта.
    "enableFreeXpLocker": false,
    // true - enable locker for bonds.
    // true - включить замок для бонов.
    "enableCrystalLocker": false,
    // Path to locker icons.
    // Путь к иконкам замков.
    "lockerIconsFolder": "xvm://res/locker/",
    // Show/hide server info or change its parameters.
    // Показать/спрятать информацию о сервере, или изменить ее параметры.
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
      // X offset.
      // Смещение по оси X.
      "offsetX": 0,
      // Y offset.
      // Смещение по оси Y.
      "offsetY": 0
    },
    // true - enable crew auto return function (the option works if there are free places in the barracks).
    // true - включить функцию автовозврата экипажа (опция работает при наличии свободных мест в казарме).
    "enableCrewAutoReturn": true,
    // true - return crew check box is selected by default.
    // true - включить галочку возврата экипажа по умолчанию.
    "crewReturnByDefault": false,
    // Show/hide common quests button or change its parameters.
    // Показать/спрятать кнопку общих задач, или изменить ее параметры.
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
      // X offset.
      // Смещение по оси X.
      "offsetX": 0,
      // Y offset.
      // Смещение по оси Y.
      "offsetY": 0
    },
    // Show/hide personal quests button or change its parameters.
    // Показать/спрятать кнопку персональных задач, или изменить ее параметры.
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
      // X offset.
      // Смещение по оси X.
      "offsetX": 0,
      // Y offset.
      // Смещение по оси Y.
      "offsetY": 0
    },
    // Show/hide current vehicle name, type and level or change their parameters.
    // Показать/спрятать название, тип и уровень текущего танка, или изменить их параметры.
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
      // X offset.
      // Смещение по оси X.
      "offsetX": 0,
      // Y offset.
      // Смещение по оси Y.
      "offsetY": 0
    },
    // true - make vehicle not ready for battle if low ammo.
    // true - сделать машину не готовой к битве если мало снарядов.
    "blockVehicleIfLowAmmo": false,
    // Below this percentage, ammo is low. (0 - 100)
    // Ниже этого процента, снарядов считается мало. (0 - 100)
    "lowAmmoPercentage": 20,
    // true - hide price button in tech tree.
    // true - прятать кнопку с ценой в дереве исследований.
    "hidePricesInTechTree": false,
    // true - show mastery mark in tech tree.
    // true - показывать знак мастерства в дереве исследований.
    "masteryMarkInTechTree": true,
    // true - allow to consider the exchange of experience with gold in tech tree.
    // true - разрешить учитывать обмен опыта за золото в дереве исследований.
    "allowExchangeXPInTechTree": true,
    // true - restore selected battle type on switching to another server, at the next login to the client.
    // true - восстанавливать выбранный тип боя при переключении на другой сервер, при следующем входе в клиент.
    "restoreBattleType": false,
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
      "x": 85,
      "y": 52,
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
      "maxRows": 2,
      // Gap between columns.
      // Пространство между колонками.
      "columnGap": 3,
      // Leading between lines.
      // Пространство между строками.
      "leading": 2,
      // Layer - "bottom", "normal" (default), "top".
      // Слой - "bottom", "normal" (по-умолчанию), "top".
      "layer": "normal",
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
        "name": "$FieldFont",
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
      // Text format for current server in the list,
      // Flash HTML tags supported. "{server}" for the server value.
      // Форматирование текста для текущего сервер в списке,
      // Поддерживаются теги Flash HTML. "{server}" заменяется на значение текущего сервера.
      "currentServerFormat": "<b>{server}</b>",
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
      "x": -3,
      "y": 51,
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
      "maxRows": 2,
      // Gap between columns.
      // Пространство между колонками.
      "columnGap": 3,
      // Leading between lines.
      // Пространство между строками.
      "leading": 0,
      // Layer - "bottom", "normal" (default), "top".
      // Слой - "bottom", "normal" (по-умолчанию), "top".
      "layer": "normal",
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
        "name": "$FieldFont",
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
      // Text format for current server in the list,
      // Flash HTML tags supported. "{server}" for the server value.
      // Форматирование текста для текущего сервер в списке,
      // Поддерживаются теги Flash HTML. "{server}" заменяется на значение текущего сервера.
      "currentServerFormat": "<b>{server}</b>",
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
    // true - show counter on buttons in lobby menu.
    // true - показать счетчики на кнопках в меню ангара.
    "showLobbyMenuCounter": true,
    // true - show counter on buttons in battle selector.
    // true - показать счетчики на кнопках в меню выбора режима боя.
    "showBattleSelectorCounter": true,
    // true - show new crew books counter in crew widget in hangar.
    // true - показать счетчики новых учебных материалов для прокачки экипажа в его виджете в ангаре.
    "showNewCrewBooksCounter": true,
    // Show/hide notifications counters in the lobby header.
    // Показывать/прятать счетчики уведомлений в шапке ангара.
    "notificationCounter": {
      "storage": true,                       // Storage        / Склад
      "store": true,                         // Store          / Магазин
      "missions": true,                      // Missions       / Задачи
      "PersonalMissionOperationsPage": true, // Campaigns      / Кампании
      "profile": true,                       // Service Record / Достижения
      "barracks": true,                      // Barracks       / Казарма
      "StrongholdView": true                 // Clan           / Клан
    },
    // true - show notifications counters in the window and on the button "Exterior".
    // true - показать счетчики уведомлений в окне и на кнопке "Внешний вид".
    "showCustomizationCounter": true,
    // true - show counter on notification list (service channel) button.
    // true - показать счетчик уведомлений на кнопке центра оповещений (системного канала).
    "showNotificationButtonCounter": true,
    // true - show counter in notification list (service channel).
    // true - показать счетчик уведомлений в центре оповещений (системном канале).
    "showNotificationListCounters": true,
    // true - allow notification list (service channel) button blinking.
    // true - разрешить мигание кнопки центра оповещений (системного канала).
    "allowNotificationsButtonBlinking": true,
    // Parameters for tank carousel.
    // Параметры карусели танков.
    "carousel": ${"carousel.xc":"carousel"},
    // Parameters for widgets.
    // Параметры виджетов.
    "widgets": ${"widgets.xc":"widgets.lobby"}
  }
}
