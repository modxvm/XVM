/**
 * Options for alive with Alt markers.
 * Настройки маркеров для живых с Alt.
 */
{
  "damageText": {                     // всплывающий урон
		"visible": true,                  //   false - не отображать
		"x": 0,                           //   положение по оси X
		"y": -80,                         //   положение по оси Y
		"alpha": 100,                     //   прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
		"color": null,                    //   цвет (допускается использование динамического цвета, см. readme-ru.txt)
		"font": {                         //   параметры шрифта
		  "name": "Comic Sans MS",        //     название
		  "size": 12,                     //     размер
		  "align": "center",              //     выравнивание текста (left, center, right)
		  "bold": false,                  //     обычный (false) или жирный (true)
		  "italic": false                 //     обычный (false) или курсив (true)
		  },
		"shadow": {                       //   параметры тени
		  "alpha": 70,                    //     прозрачность
		  "color": "0x000000",            //     цвет
		  "angle": 45,                    //     угол смещения
		  "distance": 1,                  //     дистанция смещение
		  "size": 10,                     //     размер
		  "strength": 1320                //     интенсивность
		  },
		"speed": 3,                       //   время отображения отлетающего урона
		"maxRange": 90,                   //   расстояние, на которое отлетает урон
		"damageMessage": "={{dmg}}=",      //   текст при обычном уроне (см. описание макросов в readme-ru.txt)
		"blowupMessage": "Blown-up!"      //   текст при взрыве боеукладки (см. описание макросов в readme-ru.txt)
  },
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
            "x": -29,                         //   положение по оси X
            "y": -34,                         //   положение по оси Y
            "alpha": 100,                     //   прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
            "color": null,                    //   цвет основной (допускается использование динамического цвета, см. readme-ru.txt)
            "lcolor": null,                   //   цвет дополнительный (для градиента)
            "width": 56,                      //   ширина полосы здоровья
            "height": 2,                      //   высота полосы здоровья
            "border": {                       //   параметры подложки и рамки
              "alpha": 80,                    //     прозрачность
              "color": "0x000000",            //     цвет
              "size": 2                       //     размер рамки
            },
            "fill": {                         //   параметры оставшегося здоровья
              "alpha": 80                     //     прозрачность
            },                                //
            "damage": {                       //   параметры анимации отнимаемого здоровья
              "alpha": 80,                    //     прозрачность
              "color": "0xFFFFFF",            //     цвет
              "fade": 2                       //     время затухания в секундах
            }
          },
          "damageText": {
            "$ref": { "path":"damageText" },
            "damageMessage": "={{dmg}}="
          },
          "damageTextPlayer": {
            "$ref": { "path":"damageText" },
            "damageMessage": "={{dmg}}="
          },
          "damageTextSquadman": {
            "$ref": { "path":"damageText" },
            "damageMessage": "={{dmg}}="
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
            "visible": false,                 //   false - не отображать
            "x": 0,                           //   положение по оси X
            "y": -21,                         //   положение по оси Y
            "alpha": 100                      //   прозрачность
          },
          "actionMarker": {                   // маркеры "Нужна помощь" и "Атакую"
            "visible": true,                  //   false - не отображать
            "x": 0,                           //   положение по оси X
            "y": -87,                         //   положение по оси Y
            "alpha": 100                      //   прозрачность
          },
          // Блок текстовых полей
          "textFields": [
            // Текстовое поле с именем игрока
            {
              "name": "Имя игрока",           // название текстового поля, ни на что не влияет
              "visible": true,                // false - не отображать
              "x": 0,                         // положение по оси X
              "y": -37,                       // положение по оси Y
              "alpha": 100,                   // прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
              "color": null,                  // цвет (допускается использование динамического цвета, см. readme-ru.txt)
              "font": {                       // параметры шрифта
                "name": "Comic Sans MS",      //   название
                "size": 12,                   //   размер
                "align": "center",            //   выравнивание текста (left, center, right)
                "bold": false,                //   обычный (false) или жирный (true)
                "italic": false               //   обычный (false) или курсив (true)
              },
              "shadow": {                     // параметры тени
                "alpha": 50,                  //   прозрачность
                "color": "0x000000",          //   цвет
                "angle": 45,                  //   угол смещения
                "distance": 1,                //   дистанция смещение
                "size": 5,                    //   размер
                "strength": 1320              //   интенсивность
              },
              "format": "{{nick}}"            // формат текста. См. описание макросов в readme-ru.txt
            },
            // Текстовое поле с процентом оставшегося здоровьем
            {
              "name": "Процент здоровья",     // название текстового поля, ни на что не влияет
              "visible": true,                // false - не отображать
              "x": 0,                         // положение по оси X
              "y": -16,                       // положение по оси Y
              "alpha": 100,                   // прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
              "color": "0xFFFFFF",            // цвет (допускается использование динамического цвета, см. readme-ru.txt)
              "font": {                       // параметры шрифта
                "name": "Comic Sans MS",      //   название
                "size": 11,                   //   размер
                "align": "center",            //   выравнивание текста (left, center, right)
                "bold": true,                 //   обычный (false) или жирный (true)
                "italic": false               //   обычный (false) или курсив (true)
              },
              "shadow": {                     // параметры тени
                "alpha": 60,                  //   прозрачность
                "color": "0x000000",          //   цвет
                "angle": 45,                  //   угол смещения
                "distance": 1,                //   дистанция смещение
                "size": 5,                    //   размер
                "strength": 1320              //   интенсивность
              },
              // символ процента - \u0025
              "format": "{{hp-ratio}}\u0025"  // формат текста. См. описание макросов в readme-ru.txt
            },
            // текстовое поле с рейтингом
            {
              "name": "Общий рейтинг по всей технике",
              "visible": true,
              "x": 0,
              "y": -48,
              "alpha": 100,
              "color": "{{c:eff}}",
              "font": {
                "name": "Comic Sans MS",
                "size": 11,
                "align": "center",
                "bold": false,
                "italic": false
              },
              "shadow": {
                "alpha": 50,
                "color": "0x000000",
                "angle": 45,
                "distance": 1,
                "size": 5,
                "strength": 1320
              },
              "format": "{{kb}} {{eff}} {{rating}}"
            },
			// текстовое поле с рейтингом
            {
              "name": "Количество боев на данной технике",
              "visible": true,
              "x": -28,
              "y": 0,
              "alpha": 100,
              "color": "{{c:t-battles}}",
              "font": {
                "name": "Comic Sans MS",
                "size": 11,
                "align": "center",
                "bold": false,
                "italic": false
              },
              "shadow": {
                "alpha": 50,
                "color": "0x000000",
                "angle": 45,
                "distance": 1,
                "size": 5,
                "strength": 1320
              },
              "format": "{{t-battles}}"
            },
			// текстовое поле с рейтингом
            {
              "name": "Процент побед на данной технике",
              "visible": true,
              "x": 28,
              "y": 0,
              "alpha": 100,
              "color": "{{c:t-rating}}",
              "font": {
                "name": "Comic Sans MS",
                "size": 11,
                "align": "center",
                "bold": false,
                "italic": false
              },
              "shadow": {
                "alpha": 50,
                "color": "0x000000",
                "angle": 45,
                "distance": 1,
                "size": 5,
                "strength": 1320
              },
              "format": "{{t-rating}}"
            },
			{
              "name": "Эффективность игрока на текущем танке",
              "visible": false,
              "x": -43,
              "y": 16,
              "alpha": 100,
              "color": "{{c:e}}",
              "font": {
                "name": "Comic Sans MS",
                "size": 11,
                "align": "center",
                "bold": false,
                "italic": false
              },
              "shadow": {
                "alpha": 50,
                "color": "0x000000",
                "angle": 45,
                "distance": 1,
                "size": 5,
                "strength": 1320
              },
              "format": "{{teff}} (η)"
            },
			{
              "name": "Средний дамаг за бой для текущего танка",
              "visible": false,
              "x": 49,
              "y": 16,
              "alpha": 100,
              "color": "{{c:tdb}}",
              "font": {
                "name": "Comic Sans MS",
                "size": 11,
                "align": "center",
                "bold": false,
                "italic": false
              },
              "shadow": {
                "alpha": 50,
                "color": "0x000000",
                "angle": 45,
                "distance": 1,
                "size": 5,
                "strength": 1320
              },
              "format": "{{tdb}} (dmg)"
            }
          ]
        },
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
            "x": -29,                         //   положение по оси X
            "y": -34,                         //   положение по оси Y
            "alpha": 100,                     //   прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
            "color": null,                    //   цвет основной (допускается использование динамического цвета, см. readme-ru.txt)
            "lcolor": null,                   //   цвет дополнительный (для градиента)
            "width": 56,                      //   ширина полосы здоровья
            "height": 2,                      //   высота полосы здоровья
            "border": {                       //   параметры подложки и рамки
              "alpha": 80,                    //     прозрачность
              "color": "0x000000",            //     цвет
              "size": 2                       //     размер рамки
            },
            "fill": {                         //   параметры оставшегося здоровья
              "alpha": 80                     //     прозрачность
            },                                //
            "damage": {                       //   параметры анимации отнимаемого здоровья
              "alpha": 80,                    //     прозрачность
              "color": "0xFFFFFF",            //     цвет
              "fade": 2                       //     время затухания в секундах
            }
          },
          "damageText": {
            "$ref": { "path":"damageText" },
            "damageMessage": "={{dmg}}="
          },
          "damageTextPlayer": {
            "$ref": { "path":"damageText" },
            "damageMessage": "<font face='XVMSymbol' size='12'>\u0046</font> {{dmg}} <font face='XVMSymbol' size='12'>\u0047</font>"
          },
          "damageTextSquadman": {
            "$ref": { "path":"damageText" },
            "damageMessage": "<font face='XVMSymbol' size='12'>\u0047</font> {{dmg}} <font face='XVMSymbol' size='12'>\u0046</font>"
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
            "visible": false,                 //   false - не отображать
            "x": 0,                           //   положение по оси X
            "y": -21,                         //   положение по оси Y
            "alpha": 100                      //   прозрачность
          },
          "actionMarker": {                   // маркеры "Нужна помощь" и "Атакую"
            "visible": true,                  //   false - не отображать
            "x": 0,                           //   положение по оси X
            "y": -87,                         //   положение по оси Y
            "alpha": 100                      //   прозрачность
          },
          // Блок текстовых полей
          "textFields": [
            // Текстовое поле с именем игрока
            {
              "name": "Имя игрока",           // название текстового поля, ни на что не влияет
              "visible": true,                // false - не отображать
              "x": 0,                         // положение по оси X
              "y": -37,                       // положение по оси Y
              "alpha": 100,                   // прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
              "color": null,                  // цвет (допускается использование динамического цвета, см. readme-ru.txt)
              "font": {                       // параметры шрифта
                "name": "Comic Sans MS",      //   название
                "size": 12,                   //   размер
                "align": "center",            //   выравнивание текста (left, center, right)
                "bold": false,                //   обычный (false) или жирный (true)
                "italic": false               //   обычный (false) или курсив (true)
              },
              "shadow": {                     // параметры тени
                "alpha": 50,                  //   прозрачность
                "color": "0x000000",          //   цвет
                "angle": 45,                  //   угол смещения
                "distance": 1,                //   дистанция смещение
                "size": 5,                    //   размер
                "strength": 1320              //   интенсивность
              },
              "format": "{{nick}}"            // формат текста. См. описание макросов в readme-ru.txt
            },
            // Текстовое поле с процентом оставшегося здоровьем
            {
              "name": "Процент здоровья",     // название текстового поля, ни на что не влияет
              "visible": true,                // false - не отображать
              "x": 0,                         // положение по оси X
              "y": -16,                       // положение по оси Y
              "alpha": 100,                   // прозрачность (допускается использование динамической прозрачности, см. readme-ru.txt)
              "color": "0xFFFFFF",            // цвет (допускается использование динамического цвета, см. readme-ru.txt)
              "font": {                       // параметры шрифта
                "name": "Comic Sans MS",      //   название
                "size": 11,                   //   размер
                "align": "center",            //   выравнивание текста (left, center, right)
                "bold": true,                 //   обычный (false) или жирный (true)
                "italic": false               //   обычный (false) или курсив (true)
              },
              "shadow": {                     // параметры тени
                "alpha": 60,                  //   прозрачность
                "color": "0x000000",          //   цвет
                "angle": 45,                  //   угол смещения
                "distance": 1,                //   дистанция смещение
                "size": 5,                    //   размер
                "strength": 1320              //   интенсивность
              },
              // символ процента - \u0025
              "format": "{{hp-ratio}}\u0025"  // формат текста. См. описание макросов в readme-ru.txt
            },
            // текстовое поле с рейтингом
            {
              "name": "Общий рейтинг по всей технике",
              "visible": true,
              "x": 0,
              "y": -48,
              "alpha": 100,
              "color": "{{c:eff}}",
              "font": {
                "name": "Comic Sans MS",
                "size": 11,
                "align": "center",
                "bold": false,
                "italic": false
              },
              "shadow": {
                "alpha": 50,
                "color": "0x000000",
                "angle": 45,
                "distance": 1,
                "size": 5,
                "strength": 1320
              },
              "format": "{{kb}} {{eff}} {{rating}}"
            },			
			// текстовое поле с рейтингом
            {
              "name": "Количество боев на данной технике",
              "visible": true,
              "x": -28,
              "y": 0,
              "alpha": 100,
              "color": "{{c:t-battles}}",
              "font": {
                "name": "Comic Sans MS",
                "size": 11,
                "align": "center",
                "bold": false,
                "italic": false
              },
              "shadow": {
                "alpha": 50,
                "color": "0x000000",
                "angle": 45,
                "distance": 1,
                "size": 5,
                "strength": 1320
              },
              "format": "{{t-battles}}"
            },
			// текстовое поле с рейтингом
            {
              "name": "Процент побед на данной технике",
              "visible": true,
              "x": 28,
              "y": 0,
              "alpha": 100,
              "color": "{{c:t-rating}}",
              "font": {
                "name": "Comic Sans MS",
                "size": 11,
                "align": "center",
                "bold": false,
                "italic": false
              },
              "shadow": {
                "alpha": 50,
                "color": "0x000000",
                "angle": 45,
                "distance": 1,
                "size": 5,
                "strength": 1320
              },
              "format": "{{t-rating}}"
            },
			{
              "name": "Эффективность игрока на текущем танке",
              "visible": false,
              "x": -43,
              "y": 16,
              "alpha": 100,
              "color": "{{c:e}}",
              "font": {
                "name": "Comic Sans MS",
                "size": 11,
                "align": "center",
                "bold": false,
                "italic": false
              },
              "shadow": {
                "alpha": 50,
                "color": "0x000000",
                "angle": 45,
                "distance": 1,
                "size": 5,
                "strength": 1320
              },
              "format": "{{teff}} (η)"
            },
			{
              "name": "Средний дамаг за бой для текущего танка",
              "visible": false,
              "x": 49,
              "y": 16,
              "alpha": 100,
              "color": "{{c:tdb}}",
              "font": {
                "name": "Comic Sans MS",
                "size": 11,
                "align": "center",
                "bold": false,
                "italic": false
              },
              "shadow": {
                "alpha": 50,
                "color": "0x000000",
                "angle": 45,
                "distance": 1,
                "size": 5,
                "strength": 1320
              },
              "format": "{{tdb}} (dmg)"
            }
          ]
        }
}