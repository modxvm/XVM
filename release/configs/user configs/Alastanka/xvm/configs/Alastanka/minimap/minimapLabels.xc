/**
 * Minimap labels. Basic HTML/CSS supported.
 * Надписи на миникарте. Поддерживают HTML.
 */
{
    "labels": {				// Текстовые надписи. Поддерживают HTML. 
      "nickShrink": 7,			// Максимальные размер ника для макроса {{short-nick}}. 
      "ifspgsymbol": "█",             // Символ для макроса {{ifspg}}. Выводится только если субъект типа артиллерии

      "vehicleclassmacro": {		// Подстановки макроса {{vehicle-class}} 
        "light":	"<img src='xvmres://icons/minimap/light.png' width='15' height='19'>",		//"ЛТ"  текст для легких танков 
        "medium":	"<img src='xvmres://icons/minimap/medium.png' width='15' height='19'>",		//"СТ"  текст для средних танков 
        "heavy":	"<img src='xvmres://icons/minimap/heavy.png' width='15' height='19'>",		//"СТ"  текст для тяжелых танков 
        "td":		"<img src='xvmres://icons/minimap/td.png' width='15' height='19'>",		//"ПТ"  текст для ПТ 
        "spg":		"<img src='xvmres://icons/minimap/spg.png' width='15' height='19'>",		//"АРТ" текст для арты
        "superh":	"<img src='xvmres://icons/minimap/superh.png' width='15' height='19'>" 		// superHeavyTank доп класс посредством gui_settings.xml
        // Сайт со спец символами:
        //   http://www.fileformat.info/info/unicode/char/25a0/index.htm
        // Отличный символьный шрифт от Andrey_Hard для замены букв от {{vehicle-class}} макроса:
        //   http://goo.gl/d2KIj  
      }, 
      "units": { // Текстовые надписи для танков на миникарте. 
	"revealedEnabled": true, // Выключатель добавочных текстовых полей для видимых юнитов 
	"lostEnemyEnabled": true,// Выключатель текстовых полей, помечивающих последние позиции потерянных врагов
	"format": { 
	// Формат поля. Макросы: ник-{{short-nick}}, уровень-{{level}}, название танка-{{vehicle-type}}, укороченное название танка-{{vehicle-type-short}}, тип танка-{{vtype}}, системное название танка - usa-M24_Chaffee-{vehicle-name}}. 
	// Для союзников
	  "ally":  "<textformat leading='-2'><span class='mm_a'><b>{{short-nick}}</b></span>\n<img src='xvmres://icons/level/{{level}}_ally_lostenemy.png' width='8' height='8'>\n<span class='mm_a'>{{vehicle-type}}</span></textformat>", 
	// Для врагов 
 	  "enemy": "<textformat leading='-2'><span class='mm_e'><b>{{vehicle-type}}</b></span>\n<img src='xvmres://icons/level/{{level}}_enemy_lostenemy.png' width='8' height='8'>\n<span class='mm_e'>{{short-nick}}</span></textformat>", 
	// Для совзводных 
    	  "squad": "<textformat leading='-2'><span class='mm_s'><b>{{short-nick}}</b></span>\n<img src='xvmres://icons/frends.png' width='8' height='8'>\n<span class='mm_s'>{{vehicle-type}}</span></textformat>", 
	// Формат маркера последней позиции потерянного врага
	  "lost":  "<textformat leading='-21'>\n{{vehicle-class}}\n<textformat leading='-2'><span class='mm_l'><b>{{vehicle-type}}</b></span>\n<img src='xvmres://icons/level/{{level}}_enemy.png' width='7' height='7'>\n<span 

class='mm_l'>{{short-nick}}</span></textformat>\n</textformat>", 
	// Для себя и приемника камеры в случае смерти   
          "oneself": "<textformat leading='-2'><span class='mm_o'><b> </b></span>\n  <img src='xvmres://icons/ya.png' width='10' height='10'><span class='mm_o'> </span></textformat>" 
        }, 
        "css": { // CSS стиль.(шрифт, размер, цвет) 
		 // возможность подстановки cстиля: ally=.mm_a, enemy=.mm_e, squad=.mm_s, lost=.mm_l, oneself=.mm_o, vehicleclassmacro=.mm_lclass, или свой=.mm_my
		 // Пример1: ".mm_s{font-family:$FieldFont; font-size:8px; color:#EEAACC;}"
		 // Использование1: "<span class='mm_l'><i>{{level}}</i></span>"
		 // Пример2: ".mm_s{font-family:$FieldFont; font-size:8px; color:#EEAACC;} .mm_lclass{font-family:Arial; font-size:10px; color:#FFBBDD;}"
		 // Использование2: "<span class='mm_lclass'>{{vehicle-class}}</span><span class='mm_l'><i>{{level}}</i></span>"
          "ally":  ".mm_a{font-family:$FieldFont; font-size:8px; color:#96FF00;}", //BBEEBB союзник
          "enemy": ".mm_e{font-family:$FieldFont; font-size:8px; color:#F50800;}",
 //EEBBBB враг
          "squad": ".mm_s{font-family:$FieldFont; font-size:8px; color:#FFB964;}", //FFEE44 взводный
          "lost":  ".mm_l{font-family:$FieldFont; font-size:8px; color:#8278FE;} .mm_lclass{font-family:Arial; font-size:10px; color:#FFBBDD;}", //FFFFFF пропавший
          "oneself": ".mm_o{font-family:$FieldFont; font-size:8px; color:#FF00DC;}"
 //EEAACC вы
        }, 
        "shadow": { // Тень полей 
          "ally": { // союзник
            "enabled": true, 
            "color": "0x000000", // Цвет //00FF00 
            "distance": 0,       // дистанция смещение //0 
            "angle": 0,          // угол смещения //0
            "alpha": 100,        // Прозрачность 0-100 //40 
            "blur": 2,           // Размытие 0-255 //8
            "strength": 6        // интенсивность 0-255 //14 
          }, 
          "enemy": { // враг
            "enabled": true, 
            "color": "0x000000", //FF0000 
            "distance": 0, 
            "angle": 0, 
            "alpha": 100, 
            "blur": 2, 
            "strength": 6 
          }, 
          "squad": { // взводный
            "enabled": true, 
            "color": "0x000000", //00CCCC 
            "distance": 0, 
            "angle": 0, 
            "alpha": 100, 
            "blur": 2, 
            "strength": 6 
          }, 
          "lost": { // пропавший
            "enabled": true, 
            "color": "0x000000", //FF0000 
            "distance": 0, 
            "angle": 0, 
            "alpha": 100, 
            "blur": 2, 
            "strength": 6 
          }, 
          "oneself": { // вы
            "enabled": true, 
            "color": "0x000000", //FFFFFF 
            "distance": 0, 
            "angle": 0, 
            "alpha": 100, 
            "blur": 2, 
            "strength": 6 
          } 
        },

 
        "offset": { // Смещение поля относительно текущей иконки.
          "ally":  {"x": -10, "y": -14},   // союзник 
          "enemy": {"x": -10, "y": -14},   // враг 
          "squad": {"x": -10, "y": -14},   // взводный
          "lost":  {"x": -9, "y": -3},      // пропавший 
          "oneself": {"x": -13, "y": -16}  // вы 
        }, 
        "alpha" : { // Прозрачность текста 0-100
          "ally":  100, 
          "enemy": 100, 
          "squad": 100, 
          "lost":  80, 
          "oneself": 100 
        } 
      },
 
      "mapSize": { // Поле размера стороны карты. Например 1000м, 700м, 600м. 
        // Работает только с xvm-stat.exe
        "enabled": true, 
        "format": "<b>{{cellsize}}0 м</b>   (<font size='6' color='#F50800'>сток</b></font>   <font size='6' color='#7FDC00'>топ</b></font>   <font size='6' color='#D042F3'>модули</b></font>   <font size='6' color='#00EAFF'>max</b></font>)", 
        "css": "font-size:6px; color:#FFFFFF;", 
        "alpha": 70, //80
        "offsetX": 0, 
        "offsetY": 0, 
        "shadow": { // Тень. 
          "enabled": true, 
          "color": "0x000000", //AAAAAA
          "distance": 0, 
          "angle": 0, 
          "alpha": 100, //80
          "blur": 2, //2
          "strength": 6 //3
        }, 
        // Уменьшайте размеры, если при изменении размера миникарты изображение карты сжимается.
        // Увеличивайте размеры, если содержмиое поля обрезается.
        "width": 100, // Уменьшайте размеры, если при изменении размера миникарты изображение карты сжимается. 
        "height": 30  // Увеличивайте размеры, если содержмиое поля обрезается. 
      }
    }
}