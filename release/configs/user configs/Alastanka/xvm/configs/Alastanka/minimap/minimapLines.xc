/**
 * Minimap lines. Only for owned vehicle.
 * Sizes dependent on meters work only with xvm-stat.exe for uncommon locales.
 * xvm-stat.exe is not necessary for RU, EN, DE and partially CH locale.
 * Линии на миникарте. Только для своей техники.
 */
{
  "lines": {
       // Работает только с xvm-stat.exe
       "enabled": true,
       // "inmeters": true  - дистанция линии в метрах реальной карты.
       // "inmeters": false - дистанция линии в точках миникарты. Сторона миникарты 210 точек.
       // "thickness" - толщина отрезка.
       // "from" - начало отрезка; "to" - конец.
       // Дистанция из угла в угол на километровой карте получается немногим более 1400 метров.
       // В секциях располагается произвольное кол-во отрезков.
       // Для постановки точки попробуйте отрезок длиной в единицу и с большой толщиной.
       // Для простоты можете оставить один длинный отрезок, не забыв убрать зяпятую. В конце секции запятая не ставится.
       "vehicle": [ // Направление корпуса своей техники.
         { "enabled": true, "from": 50,  "to": 100, "inmeters": true, "thickness": 2,   "alpha": 60, "color": "0x00EAFF"}, //44EE44
         { "enabled": true, "from": 200, "to": 300, "inmeters": true, "thickness": 1.5, "alpha": 60, "color": "0x00EAFF"},
         { "enabled": true, "from": 350, "to": 445, "inmeters": true, "thickness": 1,   "alpha": 30, "color": "0x00EAFF"},
         { "enabled": true, "from": 500, "to": 1500, "inmeters": true, "thickness": 0.7,   "alpha": 30, "color": "0x00EAFF"}
       ],
       "camera": [ // Направление камеры от своей техники.
         { "enabled": true, "from": 50,  "to": 100, "inmeters": true, "thickness": 2,   "alpha": 60, "color": "0x7FDC00"},
         { "enabled": true, "from": 200, "to": 300, "inmeters": true, "thickness": 1.5, "alpha": 60, "color": "0x7FDC00"},
         { "enabled": true, "from": 350, "to": 445, "inmeters": true, "thickness": 1,   "alpha": 30, "color": "0x7FDC00"},
         { "enabled": true, "from": 500, "to": 1500, "inmeters": true, "thickness": 0.7,   "alpha": 30, "color": "0x7FDC00"}
       ],
       // Углы горизонтальной наводки могут меняться в зависимости от углов постановки машины на склонах местности.
       // Подробнее по ссылке: http://goo.gl/ZqlPa
       "traverseAngle": [ // Углы горизонтальной наводки. Срабатывают только, если углы есть.
         { "enabled": true, "from": 50,  "to": 100, "inmeters": true, "thickness": 2,   "alpha": 60, "color": "0xFFFFFF"},
         { "enabled": true, "from": 200, "to": 300, "inmeters": true, "thickness": 1.5, "alpha": 45, "color": "0xFFFFFF"},
         { "enabled": true, "from": 350, "to": 445, "inmeters": true, "thickness": 1,   "alpha": 30, "color": "0xFFFFFF"},
         { "enabled": true, "from": 500, "to": 1500, "inmeters": true, "thickness": 0.7,   "alpha": 30, "color": "0xFFFFFF"}
       ]
    }
}