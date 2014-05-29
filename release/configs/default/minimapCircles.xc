/**
 * Minimap circles. Only real map meters. Only for own unit.
 * Круги на миникарте. Дистанция только в реальных метрах карты. Только для своей техники.
 */
{
    "circles": {
        "enabled": true,
        // TODO: better description and translation
        // View distance
        // Дальность обзора
        // Параметры:
        //   "enabled": false - выключен;
        //   "distance" - дистанция;
        //   "scale" - масштаб круга (множитель расстояния);
        //   "thickness" - толщина;
        //   "alpha" - прозрачность;
        //   "color" - цвет.
        // Доступные значения расстояния:
        //   N - число в метрах, рисуется статический круг
        //   "blindarea" - граница слепой зоны
        //   "dynamic"   - реальная дальность обзора танка c учётом стоит/движется
        //   "standing"  - реальная дальность обзора танка стоя
        //   "motion"    - реальная дальность обзора танка в движении
        // Источник:
        //   http://www.koreanrandom.com/forum/topic/15467-/page-5#entry187139
        //   http://www.koreanrandom.com/forum/topic/15467-/page-4#entry186794
        "view": [
            // Simple model (one dynamic circle), for most players
            { "enabled": true, "distance": "blindarea", "scale": 1, "thickness": 0.75, "alpha": 80, "color": "0xFFFF00" }

            /*
            // Extended model (4 circles), for experienced players
            { "enabled": true, "distance": 50, "scale": 1, "thickness": 0.75, "alpha": 60, "color": "0xFFFFFF" },
            { "enabled": true, "distance": 445, "scale": 1, "thickness": 1.1, "alpha": 45, "color": "0xFFCC66" },
            { "enabled": true, "distance": standing", "scale": 1, "thickness": 1.0, "alpha": 60, "color": "0xFF0000" },
            { "enabled": true, "distance": motion", "scale": 1, "thickness": 1.0, "alpha": 60, "color": "0x0000FF" }
            */
        ],
        // Maximum range of fire for artillery
        // Artillery gun fire range may differ depending on vehicle angle relative to ground
        // and vehicle height positioning relative to target. These factors are not considered.
        // See pics at http://goo.gl/ZqlPa
        // ------------------------------------------------------------------------------------------------
        // Максимальная дальность стрельбы для артиллерии
        // Дальнобойность арты может меняться в зависимости от углов постановки машины на склонах местности
        // и высоте расположения машины относительно цели. На миникарте эти факторы не учитываются.
        // Подробнее по ссылке: http://goo.gl/ZqlPa
        "artillery": { "enabled": true, "alpha": 55, "color": "0x3EB5F1", "thickness": 0.5 },
        // Maximum range of shooting for machine gun
        // Максимальная дальность полета снаряда для пулеметных танков
        "shell":     { "enabled": true, "alpha": 55, "color": "0x3EB5F1", "thickness": 0.5 },
        // Special circles dependent on vehicle type.
        // Many configuration lines for the same vehicle make many circles.
        // See other vehicle types at (replace : symbol with -):
        // http://code.google.com/p/wot-xvm/source/browse/trunk/src/xpm/xvmstat/vehinfo_short.py
        // ------------------------------------------------------------------------------------------------
        // Специальные круги, зависящие от модели техники.
        // Несколько строк для одной техники делают несколько кругов.
        // Названия танков для дополнения брать по ссылке (символ : заменяется -):
        // http://code.google.com/p/wot-xvm/source/browse/trunk/src/xpm/xvmstat/vehinfo_short.py
        "special": [
          // Example: Artillery gun fire range circle
          // Пример: Круг дальности стрельбы арты
          // "enabled": false - выключен; "thickness" - толщина; "alpha" - прозрачность; "color" - цвет.
          //{ "ussr-SU-18": { "enabled": true, "thickness": 1, "alpha": 60, "color": "0xEE4444", "distance": 500 } },
        ]
    }
}