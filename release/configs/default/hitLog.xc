/**
 * Hit log (my hits calculator).
 * For additional settings see battleLabelsTemplates.xc/hitlog
 * Лог попаданий (счетчик своих попаданий).
 * Дополнительные настройки см. в battleLabelsTemplates.xc/hitlog
 */
{
  "hitLog": {
    // Group hits by players name.
    // Группировать попадания по имени игрока.
    "groupHitsByPlayer": true,
    // Insert order: begin - insert new values to begin, end - add to end.
    // Сортировка попаданий: begin - новые значения добавляются сверху, end - снизу.
    "insertOrder": "begin",
    // Substitution for {{hitlog.dead}} macro when tank is dead.
    // Подстановка для макроса {{hitlog.dead}}, когда танк умирает.
    "deadMarker": "&#x77;",
    "blowupMarker": "&#x78;",
    // Default header format (before first hit). Only localization macros are allowed, see macros.txt.
    // Формат заголовка по умолчанию (до первого попадания). Допускаются только макросы перевода, см. macros.txt.
    "defaultHeader":  "{{l10n:Hits}}: <font size='13'>#0</font>",
    // Hits header format, including last hit (macros allowed, see macros.txt).
    // Формат заголовка (допускаются макроподстановки, см. macros.txt).
    "formatHeader":  "{{l10n:Hits}}: <font size='13'>#{{hitlog.n}}</font> {{l10n:Total}}: <b>{{hitlog.dmg-total}}</b>  {{l10n:Last}}: <font color='{{c:dmg-kind}}'><b>{{dmg}}</b></font> <font face='xvm' size='21'>{{hitlog.dead=&#x77;?&#x29;|{{hitlog.dead=&#x78;?&#x28;}}}}</font>",
    // List of hits format (macros allowed, see macros.txt).
    // Формат лога попаданий (допускаются макроподстановки, см. macros.txt)
    "formatHistory": "<textformat leading='-4' tabstops='[20,50,90,190]'><font size='12'>\u00D7{{hitlog.n-player}}:</font><tab><font color='{{c:dmg-kind}}'>{{dmg}}</font><tab>| {{hitlog.dmg-player}}<tab>|<font color='{{c:vtype}}'>{{vehicle}}</font> <font face='xvm' size='19' color='#FF0000'>{{hitlog.dead}}</font><tab>|{{name%.15s~..}} <font alpha='#A0'>{{clan}}</font></textformat>"
  }
}
