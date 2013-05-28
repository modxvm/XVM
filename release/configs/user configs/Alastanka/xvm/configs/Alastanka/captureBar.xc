/**
 * Capture bar.
 * Полоса захвата.
 */
{
  "captureBar": {
    "enabled": true, // Переключатель вкл/выкл
    "primaryTitleOffset": 7, // Смещение верхнего поля вверх на случай больших размеров шрифтов
    "appendPlus" : true, // дописывать плюс к тройке захватчиков. Невозможно расчитать более трёх.
    // Формат захвата (допускаются макроподстановки, см. readme-ru.txt)
    "enemy": { // Враг(Захват вражеской базы)
    "primaryTitleFormat":   "<font size='16' color='#96FF00'><b>Захват вражеской базы</b> {{extra}}</font>", // Верхнее текстовое поле //-над полосой захвата
    "secondaryTitleFormat": "<font size='20' color='#FFFF00'><b>{{points}}\u0025</b></font>",             // Нижнее текстовое поле //-проценты захвата
    "captureDoneFormat":    "<img src='xvmres://icons/ura.png' width='439' height='55'>",             // Текст полного захвата<font size='36' color='#FF00FF'><b>Вражеская база захвачена!</b></font>\n \n \n \n<font face='Wingdings' size='200' color='#FF0000'><b>&#79;</b></font>
    "extra": "<font size='16' color='#FFFFFF'><b>Захватчиков:</b></font> <font size='20' color='#FFFF00'><b>{{tanks}}({{speed}})</b></font> <font size='16' color='#FFFFFF'><b>Осталось времени:</b></font> <font size='20' color='#FFFF00'><b>{{time}}<b></font>",               // Дополнительный текст после необходимого расчета //-над полосой захвата дополнительно
    "shadow": {          // Тень полей
      "color": "0x000000", // Цвет
      "alpha": 50,       // Прозрачность 0-100
      "blur": 15,        // Размытие 0-255
      "strength": 20      // Сила 0-255
      }
    },
    "ally": { // Союзник(Захват нашей базы)
    "primaryTitleFormat":   "<font size='16' color='#96FF00'><b>Захват нашей базы</b> {{extra}}</font>", // Верхнее текстовое поле //-над полосой захвата
    "secondaryTitleFormat": "<font size='20' color='#FFFF00'><b>{{points}}\u0025</b></font>",             // Нижнее текстовое поле //-проценты захвата
    "captureDoneFormat":    "<img src='xvmres://icons/ura.png' width='439' height='55'>",             // Текст полного захвата<font size='36' color='#FF00FF'><b>Наша база захвачена!</b></font>\n<font face='Wingdings' size='200' color='#96FF00'><b>&#78;</b></font>
    "extra": "<font size='16' color='#FFFFFF'><b>Захватчиков:</b></font> <font size='20' color='#FFFF00'><b>{{tanks}}({{speed}})</b></font> <font size='16' color='#FFFFFF'><b>Осталось времени:</b></font> <font size='20' color='#FFFF00'><b>{{time}}<b></font>",               // Дополнительный текст после необходимого расчета //-над полосой захвата дополнительно
    "shadow": {          // Тень полей
      "color": "0x000000", // Цвет
      "alpha": 50,       // Прозрачность 0-100
      "blur": 15,        // Размытие 0-255
      "strength": 20      // Сила 0-255
      }
    }
  }
}
