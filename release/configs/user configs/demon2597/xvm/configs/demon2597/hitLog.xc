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
    // ----
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
        "header": "<u><font color='#E5E5E5'>{{l10n:hpLeftTitle}}</font></u>",
        // Row in HP list (macros allowed, see readme-en.txt).
        // Строка в списке HP (допускаются макроподстановки, см. readme-ru.txt)
        "format": "<textformat leading='-2' tabstops='[30,64,105]'><font color='#E5E5E5' size='13'><font color='{{c:hp-ratio}}'>{{hp}}<tab>({{hp-ratio}}\u0025<tab>/ {{hp-max}})<tab><font face='XVMSymbol' size='21'>{{vtype}}</font>  {{vehicle}}</font></font></textformat>"
    },
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
    // Default header format (before first hit). Only localization macros are allowed, see readme-en.txt.
    // Формат заголовка по умолчанию (до первого попадания). Допускаются только макросы перевода, см. readme-ru.txt.
    "defaultHeader":  "",
    // Hits header format, including last hit (macros allowed, see readme-en.txt).
    // Формат заголовка (допускаются макроподстановки, см. readme-ru.txt).
    "formatHeader": "<u><font color='#E5E5E5'>{{l10n:Hits}}: <b><font color='#FCFCFC'>{{n}}</font></b>  {{l10n:Total}}: <b><font color='#FFCC66'>{{dmg-total}}</font></b>  {{l10n:Last}}: <b><font color='#FCFCFC'>{{dmg}}</font></b></font></u>",
    // List of hits format (macros allowed, see readme-en.txt).
    // Формат лога попаданий (допускаются макроподстановки, см. readme-ru.txt).
    "formatHistory": "<textformat leading='-2' tabstops='[20,55,88,125,170]'><font color='#FFE1A6' size='13'><font color='#E5E5E5{{dead}}'><b></b{{dead}}>\u00D7{{n-player}}<tab>{{dmg-kind}}<tab>-{{dmg}}<tab>({{dmg-player}})</b></b><tab><font face='XVMSymbol'><font size='19'><font size='0{{dead}}'>{{dead}}</font></font><font size='0'><font size='19{{dead}}'>\u002A</font></font></font><tab><font face='XVMSymbol' size='21'>{{vtype}}</font>  <b></b{{dead}}>{{vehicle}}</b></b></font></font></textformat>",
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
