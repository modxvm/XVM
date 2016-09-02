/**
 * Textfield for map side size. 1000 m, 700 m, 600 m.
 * Поле размера стороны карты. Например, 1000 m, 700 m, 600 m.
 */
{
  // The settings correspond to the extra fields parameters
  // Настройки соответствуют параметрам дополнительных полей
  "mapSize": {
    "enabled": true,
    "alpha": 40,
    "x": 0,
    "y": 0,
    "width": 100,
    "height": 30,
    "textFormat": {
      "size": 10,
      "color": "0xFFCC66",
      "bold": true
    },
    "format": "{{cellsize}}0 {{l10n:m}}",
    "shadow": {
      "enabled": true,
      "distance": 0,
      "angle": 0,
      "color": "0x000000",
      "alpha": 80,
      "blur": 2,
      "strength": 3
    }
  }
}
