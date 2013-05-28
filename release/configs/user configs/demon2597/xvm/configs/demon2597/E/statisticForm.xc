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
    "showChancesExp": false,
    // true - Disable Platoon icons.
    // true - убрать отображение иконки взвода.
    "removeSquadIcon": false,
    // Display options for Team/Clan logos (see battleLoading.xc).
    // Параметры отображения иконки игрока/клана (см. battleLoading.xc).
    "clanIcon": {
      "show": false,
      "x": 0,
      "y": 6,
      "xr": 0,
      "yr": 6,
      "w": 16,
      "h": 16,
      "alpha": 90
    },
    // Display format for the left panel (macros allowed, see readme-en.txt).
    // Формат отображения для левой панели (допускаются макроподстановки, см. readme-ru.txt).
    "formatLeft": "<font face='PartnerCondensed Mono' size='13'><font color='{{c:rating}}'>{{rating:3}}</font>  <font color='{{c:kb}}'>{{kb:3}}</font>  <font color='{{c:xeff}}'>{{xeff}}</font> |</font>  <font face='PartnerCondensed Mono' size='13'><font color='{{c:t-battles}}'>{{t-hb:3}}</font>  <font color='{{c:e}}'>{{e}}</font></font>  <font face='XVMSymbol' size='20'>{{vtype}}</font>",
    // Display format for the right panel (macros allowed, see readme-en.txt).
    // Формат отображения для правой панели (допускаются макроподстановки, см. readme-ru.txt).
    "formatRight": "<font face='XVMSymbol' size='20'>{{vtype}}</font>  <font face='PartnerCondensed Mono' size='13'><font color='{{c:e}}'>{{e}}</font> <font color='{{c:t-battles}}'>{{t-hb:3}}</font> | <font color='{{c:xeff}}'>{{xeff}}</font>  <font color='{{c:kb}}'>{{kb:3}}</font>  <font color='{{c:rating}}'>{{rating:3}}</font></font>"
  }
}
