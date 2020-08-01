/**
 * Tooltips of vehicles in hangar.
 * Всплывающие подсказки танков в ангаре.
 */
{
  "tooltips": {
    // true - combine icons of equipment and optional devices into one row.
    // true - объединить значки оборудования и доп.модулей в одну строку.
    "combineIcons": true,
    // true - hide simplified vehicle parameters.
    // true - спрятать упрощенные ТТХ.
    "hideSimplifiedVehParams": true,
    // true - hide block "Weekly earning limit".
    // true - спрятать блок "Заработок бон".
    "hideCrystalBlock": false,
    // true - hide text at bottom of tooltip showing quantity of used equipment, optional devices and crew.
    // true - спрятать текст внизу подсказки показывающий количество используемого оборудования, доп. модулей и экипаж.
    "hideBottomText": true,
    // true - display of missing experience to unlock vehicles (in tech tree).
    // true - отображать недостающий опыт для исследования техники (в дереве исследований).
    "showXpToUnlockVeh": true,
    // Delay in tooltips appearance: increase in case of freezes, default is 0.4 sec.
    // Задержка отображения подсказок: увеличьте в случае фризов, по-умолчанию 0.4 сек.
    "tooltipsDelay": 0.4,
    // Size of the font in vehicle tooltips.
    // Размер шрифта во всплывающих подсказках к танкам.
    "fontSize": 12,
    // Name of the font in vehicle tooltips.
    // Название шрифта во всплывающих подсказках к танкам.
    "fontName": "$TextFont",
    // Color for premium shells etc. in vehicle tooltips.
    // Цвет премиумных снарядов и т.д. во всплывающих подсказках к танкам.
    "goldColor": "#FFC363",
    // Substitutions for light tanks.
    // Подстановки для легких танков.
    "lightTank": [
      "maxHealth",
      "circularVisionRadius",
      "invisibilityStillFactor",
      "invisibilityMovingFactor",
      "TEXT:<font color='#DACFAD'><b>{{l10n:armor}}</b></font>",
      "turretArmor",
      "hullArmor",
      "TEXT:<font color='#DACFAD'><b>{{l10n:firepower}}</b></font>",
      "shootingRadius",
      "damageAvgSummary",
      "piercingPowerAvgSummary",
      "avgDamagePerMinute",
      "reloadTimeSecs",
      "aimingTime",
      "shotDispersionAngle",
      "TEXT:<font color='#DACFAD'><b>{{l10n:mobility}}</b></font>",
      "pitchLimits",
      "traverseLimits",
      "turretRotationSpeed",
      "chassisRotationSpeed",
      "enginePowerPerTon",
      "speedLimits",
      "terrainResistance",
      "crewRolesIcons"
    ],
    // Substitutions for medium tanks.
    // Подстановки для средних танков.
    "mediumTank": [
      "maxHealth",
      "circularVisionRadius",
      "invisibilityStillFactor",
      "invisibilityMovingFactor",
      "TEXT:<font color='#DACFAD'><b>{{l10n:armor}}</b></font>",
      "turretArmor",
      "hullArmor",
      "TEXT:<font color='#DACFAD'><b>{{l10n:firepower}}</b></font>",
      "shootingRadius",
      "damageAvgSummary",
      "piercingPowerAvgSummary",
      "avgDamagePerMinute",
      "reloadTimeSecs",
      "aimingTime",
      "shotDispersionAngle",
      "TEXT:<font color='#DACFAD'><b>{{l10n:mobility}}</b></font>",
      "pitchLimits",
      "traverseLimits",
      "turretRotationSpeed",
      "chassisRotationSpeed",
      "enginePowerPerTon",
      "speedLimits",
      "terrainResistance",
      "crewRolesIcons"
    ],
    // Substitutions for heavy tanks.
    // Подстановки для тяжелых танков.
    "heavyTank": [
      "maxHealth",
      "circularVisionRadius",
      "invisibilityStillFactor",
      "invisibilityMovingFactor",
      "TEXT:<font color='#DACFAD'><b>{{l10n:armor}}</b></font>",
      "turretArmor",
      "hullArmor",
      "TEXT:<font color='#DACFAD'><b>{{l10n:firepower}}</b></font>",
      "shootingRadius",
      "damageAvgSummary",
      "piercingPowerAvgSummary",
      "avgDamagePerMinute",
      "reloadTimeSecs",
      "aimingTime",
      "shotDispersionAngle",
      "TEXT:<font color='#DACFAD'><b>{{l10n:mobility}}</b></font>",
      "pitchLimits",
      "traverseLimits",
      "turretRotationSpeed",
      "chassisRotationSpeed",
      "enginePowerPerTon",
      "speedLimits",
      "crewRolesIcons"
    ],
    // Substitutions for tank destroyers.
    // Подстановки для ПТ-САУ.
    "TD": [
      "maxHealth",
      "circularVisionRadius",
      "invisibilityStillFactor",
      "invisibilityMovingFactor",
      "TEXT:<font color='#DACFAD'><b>{{l10n:armor}}</b></font>",
      "turretArmor",
      "hullArmor",
      "TEXT:<font color='#DACFAD'><b>{{l10n:firepower}}</b></font>",
      "shootingRadius",
      "damageAvgSummary",
      "piercingPowerAvgSummary",
      "avgDamagePerMinute",
      "reloadTimeSecs",
      "aimingTime",
      "shotDispersionAngle",
      "TEXT:<font color='#DACFAD'><b>{{l10n:mobility}}</b></font>",
      "pitchLimits",
      "traverseLimits",
      "turretRotationSpeed",
      "chassisRotationSpeed",
      "enginePowerPerTon",
      "speedLimits",
      "crewRolesIcons"
    ],
    // Substitutions for SPG.
    // Подстановки для САУ.
    "SPG": [
      "maxHealth",
      "circularVisionRadius",
      "invisibilityStillFactor",
      "invisibilityMovingFactor",
      "TEXT:<font color='#DACFAD'><b>{{l10n:firepower}}</b></font>",
      "shootingRadius",
      "damageAvgSummary",
      "piercingPowerAvgSummary",
      "avgDamagePerMinute",
      "reloadTimeSecs",
      "clipParams",
      "explosionRadius",
      "aimingTime",
      "shotDispersionAngle",
      "TEXT:<font color='#DACFAD'><b>{{l10n:mobility}}</b></font>",
      "pitchLimits",
      "traverseLimits",
      "turretRotationSpeed",
      "chassisRotationSpeed",
      "enginePowerPerTon",
      "speedLimits",
      "crewRolesIcons"
    ],
    // List of tooltipId to hide.
    // Possible values can be found in this files: ingame_gui.mo, tooltips.mo (or INGAME_GUI.py, TOOLTIPS.py)
    // or enable "logLocalization" option and search them in the xvm.log file
    // Список tooltipId, которые необходимо спрятать.
    // Возможные значения можно найти в файлах: ingame_gui.mo, tooltips.mo (или INGAME_GUI.py, TOOLTIPS.py)
    // или включите опцию "logLocalization" и ищите их в файле xvm.log
    "hideTooltips": [
      "#ingame_gui:dynamicSquad/ally/add",
      "#ingame_gui:dynamicSquad/ally/disabled",
      "#ingame_gui:dynamicSquad/ally/received",
      "#ingame_gui:dynamicSquad/ally/wasSent",
      "#ingame_gui:dynamicSquad/enemy/add",
      "#ingame_gui:dynamicSquad/enemy/disabled",
      "#ingame_gui:dynamicSquad/enemy/received",
      "#ingame_gui:dynamicSquad/enemy/wasSent",
      "#ingame_gui:dynamicSquad/invite",
      "#tooltips:header/info/players_online_full/body",
      "#tooltips:header/info/players_online_full/header",
      "#tooltips:header/info/players_online_region/body",
      "#tooltips:header/info/players_online_region/header",
      "#tooltips:header/info/players_unavailable/body",
      "#tooltips:header/info/players_unavailable/header"
    ],
    // Log all localization keys to the xvm.log file, can be helpful to search required tooltipId.
    // Логировать все ключи локализации в файл xvm.log, может быть полезно для поиска необходимых tooltipId.
    "logLocalization": false
  }
}

/*
  List of possible values: (if the parameter is not relevant for some tank, it will be omitted)
  Список доступных значений: (если в танке данный параметр отсутствует он не будет отображаться)

  "circularVisionRadius",                 - Обзор \ Vision
  "piercingPower",                        - Пробитие базовым снарядом (от и до) \ Penetration of basic shell (from - to)
  "piercingPowerAvg",                     - Пробитие базовым снарядом (среднее) \ Penetration of basic shell (avg)
  "piercingPowerAvgSummary",              - Сводка пробития всеми снарядами \ Summary of penetration of all shells
  "avgDamage",                            - Средний урон базовым снарядом \ Average damage of basic shell
  "stunMaxDuration",                      - Максимальное время оглушения (c) \ Maximum stun duration (s)
  "stunMinDuration",                      - Минимальное время оглушения (c) \ Minimum stun duration (s)
  "damageAvgSummary",                     - Сводка урона всеми снарядами \ Summary of damages of all shells
  "avgDamagePerMinute",                   - Средний ДПМ базовым снарядом\ Average DPM with basic shell
  "explosionRadius",                      - Радиус разлета осколков фугаса \ Radius of HE explosion splash
  "shotDispersionAngle",                  - Разброс от расстояния \ Accuracy, shell dispersion over distance
  "aimingTime",                           - Время сведения \ Aiming time
  "reloadTimeSecs",                       - Время перезарядки (для барабанных их специфичное) \ Reload time (for clip guns will be shown their specific)
  "enginePower",                          - Мощность мотора \ Engine power
  "enginePowerPerTon",                    - Удельная мощность мотора (характеризует разгон) \ Engine power-to-weight ratio (characterises acceleration)
  "speedLimits",                          - Предельная скорость вперед и назад \ Speed limit forward and backward
  "chassisRotationSpeed",                 - Скорость поворота шасси \ Chassis rotation speed
  "turretArmor",                          - Сводка брони башни (спереди, сбоку, сзади) \ Summary of turret armor (frontal, side, back)
  "hullArmor",                            - Сводка брони корпуса (спереди, сбоку, сзади) \ Summary of hull armor (frontal, side, back)
  "traverseLimits",                       - УГН \ Gun traverse limits
  "pitchLimits",                          - УВН \ Elevation arc limits
  "pitchLimitsSide",                      - УВН (сбоку) \ Elevation arc limits (side)
  "pitchLimitsRear",                      - УВН (сзади) \ Elevation arc limits (rear)
  "shootingRadius",                       - Дальность стрельбы арты, пулеметов \ Shooting range of SPG, machine guns
  "turretRotationSpeed",                  - Скорость вращения башни (и оружия) \ Rotation speed of turret (and gun)
  "terrainResistance",                    - Сводка сопротивлений грунтов \ Summary of terrain resistances
  "switchOnTime",                         - Время перехода в осадный режим \ Siege mode activation time
  "switchOffTime",                        - Время перехода в походный режим \ Marching mode activation time
  "optDevicesIcons",                      - Значки дополнительного оборудования (будут показаны в конце) \ Icons of optional devices (will be shown at the end)
  "equipmentIcons",                       - Значки снаряжения (будут показаны в конце) \ Icons of equipment (will be shown at the end)
  "crewRolesIcons",                       - Значки профессий экипажа танка (будут показаны в конце) \ Icons of crew roles of vehicle (will be shown at the end)
  "gravity",                              - Гравитация \ Gravity
  "shellSpeedSummary",                    - Сводка скоростей снарядов \ Summary of shell speeds
  "radioRange",                           - Дальность связи \ Range of radio signal
  "rateOfFire",                           - Скорострельность оружия \ Rate of Fire
  "battleTiers",                          - Уровни боев танка \ Battle tiers of vehicle
  "maxHealth",                            - ХП танка \ HP of vehicle
  "invisibilityStillFactor"               - Незаметность неподвижной машины (%) \ Concealment of Stationary Vehicle (%)
  "invisibilityMovingFactor"              - Незаметность машины в движении (%) \ Concealment of Moving Vehicle (%)
  "TEXT:customtext",                      - Показывать произвольный текст (с поддержкой HTML и макросом {{l10n:text}}) \ Show custom text (with HTML support and macro {{l10n:text}})
*/
