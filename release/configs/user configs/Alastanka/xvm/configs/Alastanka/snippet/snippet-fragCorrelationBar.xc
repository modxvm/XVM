{	// fragCorrelationBar			// счёт боя
  "def": {
    "allied": {					// подстановка для формата текста
      "size": 30,				// размер шрифта
      "font": "$TitleFont",		// шрифт пожирнее
	  "color": "0x96FF00",		// цвет
	  "bold": true,				// жирный
      "align": "center"			// выравнивание
    },
    "enemy": {					// подстановка для формата текста
      "size": 30,				// размер шрифта
      "font": "$TitleFont",		// шрифт пожирнее
	  "color": "0xF50800",		// цвет
	  "bold": true,				// жирный
      "align": "center"			// выравнивание
    }
  },
   "fragCorrelationBar": {
	"visible": true,
	//"_x": 0,
	//"_y": 0,
    "indicator": {// _level0.fragCorrelationBar.indicator						//Индикатор больше, меньше, двоеточие
      //"_y": 100
	},
    "m_enemyTeamFragsTF": {// _level0.fragCorrelationBar.m_enemyTeamFragsTF		//Противники фраги
	  //"_x": 0,
	  "_y": -5,
	  "_height": 50,          // высота (с запасом)
	  "@textFormat": ${"def.enemy"}
	},
    "m_alliedTeamFragsTF": {// _level0.fragCorrelationBar.m_alliedTeamFragsTF	//Союзники фраги
	  //"_x": 0,
	  "_y": -5,
	  "_height": 50,          // высота (с запасом)
	  "@textFormat": ${"def.allied"}
	},
	"m_alliedTeamTF": {// _level0.fragCorrelationBar.m_alliedTeamTF				//Союзники надпись
      "_y": "fragCorrelationBar._y - 6",
      "_x": "fragCorrelationBar.m_enemyTeamTF._x - 162",
	  "_width": 90,
      "textColor": "0x96FF00"
	},
    "m_enemyTeamTF": {// _level0.fragCorrelationBar.m_enemyTeamTF				//Противники надпись
      "_y": "fragCorrelationBar._y - 6",
      "_x": "fragCorrelationBar.m_enemyTeamTF._x + 25",
	  "_width": 90,
      "textColor": "0xF50800"
    },
	"alliedMarkers": {// [Scaleform UIComponent alliedMarkers]					//Маркеры техники Союзники
      "_y": "fragCorrelationBar.alliedMarkers._y + 8",
	  "_x": "fragCorrelationBar.alliedMarkers._x + 20"
	},
	"enemyMarkers": {// [Scaleform UIComponent enemyMarkers]					//Маркеры техники Противники
      "_y": "fragCorrelationBar.enemyMarkers._y + 8",
	  "_x": "fragCorrelationBar.enemyMarkers._x - 20"
	},
	"redBg": {// [Scaleform UIComponent redBg]									//Маркер больше, меньше
      //"_y": 100
	},
	"greenBg": {// [Scaleform UIComponent greenBg]								//Маркер больше, меньше
      //"_y": 100
	}
  }
}
   "fragCorrelationBar": {// [Scaleform UIComponent fragCorrelationBar]
     "enabled": true,
     "enabled": true,
     "sizeIsInvalid": false,
     "__height": 66.1,
     "initialized": true,
     "scrollRect": "(x=0, y=0, width=1019, height=33.05)",
     "__width": 1019,
     "indicator": "_level0.fragCorrelationBar.indicator",
     "m_enemyTeamFragsTF": "_level0.fragCorrelationBar.m_enemyTeamFragsTF",
     "m_alliedTeamFragsTF": "_level0.fragCorrelationBar.m_alliedTeamFragsTF",
     "m_enemyTeamTF": "_level0.fragCorrelationBar.m_enemyTeamTF",
     "m_alliedTeamTF": "_level0.fragCorrelationBar.m_alliedTeamTF",
     "alliedMarkers": "[Scaleform UIComponent alliedMarkers]",
     "enemyMarkers": "[Scaleform UIComponent enemyMarkers]",
     "redBg": "[Scaleform UIComponent redBg]",
     "greenBg": "[Scaleform UIComponent greenBg]"
   },