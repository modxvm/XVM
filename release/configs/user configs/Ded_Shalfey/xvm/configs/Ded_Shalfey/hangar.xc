/**
 * Parameters for hangar
 * Параметры ангара
 */
{
  "hangar": {
    // true - Disable display of tutorial icon
    // true - скрыть иконку обучения
    "hideTutorial": true,
    // Ping servers; works only with xvm-stat.exe
    // Пинг серверов; работает только с xvm-stat.exe
    "pingServers": {
      // true - Enable display of ping to the servers
      // true - показывать пинг до серверов
      "enabled": true,
      // Update interval, in ms
      // Интервал обновления, в мс
      "updateInterval": 10000,
      // Axis field coordinates
      // Положение поля по осям
      "x": 5,
      "y": 35,
      // Transparecy
      // Прозрачность от 0 до 100
      "alpha": 75,
      // Server to responce time text delimiter
      // Разделитель сервера от времени отклика
      "delimiter": ": ",
      // Maximum number of column rows
      // Максимальное количество строк одной колонки
      "maxRows": 4,
      // Gap between columns
      // Пространство между колонками
      "columnGap": 10,
      // Text style
      // Стиль текста
      "fontStyle": {
        // Font name
        // Название шрифта
        "name": "Comic Sans MS",
        "size": 14, // Размер
        "bold": false,  // Жирный
        "italic": false, // Курсив
        // Different colors depending on server responce time
        // Разные цвета в зависимости от времени отклика сервера
        "color": {
          "great": "0x00EA66", // Отличный
          "good": "0xE5E4E1",  // Хороший
          "poor": "0x96948F",  // Так себе
          "bad": "0xD64D4D"    // Плохой
        }
      },
      // Threshold values defining responce quality
      // Пороговые значения, определеяющие качество отклика
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
      },
      // Параметры тени
      "shadow": {
        "enabled": true,
        "color": "0x000000",
        "distance": 0,
        "angle": 0,
        "alpha": 100,
        "blur": 3,
        "strength": 5
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
    "showEColumn": true
  }
}
