/**
 * Parameters of the Battle Loading screen.
 * Параметры экрана загрузки боя.
 */
{
  "battleLoading": {
    // Format of clock on the Battle Loading Screen. Format: Y:year, M:month, D:day, H:hour, N:minutes, S:seconds. "" - remove clock.
    // Формат часов на экране загрузки боя. Формат: Y:год, M:месяц, D:день, H:часы, N:минуты, S:секунды. "" - убрать часы.
    "clockFormat": "D/M/Y H:N:S",
    // true - Enable display of "chance to win" (only with xvm-stat) Read more: http://www.koreanrandom.com/forum/topic/1663-/
    // true - включить отображение шансов на победу (только с xvm-stat). Прочитать подробней: http://www.koreanrandom.com/forum/topic/1663-/
    "showChances": true,
    // Show experimental "chance to win" formula.
    // Показывать экспериментальную формулу расчета шансов.
    "showChancesExp": true,
    // true - Disable Platoon icons. This blank space can house, for example, clan logos.
    // true - убрать отображение иконки взвода. На пустое поле можно вывести, например, иконку клана.
    "removeSquadIcon": false,
    // Display options for Team/Clan logos.
    // Параметры отображения иконки игрока/клана.
    "clanIcon": {
      // false - Disable Team/Clan logos in Battle Loading Screen.
      // false - не отображать иконки игрока/клана в окне загрузки боя.
      "show": true,
      // Position on the X axis, relative to the vehicle icon.
      // Положение по оси X оносительно иконки танка.
      "x": -365,
      // Position on the Y axis, relative to the vehicle icon.
      // Положение по оси Y оносительно иконки танка.
      "y": 0,
      // Position on the X axis for right side (positive values run to the *inside* of the table).
      // Положение по оси X для правых ушей (положительные значения поместят иконку *внутрь* панели).
      "xr": -365,
      // Position on the Y axis for right side.
      // Положение по оси Y для правых ушей.
      "yr": 0,
      // Width of the Team/Clan logo.
      // Ширина иконки игрока/клана.
      "w": 24,
      // Height of the Team/Clan logo.
      // Высота иконки игрока/клана.
      "h": 24,
      // Transparency of the Team/Clan logo.
      // Прозрачность иконки игрока/клана.
      "alpha": 100
    },
    // Display format for the left panel (macros allowed, see readme-en.txt).
    // Формат отображения для левой панели (допускаются макроподстановки, см. readme-ru.txt).
    "formatLeft": "<font face='Consolas'><font color='{{c:kb}}'>{{kb}}</font> <font color='{{c:wn}}'>{{wn}}</font> <font color='{{c:rating}}'>{{rating}}</font></font> | <font face='Consolas'><font color='{{c:t-battles}}'>{{t-battles:4}}</font> <font color='{{c:t-rating}}'>{{t-rating:3}}</font></font>",
    // Display format for the right panel (macros allowed, see readme-en.txt).
    // Формат отображения для правой панели (допускаются макроподстановки, см. readme-ru.txt).
    "formatRight": "<font face='Consolas'><font color='{{c:t-battles}}'>{{t-battles:4}}</font> <font color='{{c:t-rating}}'>{{t-rating:3}}</font></font> | <font face='Consolas'><font face='Consolas'><font color='{{c:rating}}'>{{rating}}</font> <font color='{{c:wn}}'>{{wn}}</font> <font color='{{c:kb}}'>{{kb}}</font></font>"
  }
}
