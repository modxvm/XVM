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
    "appendPlus" : false,
    // Capture format (macros allowed, see readme-en.txt).
    // Формат захвата (допускаются макроподстановки, см. readme-ru.txt).
    "enemy": { // Вражеской.
      // Upper textfield.
      // Верхнее текстовое поле.
      "primaryTitleFormat":   "<font size='15' color='#FCFCFC'><font color='#60FF00'>{{l10n:enemyBaseCapture}}</font>  <font size='15'>{{extra}}</font></font>",
      // Lower textfield.
      // Нижнее текстовое поле.
      "secondaryTitleFormat": "<font size='15' color='#FCFCFC'>{{points}}\u0025</font>",
      // Full capture text.
      // Текст полного захвата.
      "captureDoneFormat":    "<font face='XVMSymbol' size='19' color='#60FF00'>\u0021  \u0021  \u0021  \u0021   </font><font size='17' color='#FFCC66'>{{l10n:enemyBaseCaptured}}<font face='XVMSymbol' size='19' color='#60FF00'>   \u0021  \u0021  \u0021  \u0021</font><font size='19'>\n\n\n\n</font><font face='XVMSymbol' size='183' color='#FFCC66'>\u0040           <font size='0'>\u0040</font></font></font>",
      // Extra text available after necessary calculations.
      // Дополнительный текст после необходимого расчета.
      "extra":"{{l10n:allyCapturers}}: <b><font color='#FFCC66'>{{tanks}}</font></b>  {{l10n:Timeleft}}: <b><font color='#FFCC66'>{{time}}</font><b>",
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
        "blur": 4,
        // Intensity 0-255; 3 is recommended.
        // Интенсивность 0-255; 3 рекомендовано.
        "strength": 2
      }
    },
    "ally": { // Союзников.
      "primaryTitleFormat":   "<font size='15' color='#FCFCFC'><font color='#FE0E00'>{{l10n:allyBaseCapture}}</font>  <font size='15'>{{extra}}</font></font>",
      "secondaryTitleFormat": "<font size='15' color='#FCFCFC'>{{points}}\u0025</font>",
      "captureDoneFormat":    "<font face='XVMSymbol' size='19' color='#FE0E00'>\u0022  \u0022  \u0022  \u0022   </font><font size='17' color='#FFCC66'>{{l10n:allyBaseCaptured}}<font face='XVMSymbol' size='19' color='#FE0E00'>   \u0022  \u0022  \u0022  \u0022</font>\n\n<font face='XVMSymbol'  size='183' color='#FFCC66'>           \u0041</font></font>",
      "extra":"{{l10n:enemyCapturers}}: <b><font color='#FFCC66'>{{tanks}}</font></b>  {{l10n:Timeleft}}: <b><font color='#FFCC66'>{{time}}</font><b>",
      "shadow": {
        "color": "0x000000",
        "alpha": 50,
        "blur": 4,
        "strength": 2
      }
    }
  }
}
