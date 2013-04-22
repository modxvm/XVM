/**
 *
 */
{
  // Лог попаданий (счетчик своих попаданий)
  "hitLog": {
    "visible": true,      // Переключатель вкл/выкл
    "x": 270,             // Позиция X (отрицательные значения - привязать к правой стороне экрана)
    "y": 5,               // Позиция Y (отрицательные значения - привязать к нижней стороне экрана)
    "w": 500,             // Ширина
    "h": 1000,            // Высота
    "lines": 0,           // Количество строк с попаданиями. Устаревшие данные выталкиваются.
    "direction": "down",  // Направление лога: up - строки добавляются сверху, down - снизу.
    "groupHitsByPlayer": true, // Группировать попадания по имени игрока
	"insertOrder": "end", // Сортировка попаданий: begin - новые значения добавляются сверху, end - снизу
    // Подстановка для макроса {{dead}}, когда танк умирает
    "deadMarker": "<font face='Wingdings'>N</font>",
    "blowupMarker": "<font face='Wingdings'>M</font>",
    // Формат заголовка по умолчанию (до первого попадания). Макросы НЕ допускаются.
    "defaultHeader":  "<font color='#FFFFFF'>Hits:</font> <font size='13'>#0</font>",
    // Формат заголовка (допускаются макроподстановки, см. readme-ru.txt)
    "formatHeader":  "<font color='#FFFFFF'>Hits:</font> <font size='13'>#{{n}}</font> <b>{{dmg-total}}</b>  <font color='#FFFFFF'>Last:</font> <font color='{{c:dmg-kind}}'><b>{{dmg}}</b> {{dead}}</font>",
    // Формат лога попаданий (допускаются макроподстановки, см. readme-ru.txt)
    "formatHistory": "<textformat leading='-4' tabstops='[20,50,90,150]'><font size='12'>\u00D7{{n-player}}:</font><tab>{{dmg-player}}<tab>| <font color='{{c:dmg-kind}}'>{{dmg}}</font><tab>| <font color='{{c:dmg-kind}}'>{{dmg-kind}}</font><tab>| <font color='{{c:vtype}}'>{{vehicle}} {{dead}}</font></textformat>",
    "shadow": {                       //   Параметры тени
      "alpha": 100,                   //     Прозрачность
      "color": "0x000000",            //     Цвет
      "angle": 45,                    //     Угол смещения
      "distance": 0,                  //     Дистанция смещения
      "size": 5,                      //     Размер
      "strength": 150                 //     Интенсивность
    }
  }
}
