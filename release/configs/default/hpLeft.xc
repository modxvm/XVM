/**
 * Show enemy HP left
 * Показывать оставшееся HP врагов
 */
{
  // Show enemy HP left by Alt press
  // Destroyed enemies and enemies HP gets updated only when it markers become visible.
  // Markers are visible only inside 564m circle.
  // Circle with 564 meters radius is game engine restriction. Maximum marker show distance.
  // Particular enemy data will not be updated while you cant see this enemy marker or its wreck.

  // Показывать оставшееся HP врагов по нажатию Alt
  // Уничтоженные враги и вражеское HP обновляется только, когда маркеры становятся видимыми.
  // Маркеры видимы только в круге радиусом 564м.
  // Круг радиусом 564 метров - это ограничение игрового движка. Максимальная дистанция отрисовки маркеров.
  // Данные по конкретному врагу не могут быть обновлены пока не видно его маркер или обломки.
  "hpLeft": {
    // false - Disable.
    // false - отключить.
    "enabled": true,
    // Header - Only localization macros are allowed, see macros.txt.
    // Заголовок - допускаются только макросы перевода, см. macros.txt.
    "header": "<font color='#FFFFFF'>{{l10n:hpLeftTitle}}</font>",
    // Row in HP list (macros allowed, see macros.txt).
    // Строка в списке попаданий (допускаются макроподстановки, см. macros.txt)
    "format": "<textformat leading='-4' tabstops='[50,90,190]'><font color='{{c:hp-ratio}}'>     {{hp}}</font><tab><font color='#FFFFFF'>/ </font>{{hp-max}}<tab><font color='#FFFFFF'>|</font><font color='{{c:vtype}}'>{{vehicle}}</font><tab><font color='#FFFFFF'>|{{name%.15s~..}} <font alpha='#A0'>{{clan}}</font></font></textformat>"
  }
}
