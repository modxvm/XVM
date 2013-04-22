/**
 *
 */
{
  // Полоса захвата
  "captureBar": {
    "enabled": true, // Переключатель вкл/выкл
    "primaryTitleOffset": 7, // Смещение верхнего поля вверх на случай больших размеров шрифтов
    "appendPlus" : true, // Дописывать плюс к тройке захватчиков. Невозможно рассчитать более трёх.
    // Формат захвата (допускаются макроподстановки, см. readme-ru.txt)
    "enemy": { // Вражеской
      "primaryTitleFormat":   "<font size='15' color='#FFFFFF'>Захват вражеской базы! {{extra}}</font>",    // Верхнее текстовое поле
      "secondaryTitleFormat": "<font size='15' color='#FFFFFF'>{{points}}</font>",                       // Нижнее текстовое поле
      "captureDoneFormat":    "<font size='17' color='#FFCC66'>Вражеская база захвачена!</font>",             // Текст полного захвата
      "extra": "Захватчиков: <b><font color='#FFCC66'>{{tanks}}</font></b> Осталось времени: <b><font color='#FFCC66'>{{time}}</font><b>", // Дополнительный текст после необходимого расчета
      "shadow": {            // Тень полей
        "color": "0x000000", // Цвет
        "alpha": 50,         // Прозрачность 0-100
        "blur": 6,           // Размытие 0-255; 6 рекомендовано
        "strength": 3        // Сила 0-255; 3 рекомендовано
      }
    },
    "ally": { // Союзников
      "primaryTitleFormat":   "<font size='15' color='#FFFFFF'>Захват нашей базы! {{extra}}</font>",
      "secondaryTitleFormat": "<font size='15' color='#FFFFFF'>{{points}}</font>",
      "captureDoneFormat":    "<font size='17' color='#FFCC66'>Наша база захвачена!</font>",
      "extra": "Захватчиков: <b><font color='#FFCC66'>{{tanks}}</font></b> Осталось времени: <b><font color='#FFCC66'>{{time}}</font><b>",
      "shadow": {
        "color": "0x000000",
        "alpha": 50,
        "blur": 6,
        "strength": 3
      }
    }
  }
}
