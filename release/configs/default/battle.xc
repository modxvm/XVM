/**
 * General parameters for the battle interface.
 * Общие параметры боевого интерфейса.
 */
{
  "battle": {
    // false - disable tank icon mirroring (good for alternative icons).
    // false - отключить зеркалирования иконок танков (полезно для альтернативных иконок).
    "mirroredVehicleIcons": true,
    // false - disable pop-up panel at the bottom after death.
    // false - отключить всплывающую внизу панель после смерти.
    "showPostmortemTips": true,
    // false - disable highlighting of own vehicle icon and squad.
    // false - отключить подсветку иконки своего танка и взвода.
    "highlightVehicleIcon": true,
    // Format of clock on the Debug Panel (near FPS).
    // Формат часов на экране панели отладки (возле FPS).
    // http://php.net/date
    "clockFormat": "H:i",
    // Path to clan icons folder relative to res_mods/mods/shared_resources/xvm/res.
    // Путь к папке иконок кланов относительно res_mods/mods/shared_resources/xvm/res.
    "clanIconsFolder": "clanicons/",
    // Path to sixth sense icon ("" for original icon).
    // Путь к иконке 6-го чувства ("" для оригинальной иконки).
    "sixthSenseIcon": "xvm://res/SixthSense.png",
    // Duration of the sixth sense indicator (msec).
    // Длительность отображения индикатора 6-го чувства (мсек).
    "sixthSenseDuration": 2000,
    // Manage battle hints.
    // Управление подсказками в бою.
    "battleHint": {
      // true - hide the hint of aiming mode changing in strategic mode.
      // true - скрыть подсказку смены режима прицеливания в стратегическом режиме.
      "hideTrajectoryView": false,
      // true - hide the hint about switching to siege mode and changing the driving mode (for wheeled vehicles).
      // true - скрыть подсказку перехода в осадный режим и смены режима движения (для колесной техники).
      "hideSiegeIndicator": false,
      // true - hide the hint about switching to menu Personal Missions.
      // true - скрыть подсказку перехода в меню ЛБЗ.
      "hideQuestProgress": false,
      // true - hide the hint of the transition to the window of exploring the features of the machine (for wheeled vehicles).
      // true - скрыть подсказку перехода к окну знакомства с особенностями машины (для колесной техники).
      "hideHelpScreen": false,
      // true - hide the tips about radar activation ("Steel Hunter" mode).
      // true - скрыть подсказку активации радара (режим "Стальной охотник").
      "hideRadarHint": false
    },
    // GUI elements settings (experts only).
    // Настройки графических элементов (только для экспертов!).
    "elements": ${"elements.xc":"elements"},
    // Camera settings
    // Настройки камеры
    "camera": ${"camera.xc":"camera"},
    // Switching between players on the minimap after death.
    // Переключение между игроками по миникарте после смерти.
    "minimapDeadSwitch": true
  },
  // Frag counter panel at top side of battle windows interface.
  // Панель счёта в бою.
  "fragCorrelation": {
    // true - show quantity of alive instead of dead.
    // true - показывать количество живых танков вместо убитых.
    "showAliveNotFrags": false
  },
  // Ingame crits panel by "expert" skill.
  // Внутриигровая панель критов от навыка "эксперт".
  "expertPanel": {
    // Delay for panel disappear. Original value was 5.
    // Задержка исчезновения панели. Оригинальное значение было 5.
    "delay": 15,
    // Panel scaling. Original value was 100.
    // Увеличение панели. 100 в оригинале.
    "scale": 150
  }
}
