/**
 * Capture bar.
 * Полоса захвата.
 */
{
  "captureBar": {
    // false - Disable.
    // false - отключить.
    "enabled": true,
    // Upper textfield offset in case of big font size.
    // Смещение верхнего поля вверх на случай больших размеров шрифтов.
    "primaryTitleOffset": 7,
    // Append plus to three capturers. Cant calculate more than three.
    // Дописывать плюс к тройке захватчиков. Невозможно рассчитать более трёх.
    "appendPlus" : true,
    // Capture format (macros allowed, see readme-en.txt).
    // Формат захвата (допускаются макроподстановки, см. readme-ru.txt).
    "enemy": { // Вражеской.
      // Upper textfield.
      // Верхнее текстовое поле.
      "primaryTitleFormat":   "<font size='16' color='#96FF00'><b>Захват вражеской базы</b> {{extra}}</font>",
      // Lower textfield.
      // Нижнее текстовое поле.
      "secondaryTitleFormat": "<font size='20' color='#FFFF00'><b>{{points}}\u0025</b></font>",
      // Full capture text.
      // Текст полного захвата.
      "captureDoneFormat":    "<img src='xvmres://icons/ura.png' width='439' height='55'>",
      // Extra text available after necessary calculations.
      // Дополнительный текст после необходимого расчета.
      "extra": "<font size='16' color='#FFFFFF'><b>Захватчиков:</b></font> <font size='20' color='#FFFF00'><b>{{tanks}}({{speed}})</b></font> <font size='16' color='#FFFFFF'><b>Осталось времени:</b></font> <font size='20' color='#FFFF00'><b>{{time}}<b></font>",
      // Fields shadow
      // Тень полей.
      "shadow": {
        // Цвет.
        "color": "0x000000",
        // Opacity 0-100.
        // Прозрачность 0-100.
        "alpha": 50,
        // Blur 0-255; 6 is recommended.
        // Размытие 0-255; 6 рекомендовано.
        "blur": 15,
        // Intensity 0-255; 3 is recommended.
        // Интенсивность 0-255; 3 рекомендовано.
        "strength": 20
      }
    },
    "ally": { // Союзников.
      "primaryTitleFormat":   "<font size='16' color='#96FF00'><b>Захват нашей базы</b> {{extra}}</font>",
      "secondaryTitleFormat": "<font size='20' color='#FFFF00'><b>{{points}}\u0025</b></font>",
      "captureDoneFormat":    "<img src='xvmres://icons/ura.png' width='439' height='55'>",
      "extra": "<font size='16' color='#FFFFFF'><b>Захватчиков:</b></font> <font size='20' color='#FFFF00'><b>{{tanks}}({{speed}})</b></font> <font size='16' color='#FFFFFF'><b>Осталось времени:</b></font> <font size='20' color='#FFFF00'><b>{{time}}<b></font>",
      "shadow": {
        "color": "0x000000",
        "alpha": 50,
        "blur": 15,
        "strength": 20
      }
    }
  }
}
