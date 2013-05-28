/**
 * Parameters of the Battle Statistics form.
 * Параметры окна статистики по клавише Tab.
 */
{
  "statisticForm": {
    // true - Enable display of "chance to win" (only with xvm-stat).
    // true - включить отображение шансов на победу (только с xvm-stat).
    "showChances": true,
    // true - Show experimental "chance to win" formula
    // true - показывать экспериментальную формулу расчета шансов.
    "showChancesExp": true,
    // true - Disable Platoon icons.
    // true - убрать отображение иконки взвода.
    "removeSquadIcon": false,
    // Display options for Team/Clan logos (see battleLoading.xc).
    // Параметры отображения иконки игрока/клана (см. battleLoading.xc).
    "clanIcon": {
      "show": true,
      "x": -175,
      "y": 0,
      "xr": -175,
      "yr": 0,
      "w": 24,
      "h": 24,
      "alpha": 100
    },
    // Display format for the left panel (macros allowed, see readme-en.txt).
    // Формат отображения для левой панели (допускаются макроподстановки, см. readme-ru.txt).
    "formatLeft": "<font face='Consolas'><font color='{{c:kb}}'>{{kb}}</font> <font color='{{c:wn}}'>{{wn}}</font> <font color='{{c:rating}}'>{{rating}}</font></font> | <font face='Consolas'><font color='{{c:t-battles}}'>{{t-battles:4}}</font> <font color='{{c:t-rating}}'>{{t-rating:3}}</font></font>",
    // Display format for the right panel (macros allowed, see readme-en.txt).
    // Формат отображения для правой панели (допускаются макроподстановки, см. readme-ru.txt).
    "formatRight": "<font face='Consolas'><font color='{{c:t-battles}}'>{{t-battles:4}}</font> <font color='{{c:t-rating}}'>{{t-rating:3}}</font></font> | <font face='Consolas'><font color='{{c:rating}}'>{{rating}}</font> <font color='{{c:wn}}'>{{wn}}</font> <font color='{{c:kb}}'>{{kb}}</font></font>"
  }
}
