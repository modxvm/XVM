/**
 * Camera settings
 * Настройки камеры
 */
{
  "camera": {
    // Global camera settings switch
    // Глобальный переключатель настроек камеры
    "enabled": false,
    // Disable switching to sniper mode by mouse wheel
    // Не переключаться в снайперский режим колесом мыши
    "noScroll": false,
    // Arcade mode
    // Аркадный режим
    "arcade": {
      // Camera distance range: [min, max], default - [2, 25]
      // Отдаление камеры: [мин, макс], по умолчанию - [2, 25]
      "distRange": [2, 25],
      // Start distance (null for default behavior - saved state from the last battle)
      // Начальная дистанция (null для поведения по умолчанию - сохраненная позиция из последнего боя)
      "startDist": null,
      // Чувствительность прокрутки (default = 5)
      // Scroll sensitivity (по умолчанию = 5)
      "scrollSensitivity": 5,
      // Enable/disable dynamic camera
      // Включить/выключить динамическую камеру
      "dynamicCameraEnabled": true
    },
    // Postmortem mode
    // Режим после смерти
    "postmortem": {
      // Camera distance range: [min, max], default - [2, 25]
      // Отдаление камеры: [мин, макс], по умолчанию - [2, 25]
      "distRange": [2, 25],
      // Start distance (null for default behavior - maximum distance)
      // Начальная дистанция (null для поведения по умолчанию - максимальная дистанция)
      "startDist": null,
      // Чувствительность прокрутки (default = 5)
      // Scroll sensitivity (по умолчанию = 5)
      "scrollSensitivity": 5,
      // Enable/disable dynamic camera
      // Включить/выключить динамическую камеру
      "dynamicCameraEnabled": true
    },
    // Strategic mode (arty)
    // Стратегический режим (арта)
    "strategic": {
      // Camera distance range: [min, max], default - [40, 100]
      // Отдаление камеры: [мин, макс], по умолчанию - [40, 100]
      "distRange": [40, 100],
      // Enable/disable dynamic camera
      // Включить/выключить динамическую камеру
      "dynamicCameraEnabled": true
    },
    // Sniper mode
    // Снайперский режим
    "sniper": {
      // List of multiplicities for the sniper mode
      // Default: [ 2, 4, 8 ]. It's possible to use a greater number of values.
      // Список значений кратности для снайперского режима
      // По умолчанию: [ 2, 4, 8 ]. Можно использовать большее количество значений.
      "zooms": [2, 4, 8],
      // Zoom Indicator
      // Global macros allowed in all fields
      // Индикатор масштаба
      // Можно использовать глобальные макросы во всех полях
      "zoomIndicator": {
        // Enable/disable
        // Включить/выключить
        "enabled": true,
        // Field position relative to screen center
        // Положение поля относительно центра экрана
        "x": 150,
        "y": 30,
        // Field size
        // Размер поля
        "width": 100,
        "height": 40,
        // Opacity in percents (0..100)
        // Прозрачность
        "alpha": 100,
        // Horizonatal text alignment (left, center, right)
        // Горизонтальное выравнивание текста (left, center, right)
        "align": "left",
        // Vertical text alignment (top, center, bottom)
        // Вертикальное выравнивание текста (top, center, bottom)
        "valign": "center",
        // Background color
        // Цвет фона
        "bgColor": null,
        // Border color 
        // Цвет рамки
        "borderColor": null,
        // Shadow settings
        // Настройки тени
        "shadow": { "distance": 0, "angle": 0, "color": "0x192E0E", "alpha": 100, "blur": 3, "strength": 7 },
        // Text format
        // Формат текста
        "format": "<font face='$TitleFont' color='#95CB29' size='16'>x{{zoom}}</font>"
      },
      // Enable/disable dynamic camera
      // Включить/выключить динамическую камеру
      "dynamicCameraEnabled": true
    }
  }
}
