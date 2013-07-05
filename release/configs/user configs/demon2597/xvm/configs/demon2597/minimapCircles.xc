/**
 * Minimap circles. Only real map meters. Only for own unit. Works only with xvm-stat.exe for uncommon locales.
 * xvm-stat.exe is not necessary for RU, EN, DE and partially CH locale.
 * Круги на миникарте. Дистанция только в реальных метрах карты. Только для своей техники.
 */
{
  "def": {
         // "enabled": true - включен; "thickness" - толщина; "alpha" - прозрачность; "color" - цвет.
         // Range circle definition.
         // Шаблон кругов дальнобойности.
         "range": { "enabled": true, "thickness": 1, "alpha": 40, "color": "0xFE7903" }
         },
  "circles": {
        "enabled": true,
        // Основные круги.
        // "enabled": true - включен; "distance" - дистанция; "thickness" - толщина; "alpha" - прозрачность; "color" - цвет.
        "major": [
            // 445 meters - maximum reveal distance. / 445 метров - максимальная дистанция засвета.
            { "enabled": true, "distance": 445, "thickness": 1, "alpha": 30, "color": "0xFFCC66" },
            { "enabled": false, "distance": 50, "thickness": 1, "alpha": 30, "color": "0xFFFFFF" }
        ],
        // Special circles dependent on vehicle type.
        // Many configuration lines for the same vehicle make many circles.
        // Only artillery top gun range by default.
        // See other vehicle types at:
        // http://code.google.com/p/wot-xvm/source/browse/trunk/src/xvm/src/wot/utils/VehicleInfoData2.as
        // Artillery gun fire range may differ depending on vehicle angle relative to ground
        // and vehicle height positioning relative to target. These factors are not considered.
        // See pics at http://goo.gl/ZqlPa
        // ------------------------------------------------------------------------------------------------
        // Специальные круги, зависящие от модели техники.
        // Несколько строк для одной техники делают несколько кругов.
        // По умолчанию в списке только круги дальнобойности артиллерии с топ орудиями.
        // Названия танков для дополнения брать по ссылке
        // http://code.google.com/p/wot-xvm/source/browse/trunk/src/xvm/src/wot/utils/VehicleInfoData2.as
        // Дальнобойность арты может меняться в зависимости от углов постановки машины на склонах местности
        // и высоте расположения машины относительно цели. На миникарте эти факторы не учитываются.
        // Подробнее по ссылке: http://goo.gl/ZqlPa
        "special": [
   // Artillery range
   // Дальнобойность САУ
   // level 2
            { "su_18":				{ "$ref": { "path": "def.range" }, "distance": 500 } },
            { "gw_mk_vie":			{ "$ref": { "path": "def.range" }, "distance": 850 } },
            { "t57":					{ "$ref": { "path": "def.range" }, "distance": 553 } },
            { "renaultbs":			{ "$ref": { "path": "def.range" }, "distance": 483 } },
   // level 3
            { "su_26":				{ "$ref": { "path": "def.range" }, "distance": 1218 } },
            { "bison_i":				{ "$ref": { "path": "def.range" }, "distance": 602 } },
            { "wespe":				{ "$ref": { "path": "def.range" }, "distance": 989 } },
            { "m7_priest":			{ "$ref": { "path": "def.range" }, "distance": 989 } },
            { "lorraine39_l_am":		{ "$ref": { "path": "def.range" }, "distance": 983 } }, 
            { "gb78_sexton_i":		{ "$ref": { "path": "def.range" }, "distance": 767 } },  
 // level 4
            { "su_5":				{ "$ref": { "path": "def.range" }, "distance": 613 } },
            { "sturmpanzer_ii":		{ "$ref": { "path": "def.range" }, "distance": 602 } },
            { "pz_sfl_ivb":			{ "$ref": { "path": "def.range" }, "distance": 989 } },
            { "m37":				{ "$ref": { "path": "def.range" }, "distance": 989 } },
            { "amx_ob_am105":		{ "$ref": { "path": "def.range" }, "distance": 1288 } },
   // level 5
            { "su122a":				{ "$ref": { "path": "def.range" }, "distance": 1201 } },
            { "grille":				{ "$ref": { "path": "def.range" }, "distance": 836 } },
            { "m41":				{ "$ref": { "path": "def.range" }, "distance": 1294 } },
            { "amx_105am":			{ "$ref": { "path": "def.range" }, "distance": 1288 } },
            { "_105_lefh18b2":		{ "$ref": { "path": "def.range" }, "distance": 989 } },
   // level 6
            { "su_8":				{ "$ref": { "path": "def.range" }, "distance": 1345 } },
            { "hummel":				{ "$ref": { "path": "def.range" }, "distance": 1260 } },
            { "m44":				{ "$ref": { "path": "def.range" }, "distance": 1294 } },
            { "amx_13f3am":			{ "$ref": { "path": "def.range" }, "distance": 1381 } },
   // level 7
            { "s_51":				{ "$ref": { "path": "def.range" }, "distance": 1264 } },
            { "su14_1":				{ "$ref": { "path": "def.range" }, "distance": 1264 } },
            { "g_panther":			{ "$ref": { "path": "def.range" }, "distance": 1300 } },
            { "m12":				{ "$ref": { "path": "def.range" }, "distance": 1413 } },
            { "lorraine155_50":		{ "$ref": { "path": "def.range" }, "distance": 1350 } },
   // level 8
            { "su_14":				{ "$ref": { "path": "def.range" }, "distance": 1264 } },
            { "gw_tiger_p":			{ "$ref": { "path": "def.range" }, "distance": 1333 } }, 
            { "m40m43":				{ "$ref": { "path": "def.range" }, "distance": 1336 } },
            { "lorraine155_51":		{ "$ref": { "path": "def.range" }, "distance": 1368 } },
   // level 9
            { "object_212":			{ "$ref": { "path": "def.range" }, "distance": 1264 } },
            { "g_tiger":				{ "$ref": { "path": "def.range" }, "distance": 1333 } },
            { "m53_55":				{ "$ref": { "path": "def.range" }, "distance": 1291 } },
            { "bat_chatillon155_55":	{ "$ref": { "path": "def.range" }, "distance": 1413 } },
   // level 10
            { "object_261":			{ "$ref": { "path": "def.range" }, "distance": 1470 } },
            { "g_e":				{ "$ref": { "path": "def.range" }, "distance": 1333 } },
            { "t92":					{ "$ref": { "path": "def.range" }, "distance": 1411 } },
            { "bat_chatillon155_58":	{ "$ref": { "path": "def.range" }, "distance": 1413 } }
        ]
    }
}