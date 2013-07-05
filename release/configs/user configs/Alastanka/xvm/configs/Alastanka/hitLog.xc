/**
 * Hit log (my hits calculator).
 * Лог попаданий (счетчик своих попаданий).
 */
{
  "hitLog": {
    // false - Disable.
    // false - отключить.
    "visible": true,

    // Show enemy HP left by Alt press
    // Destroyed enemies and enemies HP gets updated only when it markers become visible.
    // Markers are visible only inside 1000m side square.
    // Square with 1000 meters side is game engine restriction. Maximum marker show distance.
    // Particular enemy data will not be updated while you cant see this enemy marker or its wreck.
    
    // Показывать оставшееся HP врагов по нажатию Alt
    // Уничтоженные враги и вражеское HP обновляется только, когда маркеры становятся видимыми.
    // Маркеры видимы только в квадрате со стороной в 1000м.
    // Квадрат в 1000 метров это ограничение игрового движка. Максимальная дистанция отрисовки маркеров.
    // Данные по конкретному врагу не могут быть обновлены пока не видно его маркер или обломки.
    "hpLeft": true,
    // X position (negative values - bind to right side of screen).
    // Позиция X (отрицательные значения - привязать к правой стороне экрана).
    "x": 500,
    // Y position (negative values - bind to bottom side of screen).
    // Позиция Y (отрицательные значения - привязать к нижней стороне экрана).
    "y": 40,
    // Width.
    // Ширина.
    "w": 1000,
    // Height.
    // Высота.
    "h": 1000,
    // Number of lines with hits. Old lines will be pushed out.
    // Количество строк с попаданиями. Устаревшие данные выталкиваются.
    "lines": 10,
    // Log direction: up - lines will be added from up to down, down - from down to up.
    // Направление лога: up - строки добавляются сверху, down - снизу.
    "direction": "down",
    // Group hits by players name.
    // Группировать попадания по имени игрока.
    "groupHitsByPlayer": true,
    // Insert order: begin - insert new values to begin, end - add to end.
    // Сортировка попаданий: begin - новые значения добавляются сверху, end - снизу.
	"insertOrder": "end",
    // Substitution for {{dead}} macro when tank is dead.
    // Подстановка для макроса {{dead}}, когда танк умирает.
    "deadMarker": "<img src='xvmres://icons/kill.png' width='34' height='12'>",
    "blowupMarker": "<font face='Wingdings' size='22'>&#77;</font>",
    // Default header format (before first hit). Macros IS NOT allowed.
    // Формат заголовка по умолчанию (до первого попадания). Макросы НЕ допускаются.
    "defaultHeader": ${"@xvm.xc":"definition.description"},
    // Hits header format, including last hit (macros allowed, see readme-en.txt).
    // Формат заголовка (допускаются макроподстановки, см. readme-ru.txt).
    "formatHeader":  "<textformat leading='-2'><font color='#96FF00'>Дамаг противникам:</font> № <font size='13' color='#FFFF00'>{{n}}</font> всего: <font color='{{c:t-battles}}'>{{dmg-total}}</font> последний: <font color='{{c:dmg-kind}}'><b>{{dmg}}</b></font> <font color='{{c:vtype}}'>{{vehicle}}</font> <font color=''>({{nick}})</font></textformat>",
    // List of hits format (macros allowed, see readme-en.txt).
    // Формат лога попаданий (допускаются макроподстановки, см. readme-ru.txt)
    "formatHistory": "<textformat leading='-6' tabstops='[0,30,65,85,120,155]'> <font face='Consolas' size='13' color=''>\t <font color='#FFFF00'>\u00D7{{n}}</font>\t <font color='#FF0000'><b>{{dmg-player}}</b></font>\t <font color='#FFFF00'>{{n-player}}</font>\t <font color='{{c:dmg-kind}}'><b>{{dmg}}</b></font>\t <img src='xvmres://icons/{{dmg-kind}}_м.png' width='42' height='12'>\t <img src='xvmres://icons/type/{{vtype}}.png' width='15' height='15'><font color='{{c:vtype}}'>{{vehicle}}</font> <font color=''>({{nick}})</font> <font color='{{c:dmg-kind}}'><b>{{dead}}</b></font></font></textformat>",
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
      "size": 5,
      // Intensity.
      // Интенсивность.
      "strength": 150
    }
  }
}
