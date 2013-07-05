/**
 * Visual elements.
 * Двигать визуальные элименты.
 * Подгружается с файла "battle.xc"
 */
{
  // Visual elements
  // Двигать визуальные элименты
	"elements": {
		// x - X позиция
		// y - Y позиция
		// w - ширина
		// h - высота
		// a - Альфа
		// ha - горизонтальное выравнивание
		// va - выравнивание по вертикали
		// debug - false=скрыть границы, true=названия элементов и геометрии
		// x, y значения могут быть:
		//   null - использовать по умолчанию значения клиента
		//   -xxxx..xxxx
		//   xx.xx%
		// ha значения могут быть:
		//   null - использовать по умолчанию значения клиента
		//   1 - лево
		//   2 - право
		// va значения могут быть:
		//   null - использовать по умолчанию значения клиента
		//   1 - вверх
		//   2 - низ
		//389.5x0+413,45.5 => XxY+W,H
	"minimap":				{ "x":null, "y":null, "w":null, "h":null, "ha":null, "va":null, "a":null, "debug":false },	//миникарта															//461.9,478.5
	"playerMessangersPanel":{ "x":null, "y":null, "w":null, "h":null, "ha":null, "va":null, "a":null, "debug":false },	//сообщения чат убитых(кто кого убил)								//100,40
	"leftPanel":			{ "x":null, "y":null, "w":null, "h":null, "ha":null, "va":null, "a":null, "debug":false },	//панель уши левые													//628.95,751
	"rightPanel":			{ "x":null, "y":null, "w":null, "h":null, "ha":null, "va":null, "a":null, "debug":false },	//панель уши правые													//1372.45,751
	"switcher_mc":			{ "x":null, "y":null, "w":null, "h":null, "ha":null, "va":null, "a":null, "debug":false },	//панель переключения ушей											//204,42.5
	"fragCorrelationBar":	{ "x":null, "y":null, "w":null, "h":null, "ha":null, "va":null, "a":null, "debug":false },	//счёт боя, вверху посередине										//413,45.5
	"debugPanel":			{ "x":null, "y":null, "w":null, "h":null, "ha":null, "va":null, "a":null, "debug":false },	//пинг-лаг панель													//525.5,44.3
	"battleTimer":			{ "x":null, "y":null, "w":null, "h":null, "ha":null, "va":null, "a":null, "debug":false },	//время боя, право верх												//351,41.85
	"damagePanel":			{ "x":null, "y":null, "w":null, "h":null, "ha":null, "va":null, "a":null, "debug":false },	//дамаг-панель слева внизу											//233,231
	"sixthSenseIndicator":	{ "x":null, "y":null, "w":null, "h":null, "ha":null, "va":null, "a":null, "debug":false },	//индикатор(шестое чувство)											//373.35,394.95
	"vehicleErrorsPanel":	{ "x":null, "y":null, "w":null, "h":null, "ha":null, "va":null, "a":null, "debug":false },	//сообщения в центре экрана(о снаряжении, командире)				//100,40
	"messenger":			{ "x":null, "y":null, "w":null, "h":null, "ha":null, "va":null, "a":null, "debug":false },	//сообщения(чат что пишут игроки)									//350.95,393
	"damageInfoPanel":		{ "x":null, "y":null, "w":null, "h":null, "ha":null, "va":null, "a":null, "debug":false },	//																	//1200.4,86.05
	"timerBig":				{ "x":null, "y":null, "w":null, "h":null, "ha":null, "va":null, "a":null, "debug":false },	//таймер до начала боя												//1533.5,285.35
	"deathZoneTimer":		{ "x":null, "y":null, "w":null, "h":null, "ha":null, "va":null, "a":null, "debug":false },	//?																	//213.5,213.5
	"overturnedTimer":		{ "x":null, "y":null, "w":null, "h":null, "ha":null, "va":null, "a":null, "debug":false },	//?																	//213.5,213.5
	"drownTimer":			{ "x":null, "y":null, "w":null, "h":null, "ha":null, "va":null, "a":null, "debug":false },	//таймер когда тонет танк											//225.5,230.5
	"langBarPanel":			{ "x":null, "y":null, "w":null, "h":null, "ha":null, "va":null, "a":null, "debug":false },	//																	//100,40
	"consumablesPanel":		{ "x":null, "y":null, "w":null, "h":null, "ha":null, "va":null, "a":null, "debug":false },	//панель расходники и патроны										//100,40
	"vehicleMessagesPanel":	{ "x":null, "y":null, "w":null, "h":null, "ha":null, "va":null, "a":null, "debug":false },	//сообщения внизу в центре экрана(о том,кто попал,повредил тебя). 	//100,40
	"teamBasesPanel":		{ "x":null, "y":null, "w":null, "h":null, "ha":null, "va":null, "a":null, "debug":false }	//полоса захвата баз												//618.5,54.3
	}

}