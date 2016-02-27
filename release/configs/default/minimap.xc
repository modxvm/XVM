/**
 * General parameters for minimap.
 * Общие параметры миникарты. Видео по некоторым аспектам редактирования http://www.youtube.com/watch?feature=player_embedded&v=NBJcqWuEoLo
 */
{
  "minimap": {
    // false - Disable.
    // false - отключить.
    "enabled": true,
    // Map image transparency.
    // Прозрачность изображения карты.
    "mapBackgroundImageAlpha": 100,
    // Self icon transparency. White pointing arrow.
    // Прозрачность своей иконки. Белая стрелка.
    "selfIconAlpha": 75,
    // Vehicle type icons transparency.
    // Прозрачность иконок типа техники.
    "iconAlpha": 100,
    // Hide camera direction green triangle (also hides WG camera direction line).
    // Спрятать зеленый треугольник направления камеры (также скрывает луч направления камеры WG).
    "hideCameraTriangle": false,
    // Show camera line after death
    // Отображать линию направления камеры после смерти
    "showCameraLineAfterDeath": true,
    // Camera transparency and its attached geometry (green triangle).
    // Прозрачность камеры и прикрепленной геометрии (зеленый треугольник).
    "cameraAlpha": 100,
    // Vehicles icon size. Does not affect attached geometry and textfields. Floating point allowed: 0.7, 1.4.
    // Размер иконки техники. Не влияет на прикрепленную к геометрию и текстовые поля. Можно дробные: 0.7, 1.4.
    "iconScale": 1,
    // Path to icon for arty aim
    // Путь к иконке для артиллерийского прицела
    "minimapAimIcon": "xvm://res/MinimapAim.png",
    // Scale factor for the minimap aim icon (in percents)
    // Масштаб иконки для артиллерийского прицела (в процентах)
    "minimapAimIconScale": 50,
    // Map zoom by key pressing. Key is defined at file "hotkeys.xc".
    // Увеличение миникарты по нажатию кнопки. Кнопка задается в файле "hotkeys.xc".
    "zoom": {
      // Number of pixels to get back from maximum size (screen height-minimap height).
      // Число пикселей для уменьшения миникарты от максимального размера (высота экрана-высота миникарты).
      "pixelsBack": 449,
      // false - does not set zoomed minimap at display center.
      // false - не устанавливать увеличенную миникарту по центру экрана.
      "centered": false
    },
    // Map size label
    // Поле размера карты
    "mapSize": ${"minimapMapSize.xc":"mapSize"},
    // Use standard circles
    // Использовать стандартные круги
    "useStandardCircles": false,
    // Use standard labels
    // Использовать стандартные надписи
    "useStandardLabels": false,
    // Use standard lines
    // Использовать стандартные линии
    "useStandardLines": false,
    // Minimap labels.
    // Надписи на миникарте.
    "labels": ${"minimapLabels.xc":"labels"},
    "labelsData": ${"minimapLabelsData.xc":"labelsData"},
    // Minimap circles.
    // Круги на миникарте.
    "circles": ${"minimapCircles.xc":"circles"},
    // Minimap lines.
    // Линии на миникарте.
    "lines": ${"minimapLines.xc":"lines"}
  }
}
