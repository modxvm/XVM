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
      "x": 82,
      "y": 6,
      "xr": 82,
      "yr": 6,
      "w": 16,
      "h": 16,
      "alpha": 90
    },
    // Display format for the left panel (macros allowed, see readme-en.txt).
    // Формат отображения для левой панели (допускаются макроподстановки, см. readme-ru.txt).
    "formatLeft": "<font face='Comic Sans MS' size='10'><font color='{{c:kb}}'>{{kb}}</font> <font color='{{c:eff}}'>{{eff}}</font> <font color='{{c:rating}}'>{{rating}}</font></font> | <font face='Comic Sans MS' size='10'><font color='{{c:t-battles}}'>{{t-battles:4}}</font> <font color='{{c:e}}'>{{teff}}</font> <font color='{{c:t-rating}}'>{{t-rating:3}}</font></font>",
    // Display format for the right panel (macros allowed, see readme-en.txt).
    // Формат отображения для правой панели (допускаются макроподстановки, см. readme-ru.txt).
    "formatRight": "<font face='Comic Sans MS' size='10'><font color='{{c:t-rating}}'>{{t-rating:3}}</font> <font color='{{c:e}}'>{{teff}}</font> <font color='{{c:t-battles}}'>{{t-battles:4}}</font></font> | <font face='Comic Sans MS' size='10'><font color='{{c:rating}}'>{{rating}}</font> <font color='{{c:eff}}'>{{eff}}</font> <font color='{{c:kb}}'>{{kb}}</font></font>"
  }
}
