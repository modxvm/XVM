/**
 * Main configuration file (hereinafter - the configuration).
 *
 * Attention! You must NOT use the percent symbol in configuration files.
 * Instead, the percent symbol should be written: \u0025
 * Use \n as newline character instead of <br> tag
 *
 * --------------------------------------------------------------------------
 * Esli vy vidite nizhe bessmyslennyj nabor simvolov - smenite kodirovku
 * na UTF8+BOM
 *
 * Главный конфигурационный файл (далее - конфиг).
 *
 * Внимание! Использование символа процента в файлах конфига не допустимо.
 * Вместо символа процента следует писать: \u0025
 * Для переноса на новую строку используйте \n вместо тэга <br>
 *
 * Внимание! Кодировка файлов должна оставаться UTF8+BOM. В противном случае
 * вместо кириллицы в игре будут пустые глифы.
 * Для редактирования используйте Notepad++. http://goo.gl/y6iet
 * В случае блокнота Windows: Сохранить как -> Кодировка: UTF.
 */
{
  // Version of the config. Do not remove or change it unnecessarily.
  // Версия конфига. Не удаляйте и не изменяйте её без необходимости.
  "configVersion": "4.0.0",

  // Version of the editor.
  // Версия редактора.
  "editorVersion": "0.57",

  // Language used in mod
  // "auto" - automatically detect language from game client,
  // or specify file name located in res_mods/xvm/l10n/ (ex: "en")
  // Используемый язык в моде
  // "auto" - автоматически определять язык клиента игры,
  // или укажите имя файла в папке res_mods/xvm/l10n/ (например, "en")
  "language": "auto",

  // Game Region
  // "auto" - automatically detect game region from game client,
  // or specify one of: "RU", "EU", "NA", "CN", "SEA", "VN", "KR"
  // Регион (игровой кластер)
  // "auto" - автоматически определять регион из клиента игры,
  // или укажите один из: "RU", "EU", "NA", "CN", "SEA", "VN", "KR"
  "region": "auto",

  // Common config options. All settings information in the mod not being used.
  // Общие параметры конфига. Все параметры информационные, в моде не используются.
  "definition": {
    // Config author.
    // Автор конфига.
    "author": "XVM",

    // Config description.
    // Описание конфига.
    "description": "Default settings for XVM",

    // Address to config updates.
    // Адрес, где выкладываются обновления конфига.
    "url": "http://code.google.com/p/wot-xvm/",

    // Config last modified.
    // Дата последней модификации конфига.
    "date": "22.08.2013",

    // Supported version of the game.
    // Поддерживаемая версия игры.
    "gameVersion": "0.8.7",

    // The minimum required version of the XVM mod.
    // Минимально необходимая версия мода XVM.
    "modMinVersion": "4.1.1"
  },

  // Parameters for login screen.
  // Параметры экрана логина.
  "login": ${"login.xc":"login"},

  // Parameters for hangar.
  // Параметры ангара.
  "hangar": ${"hangar.xc":"hangar"},

  // Parameters for userinfo window.
  // Параметры окна достижений.
  "userInfo": ${"hangar.xc":"userInfo"},

  // General parameters for the battle interface.
  // Общие параметры боевого интерфейса.
  "battle": ${"battle.xc":"battle"},

  // Frag counter panel.
  // Панель счёта в бою.
  "fragCorrelation": ${"battle.xc":"fragCorrelation"},

  // Ingame crits panel by "expert" skill.
  // Внутриигровая панель критов от навыка "экспет".
  "expertPanel": ${"battle.xc":"expertPanel"},

  // Options for player statistics (only with xvm-stat).
  // Блок управлением статистикой (только с xvm-stat).
  "rating": ${"rating.xc":"rating"},

  // Special XVM hotkeys.
  // Специальные горячие клавиши XVM.
  "hotkeys": ${"hotkeys.xc":"hotkeys"},

  // Parameters for squad window.
  // Параметры окна взвода.
  "squad": ${"squad.xc":"squad"},

  // Parameters of the Battle Loading screen.
  // Параметры экрана загрузки боя.
  "battleLoading": ${"battleLoading.xc":"battleLoading"},

  // Parameters of the Battle Statistics form.
  // Параметры окна статистики по клавише Tab.
  "statisticForm": ${"statisticForm.xc":"statisticForm"},

  // Parameters of the Players Panels ("ears").
  // Параметры панелей игроков ("ушей").
  "playersPanel": ${"playersPanel.xc":"playersPanel"},

  // Parameters of the After Battle Screen.
  // Параметры окна послебоевой статистики.
  "finalStatistic": ${"finalStatistic.xc":"finalStatistic"},

  // {{turret}} marker display strings.
  // Отображаемые строки {{turret}} маркера.
  "turretMarkers": ${"turretMarkers.xc":"turretMarkers"},

  // Hit log (my hits calculator).
  // Лог попаданий (счетчик своих попаданий).
  "hitLog": ${"hitLog.xc":"hitLog"},

  // Capture bar.
  // Полоса захвата.
  "captureBar": ${"captureBar.xc":"captureBar"},

  // Minimap.
  // Миникарта.
  "minimap": ${"minimap.xc":"minimap"},

  // Over-target markers.
  // Маркеры над танками.
  "markers": ${"markers.xc":"markers"},

  // Color settings.
  // Настройки цветов.
  "colors": ${"colors.xc":"colors"},

  // Options for dynamic transparency.
  // Настройки динамической прозрачности.
  "alpha": ${"alpha.xc":"alpha"},

  // Text substitutions.
  // Текстовые подстановки.
  "texts": ${"texts.xc":"texts"},

  // Icon sets.
  // Наборы иконок.
  "iconset": ${"iconset.xc":"iconset"},

  // Vehicle names mapping.
  // Замена названий танков.
  "vehicleNames": ${"vehicleNames.xc":"vehicleNames"}
}