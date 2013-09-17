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
    "formatLeftNick": "<font color='{{c:eff}}'>{{nick}}</font>",
    // Display format for the right panel (macros allowed, see readme-en.txt).
    // Формат отображения для правой панели (допускаются макроподстановки, см. readme-ru.txt).
    "formatRightNick": "<font color='{{c:eff}}'>{{nick}}</font>",
    // Display format for the left panel (macros allowed, see readme-en.txt).
    // Формат отображения для левой панели (допускаются макроподстановки, см. readme-ru.txt).
    "formatLeftVehicle": "<font face='Comic Sans MS' size='10'><font color='{{c:kb}}'>{{kb:3}}</font><tab><font color='{{c:eff}}'>{{eff:4}}</font><tab><font color='{{c:rating}}'>{{rating:3}}</font></font><tab>||<font face='Comic Sans MS' size='10'><font color='{{c:t-battles}}'>{{t-hb:3}}</font><tab><font color='{{c:t-rating}}'>{{t-rating:3}}</font></font><tab>",
    // Display format for the right panel (macros allowed, see readme-en.txt).
    // Формат отображения для правой панели (допускаются макроподстановки, см. readme-ru.txt).
    "formatRightVehicle": "<font face='Comic Sans MS' size='10'><font color='{{c:kb}}'>{{kb:3}}</font><tab><font color='{{c:eff}}'>{{eff:4}}</font><tab><font color='{{c:rating}}'>{{rating:3}}</font></font><tab>||<font face='Comic Sans MS' size='10'><font color='{{c:t-battles}}'>{{t-hb:3}}</font><tab><font color='{{c:t-rating}}'>{{t-rating:3}}</font></font>"
  }
}
