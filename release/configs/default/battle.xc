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
    // false - disable pop-up panel with enemy's dog tag.
    // false - отключить всплывающую внизу панель с личным жетоном противника.
    "showPostmortemDogTag": true,
    // false - disable battle hints.
    // false - отключить подсказки в бою.
    "showBattleHint": true,
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
    // Sixth sense indicator settings
    // Настройки индикатора "шестого чувства"
    "sixthSense": {
      // X offset relative to initial position of the indicator
      // Смещение по оси X относительно изначальной позиции индикатора
      "offsetX": 0,
      // Y offset relative to initial position of the indicator
      // Смещение по оси Y относительно изначальной позиции индикатора
      "offsetY": 0,
      // Use the old indicator position above crosshair in the middle
      // of the screen (only for Lesta since 1.26)
      // Использовать старую позицию индикатора над прицелом по центру
      // экрана (только для Lesta с патча 1.26)
      "useOldInitialPosition": false,
      // Opacity of the indicator in percents (0..100) (only for WG,
      // on Lesta use ingame settings)
      // Прозрачность индикатора в процентах (0..100) (только для WG,
      // для Lesta используйте внутриигровые настройки)
      "alpha": 100,
      // Scale of the indicator (0..1)
      // Масштаб индикатора (0..1)
      "scale": 1,
      // Path to sixth sense icon ("" for original icon).
      // Путь к иконке 6-го чувства ("" для оригинальной иконки).
      "icon": "xvm://res/SixthSense.png",
      // Duration of the sixth sense indicator (msec).
      // Длительность отображения индикатора 6-го чувства (мсек).
      "duration": 2000
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
  }
}
