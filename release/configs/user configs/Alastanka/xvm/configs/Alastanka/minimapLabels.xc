/**
 * Minimap labels. Basic HTML/CSS supported.
 * Надписи на миникарте. Поддерживают HTML.
 */
{
  "labels": {
      // Maximum nickname size for {{short-nick}} macro.
      // Максимальный размер ника для макроса {{short-nick}}.
      "nickShrink": 7,
      // {{vehicle-class}} macro substitutions.
      // Подстановки макроса {{vehicle-class}}.
      "vehicleclassmacro": {
        // ЛT ♦.
        "light": "<img src='xvmres://icons/minimap/light.png' width='15' height='19'>",
        // СТ.
        "medium": "<img src='xvmres://icons/minimap/medium.png' width='15' height='19'>",
        // ТТ.
        "heavy": "<img src='xvmres://icons/minimap/heavy.png' width='15' height='19'>",
        // ПТ ▼.
        "td": "<img src='xvmres://icons/minimap/td.png' width='15' height='19'>",
        // Artillery / Арта. ■
        "spg": "<img src='xvmres://icons/minimap/spg.png' width='15' height='19'>",
        // HeavyTank10 by gui_settings.xml.
        // ТТ10 посредством gui_settings.xml.
        "superh": "<img src='xvmres://icons/minimap/superh.png' width='15' height='19'>"
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
        // Формат поля. Макросы: ник-{{short-nick}}, уровень-{{level}}, название танка-{{vehicle-type}}, укороченное название танка-{{vehicle-type-short}}, тип танка-{{vtype}}, системное название танка - usa-M24_Chaffee-{vehicle-name}}.
        "format": {
          // Союзник.
          "ally":  "<textformat leading='-2'><span class='mm_a'><b>{{short-nick}}</b></span>\n<img src='xvmres://icons/level/{{level}}_ally_lostenemy.png' width='8' height='8'>\n<span class='mm_a'>{{vehicle-type}}</span></textformat>",
          // Враг.
          "enemy": "<textformat leading='-2'><span class='mm_e'><b>{{vehicle-type}}</b></span>\n<img src='xvmres://icons/level/{{level}}_enemy_lostenemy.png' width='8' height='8'>\n<span class='mm_e'>{{short-nick}}</span></textformat>",
          // Совзводный.
          "squad": "<textformat leading='-2'><span class='mm_s'><b>{{short-nick}}</b></span>\n<img src='xvmres://icons/frends.png' width='8' height='8'>\n<span class='mm_s'>{{vehicle-type}}</span></textformat>",
          // Lost enemy units.
          // Для пропавших с миникарты врагов.
          "lost":  "<textformat leading='-21'>\n{{vehicle-class}}\n<textformat leading='-2'><span class='mm_l'><b>{{vehicle-type}}</b></span>\n<img src='xvmres://icons/level/{{level}}_enemy.png' width='7' height='7'>\n<span class='mm_l'>{{short-nick}}</span></textformat>\n</textformat>",
          // For your own marker or spectated subject.
          // Для своего маркера и маркера приёмника камеры наблюдения в случае смерти.
          "oneself": "<textformat leading='-2'><span class='mm_o'><b> </b></span>\n  <img src='xvmres://icons/ya.png' width='10' height='10'><span class='mm_o'> </span></textformat>"
        },
        // CSS style.
        // CSS стиль.
        "css": {
          "ally":  ".mm_a{font-family:$FieldFont; font-size:8px; color:#96FF00;}",
          "enemy": ".mm_e{font-family:$FieldFont; font-size:8px; color:#F50800;}",
          "squad": ".mm_s{font-family:$FieldFont; font-size:8px; color:#FFB964;}",
          "lost":  ".mm_l{font-family:$FieldFont; font-size:8px; color:#8278FE;} .mm_lclass{font-family:Arial; font-size:10px; color:#FFBBDD;}",
          "oneself": ".mm_o{font-family:$FieldFont; font-size:8px; color:#FF00DC;}"
        },
        // Fields shadow.
        // Тени полей.
        "shadow": {
          "ally": {							// союзник
            "enabled": true,
            "color": "0x000000",
            "distance": 0,
            "angle": 0,
            "alpha": 100,
            "blur": 2,
            "strength": 6
          },
          "enemy": {						// враг
            "enabled": true,
            "color": "0x000000",
            "distance": 0,
            "angle": 0,
            "alpha": 100,
            "blur": 2,
            "strength": 6
          },
          "squad": {						// взводный
            "enabled": true,
            "color": "0x000000",
            "distance": 0,
            "angle": 0,
            "alpha": 100,
            "blur": 2,
            "strength": 6
          },
          "lost": {							// пропавший
            "enabled": true,
            "color": "0x000000",
            "distance": 0,
            "angle": 0,
            "alpha": 100,
            "blur": 2,
            "strength": 6
          },
          "oneself": {						// вы 
            "enabled": true,
            "color": "0x000000",
            "distance": 0,
            "angle": 0,
            "alpha": 100,
            "blur": 2,
            "strength": 6
          }
        },
        // Field offset ralative to current icon (except lost - relative to enemy last seen position).
        // Смещение полей относительно текущей иконки (кроме lost - относительно последних координат видимой позиции).
        "offset": {
          "ally":  {"x": -10, "y": -14},	// союзник 
          "enemy": {"x": -10, "y": -14},	// враг
          "squad": {"x": -10, "y": -14},	// взводный
          "lost":  {"x": -9, "y": -3},		// пропавший
          "oneself": {"x": -13, "y": -16}	// вы 
        },
        // Прозрачность текстовых полей.
        "alpha" : {
          "ally":  100,
          "enemy": 100,
          "squad": 100,
          "lost":  80,
          "oneself": 100
        }
      },
      // Textfield for map side size. 1000m, 700m, 600m.
      // Works only with xvm-stat.exe for uncommon locales.
      // xvm-stat.exe is not necessary for RU, EN, DE and partially CH locale.
      // Поле размера стороны карты. Например, 1000м, 700м, 600м.
      "mapSize": {
        "enabled": true,
        "format": "<b>{{cellsize}}0 м</b>   (<font size='6' color='#F50800'>сток</b></font>   <font size='6' color='#7FDC00'>топ</b></font>   <font size='6' color='#D042F3'>модули</b></font>   <font size='6' color='#00EAFF'>max</b></font>)",
        "css": "font-size:6px; color:#FFFFFF;",
        "alpha": 70,
        "offsetX": 0,
        "offsetY": 0,
        "shadow": { // Тень.
          "enabled": true,
          "color": "0x000000",
          "distance": 0,
          "angle": 0,
          "alpha": 100,
          "blur": 2,
          "strength": 6
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