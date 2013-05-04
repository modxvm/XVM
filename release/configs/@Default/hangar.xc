/**
 * Parameters for hangar
 * Параметры ангара
 */
{
  "hangar": {
    // true - Disable display of tutorial icon
    // true - скрыть иконку обучения
    "hideTutorial": false,
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
      "x": 100,
      "y": 0,
      // Transparecy
      // Прозрачность от 0 до 100
      "alpha": 60,
      // Стиль текста
      "fontStyle": {
        // Font name
        // Название шрифта
        "name": "$FieldFont",
        "size": 11, // Размер
        "bold": true,  // Жирный
        "italic": false, // Курсив
        // Different colors depending on server responce time
        // Разные цвета в зависимости от времени отклика сервера
        "color": {
          "great": "0x33FFCC", // Отличный
          "good": "0x99FF33",  // Хороший
          "poor": "0xFFFF33",  // Так себе
          "bad": "0xFF7733"    // Плохой
        }
      },
      // Threshold values defining responce quality
      // Пороговые значения, определеяющие качетво отклика
      "threshold": {
        // Below this value responce is great
        // До этого значения отклик отличный
        "great": 30,
        // Below this value responce is good
        // До этого значения отклик хороший
        "good": 60,
        // Below this value responce is poor
        // До этого значения отклик так себе
        "poor": 100
        // Values above define bad responce
        // Значения более считаются плохим откликом
      }
    }
  },
  // UserInfo window.
  // Окно достижений.
  "userInfo": {
    // true - Enable filter tanks in hangar by default.
    // true - включить фильтр отображения танков в ангаре по умолчанию.
    "inHangarFilterEnabled": false,
    // true - Enable display of E column (values ​​may be incorrect due to the peculiarities of WG statistics servers).
    // true - показывать колонку эффективности по танку (значения могут быть неверными из-за особенностей предоставления статистики серверами WG).
    "showEColumn": false
  }
}
