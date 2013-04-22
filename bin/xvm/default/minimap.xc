/**
 *
 */
{
  // Миникарта
  "minimap": {
    // Напоминалка: размер миникарты меняется по нажатию клавиш "-" и "=".
    // Через все поля можно подкачивать изображения с диска:
    //   "format": { "ally": "<img src='img://../icons/bzz.png' width='8' height='8'>"}, ...
    //   Файлы должны быть в WoT\res_mods\icons\bzz.png
    // Видео по некоторым аспектам редактирования http://www.youtube.com/watch?feature=player_embedded&v=NBJcqWuEoLo
    "enabled": true,                // false - отключить
    "mapBackgroundImageAlpha": 100, // Прозрачность изображения карты.
    "selfIconAlpha": 100,           // Прозрачность своей иконки. Белая стрелка
    "cameraAlpha": 100,             // Прозрачность камеры и прикрепленной геометрии. Зеленый треугольник.
    "iconScale": 1,                 // Размер иконки техники.
                                    // Не влияет на прикрепленную к геометрию и текстовые поля.
                                    // Можно дробные: 0.7 1.4.
    "zoom": { // Увеличение миникарты по нажатию кнопки. Кнопка задается в секции "keys" верхнего уровня в этом файле конфигурации.
      "pixelsBack": 160,  // Число пикселей для уменьшения миникарты от максимального размера
      "centered": true // Центрирование увеличенной миникарты по центру экрана
    },
    "labels": {                     // Текстовые поля. Поддерживают HTML.
      "nickShrink": 5,              // Максимальный размер ника для макроса {{short-nick}}.
      "vehicleclassmacro": {        // Подстановки макроса {{vehicle-class}}
        "light": "", // ЛT ♦
        "medium": "",// СТ
        "heavy": "", // ТТ
        "td": "",    // ПТ ▼
        "spg": "■",  // Арта
        "superh": "" // ТТ10 посредством gui_settings.xml
        // Сайт со спец символами:
        //   http://www.fileformat.info/info/unicode/char/25a0/index.htm
        // Отличный символьный шрифт от Andrey_Hard для замены букв от {{vehicle-class}} макроса:
        //   http://goo.gl/d2KIj
      },
      "units": { // Текстовые поля для танков на миникарте.
        "revealedEnabled": true, // Выключатель добавочных текстовых полей для видимых юнитов.
        "lostEnemyEnabled": true,// Выключатель текстовых полей для пропавших врагов.
        "format": { // Формат поля.
          "ally":  "<span class='mm_a'>{{vehicle}}</span>", // Союзник
          "enemy": "<span class='mm_e'>{{vehicle}}</span>", // Враг
          "squad": "<textformat leading='-1'><span class='mm_s'><i>{{short-nick}}</i>\n{{vehicle}}</span><textformat>", // Совзводный.
          "lost":  "<span class='mm_dot'>\u2022</span><span class='mm_l'><i>{{vehicle}}</i></span>",  // Для пропавших с миникарты врагов.
          "oneself": ""  // Для своего маркера и маркера приёмника камеры наблюдения в случае смерти.
        },
        "css": { // CSS стиль.
          "ally":  ".mm_a{font-family:$FieldFont; font-size:8px; color:#C8FFA6;}",
          "enemy": ".mm_e{font-family:$FieldFont; font-size:8px; color:#FCA9A4;}",
          "squad": ".mm_s{font-family:$FieldFont; font-size:8px; color:#FFC099;}",
          "lost":  ".mm_l{font-family:$FieldFont; font-size:8px; color:#FCA9A4;} .mm_dot{font-family:Arial; font-size:17px; color:#FCA9A4;}",
          "oneself": ".mm_o{font-family:$FieldFont; font-size:8px; color:#FFFFFF;}"
        },
        "shadow": { // Тени полей.
          "ally": {
            "enabled": true,
            "color": "0x000000",
            "distance": 0, // Дистанция тени относительно поля.
            "angle": 0,    // Угол тени при дистанции > 0
            "alpha": 80,   // Прозрачность
            "blur": 3,     // Размытие
            "strength": 4  // Сила
          },
          "enemy": {
            "enabled": true,
            "color": "0x000000",
            "distance": 0,
            "angle": 0,
            "alpha": 80,
            "blur": 3,
            "strength": 4
          },
          "squad": {
            "enabled": true,
            "color": "0x000000",
            "distance": 0,
            "angle": 0,
            "alpha": 80,
            "blur": 3,
            "strength": 4
          },
          "lost": {
            "enabled": true,
            "color": "0x000000",
            "distance": 0,
            "angle": 0,
            "alpha": 80,
            "blur": 6,
            "strength": 4
          },
          "oneself": {
            "enabled": true,
            "color": "0x000000",
            "distance": 0,
            "angle": 0,
            "alpha": 80,
            "blur": 3,
            "strength": 4
          }
        },
        "offset": { // Выравнивание
          "ally":  {"x": 3, "y": -1},   // Смещение поля относительно текущей иконки.
          "enemy": {"x": 3, "y": -1},   // Смещение поля относительно текущей иконки.
          "squad": {"x": 3, "y": -2},   // Смещение поля относительно текущей иконки.
          "lost":  {"x": -6, "y": -10}, // Смещение относительно последних координат видимой позиции.
          "oneself": {"x": 0, "y": 0}   // Смещение поля относительно текущей иконки.
        },
        "alpha" : { // Прозрачность текстовых полей.
          "ally":  100,
          "enemy": 100,
          "squad": 100,
          "lost":  70,
          "oneself": 100
        }
      },
      "mapSize": { // Поле размера стороны карты. Например, 1000м, 700м, 600м.
        "enabled": true,
        "format": "<b>{{cellsize}}0 м</b>",
        "css": "font-size:10px; color:#FFCC66;",
        "alpha": 80,
        "offsetX": 0,
        "offsetY": 0,
        "shadow": { // Тень.
          "enabled": true,
          "color": "0x000000",
          "distance": 0,
          "angle": 0,
          "alpha": 80,
          "blur": 2,
          "strength": 3
        },
        // Уменьшайте размеры, если при изменении размера миникарты изображение карты сжимается.
        // Увеличивайте размеры, если содержмиое поля обрезается.
        "width": 100,
        "height": 30
      }
    },
    "circles": { // Круги дальности. Дистанция только в реальных метрах карты. Только для своей техники.
        "enabled": true,
        "major": [ // Основные круги. thickness - толщина.
            { "enabled": true, "distance": 445, "thickness": 0.75, "alpha": 35, "color": "0xFFCC66" },  // 445 метров - максимальная дистанция засвета.
            { "enabled": false, "distance": 50, "thickness": 1, "alpha": 30, "color": "0xFFFFFF" }   // enabled : false <- выключен
        ],
        // Специальные круги, зависящие от модели техники.
        // Несколько строк для одной техники делают несколько кругов.
        // По умолчанию в списке только круги дальнобойности артиллерии с топ орудиями.
        //   Типы для дополнения брать по ссылке
        // http://code.google.com/p/wot-xvm/source/browse/trunk/src/xvm/src/wot/utils/VehicleInfoData2.as
        //   Дальнобойность арты может меняться в зависимости от углов постановки машины на склонах местности
        // и высоте расположения машины относительно цели. На миникарте эти факторы не учитываются.
        // Подробнее по ссылке: http://goo.gl/ZqlPa
        "special": [
            { "su_18":            { "enabled": true, "distance": 552,  "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "su_26":            { "enabled": true, "distance": 578,  "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "su_5":             { "enabled": true, "distance": 605,  "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "su_8":             { "enabled": true, "distance": 920,  "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "s_51":             { "enabled": true, "distance": 1229, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "su_14":            { "enabled": true, "distance": 1229, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "object_212":       { "enabled": true, "distance": 1229, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "object_261":       { "enabled": true, "distance": 1463, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },

            { "bison_i":          { "enabled": true, "distance": 605,  "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "sturmpanzer_ii":   { "enabled": true, "distance": 605,  "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "wespe":            { "enabled": true, "distance": 1000, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "grille":           { "enabled": true, "distance": 1210, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "hummel":           { "enabled": true, "distance": 1264, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "g_panther":        { "enabled": true, "distance": 1407, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "g_tiger":          { "enabled": true, "distance": 1172, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "g_e":              { "enabled": true, "distance": 1172, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },

            { "t57":              { "enabled": true, "distance": 552,  "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "m37":              { "enabled": true, "distance": 969,  "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "m7_priest":        { "enabled": true, "distance": 1047, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "m41":              { "enabled": true, "distance": 1210, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "m12":              { "enabled": true, "distance": 1316, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "m40m43":           { "enabled": true, "distance": 1179, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "t92":              { "enabled": true, "distance": 1248, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },

            { "renaultbs":        { "enabled": true, "distance": 450,  "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "lorraine39_l_am":  { "enabled": true, "distance": 844,  "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "amx_105am":        { "enabled": true, "distance": 1000, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "_105_lefh18b2":    { "enabled": true, "distance": 1000, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "amx_13f3am":       { "enabled": true, "distance": 1250, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "lorraine155_50":   { "enabled": true, "distance": 1202, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "lorraine155_51":   { "enabled": true, "distance": 1296, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "bat_chatillon155": { "enabled": true, "distance": 1296, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },

            { "gb78_sexton_i":    { "enabled": true, "distance": 767,  "thickness": 1, "alpha": 60, "color": "0xEE4444" } }
        ]
    },
    "lines": { // Линии. Только для своей техники.
       "enabled": false,
       // "inmeters": true  - дистанция линии в метрах реальной карты.
       // "inmeters": false - дистанция линии в точках миникарты. Сторона миникарты 210 точек.
       // "thickness" - толщина отрезка.
       // "from" - начало отрезка; "to" - конец.
       // Дистанция из угла в угол на километровой карте получается немногим более 1400 метров.
       // В секциях располагается произвольное кол-во отрезков.
       // Для постановки точки попробуйте отрезок длиной в единицу и с большой толщиной.
       // Для простоты можете оставить один длинный отрезок, не забыв убрать зяпятую. В конце секции запятая не ставится.
       "vehicle": [ // Направление корпуса своей техники.
         { "enabled": true, "from": 50,  "to": 95,  "inmeters": true, "thickness": 1.5, "alpha": 45, "color": "0x60FF00"},
         { "enabled": true, "from": 100, "to": 145, "inmeters": true, "thickness": 1.4, "alpha": 40, "color": "0x60FF00"},
         { "enabled": true, "from": 150, "to": 196, "inmeters": true, "thickness": 1.3, "alpha": 35, "color": "0x60FF00"},
         { "enabled": true, "from": 200, "to": 246, "inmeters": true, "thickness": 1.2, "alpha": 33, "color": "0x60FF00"},
         { "enabled": true, "from": 250, "to": 296, "inmeters": true, "thickness": 1.1, "alpha": 30, "color": "0x60FF00"},
         { "enabled": true, "from": 300, "to": 397, "inmeters": true, "thickness": 1,   "alpha": 30, "color": "0x60FF00"},
         { "enabled": true, "from": 400, "to": 497, "inmeters": true, "thickness": 0.9, "alpha": 30, "color": "0x60FF00"},
         { "enabled": true, "from": 500, "to": 2000,"inmeters": true, "thickness": 0.75, "alpha": 30, "color": "0x60FF00"}
       ],
       "camera": [ // Направление камеры от своей техники.
         { "enabled": true, "from": 50,  "to": 80,   "inmeters": true, "thickness": 1.3,  "alpha": 45, "color": "0xFFCC66"},
         { "enabled": true, "from": 120, "to": 180,  "inmeters": true, "thickness": 1.2,  "alpha": 40, "color": "0xFFCC66"},
         { "enabled": true, "from": 220, "to": 280,  "inmeters": true, "thickness": 1.1,  "alpha": 35, "color": "0xFFCC66"},
         { "enabled": true, "from": 320, "to": 380,  "inmeters": true, "thickness": 1,    "alpha": 30, "color": "0xFFCC66"},
         { "enabled": true, "from": 420, "to": 480,  "inmeters": true, "thickness": 0.9,  "alpha": 30, "color": "0xFFCC66"},
         { "enabled": true, "from": 520, "to": 580,  "inmeters": true, "thickness": 0.8,  "alpha": 30, "color": "0xFFCC66"},
         { "enabled": true, "from": 620, "to": 680,  "inmeters": true, "thickness": 0.75, "alpha": 30, "color": "0xFFCC66"},
         { "enabled": true, "from": 720, "to": 780,  "inmeters": true, "thickness": 0.75, "alpha": 30, "color": "0xFFCC66"},
         { "enabled": true, "from": 820, "to": 880,  "inmeters": true, "thickness": 0.75, "alpha": 30, "color": "0xFFCC66"},
         { "enabled": true, "from": 920, "to": 980,  "inmeters": true, "thickness": 0.75, "alpha": 30, "color": "0xFFCC66"},
         { "enabled": true, "from": 1020,"to": 1080, "inmeters": true, "thickness": 0.75, "alpha": 30, "color": "0xFFCC66"},
         { "enabled": true, "from": 1120,"to": 1180, "inmeters": true, "thickness": 0.75,  "alpha": 30, "color": "0xFFCC66"},
         { "enabled": true, "from": 1220,"to": 1280, "inmeters": true, "thickness": 0.75,  "alpha": 30, "color": "0xFFCC66"},
         { "enabled": true, "from": 1320,"to": 1380, "inmeters": true, "thickness": 0.75,  "alpha": 30, "color": "0xFFCC66"},
         { "enabled": true, "from": 1420,"to": 1480, "inmeters": true, "thickness": 0.75,  "alpha": 30, "color": "0xFFCC66"},
         { "enabled": true, "from": 1520,"to": 1580, "inmeters": true, "thickness": 0.75,  "alpha": 30, "color": "0xFFCC66"},
         { "enabled": true, "from": 1620,"to": 1680, "inmeters": true, "thickness": 0.75,  "alpha": 30, "color": "0xFFCC66"},
         { "enabled": true, "from": 1720,"to": 1780, "inmeters": true, "thickness": 0.75,  "alpha": 30, "color": "0xFFCC66"},
         { "enabled": true, "from": 1820,"to": 1880, "inmeters": true, "thickness": 0.75,  "alpha": 30, "color": "0xFFCC66"},
         { "enabled": true, "from": 1920,"to": 2000, "inmeters": true, "thickness": 0.75,  "alpha": 30, "color": "0xFFCC66"},
           //Точки
         { "enabled": true, "from": 99,  "to": 100,  "inmeters": true, "thickness": 2.2,   "alpha": 45, "color": "0xFFCC66"},
         { "enabled": true, "from": 199, "to": 200,  "inmeters": true, "thickness": 2.1,   "alpha": 40, "color": "0xFFCC66"},
         { "enabled": true, "from": 299, "to": 300,  "inmeters": true, "thickness": 2,     "alpha": 35, "color": "0xFFCC66"},
         { "enabled": true, "from": 399, "to": 400,  "inmeters": true, "thickness": 1.9,   "alpha": 30, "color": "0xFFCC66"},
         { "enabled": true, "from": 499, "to": 500,  "inmeters": true, "thickness": 1.8,   "alpha": 30, "color": "0xFFCC66"},
         { "enabled": true, "from": 599, "to": 600,  "inmeters": true, "thickness": 1.7,   "alpha": 30, "color": "0xFFCC66"},
         { "enabled": true, "from": 699, "to": 700,  "inmeters": true, "thickness": 1.6,   "alpha": 30, "color": "0xFFCC66"},
         { "enabled": true, "from": 799, "to": 800,  "inmeters": true, "thickness": 1.6,   "alpha": 30, "color": "0xFFCC66"},
         { "enabled": true, "from": 899, "to": 900,  "inmeters": true, "thickness": 1.6,   "alpha": 30, "color": "0xFFCC66"},
         { "enabled": true, "from": 999, "to": 1000, "inmeters": true, "thickness": 1.6,   "alpha": 30, "color": "0xFFCC66"},
         { "enabled": true, "from": 1099,"to": 1100, "inmeters": true, "thickness": 1.6,   "alpha": 30, "color": "0xFFCC66"},
         { "enabled": true, "from": 1199,"to": 1200, "inmeters": true, "thickness": 1.6,   "alpha": 30, "color": "0xFFCC66"},
         { "enabled": true, "from": 1299,"to": 1300, "inmeters": true, "thickness": 1.6,   "alpha": 30, "color": "0xFFCC66"},
         { "enabled": true, "from": 1399,"to": 1400, "inmeters": true, "thickness": 1.6,   "alpha": 30, "color": "0xFFCC66"},
         { "enabled": true, "from": 1499,"to": 1500, "inmeters": true, "thickness": 1.6,   "alpha": 30, "color": "0xFFCC66"}
       ],
       // Углы горизонтальной наводки могут меняться в зависимости от углов постановки машины на склонах местности.
       // Подробнее по ссылке: http://goo.gl/ZqlPa
       "traverseAngle": [ // Углы горизонтальной наводки. Срабатывают только, если углы есть.
         { "enabled": true, "from": 50,  "to": 95,  "inmeters": true, "thickness": 1.5,   "alpha": 50, "color": "0xCCCCCC"},
         { "enabled": true, "from": 100, "to": 145, "inmeters": true, "thickness": 1.4,   "alpha": 48, "color": "0xCCCCCC"},
         { "enabled": true, "from": 150, "to": 196, "inmeters": true, "thickness": 1.3,   "alpha": 46, "color": "0xCCCCCC"},
         { "enabled": true, "from": 200, "to": 246, "inmeters": true, "thickness": 1.2, "alpha": 44, "color": "0xCCCCCC"},
         { "enabled": true, "from": 250, "to": 296, "inmeters": true, "thickness": 1.1, "alpha": 42, "color": "0xCCCCCC"},
         { "enabled": true, "from": 300, "to": 397, "inmeters": true, "thickness": 1,   "alpha": 40, "color": "0xCCCCCC"},
         { "enabled": true, "from": 400, "to": 497, "inmeters": true, "thickness": 0.9,   "alpha": 40, "color": "0xCCCCCC"},
         { "enabled": true, "from": 500, "to": 2000,"inmeters": true, "thickness": 0.75,   "alpha": 40, "color": "0xCCCCCC"}
       ]
    },
    "square" : { // Квадрат со стороной 1000m. Показывает границы максимальной отрисовка юнитов.
      "enabled": false,
      "artilleryEnabled": false, // Показывать ли квадрат в случае артиллерии
      "thickness": 0.7, // Толщина
      "alpha": 40, // Прозрачность
      "color": "0xFFFFFF"
    }
  }
}
