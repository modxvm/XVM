/**
 * Options for alive with Alt markers.
 * Настройки маркеров для живых с Alt.
 */
{
  // Floating damage values.
  // Всплывающий урон.
  "damageText": {
    // false - disable / не отображать.
    "visible": true,
    // Axis field coordinates
    // Положение поля по осям
    "x": 0,
    "y": -67,
    // Opacity (dynamic transparency allowed, see readme-en.txt).
    // Прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
    "alpha": 100,
    // Color (dynamic colors allowed, see readme-en.txt).
    // Цвет (допускается использование динамического цвета, см. readme-ru.txt)
    "color": null,
    // Параметры шрифта.
    "font": {
      "name": "$FieldFont",           // Font name      / Название
      "size": 18,                     // Font size      / Размер
      "align": "center",              // Text alignment (left, center, right) /   Выравнивание текста (left, center, right)
      "bold": false,                  // True - bold    / Жирный.
      "italic": false                 // True - italic  / Курсив.
    },
    // Параметры тени.
    "shadow": {
      "alpha": 100,                   // Opacity          / Прозрачность.
      "color": "0x000000",            //                    Цвет.
      "angle": 45,                    // Offset angle     / Угол смещения.
      "distance": 0,                  // Offset distance  / Дистанция смещения.
      "size": 6,                      //                    Размер.
      "strength": 200                 // Intensity        / Интенсивность.
    },
    // Rising speed of displayed damage (float up speed).
    // Время отображения отлетающего урона.
    "speed": 6,
    // Maximimum distance of target for which damage rises.
    // Расстояние, на которое отлетает урон.
    "maxRange": 140,
    // Text for normal damage (see description of macros in the readme-en.txt).
    // Текст при обычном уроне (см. описание макросов в readme-ru.txt).
    "damageMessage": "<font color='{{c:dmg-kind}}'>-{{dmg}} ({{hp-ratio}}\u0025)</font> <img src='xvmres://icons/{{c:dmg-kind}}.png' width='52' height='45'>",
    // Text for ammo rack explosion (see description of macros in the readme-en.txt).
    // Текст при взрыве боеукладки (см. описание макросов в readme-ru.txt).
    "blowupMessage": "<img src='xvmres://icons/blowup.png' width='52' height='45'> <font color='{{c:dmg-kind}}'>-{{dmg}} ({{hp-ratio}}\u0025)</font>"
  },
// союзник
// союзник/живой/расширенный режим (c Alt)
  "ally": {
          "vehicleIcon": {                    // иконка типа танка (тт/ст/лт/пт/арта)
            "visible": true,                  //   false - не отображать
            "showSpeaker": false,             //   true - Показывать спикер даже если visible=false
            "x": 0,                           //   положение по оси X
            "y": -16,                         //   положение по оси Y
            "alpha": 100,                     //   прозрачность
            "color": null,                    //   цвет (в данный момент не используется)
            "maxScale": 100,                  //   максимальный масштаб (по умолчанию 100)
            "scaleX": 0,                      //   смещение по оси X (?)
            "scaleY": 16,                     //   смещение по оси Y (?)
            "shadow": {                       //   параметры тени
              "alpha": 100,                   //     прозрачность
              "color": "0x000000",            //     цвет
              "angle": 45,                    //     угол смещения
              "distance": 0,                  //     дистанция смещение
              "size": 6,                      //     размер
              "strength": 200                 //     интенсивность
            }
          },
          "healthBar": {                      // индикатор здоровья
            "visible": true,                  //   false - не отображать
            "x": -41,                         //   положение по оси X
            "y": -33,                         //   положение по оси Y
            "alpha": 100,                     //   прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
            "color": null,                    //   цвет основной (допускается использование динамического цвета, см. readme-ru.txt)
            "lcolor": null,                   //   цвет дополнительный (для градиента)
            "width": 80,                      //   ширина полосы здоровья
            "height": 12,                     //   высота полосы здоровья
            "border": {                       //   параметры подложки и рамки
              "alpha": 30,                    //     прозрачность
              "color": "0x000000",            //     цвет
              "size": 1                       //     размер рамки
            },
            "fill": {                         //   параметры оставшегося здоровья
              "alpha": 30                     //     прозрачность
            },                                //
            "damage": {                       //   параметры анимации отнимаемого здоровья
              "alpha": 80,                    //     прозрачность
              "color": "0xFFFF00",                  //     цвет
              "fade": 1                       //     время затухания в секундах
            }
          },
          "damageText": {
            "$ref": { "path":"damageText" },
            "damageMessage": "<font color='{{c:dmg-kind}}'>-{{dmg}} ({{hp-ratio}}\u0025)</font> <img src='xvmres://icons/{{c:dmg-kind}}.png' width='52' height='45'>"
          },
          "damageTextPlayer": {
            "$ref": { "path":"damageText" },
            "damageMessage": "<font color='{{c:dmg-kind}}'>-{{dmg}} ({{hp-ratio}}\u0025)</font> <img src='xvmres://icons/{{c:dmg-kind}}.png' width='52' height='45'>"
          },
          "damageTextSquadman": {
            "$ref": { "path":"damageText" },
            "damageMessage": "<font color='{{c:dmg-kind}}'>-{{dmg}} ({{hp-ratio}}\u0025)</font> <img src='xvmres://icons/{{c:dmg-kind}}.png' width='52' height='45'>"
          },
          "contourIcon": {                    // иконки танка
            "visible": false,                 //   false - не отображать
            "x": 6,                           //   положение по оси X
            "y": -65,                         //   положение по оси Y
            "alpha": 100,                     //   прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
            "color": null,                    //   цвет (допускается использование динамического цвета, см. readme-ru.txt)
            "amount": 0                       //   интенсивность цвета от 0 до 100. По умолчанию 0, т.е. выключено.
          },
          "clanIcon": {                       // Иконка игрока/клана
            "visible": false,                 //   false - не отображать
            "x": 0,                           //   положение по оси X
            "y": -67,                         //   положение по оси Y
            "w": 16,                          //   ширина
            "h": 16,                          //   высота
            "alpha": 100                      //   прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
          },
          "levelIcon": {                      // уровень танка
            "visible": true,                 //   false - не отображать
            "x": 0,                           //   положение по оси X
            "y": -25,                         //   положение по оси Y
            "alpha": 100                      //   прозрачность
          },
          "actionMarker": {                   // маркеры "Нужна помощь" и "Атакую"
            "visible": true,                  //   false - не отображать
            "x": 0,                           //   положение по оси X
            "y": -67,                         //   положение по оси Y
            "alpha": 100                      //   прозрачность
          },
          // Блок текстовых полей
          "textFields": [
            // Текстовое поле с именем игрока
            {
              "name": "Имя игрока",           // название текстового поля, ни на что не влияет
              "visible": true,                // false - не отображать
              "x": 0,                         // положение по оси X
              "y": -48,                       // положение по оси Y
              "alpha": 100,                   // прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
              "color": null,                  // цвет (допускается использование динамического цвета, см. readme-ru.txt)
              "font": {                       // параметры шрифта
                "name": "$FieldFont",         //   название
                "size": 13,                   //   размер
                "align": "center",            //   выравнивание текста (left, center, right)
                "bold": false,                //   обычный (false) или жирный (true)
                "italic": false               //   обычный (false) или курсив (true)
              },
              "shadow": {                     // параметры тени
                "alpha": 100,                 //   прозрачность
                "color": "0x000000",          //   цвет
                "angle": 45,                  //   угол смещения
                "distance": 0,                //   дистанция смещение
                "size": 6,                    //   размер
                "strength": 200               //   интенсивность
              },
              "format": "{{nick}}"            // формат текста. См. описание макросов в readme-ru.txt
            },
            // Текстовое поле с процентом оставшегося здоровьем
            {
              "name": "Процент здоровья",     // название текстового поля, ни на что не влияет
              "visible": true,                // false - не отображать
              "x": 0,                         // положение по оси X
              "y": -20,                       // положение по оси Y
              "alpha": 100,                   // прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
              "color": "0xFFFFFF",            // цвет (допускается использование динамического цвета, см. readme-ru.txt)
              "font": {                       // параметры шрифта
                "name": "$FieldFont",         //   название
                "size": 11,                   //   размер
                "align": "center",            //   выравнивание текста (left, center, right)
                "bold": true,                 //   обычный (false) или жирный (true)
                "italic": false               //   обычный (false) или курсив (true)
              },
              "shadow": {                     // параметры тени
                "alpha": 100,                 //   прозрачность
                "color": "0x000000",          //   цвет
                "angle": 45,                  //   угол смещения
                "distance": 0,                //   дистанция смещение
                "size": 4,                    //   размер
                "strength": 100               //   интенсивность
              },
              // символ процента - \u0025
              "format": "{{hp-ratio}}\u0025"  // формат текста. См. описание макросов в readme-ru.txt
            },
            // текстовое поле с рейтингом
            {
              "name": "Процент побед",
              "visible": true,
              "x": 25,
              "y": -58,
              "alpha": 100,
              "color": "{{c:rating}}",
              "font": {
                "name": "$FieldFont",
                "size": 13,
                "align": "center",
                "bold": false,
                "italic": false
              },
              "shadow": {
                "alpha": 100,
                "color": "0x000000",
                "angle": 45,
                "distance": 0,
                "size": 6,
                "strength": 200
              },
              "format": "{{rating}}"
            },
            {
              "shadow": {
                "angle": 45,
                "distance": 1,
                "strength": 200,
                "size": 2,
                "alpha": 100,
                "color": "0x000000"
              },
              "name": "Эффективность",
              "x": 0,
              "y": -58,
              "visible": true,
              "format": "{{wn}}",
              "font": {
                "bold": false,
                "align": "center",
                "size": 13,
                "name": "$FieldFont"
              },
              "alpha": 100,
              "color": "{{c:wn}}"
            },
            {
              "shadow": {
                "angle": 45,
                "distance": 1,
                "strength": 200,
                "size": 2,
                "alpha": 100,
                "color": "0x000000"
              },
              "name": "Количество кило боев",
              "x": -25,
              "y": -58,
              "visible": true,
              "format": "{{kb}}",
              "font": {
                "bold": false,
                "align": "center",
                "size": 13,
                "name": "$FieldFont"
              },
              "alpha": 100,
              "color": "{{c:kb}}"
            },
            // Текстовое поле с названием танка
            {
              "name": "Название танка",       // название текстового поля, ни на что не влияет
              "visible": true,                // false - не отображать
              "x": 0,                         // положение по оси X
              "y": -36,                       // положение по оси Y
              "alpha": 100,                   // прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
              "color": null,                  // цвет (допускается использование динамического цвета, см. readme-ru.txt)
              "font": {                       // параметры шрифта
                "name": "$FieldFont",         //   название
                "size": 13,                   //   размер
                "align": "center",            //   выравнивание текста (left, center, right)
                "bold": false,                //   обычный (false) или жирный (true)
                "italic": false               //   обычный (false) или курсив (true)
              },
              "shadow": {                     // параметры тени
                "alpha": 100,                 //   прозрачность
                "color": "0x000000",          //   цвет
                "angle": 45,                  //   угол смещения
                "distance": 0,                //   дистанция смещение
                "size": 6,                    //   размер
                "strength": 200               //   интенсивность
              },
              "format": "{{vehicle}}" // формат текста. См. описание макросов в readme-ru.txt
            },
            // Субъект уязвим. {{turret}}
            {
              "name": "Сток танк",            // название текстового поля, ни на что не влияет
              "visible": true,                // false - не отображать
              "x": 0,                         // положение по оси X
              "y": -80,                       // положение по оси Y
              "alpha": 100,                   // прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
              "color": "0xA0CFFF",                  // цвет (допускается использование динамического цвета, см. readme-ru.txt)
              "font": {                       // параметры шрифта
                "name": "$FieldFont",         //   название
                "size": 13,                   //   размер
                "align": "center",            //   выравнивание текста (left, center, right)
                "bold": true,                 //   обычный (false) или жирный (true)
                "italic": false               //   обычный (false) или курсив (true)
              },
              "shadow": {                     // параметры тени
                "alpha": 100,                 //   прозрачность
                "color": "0x000000",          //   цвет
                "angle": 45,                  //   угол смещения
                "distance": 0,                //   дистанция смещение
                "size": 6,                    //   размер
                "strength": 200               //   интенсивность
              },
              "format": "{{turret}}" // формат текста. См. описание макросов в readme-ru.txt
            },
     // Статистика над танком Дополнительно({{tdb}}-(д)средний Дамаг на танке за бой, {{tfb}}-(ф)средний Фраг на танке за бой, {{tsb}}-(з)средний Засвет на танке за бой, {{e}}-(р)Рейтинг на танке 1-9)
            {
              "name": "Статистика дополнительно",      // название текстового поля, ни на что не влияет
              "visible": true,                // false - не отображать
              "x": 0,                         // положение по оси X
              "y": -70,                      // положение по оси Y
              "alpha": 100,                   // прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
              "color": "0xFFFFFF",                  // цвет (допускается использование динамического цвета, см. readme-ru.txt)
              "font": {                       // параметры шрифта
                "name": "$FieldFont",         //   название
                "size": 13,                   //   размер
                "align": "center",            //   выравнивание текста (left, center, right)
                "bold": false,                //   обычный (false) или жирный (true)
                "italic": false               //   обычный (false) или курсив (true)
              },
              "shadow": {                     // параметры тени
                "alpha": 100,                 //   прозрачность
                "color": "0x000000",          //   цвет
                "angle": 90,                  //   угол смещения
                "distance": 0,                //   дистанция смещение
                "size": 6,                    //   размер
                "strength": 200               //   интенсивность
              },
              "format": "<font size='0{{c:e}}'>р-<font color='{{c:e}}'>{{e}}</font>|д-<font color='{{c:tdb}}'>{{tdb}}</font>|ф-<font color='{{c:tfb}}'>{{tfb}}</font>|з-<font color='{{c:tsb}}'>{{tsb}}</font></font>"            // формат текста. См. описание макросов в readme-ru.txt
            },
     // Текстовое поле с черепом здоровья
            {
              "name": "череп здоровья",           // название текстового поля, ни на что не влияет
              "visible": true,                // false - не отображать
              "x": 0,                         // положение по оси X
              "y": -110,                       // положение по оси Y (-95)
              "alpha": "{{a:hp-ratio}}",                   // прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
              "color": "{{c:hp-ratio}}",                  // цвет (допускается использование динамического цвета, см. readme-ru.txt)
              "font": {                       // параметры шрифта
                "name": "$FieldFont",         //   название (Wingdings)
                "size": 13,                   //   размер
                "align": "center",            //   выравнивание текста (left, center, right)
                "bold": true,                //   обычный (false) или жирный (true)
                "italic": false               //   обычный (false) или курсив (true)
              },
              "shadow": {                     // параметры тени
                "alpha": 100,                 //   прозрачность
                "color": "0x000000",          //   цвет
                "angle": 45,                  //   угол смещения
                "distance": 0,                //   дистанция смещение
                "size": 6,                    //   размер
                "strength": 200               //   интенсивность
              },

              "format": "<img src='xvmres://icons/{{c:hp-ratio}}.png' width='30' height='30'>"            // формат текста. См. описание макросов в readme-ru.txt (&#78;)
            },
     // Текстовое поле картинка взвода "squad"
            {
              "name": "картинка взвода",      // название текстового поля, ни на что не влияет
              "visible": true,                // false - не отображать
              "x": 0,                         // положение по оси X
              "y": -135,                      // положение по оси Y
              "alpha": 100,                   // прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
              "color": null,                  // цвет (допускается использование динамического цвета, см. readme-ru.txt)
              "font": {                       // параметры шрифта
                "name": "$FieldFont",         //   название
                "size": 13,                   //   размер
                "align": "center",            //   выравнивание текста (left, center, right)
                "bold": false,                //   обычный (false) или жирный (true)
                "italic": false               //   обычный (false) или курсив (true)
              },
              "shadow": {                     // параметры тени
                "alpha": 100,                 //   прозрачность
                "color": "0x000000",          //   цвет
                "angle": 90,                  //   угол смещения
                "distance": 0,                //   дистанция смещение
                "size": 6,                    //   размер
                "strength": 200               //   интенсивность
              },
              "format": "<img src='xvmres://icons/squad{{squad}}.png' width='41' height='24'>"            // формат текста. См. описание макросов в readme-ru.txt
            },
     // Текстовое поле картинка "олень-рога"
            {
              "name": "картинка олень-рога",      // название текстового поля, ни на что не влияет
              "visible": true,                // false - не отображать
              "x": 3,                         // положение по оси X
              "y": -150,                      // положение по оси Y
              "alpha": 100,                   // прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
              "color": null,                  // цвет (допускается использование динамического цвета, см. readme-ru.txt)
              "font": {                       // параметры шрифта
                "name": "$FieldFont",         //   название
                "size": 13,                   //   размер
                "align": "center",            //   выравнивание текста (left, center, right)
                "bold": false,                //   обычный (false) или жирный (true)
                "italic": false               //   обычный (false) или курсив (true)
              },
              "shadow": {                     // параметры тени
                "alpha": 100,                 //   прозрачность
                "color": "0x000000",          //   цвет
                "angle": 90,                  //   угол смещения
                "distance": 0,                //   дистанция смещение
                "size": 6,                    //   размер
                "strength": 200               //   интенсивность
              },
              "format": "<img src='xvmres://icons/{{c:rating}}.png' width='100' height='100'>"            // формат текста. См. описание макросов в readme-ru.txt
            }
          ]
        },
// противник		
  // противник/живой/расширенный режим (c Alt)
  "enemy": {
          "vehicleIcon": {                    // иконка типа танка (тт/ст/лт/пт/арта)
            "visible": true,                  //   false - не отображать
            "showSpeaker": false,             //   true - Показывать спикер даже если visible=false
            "x": 0,                           //   положение по оси X
            "y": -16,                         //   положение по оси Y
            "alpha": 100,                     //   прозрачность
            "color": null,                    //   цвет (в данный момент не используется)
            "maxScale": 100,                  //   максимальный масштаб (по умолчанию 100)
            "scaleX": 0,                      //   смещение по оси X (?)
            "scaleY": 16,                     //   смещение по оси Y (?)
            "shadow": {                       //   параметры тени
              "alpha": 100,                   //     прозрачность
              "color": "0x000000",            //     цвет
              "angle": 45,                    //     угол смещения
              "distance": 0,                  //     дистанция смещение
              "size": 6,                      //     размер
              "strength": 200                 //     интенсивность
            }
          },
          "healthBar": {                      // индикатор здоровья
            "visible": true,                  //   false - не отображать
            "x": -41,                         //   положение по оси X
            "y": -33,                         //   положение по оси Y
            "alpha": 100,                     //   прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
            "color": null,                    //   цвет основной (допускается использование динамического цвета, см. readme-ru.txt)
            "lcolor": null,                   //   цвет дополнительный (для градиента)
            "width": 80,                      //   ширина полосы здоровья
            "height": 12,                     //   высота полосы здоровья
            "border": {                       //   параметры подложки и рамки
              "alpha": 30,                    //     прозрачность
              "color": "0x000000",            //     цвет
              "size": 1                       //     размер рамки
            },
            "fill": {                         //   параметры оставшегося здоровья
              "alpha": 30                     //     прозрачность
            },                                //
            "damage": {                       //   параметры анимации отнимаемого здоровья
              "alpha": 80,                    //     прозрачность
              "color": "0xFFFF00",                  //     цвет
              "fade": 1                       //     время затухания в секундах
            }
          },
          "damageText": {
            "$ref": { "path":"damageText" },
            "damageMessage": "<font color='{{c:dmg-kind}}'>-{{dmg}} ({{hp-ratio}}\u0025)</font> <img src='xvmres://icons/{{c:dmg-kind}}.png' width='52' height='45'>"
          },
          "damageTextPlayer": {
            "$ref": { "path":"damageText" },
            "damageMessage": "<font color='{{c:dmg-kind}}'>-{{dmg}} ({{hp-ratio}}\u0025)</font> <img src='xvmres://icons/{{c:dmg-kind}}.png' width='52' height='45'>"
          },
          "damageTextSquadman": {
            "$ref": { "path":"damageText" },
            "damageMessage": "<font color='{{c:dmg-kind}}'>-{{dmg}} ({{hp-ratio}}\u0025)</font> <img src='xvmres://icons/{{c:dmg-kind}}.png' width='52' height='45'>"
          },
          "contourIcon": {                    // иконки танка
            "visible": false,                 //   false - не отображать
            "x": 6,                           //   положение по оси X
            "y": -65,                         //   положение по оси Y
            "alpha": 100,                     //   прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
            "color": null,                    //   цвет (допускается использование динамического цвета, см. readme-ru.txt)
            "amount": 0                       //   интенсивность цвета от 0 до 100. По умолчанию 0, т.е. выключено.
          },
          "clanIcon": {                       // Иконка игрока/клана
            "visible": false,                 //   false - не отображать
            "x": 0,                           //   положение по оси X
            "y": -67,                         //   положение по оси Y
            "w": 16,                          //   ширина
            "h": 16,                          //   высота
            "alpha": 100                      //   прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
          },
          "levelIcon": {                      // уровень танка
            "visible": true,                 //   false - не отображать
            "x": 0,                           //   положение по оси X
            "y": -25,                         //   положение по оси Y
            "alpha": 100                      //   прозрачность
          },
          "actionMarker": {                   // маркеры "Нужна помощь" и "Атакую"
            "visible": true,                  //   false - не отображать
            "x": 0,                           //   положение по оси X
            "y": -67,                         //   положение по оси Y
            "alpha": 100                      //   прозрачность
          },
          // Блок текстовых полей
          "textFields": [
            // Текстовое поле с именем игрока
            {
              "name": "Имя игрока",           // название текстового поля, ни на что не влияет
              "visible": true,                // false - не отображать
              "x": 0,                         // положение по оси X
              "y": -48,                       // положение по оси Y
              "alpha": 100,                   // прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
              "color": null,                  // цвет (допускается использование динамического цвета, см. readme-ru.txt)
              "font": {                       // параметры шрифта
                "name": "$FieldFont",         //   название
                "size": 13,                   //   размер
                "align": "center",            //   выравнивание текста (left, center, right)
                "bold": false,                //   обычный (false) или жирный (true)
                "italic": false               //   обычный (false) или курсив (true)
              },
              "shadow": {                     // параметры тени
                "alpha": 100,                 //   прозрачность
                "color": "0x000000",          //   цвет
                "angle": 45,                  //   угол смещения
                "distance": 0,                //   дистанция смещение
                "size": 6,                    //   размер
                "strength": 200               //   интенсивность
              },
              "format": "{{nick}}"            // формат текста. См. описание макросов в readme-ru.txt
            },
            // Текстовое поле с процентом оставшегося здоровьем
            {
              "name": "Процент здоровья",     // название текстового поля, ни на что не влияет
              "visible": true,                // false - не отображать
              "x": 0,                         // положение по оси X
              "y": -20,                       // положение по оси Y
              "alpha": 100,                   // прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
              "color": "0xFFFFFF",            // цвет (допускается использование динамического цвета, см. readme-ru.txt)
              "font": {                       // параметры шрифта
                "name": "$FieldFont",         //   название
                "size": 11,                   //   размер
                "align": "center",            //   выравнивание текста (left, center, right)
                "bold": true,                 //   обычный (false) или жирный (true)
                "italic": false               //   обычный (false) или курсив (true)
              },
              "shadow": {                     // параметры тени
                "alpha": 100,                 //   прозрачность
                "color": "0x000000",          //   цвет
                "angle": 45,                  //   угол смещения
                "distance": 0,                //   дистанция смещение
                "size": 4,                    //   размер
                "strength": 100               //   интенсивность
              },
              // символ процента - \u0025
              "format": "{{hp-ratio}}\u0025"  // формат текста. См. описание макросов в readme-ru.txt
            },
            // текстовое поле с рейтингом
            {
              "name": "Процент побед",
              "visible": true,
              "x": 25,
              "y": -58,
              "alpha": 100,
              "color": "{{c:rating}}",
              "font": {
                "name": "$FieldFont",
                "size": 13,
                "align": "center",
                "bold": false,
                "italic": false
              },
              "shadow": {
                "alpha": 100,
                "color": "0x000000",
                "angle": 45,
                "distance": 0,
                "size": 6,
                "strength": 200
              },
              "format": "{{rating}}"
            },
            {
              "shadow": {
                "angle": 45,
                "distance": 1,
                "strength": 200,
                "size": 2,
                "alpha": 100,
                "color": "0x000000"
              },
              "name": "Эффективность",
              "x": 0,
              "y": -58,
              "visible": true,
              "format": "{{wn}}",
              "font": {
                "bold": false,
                "align": "center",
                "size": 13,
                "name": "$FieldFont"
              },
              "alpha": 100,
              "color": "{{c:wn}}"
            },
            {
              "shadow": {
                "angle": 45,
                "distance": 1,
                "strength": 200,
                "size": 2,
                "alpha": 100,
                "color": "0x000000"
              },
              "name": "Количество кило боев",
              "x": -25,
              "y": -58,
              "visible": true,
              "format": "{{kb}}",
              "font": {
                "bold": false,
                "align": "center",
                "size": 13,
                "name": "$FieldFont"
              },
              "alpha": 100,
              "color": "{{c:kb}}"
            },
            // Текстовое поле с названием танка
            {
              "name": "Название танка",       // название текстового поля, ни на что не влияет
              "visible": true,                // false - не отображать
              "x": 0,                         // положение по оси X
              "y": -36,                       // положение по оси Y
              "alpha": 100,                   // прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
              "color": null,                  // цвет (допускается использование динамического цвета, см. readme-ru.txt)
              "font": {                       // параметры шрифта
                "name": "$FieldFont",         //   название
                "size": 13,                   //   размер
                "align": "center",            //   выравнивание текста (left, center, right)
                "bold": false,                //   обычный (false) или жирный (true)
                "italic": false               //   обычный (false) или курсив (true)
              },
              "shadow": {                     // параметры тени
                "alpha": 100,                 //   прозрачность
                "color": "0x000000",          //   цвет
                "angle": 45,                  //   угол смещения
                "distance": 0,                //   дистанция смещение
                "size": 6,                    //   размер
                "strength": 200               //   интенсивность
              },
              "format": "{{vehicle}}" // формат текста. См. описание макросов в readme-ru.txt
            },
            // Субъект уязвим. {{turret}}
            {
              "name": "Сток танк",            // название текстового поля, ни на что не влияет
              "visible": true,                // false - не отображать
              "x": 0,                         // положение по оси X
              "y": -80,                       // положение по оси Y
              "alpha": 100,                   // прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
              "color": "0xA0CFFF",                  // цвет (допускается использование динамического цвета, см. readme-ru.txt)
              "font": {                       // параметры шрифта
                "name": "$FieldFont",         //   название
                "size": 13,                   //   размер
                "align": "center",            //   выравнивание текста (left, center, right)
                "bold": true,                 //   обычный (false) или жирный (true)
                "italic": false               //   обычный (false) или курсив (true)
              },
              "shadow": {                     // параметры тени
                "alpha": 100,                 //   прозрачность
                "color": "0x000000",          //   цвет
                "angle": 45,                  //   угол смещения
                "distance": 0,                //   дистанция смещение
                "size": 6,                    //   размер
                "strength": 200               //   интенсивность
              },
              "format": "{{turret}}" // формат текста. См. описание макросов в readme-ru.txt
            },
     // Статистика над танком Дополнительно({{tdb}}-(д)средний Дамаг на танке за бой, {{tfb}}-(ф)средний Фраг на танке за бой, {{tsb}}-(з)средний Засвет на танке за бой, {{e}}-(р)Рейтинг на танке 1-9)
            {
              "name": "Статистика дополнительно",      // название текстового поля, ни на что не влияет
              "visible": true,                // false - не отображать
              "x": 0,                         // положение по оси X
              "y": -70,                      // положение по оси Y
              "alpha": 100,                   // прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
              "color": "0xFFFFFF",                  // цвет (допускается использование динамического цвета, см. readme-ru.txt)
              "font": {                       // параметры шрифта
                "name": "$FieldFont",         //   название
                "size": 13,                   //   размер
                "align": "center",            //   выравнивание текста (left, center, right)
                "bold": false,                //   обычный (false) или жирный (true)
                "italic": false               //   обычный (false) или курсив (true)
              },
              "shadow": {                     // параметры тени
                "alpha": 100,                 //   прозрачность
                "color": "0x000000",          //   цвет
                "angle": 90,                  //   угол смещения
                "distance": 0,                //   дистанция смещение
                "size": 6,                    //   размер
                "strength": 200               //   интенсивность
              },
              "format": "<font size='0{{c:e}}'>р-<font color='{{c:e}}'>{{e}}</font>|д-<font color='{{c:tdb}}'>{{tdb}}</font>|ф-<font color='{{c:tfb}}'>{{tfb}}</font>|з-<font color='{{c:tsb}}'>{{tsb}}</font></font>"            // формат текста. См. описание макросов в readme-ru.txt
            },
     // Текстовое поле с черепом здоровья
            {
              "name": "череп здоровья",           // название текстового поля, ни на что не влияет
              "visible": true,                // false - не отображать
              "x": 0,                         // положение по оси X
              "y": -110,                       // положение по оси Y (-95)
              "alpha": "{{a:hp-ratio}}",                   // прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
              "color": "{{c:hp-ratio}}",                  // цвет (допускается использование динамического цвета, см. readme-ru.txt)
              "font": {                       // параметры шрифта
                "name": "$FieldFont",         //   название (Wingdings)
                "size": 13,                   //   размер
                "align": "center",            //   выравнивание текста (left, center, right)
                "bold": true,                //   обычный (false) или жирный (true)
                "italic": false               //   обычный (false) или курсив (true)
              },
              "shadow": {                     // параметры тени
                "alpha": 100,                 //   прозрачность
                "color": "0x000000",          //   цвет
                "angle": 45,                  //   угол смещения
                "distance": 0,                //   дистанция смещение
                "size": 6,                    //   размер
                "strength": 200               //   интенсивность
              },

              "format": "<img src='xvmres://icons/{{c:hp-ratio}}-.png' width='30' height='30'>"            // формат текста. См. описание макросов в readme-ru.txt (&#78;)
            },
     // Текстовое поле картинка взвода "squad"
            {
              "name": "картинка взвода",      // название текстового поля, ни на что не влияет
              "visible": true,                // false - не отображать
              "x": 0,                         // положение по оси X
              "y": -135,                      // положение по оси Y
              "alpha": 100,                   // прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
              "color": null,                  // цвет (допускается использование динамического цвета, см. readme-ru.txt)
              "font": {                       // параметры шрифта
                "name": "$FieldFont",         //   название
                "size": 13,                   //   размер
                "align": "center",            //   выравнивание текста (left, center, right)
                "bold": false,                //   обычный (false) или жирный (true)
                "italic": false               //   обычный (false) или курсив (true)
              },
              "shadow": {                     // параметры тени
                "alpha": 100,                 //   прозрачность
                "color": "0x000000",          //   цвет
                "angle": 90,                  //   угол смещения
                "distance": 0,                //   дистанция смещение
                "size": 6,                    //   размер
                "strength": 200               //   интенсивность
              },
              "format": "<img src='xvmres://icons/squad{{squad}}.png' width='41' height='24'>"            // формат текста. См. описание макросов в readme-ru.txt
            },
     // Текстовое поле картинка "олень-рога"
            {
              "name": "картинка олень-рога",      // название текстового поля, ни на что не влияет
              "visible": true,                // false - не отображать
              "x": 3,                         // положение по оси X
              "y": -150,                      // положение по оси Y
              "alpha": 100,                   // прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
              "color": null,                  // цвет (допускается использование динамического цвета, см. readme-ru.txt)
              "font": {                       // параметры шрифта
                "name": "$FieldFont",         //   название
                "size": 13,                   //   размер
                "align": "center",            //   выравнивание текста (left, center, right)
                "bold": false,                //   обычный (false) или жирный (true)
                "italic": false               //   обычный (false) или курсив (true)
              },
              "shadow": {                     // параметры тени
                "alpha": 100,                 //   прозрачность
                "color": "0x000000",          //   цвет
                "angle": 90,                  //   угол смещения
                "distance": 0,                //   дистанция смещение
                "size": 6,                    //   размер
                "strength": 200               //   интенсивность
              },
              "format": "<img src='xvmres://icons/{{c:rating}}.png' width='100' height='100'>"            // формат текста. См. описание макросов в readme-ru.txt
            }
          ]
        }
}