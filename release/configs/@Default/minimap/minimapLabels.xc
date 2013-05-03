/**
 * Minimap labels.
 * Надписи на миникарте.
 */
{
  "labels": {                     // Текстовые поля. Поддерживают HTML.
      "nickShrink": 5,              // Максимальный размер ника для макроса {{short-nick}}.
      "vehicleclassmacro": {        // Подстановки макроса {{vehicle-class}}
        "light": "", // ЛT
        "medium": "",// СТ
        "heavy": "", // ТТ
        "td": "",    // ПТ
        "spg": "¦",  // Арта
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
    }
}