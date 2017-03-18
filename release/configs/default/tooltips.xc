/**
 * Tooltips of vehicles in hangar.
 * Всплывающие подсказки танков в ангаре.
 */
{
  "tooltips": {
    // true - Combine icons of equipment and optional devices into one row.
    // true - Объединить значки оборудования и доп.модулей в одну строку.
    "combineIcons": true,
    // true - Hide simplified vehicle parameters
    // true - Спрятать упрощенные ТТХ
    "hideSimplifiedVehParams": true,
    // true - Hide text at bottom of tooltip showing quantity of used eqipment, optional devices and crew.
    // true - Спрятать текст внизу подсказки показывающий количество используемого оборудования, доп. модулей и экипаж.
    "hideBottomText": true,
    // delay in tooltips appearance: increase in case of freezes, default is 0.4 sec
    // задержка отображения подсказок: увеличьте в случае фризов, по-умолчанию 0.4 сек
    "tooltipsDelay": 0.4,
    // size of the font in vehicle tooltips
    // размер шрифта во всплывающих подсказках к танкам
    "fontSize": 12,
    // name of the font in vehicle tooltips
    // название шрифта во всплывающих подсказках к танкам
    "fontName": "$TextFont",
    // color for premium shells etc. in vehicle tooltips
    // цвет премиумных снарядов и т.д. во всплывающих подсказках к танкам
    "goldColor": "#FFC363",

    "lightTank":    [
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
    "mediumTank":   [
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
    "heavyTank":    [
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
    "TD":           [
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
    "SPG":          [
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
                    ]
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
"optDevicesIcons",                      - Значки дополнительного оборудования (будут показаны в конце) \ Icons of optional devices (will be shown at the end)
"equipmentIcons",                       - Значки снаряжения (будут показаны в конце) \ Icons of equipment (will be shown at the end)
"crewRolesIcons",                       - Значки профессий экипажа танка (будут показаны в конце) \ Icons of crew roles of vehicle (will be shown at the end)
"gravity",                              - Гравитация \ Gravity
"shellSpeedSummary",                    - Сводка скоростей снарядов \ Summary of shell speeds
"radioRange",                           - Дальность связи \ Range of radio signal
"rateOfFire",                           - Скорострельность оружия (в барабанах заменяется их специфичными) \ Rate of Fire (for clip guns will be shown their specific)
"battleTiers",                          - Уровни боев танка \ Battle tiers of vehicle
"maxHealth",                            - ХП танка \ HP of vehicle
"invisibilityStillFactor"               - Незаметность неподвижной машины (%) \ Concealment of Stationary Vehicle (%)
"invisibilityMovingFactor"              - Незаметность машины в движении (%) \ Concealment of Moving Vehicle (%)
"TEXT:customtext",                      - Показывать произвольный текст (с поддержкой HTML и макросом {{l10n:text}}) \ Show custom text (with HTML support and macro {{l10n:text}})
*/