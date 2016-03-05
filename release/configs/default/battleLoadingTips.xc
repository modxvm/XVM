/**
 * Parameters of the Battle Loading screen.
 * Параметры экрана загрузки боя.
 */
{
  "battleLoadingTips": {
    "$ref": { "file": "battleLoading.xc", "path": "battleLoading" },
    // X offset for allies squad icons
    // Cмещение по оси X значка взвода для союзников
    "squadIconOffsetXLeft": -40,
    // X offset for enemies squad icons field
    // Cмещение по оси X значка взвода для противников
    "squadIconOffsetXRight": -40,
    // X offset for allies player names field
    // Cмещение по оси X поля ника для союзников
    "nameFieldOffsetXLeft": -40,
    // X offset for enemies player names field
    // Cмещение по оси X поля ника для противников
    "nameFieldOffsetXRight": -40,
    // X offset for "formatLeftVehicle" field
    // Cмещение по оси X поля названия танка для союзников
    "vehicleFieldOffsetXLeft": 0,
    // X offset for "formatRightVehicle" field
    // Cмещение по оси X поля названия танка для противников
    "vehicleFieldOffsetXRight": 0,
    // X offset for allies vehicle icons
    // Смещение по оси X иконки танка для союзников
    "vehicleIconOffsetXLeft": 0,
    // X offset for enemies vehicle icons
    // Смещение по оси X иконки танка для противников
    "vehicleIconOffsetXRight": 0,
    // Display format for the left panel (macros allowed, see macros.txt).
    // Формат отображения для левой панели (допускаются макроподстановки, см. macros.txt).
    "formatLeftNick": "<img src='xvm://res/icons/flags/{{flag|default}}.png' width='16' height='13'> <img src='xvm://res/icons/xvm/xvm-user-{{xvm-user}}.png'> {{name%.15s~..}}<font alpha='#A0'>{{clan}}</font>",
    // Display format for the right panel (macros allowed, see macros.txt).
    // Формат отображения для правой панели (допускаются макроподстановки, см. macros.txt).
    "formatRightNick": "<font alpha='#A0'>{{clan}}</font>{{name%.15s~..}} <img src='xvm://res/icons/xvm/xvm-user-{{xvm-user}}.png'> <img src='xvm://res/icons/flags/{{flag|default}}.png' width='16' height='13'>",
    // Display format for the left panel (macros allowed, see macros.txt).
    // Формат отображения для левой панели (допускаются макроподстановки, см. macros.txt).
    "formatLeftVehicle": "{{vehicle}}<font face='mono' size='{{xvm-stat?13|0}}'> <font color='{{c:r}}'>{{r}}</font></font>",
    // Display format for the right panel (macros allowed, see macros.txt).
    // Формат отображения для правой панели (допускаются макроподстановки, см. macros.txt).
    "formatRightVehicle": "<font face='mono' size='{{xvm-stat?13|0}}'><font color='{{c:r}}'>{{r}}</font> </font>{{vehicle}}"
  }
}
