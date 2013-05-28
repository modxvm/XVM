/**
 * Hit log (my hits calculator).
 * Лог попаданий (счетчик своих попаданий).
 */
{
  "hitLog": {
    // false - Disable.
    // false - отключить.
    "visible": true,
    // Show enemy hp left by Alt press
    // Показывать оставшееся здоровье врагов по нажатию Alt
    "hpLeft": true,
    // X position (negative values - bind to right side of screen).
    // Позиция X (отрицательные значения - привязать к правой стороне экрана).
    "x": 305,
    // Y position (negative values - bind to bottom side of screen).
    // Позиция Y (отрицательные значения - привязать к нижней стороне экрана).
    "y": 5,
    // Width.
    // Ширина.
    "w": 500,
    // Height.
    // Высота.
    "h": 500,
    // Number of lines with hits. Old lines will be pushed out.
    // Количество строк с попаданиями. Устаревшие данные выталкиваются.
    "lines": 21,
    // Log direction: up - lines will be added from up to down, down - from down to up.
    // Направление лога: up - строки добавляются сверху, down - снизу.
    "direction": "down",
    // Group hits by players name.
    // Группировать попадания по имени игрока.
    "groupHitsByPlayer": false,
    // Insert order: begin - insert new values to begin, end - add to end.
    // Сортировка попаданий: begin - новые значения добавляются сверху, end - снизу.
	"insertOrder": "begin",
    // Substitution for {{dead}} macro when tank is dead.
    // Подстановка для макроса {{dead}}, когда танк умирает.
    "deadMarker": "\u0029",
    "blowupMarker": "\u0028",
    // Default header format (before first hit). Macros IS NOT allowed.
    // Формат заголовка по умолчанию (до первого попадания). Макросы НЕ допускаются.
    "defaultHeader":  "",
    // Hits header format, including last hit (macros allowed, see readme-en.txt).
    // Формат заголовка (допускаются макроподстановки, см. readme-ru.txt).
    "formatHeader": "<u><font color='#E5E5E5'>Атак: <b><font color='#FCFCFC'>{{n}}</font></b>  Урона: <b><font color='#FFCC66'>{{dmg-total}}</font></b>  Последний: <b><font color='#FCFCFC'>{{dmg}}</font></b></font></u>",
    // List of hits format (macros allowed, see readme-en.txt).
    // Формат лога попаданий (допускаются макроподстановки, см. readme-ru.txt)
    "formatHistory": "<textformat leading='-1' tabstops='[20,55,90,130,175]'><font color='#FFE1A6' size='13'><font color='#E5E5E5{{dead}}'><b></b{{dead}}>\u00D7{{n-player}}<tab>{{dmg-kind}}<tab>-{{dmg}}<tab>({{dmg-player}})</b></b><tab><font face='XVMSymbol'><font size='19'><font size='0{{dead}}'>{{dead}}</font></font><font size='0'><font size='19{{dead}}'>\u002A</font></font></font><tab><font face='XVMSymbol' size='20'>{{vtype}}</font>  <b></b{{dead}}>{{vehicle}}</b></b></font></font></textformat>",
    // Shadow options.
    // Параметры тени.
    "shadow": {
      // Opacity.
      // Прозрачность.
      "alpha": 100,
      // Цвет.
      "color": "0x000000",
      // Offset angle.
      // Угол смещения.
      "angle": 45,
      // Offset distance.
      // Дистанция смещения.
      "distance": 0,
      // Размер.
      "size": 4,
      // Intensity.
      // Интенсивность.
      "strength": 100
    }
  }
}
