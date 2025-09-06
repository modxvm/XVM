/**
 * Minimap circles. Only real map meters. Only for own unit.
 * Круги на миникарте. Дистанция только в реальных метрах карты. Только для своей техники.
 */
{
  "circles": {
    // TODO: better description and translation.
    // View distance.
    // Дальность обзора.
    // Параметры:
    //   "enabled": false - выключен
    //   "distance" - дистанция
    //   "scale" - масштаб круга (множитель расстояния) (параметр не обязательный)
    //   "thickness" - толщина
    //   "alpha" - прозрачность
    //   "color" - цвет
    //   "state" - состояние танка: 1-стоит, 2-двигается (параметр не обязательный)
    // Доступные значения расстояния:
    //   N - число в метрах, рисуется статический круг
    //   "dynamic"   - реальная дальность обзора танка c учётом стоит/движется
    //   "motion"    - реальная дальность обзора танка в движении
    //   "standing"  - реальная дальность обзора танка стоя
    //   "blindarea" - реальная граница слепой зоны танка (50<=X<=445)
    //   "blindarea_motion" - реальная граница слепой зоны танка в движении (50<=X<=445)
    //   "blindarea_standing" - реальная граница слепой зоны танка стоя (50<=X<=445)
    // Источник:
    //   https://kr.cm/f/t/15467/c/187139/
    //   https://kr.cm/f/t/15467/c/186794/
    "view": [
      // Main circles:
      // Основные круги:
      { "enabled": true, "distance": "blindarea", "scale": 1, "thickness": 0.75, "alpha": 80, "color": "0x3EB5F1" },
      { "enabled": true, "distance": 445,         "scale": 1, "thickness":  1.1, "alpha": 45, "color": "0xFFCC66" },
      // Circle of the maximum units appearance.
      // Окружность границы максимальной отрисовки юнитов.
      { "enabled": "{{my-vtype-key=SPG?false|true}}", "distance": 564, "scale": 1, "thickness": 0.7, "alpha": 40, "color": "0xFFFFFF" },
      // Additional circles:
      // Дополнительные круги:
      { "enabled": true,  "distance": 50,         "scale": 1, "thickness": 0.75, "alpha": 60, "color": "0xFFFFFF" },
      { "enabled": false, "distance": "standing", "scale": 1, "thickness":  1.0, "alpha": 60, "color": "0xFF0000" },
      { "enabled": false, "distance": "motion",   "scale": 1, "thickness":  1.0, "alpha": 60, "color": "0x0000FF" },
      { "enabled": false, "distance": "dynamic",  "scale": 1, "thickness":  1.0, "alpha": 60, "color": "0x3EB5F1" }
    ],
    // Maximum range of fire for artillery.
    // Artillery gun fire range may differ depending on vehicle angle relative to ground
    // and vehicle height positioning relative to target. These factors are not considered.
    // See pics at https://kr.cm/f/t/2076/c/35697/
    // ------------------------------------------------------------------------------------------------
    // Максимальная дальность стрельбы для артиллерии.
    // Дальнобойность арты может меняться в зависимости от углов постановки машины на склонах местности
    // и высоте расположения машины относительно цели. На миникарте эти факторы не учитываются.
    // Подробнее по ссылке: https://kr.cm/f/t/2076/c/35697/
    "artillery": { "enabled": true, "alpha": 55, "color": "0xFF6666", "thickness": 0.5 },
    // Maximum range of shooting for machine gun
    // Максимальная дальность полета снаряда для пулеметных танков
    "shell":     { "enabled": true, "alpha": 55, "color": "0xFF6666", "thickness": 0.5 },
    // Special circles dependent on vehicle type.
    // Many configuration lines for the same vehicle make many circles.
    // See other vehicle types in file: vehicleNames.xc
    // ------------------------------------------------------------------------------------------------
    // Специальные круги, зависящие от модели техники.
    // Несколько строк для одной техники делают несколько кругов.
    // Названия танков для дополнения брать в файле: vehicleNames.xc
    "special": [
      // Example: Artillery gun fire range circle.
      // Пример: Круг дальности стрельбы арты.
      // Параметры:
      //   "enabled": false - выключен;
      //   "distance" - дистанция;
      //   "thickness" - толщина;
      //   "alpha" - прозрачность;
      //   "color" - цвет.
      //{ "china-Ch01_Type59": { "enabled": true, "distance": 500, "thickness": 1, "alpha": 60, "color": "0xEE4444" } }
    ]
  }
}
