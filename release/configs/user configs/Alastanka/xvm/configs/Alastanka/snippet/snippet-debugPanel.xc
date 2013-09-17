{	// debugPanel					// пинг-лаг-фпс панель
  "def": {
    "tf": {                    // подстановка для формата текста
      //"size": 15,              // размер шрифта
      "font": "$TitleFont",    // шрифт пожирнее
	  "color": "0x96FF00"
      //"align": "center"        // выравнивание
    }
  },
   "debugPanel": {
   "visible": true,		//ON true/ OFF false
   "_x": "WIDTH / 2 - 250",	//Делим экран на 3 части и минус(-) или плюс(+) пикселей
   "_y": 1, //32
     "clock": {// _level0.debugPanel.clock
	   "_x": 380,
	   "_y": -2
     },
     "lag": {// _level0.debugPanel.lag
       "@textFormat": ${"def.tf"}
     },
     "ping": {// _level0.debugPanel.ping
	   "@textFormat": ${"def.tf"}
     },
     "fps": {// _level0.debugPanel.fps
	   "@textFormat": ${"def.tf"}
     }
   }
}
   "debugPanel": {// [Scaleform UIComponent debugPanel]
     "enabled": true,
     "enabled": true,
     "_disabled": false,
     "sizeIsInvalid": false,
     "__height": 24.1,
     "initialized": true,
     "__width": 186.5,
     "clock": "_level0.debugPanel.clock",
     "lag": "_level0.debugPanel.lag",
     "ping": "_level0.debugPanel.ping",
     "fps": "_level0.debugPanel.fps"
   },