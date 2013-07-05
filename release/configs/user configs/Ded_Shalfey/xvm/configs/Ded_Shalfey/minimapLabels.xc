/**
 * Minimap labels. Basic HTML/CSS supported.
 * Надписи на миникарте. Поддерживают HTML.
 */
{
  "labels": {
      // Maximum nickname size for {{short-nick}} macro.
      // Максимальный размер ника для макроса {{short-nick}}.
      "nickShrink": 5,
      // {{vehicle-class}} macro substitutions.
      // Подстановки макроса {{vehicle-class}}.
      "vehicleclassmacro": {
        // ЛT ♦.
        "light": "\u003A",
        // СТ.
        "medium": "\u003B",
        // ТТ.
        "heavy": "\u003F",
        // ПТ ▼.
        "td": "\u002E",
        // Artillery / Арта.
        "spg": "\u002D",
        // HeavyTank10 by gui_settings.xml.
        // ТТ10 посредством gui_settings.xml.
        "superh": ""
        // Special symbols website / Сайт со спец символами:
        // http://www.fileformat.info/info/unicode/char/25a0/index.htm
        // Great symbolic font by Andrey_Hard for {{vehicle-class}}:
        // Отличный символьный шрифт от Andrey_Hard для замены букв от {{vehicle-class}} макроса:
        // http://goo.gl/d2KIj
      },
      // Textfields for tanks on minimap.
      // Текстовые поля для танков на миникарте.
      "units": {
        // Textfields switch for revealed units.
        // Выключатель добавочных текстовых полей для видимых юнитов.
        "revealedEnabled": true,
        // Textfields switch for lost enemy units. Show last seen position.
        // Выключатель текстовых полей для пропавших врагов.
        "lostEnemyEnabled": true,
        // Формат поля.
        "format": {
          // Союзник.
          "ally":  "<span class='mm_a'>{{vehicle}}</span>",
          // Враг.
          "enemy": "<span class='mm_e'>{{vehicle}}</span>",
          // Совзводный.
          "squad": "<textformat leading='-1'><span class='mm_s'><i>{{short-nick}}</i>\n{{vehicle}}</span><textformat>",
          // Lost enemy units.
          // Для пропавших с миникарты врагов.
          "lost":  "<span class='mm_dot'>\u2022</span><span class='mm_l'><i>{{vehicle}}</i></span>",
          // For your own marker or spectated subject.
          // Для своего маркера и маркера приёмника камеры наблюдения в случае смерти.
          "oneself": ""
        },
        // CSS style.
        // CSS стиль.
        "css": {
          "ally":  ".mm_a{font-family:$FieldFont; font-size:8px; color:#C8FFA6;}",
          "enemy": ".mm_e{font-family:$FieldFont; font-size:8px; color:#FCA9A4;}",
          "squad": ".mm_s{font-family:$FieldFont; font-size:8px; color:#FFC099;}",
          "lost":  ".mm_l{font-family:$FieldFont; font-size:8px; color:#FCA9A4;} .mm_dot{font-family:Arial; font-size:17px; color:#FCA9A4;}",
          "oneself": ".mm_o{font-family:$FieldFont; font-size:8px; color:#FFFFFF;}"
        },
        // Fields shadow.
        // Тени полей.
        "shadow": {
          "ally": {
            "enabled": true,
            "color": "0x000000",
            "distance": 0,
            "angle": 0,
            "alpha": 80,
            "blur": 3,
            "strength": 4
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
        // Field offset ralative to current icon (except lost - relative to enemy last seen position).
        // Смещение полей относительно текущей иконки (кроме lost - относительно последних координат видимой позиции).
        "offset": {
          "ally":  {"x": -4, "y": 2},
          "enemy": {"x": -4, "y": 2},
          "squad": {"x": -4, "y": -7},
          "lost":  {"x": -6, "y": -10},
          "oneself": {"x": 0, "y": 0}
        },
        // Прозрачность текстовых полей.
        "alpha" : {
          "ally":  100,
          "enemy": 100,
          "squad": 100,
          "lost":  70,
          "oneself": 100
        }
      },
      // Textfield for map side size. 1000m, 700m, 600m.
      // Works only with xvm-stat.exe for uncommon locales.
      // xvm-stat.exe is not necessary for RU, EN, DE and partially CH locale.
      // Поле размера стороны карты. Например, 1000м, 700м, 600м.
      "mapSize": {
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
        // Decrease sizes in case of map image weird shrinking while map resize.
        // Increase sizes in case of field being partially cut off.
        // -------------------------------------------------------------------------------------
        // Уменьшайте размеры, если при изменении размера миникарты изображение карты сжимается.
        // Увеличивайте размеры, если содержмиое поля обрезается.
        "width": 100,
        "height": 30
      }
    }
}