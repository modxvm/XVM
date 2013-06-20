/**
 * Minimap circles. Only real map meters. Only for own unit. Works only with xvm-stat.exe for uncommon locales.
 * xvm-stat.exe is not necessary for RU, EN, DE and partially CH locale.
 * Круги на миникарте. Дистанция только в реальных метрах карты. Только для своей техники.
 */
{
  // Artillery gun fire range circle
  // Круг дальности стрельбы арты
  // "enabled": false - выключен; "thickness" - толщина; "alpha" - прозрачность; "color" - цвет.
  "rangeCircle": { "enabled": true, "thickness": 1, "alpha": 60, "color": "0xEE4444" },
  
  "circles": {
        "enabled": true,
        // Основные круги.
        // "enabled": false - выключен; "distance" - дистанция; "thickness" - толщина; "alpha" - прозрачность; "color" - цвет.
        "major": [
            // 445 meters - maximum reveal distance. / 445 метров - максимальная дистанция засвета.
            { "enabled": true,  "distance": 445, "thickness": 0.75, "alpha": 35, "color": "0xFFCC66" },
            { "enabled": false, "distance": 50,  "thickness": 1,    "alpha": 30, "color": "0xFFFFFF" }
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
        // http://code.google.com/p/wot-xvm/source/browse/trunk/src/xvm/src/com/xvm/VehicleInfoData2.as
        // Дальнобойность арты может меняться в зависимости от углов постановки машины на склонах местности
        // и высоте расположения машины относительно цели. На миникарте эти факторы не учитываются.
        // Подробнее по ссылке: http://goo.gl/ZqlPa
        "special": [
            { "su_18":            {"$ref": { "path": "rangeCircle" }, "distance": 552  } },
            { "su_26":            {"$ref": { "path": "rangeCircle" }, "distance": 578  } },
            { "su_5":             {"$ref": { "path": "rangeCircle" }, "distance": 605  } },
            { "su_8":             {"$ref": { "path": "rangeCircle" }, "distance": 920  } },
            { "s_51":             {"$ref": { "path": "rangeCircle" }, "distance": 1229 } },
            { "su_14":            {"$ref": { "path": "rangeCircle" }, "distance": 1229 } },
            { "object_212":       {"$ref": { "path": "rangeCircle" }, "distance": 1229 } },
            { "object_261":       {"$ref": { "path": "rangeCircle" }, "distance": 1463 } },

            { "bison_i":          {"$ref": { "path": "rangeCircle" }, "distance": 605  } },
            { "sturmpanzer_ii":   {"$ref": { "path": "rangeCircle" }, "distance": 605  } },
            { "wespe":            {"$ref": { "path": "rangeCircle" }, "distance": 1000 } },
            { "grille":           {"$ref": { "path": "rangeCircle" }, "distance": 1210 } },
            { "hummel":           {"$ref": { "path": "rangeCircle" }, "distance": 1264 } },
            { "g_panther":        {"$ref": { "path": "rangeCircle" }, "distance": 1407 } },
            { "g_tiger":          {"$ref": { "path": "rangeCircle" }, "distance": 1172 } },
            { "g_e":              {"$ref": { "path": "rangeCircle" }, "distance": 1172 } },

            { "t57":              {"$ref": { "path": "rangeCircle" }, "distance": 552  } },
            { "m37":              {"$ref": { "path": "rangeCircle" }, "distance": 969  } },
            { "m7_priest":        {"$ref": { "path": "rangeCircle" }, "distance": 1047 } },
            { "m41":              {"$ref": { "path": "rangeCircle" }, "distance": 1210 } },
            { "m12":              {"$ref": { "path": "rangeCircle" }, "distance": 1316 } },
            { "m40m43":           {"$ref": { "path": "rangeCircle" }, "distance": 1179 } },
            { "t92":              {"$ref": { "path": "rangeCircle" }, "distance": 1248 } },

            { "renaultbs":        {"$ref": { "path": "rangeCircle" }, "distance": 450  } },
            { "lorraine39_l_am":  {"$ref": { "path": "rangeCircle" }, "distance": 844  } },
            { "amx_105am":        {"$ref": { "path": "rangeCircle" }, "distance": 1000 } },
            { "_105_lefh18b2":    {"$ref": { "path": "rangeCircle" }, "distance": 1000 } },
            { "amx_13f3am":       {"$ref": { "path": "rangeCircle" }, "distance": 1250 } },
            { "lorraine155_50":   {"$ref": { "path": "rangeCircle" }, "distance": 1202 } },
            { "lorraine155_51":   {"$ref": { "path": "rangeCircle" }, "distance": 1296 } },
            { "bat_chatillon155": {"$ref": { "path": "rangeCircle" }, "distance": 1296 } },

            { "gb78_sexton_i":    {"$ref": { "path": "rangeCircle" }, "distance": 767  } }
        ]
    }
}