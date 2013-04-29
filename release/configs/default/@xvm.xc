/**
 * Full configuration file (hereinafter - the configuration) with all possible
 * options, default configuration.
 *
 * Attention! You must NOT use the percent symbol in this file.
 * Instead, the percent symbol should be written: \u0025
 *
 * ----------------------------------------------------------------------------
 *
 * Esli vy vidite nizhe bessmyslennyj nabor simvolov - smenite kodirovku
 * na UTF8+BOM
 *
 * Полный конфигурационный файл (далее - конфиг) со всеми возможными опциями,
 * настроенными по умолчанию.
 *
 * Внимание! Использование символа процента в данном файле не допустимо.
 * Вместо символа процента следует писать: \u0025
 *
 * Внимание! Кодировка файла должна оставаться UTF8 + BOM. В противном случае
 * вместо кириллицы в игре будут пустые глифы.
 * Для редактирования используйте notepad++. http://goo.gl/y6iet
 * В случае Windows notepad: Сохранить как -> Кодировка: UTF
 */
{
   // Version of the config. Do not remove or change it unnecessarily.
   // Версия конфига. Не удаляйте и не изменяйте её без необходимости.
  "configVersion": "1.5.0",

  // Version of the editor.
  // Версия редактора.
  "editorVersion": "0.41",

  // Common config options. All settings information in the mod not being used.
  // Общие параметры конфига. Все параметры информационные, в моде не используются.
  "definition": {
    // сonfig author
    // автор конфига
    "author": "sirmax2",

    // config description
    // описание конфига
    "description": "Default settings for XVM",

    // address to config updates
    // адрес, где выкладываются обновления конфига
    "url": "http://code.google.com/p/wot-xvm/",

    // config last modified
    // дата последней модификации конфига
    "date": "15.04.2013",

    // поддерживаемая версия игры
    "gameVersion": "0.8.5",

    // минимально необходимая версия мода XVM
    "modMinVersion": "3.5.0"
  },

  // Блок параметров ангара
  "hangar": ${"hangar.xc":"hangar"},

  // Окно достижений
  "userInfo": ${"hangar.xc":"userInfo"},

  // Блок общих параметров боевого интерфейса
  "battle": ${"battle.xc":"battle"},

  // Панель счёта в бою
  "fragCorrelation": ${"battle.xc":"fragCorrelation"},

  // Блок управлением статистикой (только с xvm-stat)
  "rating": ${"rating.xc":"rating"},

  // Специальные горячие клавиши XVM
  "hotkeys": ${"hotkeys.xc":"hotkeys"},

  // Окно взвода
  "squad": ${"squad.xc":"squad"},

  // Параметры экрана загрузки боя
  "battleLoading": ${"battleLoading.xc":"battleLoading"},

  // Параметры окна статистики по клавише Tab
  "statisticForm": ${"statisticForm.xc":"statisticForm"},

  // Параметры панелей игроков ("ушей")
  "playersPanel": ${"playersPanel.xc":"playersPanel"},

  // Параметры окна послебоевой статистики
  "finalStatistic": ${"finalStatistic.xc":"finalStatistic"},

  // Отображаемые строки {{turret}} маркера
  "turretMarkers": ${"turretMarkers.xc":"turretMarkers"},

  // Лог попаданий (счетчик своих попаданий)
  "hitLog": ${"hitLog.xc":"hitLog"},

  // Полоса захвата
  "captureBar": ${"captureBar.xc":"captureBar"},

  // Миникарта
  "minimap": ${"minimap.xc":"minimap"},

  // Блок маркеров над танками
  "markers": ${"markers.xc":"markers"},

  // Настройки цветов
  "colors": ${"colors.xc":"colors"},

  // Настройки динамической прозрачности
  "alpha": ${"alpha.xc":"alpha"},

  // Текстовые подстановки
  "texts": ${"texts.xc":"texts"},

  // Наборы иконок
  "iconset": ${"iconset.xc":"iconset"},

  // Замена названий танков. Значение null - использовать стандартное название.
  "vehicleNames": ${"vehicleNames.xc":"vehicleNames"}
}
