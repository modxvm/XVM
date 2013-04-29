/**
 * Общие параметры боевого интерфейса
 */
{
  "battle": {
    "mirroredVehicleIcons": true,           // false - отключить зеркалирования иконок танков (полезно для альтернативных иконок). По умолчанию включено.
    "showPostmortemTips": true,             // false - отключить всплывающую внизу панель после смерти. По умолчанию включено.
    "removePanelsModeSwitcher": false,      // true - убрать переключатель режимов ушей мышкой
    "highlightVehicleIcon": true,           // false - отключить подсветку иконки своего танка и взвода
    "clockFormat": "H:N",                   // Формат часов на экране панели отладки (возле FPS). Формат: Y:год, M:месяц, D:день, H:часы, N:минуты, S:секунды. "" - убрать часы.
    "useStandardMarkers": false,            // true - использовать стандартные маркеры клиента
    "clanIconsFolder": "clanicons"          // путь к папке иконок кланов относительно res_mods/xvm/img
  },
  // Панель счёта в бою
  "fragCorrelation": {
    "hideTeamTextFields": true // true - cпрятать два текстовых поля "Союзники | Противники"
  }
}
