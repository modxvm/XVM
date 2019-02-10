/**
 * Textfield for map side size.
 * Поле размера стороны карты.
 *
 * Example:
 * Например:
 *   1000 m, 700 m, 600 m.
 */
{
  // The settings correspond to the extra fields parameters.
  // Настройки соответствуют параметрам дополнительных полей.
  "mapSize": {
    "enabled": true,
    "x": 0,
    "y": 0,
    "alpha": 70,
    "textFormat": {
      "font": "Times New Roman",
      "size": 10,
      "color": "0xFFCC66",
      "align": "left",
      "bold": true,
      "italic": false
    },
    "format": "{{cellsize}}0 {{l10n:m}}",
    "shadow": {
      "enabled": true,
      "color": "0x000000",
      "alpha": 70,
      "blur": 2,
      "strength": 3,
      "distance": 0,
      "angle": 0
    }
  }
}
