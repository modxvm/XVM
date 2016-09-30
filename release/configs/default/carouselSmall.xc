/**
 * Small carousel cells settings
 * Настройки ячеек карусели малелького размера
 */
{
  // Definitions
  // Шаблоны
  "def": {
    // Text fields shadow.
    // Тень текстовых полей.
    "textFieldShadow": { "enabled": true, "color": "0x000000", "alpha": 80, "blur": 2, "strength": 2, "distance": 0, "angle": 0 }
  },
  "small": {
    // Cell width
    // Ширина ячейки
    "width": 160,
    // Cell height
    // Высота ячейки
    "height": 35,
    // Spacing between carousel cells.
    // Отступ между ячейками карусели.
    "padding": {
      "horizontal": 10,   // по горизонтали
      "vertical": 2       // по вертикали
    },
    // Standard cell elements.
    // Стандартные элементы ячеек.
    "fields": {
    },
    // Extra cell fields (see playersPanel.xc).
    // Дополнительные поля ячеек (см. playersPanel.xc).
    "extraFields": [
      // Sign of mastery.
      // Знак мастерства.
      {
        "enabled": true,
        "x": -1, "y": 10, "width": 23, "height": 23,
        "src": "img://gui/maps/icons/library/proficiency/class_icons_{{v.mastery}}.png"
      }
    ]
  }
}
