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
        // LT / ЛT ♦.
        "light": "LT",
        // MT / СТ.
        "medium": "MT",
        // HT / ТТ.
        "heavy": "HT",
        // TD / ПТ ▼.
        "td": "TD",
        // Artillery / Арта. ■
        "spg": "SPG",
        // HeavyTank10 by gui_settings.xml.
        // ТТ10 посредством gui_settings.xml.
        "superh": "superh"
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
        // Формат поля. Макросы: ник-{{short-nick}}, уровень-{{level}}, название танка-{{vehicle-type}}, укороченное название танка-{{vehicle-type-short}}, тип танка-{{vehicle-type}}, системное название танка - usa-M24_Chaffee-{vehicle-name}}.
        "format": {
          // Союзник.
          "ally":           "<textformat leading='-21'>\n<img src='xvmres://icons/map/ally/{{vehicle-class}}{{level}}.png' width='15' height='19'>\n<textformat leading='-2'><span class='mm_a'><b>{{short-nick}}</b></span>\n    <img src='xvmres://icons/level/{{level}}_ally_lostenemy.png' width='9' height='9'>\n<span class='mm_a'>{{vehicle-type}}</span></textformat>\n</textformat>",
          // Тимкиллер.
          "teamkiller":     "<textformat leading='-21'>\n<img src='xvmres://icons/map/teamkiller/{{vehicle-class}}{{level}}.png' width='15' height='19'>\n<textformat leading='-2'><span class='mm_t'><b>{{short-nick}}</b></span>\n    <img src='xvmres://icons/level/{{level}}_ally_lostenemy.png' width='9' height='9'>\n<span class='mm_t'>{{vehicle-type}}</span></textformat>\n</textformat>",
          // Враг.
          "enemy":          "<textformat leading='-21'>\n<img src='xvmres://icons/map/enemy/{{vehicle-class}}{{level}}.png' width='15' height='19'>\n<textformat leading='-2'><span class='mm_e'><b>{{vehicle-type}}</b></span>\n    <img src='xvmres://icons/level/{{level}}_enemy_lostenemy.png' width='9' height='9'>\n<span class='mm_e'>{{short-nick}}</span></textformat>\n</textformat>",
          // Взводный.
          "squad":          "<textformat leading='-21'>\n<img src='xvmres://icons/map/squad/{{vehicle-class}}{{level}}.png' width='15' height='19'>\n<textformat leading='-2'><span class='mm_s'><b>{{short-nick}}</b></span>\n    <img src='xvmres://icons/level/{{level}}_ally_lostenemy.png' width='9' height='9'><img src='xvmres://icons/frends.png' width='10' height='10'>\n<span class='mm_s'>{{vehicle-type}}</span></textformat>\n</textformat>",
          // Own marker or spectated subject.
          // Свой маркер и маркер приёмника камеры наблюдения в случае смерти.
          "oneself":        "<textformat leading='-21'>\n<img src='xvmres://icons/map/oneself/{{vehicle-class}}{{level}}.png' width='15' height='19'>\n<textformat leading='-2'><span class='mm_o'><b>{{short-nick}}</b></span>\n    <img src='xvmres://icons/level/{{level}}_ally_lostenemy.png' width='9' height='9'><img src='xvmres://icons/ya.png' width='10' height='10'><span class='mm_o'>{{vehicle-type}}</span></textformat>\n</textformat>",
          // Out of radio range ally
          // Союзник, с которым потеряна связь
          "lostally":       "<textformat leading='-21'>\n<img src='xvmres://icons/map/lostally/{{vehicle-class}}{{level}}.png' width='15' height='19'>\n<textformat leading='-2'><span class='mm_la'><b>{{short-nick}}</b></span>\n    <img src='xvmres://icons/level/{{level}}_ally_lostenemy.png' width='9' height='9'>\n<span class='mm_la'>{{vehicle-type}}</span></textformat>",
          // Out of radio range teamkiller
          // Тимкиллер, с которым потеряна связь
          "lostteamkiller": "<textformat leading='-21'>\n<img src='xvmres://icons/map/teamkiller/{{vehicle-class}}{{level}}.png' width='15' height='19'>\n<textformat leading='-2'><span class='mm_lt'><b>{{short-nick}}</b></span>\n    <img src='xvmres://icons/level/{{level}}_ally_lostenemy.png' width='9' height='9'>\n<span class='mm_lt'>{{vehicle-type}}</span></textformat>\n</textformat>",
          // Lost enemy units.
          // Противник, пропавший из засвета
          "lost":           "<textformat leading='-21'>\n<img src='xvmres://icons/map/lost/{{vehicle-class}}{{level}}.png' width='15' height='19'>\n<textformat leading='-2'><span class='mm_l'><b>{{vehicle-type}}</b></span>\n    <img src='xvmres://icons/level/{{level}}_enemy.png' width='9' height='9'>\n<span class='mm_l'>{{short-nick}}</span></textformat>\n</textformat>",
          // Out of radio range squadman
          // Взводный, с которым потеряна связь
          "lostsquad":      "<textformat leading='-21'>\n<img src='xvmres://icons/map/squad/{{vehicle-class}}{{level}}.png' width='15' height='19'>\n<textformat leading='-2'><span class='mm_ls'><b>{{short-nick}}</b></span>\n    <img src='xvmres://icons/level/{{level}}_ally_lostenemy.png' width='9' height='9'><img src='xvmres://icons/frends.png' width='10' height='10'>\n<span class='mm_ls'>{{vehicle-type}}</span></textformat>\n</textformat>",
          // Мертвый союзник.
          "deadally":       "<img src='xvmres://icons/map/deadally/{{vehicle-class}}.png' width='30' height='30'>",
          // Мертвый тимкиллер.
          "deadteamkiller": "<img src='xvmres://icons/map/teamkiller/{{vehicle-class}}.png' width='30' height='30'>",
          // Мертвый противник.
          "deadenemy":      "<img src='xvmres://icons/map/deadenemy/{{vehicle-class}}.png' width='30' height='30'>",
          // Мертвый взводный.
          "deadsquad":      "<img src='xvmres://icons/map/deadsquad/{{vehicle-class}}.png' width='30' height='30'>"
        },
        // CSS style (fonts and colors option)
        // CSS стиль (настройка шрифтов и цветов)
        "css": {
          "ally":            ".mm_a{font-family:$FieldFont; font-size:8px; color:#96FF00;}", //C8FFA6
          "teamkiller":      ".mm_t{font-family:$FieldFont; font-size:8px; color:#00EAFF;}", //A6F8FF
          "enemy":           ".mm_e{font-family:$FieldFont; font-size:8px; color:#F50800;}", //FCA9A4
          "squad":           ".mm_s{font-family:$FieldFont; font-size:8px; color:#FFB964;}", //FFD099
          "oneself":         ".mm_o{font-family:$FieldFont; font-size:8px; color:#FF00DC;}", //FF00DC
          "lostally":       ".mm_la{font-family:$FieldFont; font-size:8px; color:#FFF80D;} .mm_dot{font-family:Arial; font-size:10px; color:#B4E595;}", //C8FFA6
          "lostteamkiller": ".mm_lt{font-family:$FieldFont; font-size:8px; color:#00EAFF;} .mm_dot{font-family:Arial; font-size:10px; color:#00D2E5;}", //A6F8FF
          "lost":            ".mm_l{font-family:$FieldFont; font-size:8px; color:#8278FE;} .mm_dot{font-family:Arial; font-size:10px; color:#E59995;}", //FCA9A4
          "lostsquad":      ".mm_ls{font-family:$FieldFont; font-size:8px; color:#FFB964;} .mm_dot{font-family:Arial; font-size:10px; color:#E5BB8A;}", //FFD099
          "deadally":       ".mm_da{font-family:$FieldFont; font-size:8px; color:#96FF00;} .mm_dot{font-family:Arial; font-size:10px; color:#004D00;}", //6E8C5B
          "deadteamkiller": ".mm_dt{font-family:$FieldFont; font-size:8px; color:#00EAFF;} .mm_dot{font-family:Arial; font-size:10px; color:#043A40;}", //5B898C
          "deadenemy":      ".mm_de{font-family:$FieldFont; font-size:8px; color:#F50800;} .mm_dot{font-family:Arial; font-size:10px; color:#4D0300;}", //996763
          "deadsquad":      ".mm_ds{font-family:$FieldFont; font-size:8px; color:#FFB964;} .mm_dot{font-family:Arial; font-size:10px; color:#663800;}"  //997C5C
        },
        // Fields shadow.
        // Тени полей.
        // "distance"- дистанция тени относительно поля, "angle"- угол тени при дистанции > 0, "alpha"- прозрачность, "blur"- размытие, "strength'- сила.
        "shadow": {
          "ally": 
           { "enabled": true, "color": "0x000000", "distance": 0, "angle": 0, "alpha": 100, "blur": 2, "strength": 6 },
          "teamkiller": 
           { "enabled": true, "color": "0x000000", "distance": 0, "angle": 0, "alpha": 100, "blur": 2, "strength": 6 },
          "enemy": 
           { "enabled": true, "color": "0x000000", "distance": 0, "angle": 0, "alpha": 100, "blur": 2, "strength": 6 },
          "squad": 
           { "enabled": true, "color": "0x000000", "distance": 0, "angle": 0, "alpha": 100, "blur": 2, "strength": 6 },
          "oneself": 
           { "enabled": true, "color": "0x000000", "distance": 0, "angle": 0, "alpha": 100, "blur": 2, "strength": 6 },
          "lostally": 
           { "enabled": true, "color": "0x000000", "distance": 0, "angle": 0, "alpha": 100, "blur": 2, "strength": 6 },
          "lostteamkiller": 
           { "enabled": true, "color": "0x000000", "distance": 0, "angle": 0, "alpha": 100, "blur": 2, "strength": 6 },
          "lost": 
           { "enabled": true, "color": "0x000000", "distance": 0, "angle": 0, "alpha": 100, "blur": 2, "strength": 6 },
          "lostsquad": 
           { "enabled": true, "color": "0x000000", "distance": 0, "angle": 0, "alpha": 100, "blur": 2, "strength": 6 },
          "deadally": 
           { "enabled": true, "color": "0x000000", "distance": 0, "angle": 0, "alpha": 100, "blur": 2, "strength": 6 },
          "deadteamkiller": 
           { "enabled": true, "color": "0x000000", "distance": 0, "angle": 0, "alpha": 100, "blur": 2, "strength": 6 },
          "deadenemy": 
           { "enabled": true, "color": "0x000000", "distance": 0, "angle": 0, "alpha": 100, "blur": 2, "strength": 6 },
          "deadsquad": 
           { "enabled": true, "color": "0x000000", "distance": 0, "angle": 0, "alpha": 100, "blur": 2, "strength": 6 }
        },
        // Field offset ralative to current icon (except lost - relative to enemy last seen position).
        // Смещение полей относительно текущей иконки (кроме lost и dead- относительно последних координат видимой позиции).
        "offset": {
          "ally":           {"x": -9.5, "y": -3.5},
          "teamkiller":     {"x": -9.5, "y": -3.5},
          "enemy":          {"x": -9.5, "y": -3.5},
          "squad":          {"x": -9.5, "y": -3.5},
          "oneself":        {"x": -13, "y": -16},
          "lostally":       {"x": -9.5, "y": -3.5},
          "lostteamkiller": {"x": -9.5, "y": -3.5},
          "lost":           {"x": -9.5, "y": -3.5},
          "lostsquad":      {"x": -9.5, "y": -3.5},
          "deadally":       {"x": -17, "y": -17},
          "deadteamkiller": {"x": -17, "y": -17},
          "deadenemy":      {"x": -17, "y": -17},
          "deadsquad":      {"x": -17, "y": -17}
        },
        // Прозрачность текстовых полей.
        "alpha" : {
          "ally": 100,
          "teamkiller": 100,
          "enemy": 100,
          "squad": 100,
          "oneself": 100,
          "lostally": 100,
          "lostteamkiller": 70,
          "lost": 70,
          "lostsquad": 70,
          "deadally": 70,
          "deadteamkiller": 70,
          "deadenemy": 70,
          "deadsquad": 70
        }
      },
      // Textfield for map side size. 1000m, 700m, 600m.
      // Поле размера стороны карты. Например, 1000м, 700м, 600м.
      "mapSize": {
        "enabled": true,
        "format": "<b>{{cellsize}}0 m</b>(<font color='#FE0E00'>■</font>stock   <font color='#60FF00'>■</font>top   <font color='#D042F3'>■</font>module   <font color='#00EAFF'>■</font>max)",
        "css": "font-size:6px; color:#FFFFFF;",
        "alpha": 100,
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