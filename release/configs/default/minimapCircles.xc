/**
 *
 */
{
  "circles": { //  руги дальности. ƒистанци€ только в реальных метрах карты. “олько дл€ своей техники.
        "enabled": true,
        "major": [ // ќсновные круги. thickness - толщина.
            { "enabled": true, "distance": 445, "thickness": 0.75, "alpha": 35, "color": "0xFFCC66" },  // 445 метров - максимальна€ дистанци€ засвета.
            { "enabled": false, "distance": 50, "thickness": 1, "alpha": 30, "color": "0xFFFFFF" }   // enabled : false <- выключен
        ],
        // —пециальные круги, завис€щие от модели техники.
        // Ќесколько строк дл€ одной техники делают несколько кругов.
        // ѕо умолчанию в списке только круги дальнобойности артиллерии с топ оруди€ми.
        //   “ипы дл€ дополнени€ брать по ссылке
        // http://code.google.com/p/wot-xvm/source/browse/trunk/src/xvm/src/wot/utils/VehicleInfoData2.as
        //   ƒальнобойность арты может мен€тьс€ в зависимости от углов постановки машины на склонах местности
        // и высоте расположени€ машины относительно цели. Ќа миникарте эти факторы не учитываютс€.
        // ѕодробнее по ссылке: http://goo.gl/ZqlPa
        "special": [
            { "su_18":            { "enabled": true, "distance": 552,  "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "su_26":            { "enabled": true, "distance": 578,  "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "su_5":             { "enabled": true, "distance": 605,  "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "su_8":             { "enabled": true, "distance": 920,  "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "s_51":             { "enabled": true, "distance": 1229, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "su_14":            { "enabled": true, "distance": 1229, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "object_212":       { "enabled": true, "distance": 1229, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "object_261":       { "enabled": true, "distance": 1463, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },

            { "bison_i":          { "enabled": true, "distance": 605,  "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "sturmpanzer_ii":   { "enabled": true, "distance": 605,  "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "wespe":            { "enabled": true, "distance": 1000, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "grille":           { "enabled": true, "distance": 1210, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "hummel":           { "enabled": true, "distance": 1264, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "g_panther":        { "enabled": true, "distance": 1407, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "g_tiger":          { "enabled": true, "distance": 1172, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "g_e":              { "enabled": true, "distance": 1172, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },

            { "t57":              { "enabled": true, "distance": 552,  "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "m37":              { "enabled": true, "distance": 969,  "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "m7_priest":        { "enabled": true, "distance": 1047, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "m41":              { "enabled": true, "distance": 1210, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "m12":              { "enabled": true, "distance": 1316, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "m40m43":           { "enabled": true, "distance": 1179, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "t92":              { "enabled": true, "distance": 1248, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },

            { "renaultbs":        { "enabled": true, "distance": 450,  "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "lorraine39_l_am":  { "enabled": true, "distance": 844,  "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "amx_105am":        { "enabled": true, "distance": 1000, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "_105_lefh18b2":    { "enabled": true, "distance": 1000, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "amx_13f3am":       { "enabled": true, "distance": 1250, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "lorraine155_50":   { "enabled": true, "distance": 1202, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "lorraine155_51":   { "enabled": true, "distance": 1296, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },
            { "bat_chatillon155": { "enabled": true, "distance": 1296, "thickness": 1, "alpha": 60, "color": "0xEE4444" } },

            { "gb78_sexton_i":    { "enabled": true, "distance": 767,  "thickness": 1, "alpha": 60, "color": "0xEE4444" } }
        ]
    }
}