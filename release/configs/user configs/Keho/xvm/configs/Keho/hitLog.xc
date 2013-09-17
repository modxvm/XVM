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
    "hpLeft": {
        // false - Disable.
        // false - отключить.
        "enabled": true,
        // Header - Only localization macros are allowed, see readme-en.txt.
        // Заголовок - допускаются только макросы перевода, см. readme-ru.txt.
        "header": "<font color='#FFFFFF'>{{l10n:hpLeftTitle}}</font>",
        // Row in HP list (macros allowed, see readme-en.txt).
        // Строка в списке попаданий (допускаются макроподстановки, см. readme-ru.txt)
        "format": "<textformat leading='-4' tabstops='[50,90,180]'><font color='{{c:hp-ratio}}'>     {{hp}}</font><tab><font color='#FFFFFF'>/ </font>{{hp-ratio}}\u0025<tab><font color='#FFFFFF'>|</font><font color='{{c:vtype}}'>{{vehicle}}</font><tab><font color='#FFFFFF'>|{{name}} <font color='#FF99FF'>{{clan}}</font></textformat>"
    },

    // X position (negative values - bind to right side of screen).
    // Позиция X (отрицательные значения - привязать к правой стороне экрана).
    "x": 0,
    // Y position (negative values - bind to bottom side of screen).
    // Позиция Y (отрицательные значения - привязать к нижней стороне экрана).
    "y": 450,
    // Width.
    // Ширина.
    "w": 600,
    // Height.
    // Высота.
    "h": 500,
    // Number of lines with hits. Old lines will be pushed out.
    // Количество строк с попаданиями. Устаревшие данные выталкиваются.
    "lines": 15,
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
    "deadMarker": "<img src='xvmres://icons/keho/a/1.png' width='14' height='14'>",
    "blowupMarker": "<img src='xvmres://icons/keho/a/1.png' width='14' height='14'>",
    // Default header format (before first hit). Only localization macros are allowed, see readme-en.txt.
    // Формат заголовка по умолчанию (до первого попадания). Допускаются только макросы перевода, см. readme-ru.txt.
    "defaultHeader":  "",
    // Hits header format, including last hit (macros allowed, see readme-en.txt).
    // Формат заголовка (допускаются макроподстановки, см. readme-ru.txt).
    "formatHeader":  "<font color='#FFFFFF'>{{l10n:Hits}}:</font> <font size='20'>×{{n}}</font> <font color='#FFFFFF'>{{l10n:Total}}: </font><font size='20'><font color='#FFFFFF'><b>{{dmg-total}}</b> ",
    // List of hits format (macros allowed, see readme-en.txt).
    // Формат лога попаданий (допускаются макроподстановки, см. readme-ru.txt)
    "formatHistory": "<textformat leading='-4' tabstops='[13,48,87,134,212]'><b><font color='#FFFFFF'><font size='13'>×{{n-player}}: </font></font><font size='13'><tab>{{dmg-player}}<tab>| <font color='{{c:dmg-kind}}'>{{dmg}}</font><tab>| <img src='xvmres://icons/Keho/hitlog/{{dmg-kind}}.png' width='15' height='15' vspace='0'><font size='13'>{{dead}}</font> <tab>| <font color='{{c:vtype}}'><font size='13'>{{vehicle}} </font></font><tab>|  <font color='#FFFFFF'><font size='12'>{{name}}</font></font></b> <font size='11'><font face='Consolas'><font color='#FF99FF'>{{clan}}</font></font></font></font></textformat>",
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
