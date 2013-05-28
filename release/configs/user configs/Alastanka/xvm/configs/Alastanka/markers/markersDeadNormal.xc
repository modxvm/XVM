/**
 * Options for dead without Alt markers.
 * Настройки маркеров для трупов без Alt.
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
      "maxRange": 200,                   //   расстояние, на которое отлетает урон
      "damageMessage": "<img src='xvmres://icons/dead.png' width='52' height='45'><img src='xvmres://icons/dmg/{{c:dmg}}.png' width='30' height='30'> <font color='{{c:dmg-kind}}'>-{{dmg}} ({{hp-ratio}}\u0025)</font>\n <font color='{{c:vtype}}'>{{vehicle}}</font>",       //   текст при обычном уроне (см. описание макросов в readme-ru.txt)
      "blowupMessage": "<img src='xvmres://icons/dead_blowup.png' width='52' height='45'><img src='xvmres://icons/dmg/{{c:dmg}}.png' width='30' height='30'> <font color='{{c:dmg-kind}}'>-{{dmg}} ({{hp-ratio}}\u0025)</font>\n <font color='{{c:vtype}}'>{{vehicle}}</font>"      //   текст при взрыве боеукладки (см. описание макросов в readme-ru.txt)
  },
// союзник
  // союзник/мертвый/нормальный режим (без Alt)
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
            "visible": false,                 //   false - не отображать
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
            "damageMessage": "<img src='xvmres://icons/dead.png' width='52' height='45'><img src='xvmres://icons/dmg/{{c:dmg}}.png' width='30' height='30'> <font color='{{c:dmg-kind}}'>-{{dmg}} ({{hp-ratio}}\u0025)</font>\n <font color='{{c:vtype}}'>{{vehicle}}</font>"
          },
          "damageTextPlayer": {
            "$ref": { "path":"damageText" },
            "damageMessage": "<img src='xvmres://icons/dead.png' width='52' height='45'><img src='xvmres://icons/dmg/{{c:dmg}}.png' width='30' height='30'> <font color='{{c:dmg-kind}}'>-{{dmg}} ({{hp-ratio}}\u0025)</font>\n <font color='{{c:vtype}}'>{{vehicle}}</font>"
          },
          "damageTextSquadman": {
            "$ref": { "path":"damageText" },
            "damageMessage": "<img src='xvmres://icons/dead.png' width='52' height='45'><img src='xvmres://icons/dmg/{{c:dmg}}.png' width='30' height='30'> <font color='{{c:dmg-kind}}'>-{{dmg}} ({{hp-ratio}}\u0025)</font>\n <font color='{{c:vtype}}'>{{vehicle}}</font>"
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
          "textFields": [  ]                  // Не отображать текст в этом режиме
        },
// противник
  // противник/мертвый/нормальный режим (без Alt)
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
            "visible": false,                 //   false - не отображать
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
            "damageMessage": "<img src='xvmres://icons/dead.png' width='52' height='45'><img src='xvmres://icons/dmg/{{c:dmg}}.png' width='30' height='30'> <font color='{{c:dmg-kind}}'>-{{dmg}} ({{hp-ratio}}\u0025)</font>\n <font color='{{c:vtype}}'>{{vehicle}}</font>"
          },
          "damageTextPlayer": {
            "$ref": { "path":"damageText" },
            "damageMessage": "<img src='xvmres://icons/dead.png' width='52' height='45'><img src='xvmres://icons/dmg/{{c:dmg}}.png' width='30' height='30'> <font color='{{c:dmg-kind}}'>-{{dmg}} ({{hp-ratio}}\u0025)</font>\n <font color='{{c:vtype}}'>{{vehicle}}</font>"
          },
          "damageTextSquadman": {
            "$ref": { "path":"damageText" },
            "damageMessage": "<img src='xvmres://icons/dead.png' width='52' height='45'><img src='xvmres://icons/dmg/{{c:dmg}}.png' width='30' height='30'> <font color='{{c:dmg-kind}}'>-{{dmg}} ({{hp-ratio}}\u0025)</font>\n <font color='{{c:vtype}}'>{{vehicle}}</font>"
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
          "textFields": [  ]                  // Не отображать текст в этом режиме
        }
}