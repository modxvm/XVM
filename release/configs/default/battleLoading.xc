/**
 * Parameters of the Battle Loading screen.
 * Параметры экрана загрузки боя.
 */
{
  "battleLoading": {
    // Format of clock on the Battle Loading Screen.
    // Формат часов на экране загрузки боя.
    // http://php.net/date
    "clockFormat": "H:i:s",
    // true - enable display of battle tier.
    // true - включить отображение уровня боя.
    "showBattleTier": false,
    // true - disable Platoon icons. This blank space can house, for example, clan logos.
    // true - убрать отображение иконки взвода. На пустое поле можно вывести, например, иконку клана.
    "removeSquadIcon": false,
    // true - disable vehicle level indicator.
    // true - убрать отображение уровня танка.
    "removeVehicleLevel": false,
    // true - disable vehicle type icon. This space will be used for formatted vehicle field.
    // true - убрать отображение типа танка. Пустое место будет использовано под форматируемое поле.
    "removeVehicleTypeIcon": false,
    // Show border for name field (useful for config tuning)
    // Показывать рамку для поля имени игрока (полезно для настройки конфига)
    "nameFieldShowBorder": false,
    // Show border for vehicle field (useful for config tuning)
    // Показывать рамку для поля имени танка (полезно для настройки конфига)
    "vehicleFieldShowBorder": false,
    // X offset for allies squad icons
    // Смещение по оси X значка взвода союзников
    "squadIconOffsetXLeft": 0,
    // X offset for enemies squad icons field
    // Смещение по оси X значка взвода противников
    "squadIconOffsetXRight": 0,
    // X offset for allies player names field
    // Смещение по оси X поля ника союзников
    "nameFieldOffsetXLeft": -11,
    // Width delta for allies player names field
    // Изменение ширины поля ника союзников
    "nameFieldWidthDeltaLeft": 0,
    // X offset for enemies player names field
    // Смещение по оси X поля ника противников
    "nameFieldOffsetXRight": -14,
    // Width delta for enemies player names field
    // Изменение ширины поля ника противников
    "nameFieldWidthDeltaRight": 0,
    // X offset for allies vehicle names field
    // Смещение по оси X поля названия танка союзников
    "vehicleFieldOffsetXLeft": 0,
    // Width delta for allies vehicle names field
    // Изменение ширины поля названия танка союзников
    "vehicleFieldWidthDeltaLeft": 0,
    // X offset for enemies vehicle names field
    // Смещение по оси X поля названия танка противников
    "vehicleFieldOffsetXRight": 0,
    // Width delta for enemies vehicle names field
    // Изменение ширины поля названия танка противников
    "vehicleFieldWidthDeltaRight": 0,
    // X offset for allies vehicle icons
    // Смещение по оси X иконки танка союзников
    "vehicleIconOffsetXLeft": 0,
    // X offset for enemies vehicle icons
    // Смещение по оси X иконки танка противников
    "vehicleIconOffsetXRight": 0,
    // Display options for Team/Clan logos.
    // Параметры отображения иконки игрока/клана.
    "clanIcon": {
      // false - Disable Team/Clan logos in Battle Loading Screen.
      // false - не отображать иконки игрока/клана в окне загрузки боя.
      "show": true,
      // Position on the X axis, relative to the vehicle icon.
      // Положение по оси X относительно иконки танка.
      "x": 0,
      // Position on the Y axis, relative to the vehicle icon.
      // Положение по оси Y относительно иконки танка.
      "y": 6,
      // Position on the X axis for right side (positive values run to the *inside* of the table).
      // Положение по оси X для правых ушей (положительные значения поместят иконку *внутрь* панели).
      "xr": 0,
      // Position on the Y axis for right side.
      // Положение по оси Y для правых ушей.
      "yr": 6,
      // Width of the Team/Clan logo.
      // Ширина иконки игрока/клана.
      "w": 16,
      // Height of the Team/Clan logo.
      // Высота иконки игрока/клана.
      "h": 16,
      // Transparency of the Team/Clan logo.
      // Прозрачность иконки игрока/клана.
      "alpha": 90
    },
    // false - disable highlight of icons during battle start depends on ready state.
    // false - отключить затемнение иконки не загрузившегося игрока.
    "darkenNotReadyIcon": true,
    // Display format for the left panel (macros allowed, see macros.txt).
    // Формат отображения для левой панели (допускаются макроподстановки, см. macros.txt).
    "formatLeftNick": "<img src='xvm://res/icons/flags/{{flag|default}}.png' width='16' height='13'> <img src='xvm://res/icons/xvm/xvm-user-{{xvm-user}}.png'> {{name%.15s~..}} <font alpha='#A0'>{{clan}}</font>",
    // Display format for the right panel (macros allowed, see macros.txt).
    // Формат отображения для правой панели (допускаются макроподстановки, см. macros.txt).
    "formatRightNick": "<font alpha='#A0'>{{clan}}</font> {{name%.15s~..}} <img src='xvm://res/icons/xvm/xvm-user-{{xvm-user}}.png'> <img src='xvm://res/icons/flags/{{flag|default}}.png' width='16' height='13'>",
    // Display format for the left panel (macros allowed, see macros.txt).
    // Формат отображения для левой панели (допускаются макроподстановки, см. macros.txt).
    "formatLeftVehicle": "{{vehicle}}<font face='mono' size='{{xvm-stat?13|0}}'> <font color='{{c:kb}}'>{{kb%2d~k|--k}}</font> <font color='{{c:r}}'>{{r}}</font> <font color='{{c:winrate}}'>{{winrate%2d~%|--%}}</font></font>",
    // Display format for the right panel (macros allowed, see macros.txt).
    // Формат отображения для правой панели (допускаются макроподстановки, см. macros.txt).
    "formatRightVehicle": "<font face='mono' size='{{xvm-stat?13|0}}'><font color='{{c:winrate}}'>{{winrate%2d~%|--%}}</font> <font color='{{c:r}}'>{{r}}</font> <font color='{{c:kb}}'>{{kb%2d~k|--k}}</font> </font>{{vehicle}}"
  }
}
