/**
 * Options for alive without Alt markers.
 * Настройки маркеров для живых без Alt.
 */
{
  "damageText": {                     // всплывающий урон
      "visible": true,                  //   false - не отображать
      "x": 0,                           //   положение по оси X
      "y": -67,                         //   положение по оси Y
      "alpha": 100,                     //   прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
      "color": null,                    //   цвет (допускается использование динамического цвета, см. readme-ru.txt)
      "font": {                         //   параметры шрифта
        "name": "$FieldFont",           //     название
        "size": 18,                     //     размер
        "align": "center",              //     выравнивание текста (left, center, right)
        "bold": true,                  //     обычный (false) или жирный (true)
        "italic": false                 //     обычный (false) или курсив (true)
      },
      "shadow": {                       //   параметры тени
        "alpha": 100,                   //     прозрачность
        "color": "0x000000",            //     цвет
        "angle": 45,                    //     угол смещения
        "distance": 0,                  //     дистанция смещение
        "size": 6,                      //     размер
        "strength": 200                 //     интенсивность
      },
      "speed": 6,                       //   время отображения отлетающего урона
      "maxRange": 140,                   //   расстояние, на которое отлетает урон
      "damageMessage": "<img src='xvmres://icons/{{dmg-kind}}.png' width='52' height='45'><img src='xvmres://icons/dmg/{{c:dmg}}.png' width='30' height='30'> <font color='{{c:dmg-kind}}'>-{{dmg}} ({{hp-ratio}}\u0025)</font>",       //   текст при обычном уроне (см. описание макросов в readme-ru.txt)
      "blowupMessage": "<img src='xvmres://icons/боеукладка.png' width='52' height='45'> <font color='{{c:dmg-kind}}'>-{{dmg}} ({{hp-ratio}}\u0025)</font>"      //   текст при взрыве боеукладки (см. описание макросов в readme-ru.txt)
  },
// союзник
  // союзник/живой/нормальный режим (без Alt)
  "ally": {
          "vehicleIcon": {                    // иконка типа танка (тт/ст/лт/пт/арта)
            "visible": true,                  //   false - не отображать
            "showSpeaker": true,             //   true - Показывать спикер даже если visible=false
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
              "fade": 3                       //     время затухания в секундах
            }
          },
          "damageText": {
          //  "$ref": { "path":"damageText" },
            "damageMessage": "<img src='xvmres://icons/{{dmg-kind}}.png' width='52' height='45'><img src='xvmres://icons/dmg/{{c:dmg}}.png' width='30' height='30'> <font color='{{c:dmg-kind}}'>-{{dmg}} ({{hp-ratio}}\u0025)</font>"
          },
          "damageTextPlayer": {
          //  "$ref": { "path":"damageText" },
            "damageMessage": "<img src='xvmres://icons/{{dmg-kind}}.png' width='52' height='45'><img src='xvmres://icons/dmg/{{c:dmg}}.png' width='30' height='30'> <font color='{{c:dmg-kind}}'>-{{dmg}} ({{hp-ratio}}\u0025)</font>"
          },
          "damageTextSquadman": {
          //  "$ref": { "path":"damageText" },
            "damageMessage": "<img src='xvmres://icons/{{dmg-kind}}.png' width='52' height='45'><img src='xvmres://icons/dmg/{{c:dmg}}.png' width='30' height='30'> <font color='{{c:dmg-kind}}'>-{{dmg}} ({{hp-ratio}}\u0025)</font>"
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
            "y": -135,                         //   положение по оси Y
            "alpha": 100                      //   прозрачность
          },
          // Блок текстовых полей
          "textFields": [
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
                "bold": false,                 //   обычный (false) или жирный (true)
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
            // Текстовое поле с оставшимся / максимальным здоровьем
            {
              "name": "Здоровье",             // название текстового поля, ни на что не влияет
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
              "format": "{{hp}} / {{hp-max}}  {{hp-ratio}}\u0025" // формат текста. См. описание макросов в readme-ru.txt
            },
// Статистика над танком
            {
              "shadow": {
                "angle": 45,
                "distance": 1,
                "strength": 200,
                "size": 2,
                "alpha": 100,
                "color": "0x000000"
              },
              "name": "Количество боев",
              "x": -25,
              "y": -58,
              "visible": true,
              "format": "{{t-battles}}",
              "font": {
                "bold": false,
                "align": "center",
                "size": 13,
                "name": "$FieldFont"
              },
              "alpha": 100,
              "color": "{{c:t-battles}}"
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
              "name": "Эфективность на танке",
              "x": 0,
              "y": -58,
              "visible": true,
              "format": "{{teff}}",
              "font": {
                "bold": false,
                "align": "center",
                "size": 13,
                "name": "$FieldFont"
              },
              "alpha": 100,
              "color": "{{c:e}}"
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
              "name": "Процент побед на танке",
              "x": 25,
              "y": -58,
              "visible": true,
              "format": "{{t-rating}}",
              "font": {
                "bold": false,
                "align": "center",
                "size": 13,
                "name": "$FieldFont"
              },
              "alpha": 100,
              "color": "{{c:t-rating}}"
            },
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
  // противник/живой/нормальный режим (без Alt)
  "enemy": {
          "vehicleIcon": {                    // иконка типа танка (тт/ст/лт/пт/арта)
            "visible": true,                  //   false - не отображать
            "showSpeaker": true,             //   true - Показывать спикер даже если visible=false
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
              "fade": 3                       //     время затухания в секундах
            }
          },
          "damageText": {
          //  "$ref": { "path":"damageText" },
            "damageMessage": "<img src='xvmres://icons/{{dmg-kind}}.png' width='52' height='45'><img src='xvmres://icons/dmg/{{c:dmg}}.png' width='30' height='30'> <font color='{{c:dmg-kind}}'>-{{dmg}} ({{hp-ratio}}\u0025)</font>"
          },
          "damageTextPlayer": {
          //  "$ref": { "path":"damageText" },
            "damageMessage": "<img src='xvmres://icons/{{dmg-kind}}.png' width='52' height='45'><img src='xvmres://icons/dmg/{{c:dmg}}.png' width='30' height='30'> <font color='{{c:dmg-kind}}'>-{{dmg}} ({{hp-ratio}}\u0025)</font>"
          },
          "damageTextSquadman": {
          //  "$ref": { "path":"damageText" },
            "damageMessage": "<img src='xvmres://icons/{{dmg-kind}}.png' width='52' height='45'><img src='xvmres://icons/dmg/{{c:dmg}}.png' width='30' height='30'> <font color='{{c:dmg-kind}}'>-{{dmg}} ({{hp-ratio}}\u0025)</font>"
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
            "y": -135,                         //   положение по оси Y
            "alpha": 100                      //   прозрачность
          },
          // Блок текстовых полей
          "textFields": [
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
                "bold": false,                 //   обычный (false) или жирный (true)
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
            // Текстовое поле с оставшимся / максимальным здоровьем
            {
              "name": "Здоровье",             // название текстового поля, ни на что не влияет
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
              "format": "{{hp}} / {{hp-max}}  {{hp-ratio}}\u0025" // формат текста. См. описание макросов в readme-ru.txt
            },
// Статистика над танком
            {
              "shadow": {
                "angle": 45,
                "distance": 1,
                "strength": 200,
                "size": 2,
                "alpha": 100,
                "color": "0x000000"
              },
              "name": "Количество боев",
              "x": -25,
              "y": -58,
              "visible": true,
              "format": "{{t-battles}}",
              "font": {
                "bold": false,
                "align": "center",
                "size": 13,
                "name": "$FieldFont"
              },
              "alpha": 100,
              "color": "{{c:t-battles}}"
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
              "name": "Эфективность на танке",
              "x": 0,
              "y": -58,
              "visible": true,
              "format": "{{teff}}",
              "font": {
                "bold": false,
                "align": "center",
                "size": 13,
                "name": "$FieldFont"
              },
              "alpha": 100,
              "color": "{{c:e}}"
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
              "name": "Процент побед на танке",
              "x": 25,
              "y": -58,
              "visible": true,
              "format": "{{t-rating}}",
              "font": {
                "bold": false,
                "align": "center",
                "size": 13,
                "name": "$FieldFont"
              },
              "alpha": 100,
              "color": "{{c:t-rating}}"
            },
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
        }
}