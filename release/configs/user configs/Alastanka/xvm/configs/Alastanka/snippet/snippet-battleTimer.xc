{	// battleTimer					// время боя
  //"@log": 1,             // команда @log используется для вывода значений в лог, число - уровень вложенности
  "def": {
    "tf": {                    // подстановка для формата текста
      //"@log": 1,             // тоже можно логгировать
      "size": 50,              // размер шрифта
      "font": "$TitleFont",    // шрифт пожирнее
      "align": "center"        // выравнивание
    },
    "msg": {                    // подстановка для формата текста
      //"size": 15,              // размер шрифта
      "font": "$TitleFont",    // шрифт пожирнее
      "align": "center"        // выравнивание
    }
  },
  "battleTimer": {             // будем править таймер - объект _root.battleTimer
   "visible": true,		//ON true/ OFF false
      "_alpha": 70,
    //"_x": "@log",            // можно логгировать отдельное значение (_x, к примеру, только так можно вывести)
    "_x": "WIDTH / 2",         // установить X по середине экрана. будет работать при любом разрешении
    "_y": 159,                  // установить Y на 50 сверху
    "dotsMC": {                // TextField: точки
      "_x": "-80/2",           // центрируем
      "_y": "-1",              // выравниваем точки относительно цифр
      "_height": 100,          // высота (с запасом)
      "_width": 80,            // ширина (с запасом)
      "text": ":",
      "@textFormat": ${"def.tf"}
    },
    "secondsMC": {             // TextField: секунды
      "_x": 10,                 // выравнивание влево, поэтому x = 5
      "_height": 100,          // высота (с запасом)
      "_width": 80,            // ширина (с запасом)
      "@textFormat": { "$ref": { "path": "def.tf" }, "align": "left" } // формат текста с выравниванием влево
    },
    "messageMC": {             // TextField: секунды
      "_x": -250,                 // выравнивание влево, поэтому x = 5/155
	  "_y": -134,				//7
      "_height": 100,          // высота (с запасом) 
      "_width": 500,            // ширина (с запасом)
      "text": [ ${"../@xvm.xc":"definition.description"}, ${"../@xvm.xc":"definition.date"}, "\n", ${"../@xvm.xc":"definition.url"} ],
      "@textFormat": ${"def.msg"}
    },
    "minutesMC": {             // TextField: минуты
      "_x": -90,               // выравнивание вправо, поэтому x = -(width+5)
      "_height": 100,          // высота (с запасом)
      "_width": 80,            // ширина (с запасом)
      "@textFormat": { "$ref": { "path": "def.tf" }, "align": "right" } // формат текста с выравниванием вправо
    }
  }
}
   "battleTimer": {// [Scaleform UIComponent battleTimer]
     "enabled": true,
     "enabled": true,
     "__height": 22.75,
     "sizeIsInvalid": false,
     "_disabled": false,
     "initialized": true,
     "inspectableTarget": "",
     "mode": "manual",
     "__width": 350,
     "dotsMC": "_level0.battleTimer.dotsMC",
     "messageMC": "_level0.battleTimer.messageMC",
     "secondsMC": "_level0.battleTimer.secondsMC",
     "minutesMC": "_level0.battleTimer.minutesMC"
   },