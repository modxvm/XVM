/**
 * Minimap circles. Only real map meters. Only for own unit. Works only with xvm-stat.exe for uncommon locales.
 * xvm-stat.exe is not necessary for RU, EN, DE and partially CH locale.
 * Круги на миникарте. Дистанция только в реальных метрах карты. Только для своей техники.
 */
{
  // "enabled": false - выключен;
  // "distance" - дистанция;
  // "thickness" - толщина;
  // "alpha" - прозрачность;
  // "color" - цвет.
  // Reveal distance circle
  // Круг дистанции засвета
  "seeCircle":      { "enabled": true, "thickness": 1, "alpha": 75, "color": "0x7DFF3D" },
  // Artillery gun fire range circle
  // Круг дальности стрельбы арты
  "rangeCircle":    { "enabled": true, "thickness": 1, "alpha": 75, "color": "0xEE4384" },
  // Fire range circle for some non artyllery tanks
  // Круг дальности стрельбы некоторых орудий обычных танков
  "rangeCircleGun": { "enabled": true, "thickness": 1, "alpha": 75, "color": "0x0082FF" },

  "circles": {
        "enabled": true,
        // Основные круги.
        // "enabled": false - выключен; "distance" - дистанция; "thickness" - толщина; "alpha" - прозрачность; "color" - цвет.
        "major": [
            // 445 meters - maximum reveal distance. / 445 метров - максимальная дистанция засвета.
            { "enabled": true, "distance": 445, "thickness": 1, "alpha": 65, "color": "0xFFCC66" },
            { "enabled": true, "distance":  50, "thickness":   1, "alpha": 50, "color": "0xFFFFFF" }
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

        // Дальность стрельбы арты
        // level 2
            { "su_18":                {"$ref": { "path": "rangeCircle" }, "distance": 500 } },
            { "gw_mk_vie":            {"$ref": { "path": "rangeCircle" }, "distance": 850 } },
            { "t57":                  {"$ref": { "path": "rangeCircle" }, "distance": 553 } },
            { "renaultbs":            {"$ref": { "path": "rangeCircle" }, "distance": 483 } },
        // level 3
            { "su_26":                {"$ref": { "path": "rangeCircle" }, "distance": 1218} },
            { "bison_i":              {"$ref": { "path": "rangeCircle" }, "distance": 602 } },
            { "wespe":                {"$ref": { "path": "rangeCircle" }, "distance": 989 } },
            { "m7_priest":            {"$ref": { "path": "rangeCircle" }, "distance": 989 } },
            { "lorraine39_l_am":      {"$ref": { "path": "rangeCircle" }, "distance": 983 } },
            { "gb78_sexton_i":        {"$ref": { "path": "rangeCircle" }, "distance": 767 } },
        // level 4
            { "su_5":                 {"$ref": { "path": "rangeCircle" }, "distance": 613 } },
            { "sturmpanzer_ii":       {"$ref": { "path": "rangeCircle" }, "distance": 602 } },
            { "pz_sfl_ivb":           {"$ref": { "path": "rangeCircle" }, "distance": 989 } },
            { "m37":                  {"$ref": { "path": "rangeCircle" }, "distance": 989 } },
            { "amx_ob_am105":         {"$ref": { "path": "rangeCircle" }, "distance": 1288} },
        // level 5
            { "su122a":               {"$ref": { "path": "rangeCircle" }, "distance": 1201} },
            { "grille":               {"$ref": { "path": "rangeCircle" }, "distance": 836 } },
            { "m41":                  {"$ref": { "path": "rangeCircle" }, "distance": 1294} },
            { "amx_105am":            {"$ref": { "path": "rangeCircle" }, "distance": 1288} },
        // level 6
            { "su_8":                 {"$ref": { "path": "rangeCircle" }, "distance": 1345} },
            { "hummel":               {"$ref": { "path": "rangeCircle" }, "distance": 1260} },
            { "m44":                  {"$ref": { "path": "rangeCircle" }, "distance": 1294} },
            { "amx_13f3am":           {"$ref": { "path": "rangeCircle" }, "distance": 1381} },
        // level 7
            { "s_51":                 {"$ref": { "path": "rangeCircle" }, "distance": 1264} },
            { "su14_1":               {"$ref": { "path": "rangeCircle" }, "distance": 1264} },
            { "g_panther":            {"$ref": { "path": "rangeCircle" }, "distance": 1300} },
            { "m12":                  {"$ref": { "path": "rangeCircle" }, "distance": 1413} },
            { "lorraine155_50":       {"$ref": { "path": "rangeCircle" }, "distance": 1350} },
        // level 8
            { "su_14":                {"$ref": { "path": "rangeCircle" }, "distance": 1264} },
            { "gw_tiger_p":           {"$ref": { "path": "rangeCircle" }, "distance": 1333} },
            { "m40m43":               {"$ref": { "path": "rangeCircle" }, "distance": 1336} },
            { "lorraine155_51":       {"$ref": { "path": "rangeCircle" }, "distance": 1368} },
        // level 9
            { "object_212":           {"$ref": { "path": "rangeCircle" }, "distance": 1264} },
            { "g_tiger":              {"$ref": { "path": "rangeCircle" }, "distance": 1333} },
            { "m53_55":               {"$ref": { "path": "rangeCircle" }, "distance": 1291} },
            { "bat_chatillon155_55":  {"$ref": { "path": "rangeCircle" }, "distance": 1413} },
        // level 10
            { "object_261":           {"$ref": { "path": "rangeCircle" }, "distance": 1470} },
            { "g_e":                  {"$ref": { "path": "rangeCircle" }, "distance": 1333} },
            { "t92":                  {"$ref": { "path": "rangeCircle" }, "distance": 1411} },
            { "bat_chatillon155_58":  {"$ref": { "path": "rangeCircle" }, "distance": 1413} },

        // Ограниченная дальнобойность некоторых орудий обычных танков
        // level 1
            { "ms_1":               {"$ref": { "path": "rangeCircleGun" }, "distance": 360 } }, //23 мм ВЯ
            { "ltraktor":           {"$ref": { "path": "rangeCircleGun" }, "distance": 350 } }, //2 cm KwK 38 L/55
            { "t1_cunningham":      {"$ref": { "path": "rangeCircleGun" }, "distance": 360 } }, //20 mm Hispano-Suiza Birgikt Gun
            { "renaultft":          {"$ref": { "path": "rangeCircleGun" }, "distance": 395 } }, //25 mm Canon Raccourci Mle. 1934
            { "gb01_medium_mark_i": {"$ref": { "path": "rangeCircleGun" }, "distance": 350 } }, //Machine Gun BESA
            { "ch06_renault_nc31":  {"$ref": { "path": "rangeCircleGun" }, "distance": 350 } }, //13.2 mm Hotchkiss mle. 1930
        // level 2
            { "t1_e6":              {"$ref": { "path": "rangeCircleGun" }, "distance": 395 } }, //37 mm Semiautomatic Gun M1924A1
            { "t2_lt":              {"$ref": { "path": "rangeCircleGun" }, "distance": 360 } }, //20 mm Hispano Suiza Birgikt Gun M1

       // Дальность максимального засвета танков
       //  данные взяты из ТТХ топовых башен, то есть 100% экипаж без учета модулей и умений
        // Арта
        // level 2
            { "su_18":               {"$ref": { "path": "seeCircle" }, "distance": 260 } },
            { "gw_mk_vie":           {"$ref": { "path": "seeCircle" }, "distance": 320 } },
            { "t57":                 {"$ref": { "path": "seeCircle" }, "distance": 320 } },
            { "renaultbs":           {"$ref": { "path": "seeCircle" }, "distance": 260 } },
        // level 3
            { "su_26":               {"$ref": { "path": "seeCircle" }, "distance": 320 } },
            { "bison_i":             {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "wespe":               {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "m7_priest":           {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "lorraine39_l_am":     {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "gb78_sexton_i":       {"$ref": { "path": "seeCircle" }, "distance": 360 } },
        // level 4
            { "su_5":                {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "sturmpanzer_ii":      {"$ref": { "path": "seeCircle" }, "distance": 340 } },
            { "pz_sfl_ivb":          {"$ref": { "path": "seeCircle" }, "distance": 340 } },
            { "m37":                 {"$ref": { "path": "seeCircle" }, "distance": 340 } },
            { "amx_ob_am105":        {"$ref": { "path": "seeCircle" }, "distance": 340 } },
        // level 5
            { "su122a":              {"$ref": { "path": "seeCircle" }, "distance": 340 } },
            { "grille":              {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "m41":                 {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "amx_105am":           {"$ref": { "path": "seeCircle" }, "distance": 350 } },
        // level 6
            { "su_8":                {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "hummel":              {"$ref": { "path": "seeCircle" }, "distance": 360 } },
            { "m44":                 {"$ref": { "path": "seeCircle" }, "distance": 360 } },
            { "amx_13f3am":          {"$ref": { "path": "seeCircle" }, "distance": 360 } },
        // level 7
            { "s_51":                {"$ref": { "path": "seeCircle" }, "distance": 360 } },
            { "su_14":               {"$ref": { "path": "seeCircle" }, "distance": 360 } },
            { "g_panther":           {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "m12":                 {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "lorraine155_50":      {"$ref": { "path": "seeCircle" }, "distance": 350 } },
        // level 8
            { "su14_1":              {"$ref": { "path": "seeCircle" }, "distance": 310 } },
            { "gw_tiger_p":          {"$ref": { "path": "seeCircle" }, "distance": 380 } },
            { "m40m43":              {"$ref": { "path": "seeCircle" }, "distance": 380 } },
            { "lorraine155_51":      {"$ref": { "path": "seeCircle" }, "distance": 360 } },
        // level 9
            { "object_212":          {"$ref": { "path": "seeCircle" }, "distance": 320 } },
            { "g_tiger":             {"$ref": { "path": "seeCircle" }, "distance": 390 } },
            { "m53_55":              {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "bat_chatillon155_55": {"$ref": { "path": "seeCircle" }, "distance": 400 } },
        // level 10
            { "object_261":          {"$ref": { "path": "seeCircle" }, "distance": 390 } },
            { "g_e":                 {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "t92":                 {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "bat_chatillon155_58": {"$ref": { "path": "seeCircle" }, "distance": 380 } },

       // Техника по уровням:
       // 1
            { "ch06_renault_nc31":             {"$ref": { "path": "seeCircle" }, "distance": 280 } },
            { "gb01_medium_mark_i":            {"$ref": { "path": "seeCircle" }, "distance": 280 } },
            { "ltraktor":                      {"$ref": { "path": "seeCircle" }, "distance": 310 } },
            { "ms_1":                          {"$ref": { "path": "seeCircle" }, "distance": 280 } },
            { "observer":                      {"$ref": { "path": "seeCircle" }, "distance": 240 } },
            { "renaultft":                     {"$ref": { "path": "seeCircle" }, "distance": 280 } },
            { "t1_cunningham":                 {"$ref": { "path": "seeCircle" }, "distance": 280 } },
       // 2
            { "at_1":                          {"$ref": { "path": "seeCircle" }, "distance": 250 } },
            { "bt_2":                          {"$ref": { "path": "seeCircle" }, "distance": 280 } },
            { "ch07_vickers_mke_type_bt26":    {"$ref": { "path": "seeCircle" }, "distance": 310 } },
            { "d1":                            {"$ref": { "path": "seeCircle" }, "distance": 300 } },
            { "gb03_cruiser_mk_i":             {"$ref": { "path": "seeCircle" }, "distance": 320 } },
            { "gb05_vickers_medium_mk_ii":     {"$ref": { "path": "seeCircle" }, "distance": 300 } },
            { "gb39_universal_carrierqf2":     {"$ref": { "path": "seeCircle" }, "distance": 320 } },
            { "gb58_cruiser_mk_iii":           {"$ref": { "path": "seeCircle" }, "distance": 320 } },
            { "h39_captured":                  {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "hotchkiss_h35":                 {"$ref": { "path": "seeCircle" }, "distance": 300 } },
            { "m2_lt":                         {"$ref": { "path": "seeCircle" }, "distance": 320 } },
            { "panzerjager_i":                 {"$ref": { "path": "seeCircle" }, "distance": 320 } },
            { "pz35t":                         {"$ref": { "path": "seeCircle" }, "distance": 320 } },
            { "pzi":                           {"$ref": { "path": "seeCircle" }, "distance": 320 } },
            { "pzii":                          {"$ref": { "path": "seeCircle" }, "distance": 320 } },
            { "renaultft_ac":                  {"$ref": { "path": "seeCircle" }, "distance": 320 } },
            { "t1_e6":                         {"$ref": { "path": "seeCircle" }, "distance": 260 } },
            { "t18":                           {"$ref": { "path": "seeCircle" }, "distance": 240 } },
            { "t2_lt":                         {"$ref": { "path": "seeCircle" }, "distance": 260 } },
            { "t2_med":                        {"$ref": { "path": "seeCircle" }, "distance": 320 } },
            { "t_26":                          {"$ref": { "path": "seeCircle" }, "distance": 310 } },
            { "tetrarch_ll":                   {"$ref": { "path": "seeCircle" }, "distance": 260 } },
            { "t_60":                          {"$ref": { "path": "seeCircle" }, "distance": 300 } },
       // 3
            { "amx38":                         {"$ref": { "path": "seeCircle" }, "distance": 310 } },
            { "bt_7":                          {"$ref": { "path": "seeCircle" }, "distance": 280 } },
            { "bt_sv":                         {"$ref": { "path": "seeCircle" }, "distance": 280 } },
            { "ch08_type97_chi_ha":            {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "d2":                            {"$ref": { "path": "seeCircle" }, "distance": 320 } },
            { "fcm_36pak40":                   {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "g20_marder_ii":                 {"$ref": { "path": "seeCircle" }, "distance": 360 } },
            { "gb06_vickers_medium_mk_iii":    {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "gb42_valentine_at":             {"$ref": { "path": "seeCircle" }, "distance": 360 } },
            { "gb59_cruiser_mk_iv":            {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "gb69_cruiser_mk_ii":            {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "m2_med":                        {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "m22_locust":                    {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "m3_stuart":                     {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "m3_stuart_ll":                  {"$ref": { "path": "seeCircle" }, "distance": 280 } },
            { "mtls_1g14":                     {"$ref": { "path": "seeCircle" }, "distance": 320 } },
            { "pz38t":                         {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "pzi_ausf_c":                    {"$ref": { "path": "seeCircle" }, "distance": 340 } },
            { "pzii_j":                        {"$ref": { "path": "seeCircle" }, "distance": 320 } },
            { "pz_ii_ausfg":                   {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "pziii_a":                       {"$ref": { "path": "seeCircle" }, "distance": 320 } },
            { "renaultue57":                   {"$ref": { "path": "seeCircle" }, "distance": 360 } },
            { "s35_captured":                  {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "su_76":                         {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "t_127":                         {"$ref": { "path": "seeCircle" }, "distance": 320 } },
            { "t_15":                          {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "t_46":                          {"$ref": { "path": "seeCircle" }, "distance": 310 } },
            { "t82":                           {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "t_70":                          {"$ref": { "path": "seeCircle" }, "distance": 310 } },
       // 4
            { "a_20":                          {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "a_32":                          {"$ref": { "path": "seeCircle" }, "distance": 320 } },
            { "amx40":                         {"$ref": { "path": "seeCircle" }, "distance": 340 } },
            { "b1":                            {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "b_1bis_captured":               {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "ch09_m5":                       {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "gaz_74b":                       {"$ref": { "path": "seeCircle" }, "distance": 390 } },
            { "gb04_valentine":                {"$ref": { "path": "seeCircle" }, "distance": 340 } },
            { "gb07_matilda":                  {"$ref": { "path": "seeCircle" }, "distance": 340 } },
            { "gb57_alecto":                   {"$ref": { "path": "seeCircle" }, "distance": 390 } },
            { "gb60_covenanter":               {"$ref": { "path": "seeCircle" }, "distance": 340 } },
            { "hetzer":                        {"$ref": { "path": "seeCircle" }, "distance": 260 } },
            { "m3_grant":                      {"$ref": { "path": "seeCircle" }, "distance": 320 } },
            { "m5_stuart":                     {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "m8a1":                          {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "pz38_na":                       {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "pzii_luchs":                    {"$ref": { "path": "seeCircle" }, "distance": 360 } },
            { "pziii":                         {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "somua_sau_40":                  {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "t_28":                          {"$ref": { "path": "seeCircle" }, "distance": 340 } },
            { "t40":                           {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "t_50":                          {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "valentine_ll":                  {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "t80":                           {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "vk2001db":                      {"$ref": { "path": "seeCircle" }, "distance": 330 } },
       // 5
            { "bdr_g1b":                       {"$ref": { "path": "seeCircle" }, "distance": 320 } },
            { "ch21_t34":                      {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "churchill_ll":                  {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "elc_amx":                       {"$ref": { "path": "seeCircle" }, "distance": 360 } },
            { "gb08_churchill_i":              {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "gb20_crusader":                 {"$ref": { "path": "seeCircle" }, "distance": 360 } },
            { "gb68_matilda_black_prince":     {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "gb73_at2":                      {"$ref": { "path": "seeCircle" }, "distance": 310 } },
            { "kv":                            {"$ref": { "path": "seeCircle" }, "distance": 310 } },
            { "kv1":                           {"$ref": { "path": "seeCircle" }, "distance": 310 } },
            { "kv_220":                        {"$ref": { "path": "seeCircle" }, "distance": 310 } },
            { "kv_220_action":                 {"$ref": { "path": "seeCircle" }, "distance": 310 } },
            { "m10_wolverine":                 {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "m24_chaffee":                   {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "m4_sherman":                    {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "m4a2e4":                        {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "m7_med":                        {"$ref": { "path": "seeCircle" }, "distance": 380 } },
            { "matilda_ii_ll":                 {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "pziii_iv":                      {"$ref": { "path": "seeCircle" }, "distance": 320 } },
            { "pziv":                          {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "pziv_hydro":                    {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "ram_ii":                        {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "s_35ca":                        {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "stugiii":                       {"$ref": { "path": "seeCircle" }, "distance": 310 } },
            { "su_85i":                        {"$ref": { "path": "seeCircle" }, "distance": 320 } },
            { "su_85":                         {"$ref": { "path": "seeCircle" }, "distance": 280 } },
            { "t_50_2":                        {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "t1_hvy":                        {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "t14":                           {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "t_25":                          {"$ref": { "path": "seeCircle" }, "distance": 320 } },
            { "t_34":                          {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "t49":                           {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "vk1602":                        {"$ref": { "path": "seeCircle" }, "distance": 380 } },
            { "gb51_excelsior":                {"$ref": { "path": "seeCircle" }, "distance": 350 } },
       // 6
            { "amx_12t":                       {"$ref": { "path": "seeCircle" }, "distance": 380 } },
            { "arl_44":                        {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "arl_v39":                       {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "ch15_59_16":                    {"$ref": { "path": "seeCircle" }, "distance": 380 } },
            { "ch20_type58":                   {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "dickermax":                     {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "gb09_churchill_vii":            {"$ref": { "path": "seeCircle" }, "distance": 360 } },
            { "gb21_cromwell":                 {"$ref": { "path": "seeCircle" }, "distance": 360 } },
            { "gb40_gun_carrier_churchill":    {"$ref": { "path": "seeCircle" }, "distance": 340 } },
            { "gb63_tog_ii":                   {"$ref": { "path": "seeCircle" }, "distance": 360 } },
            { "gb74_at8":                      {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "jagdpziv":                      {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "kv_1s":                         {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "kv2":                           {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "m18_hellcat":                   {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "m36_slagger":                   {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "m4a3e8_sherman":                {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "m6":                            {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "pziv_schmalturm":               {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "pzv_pziv":                      {"$ref": { "path": "seeCircle" }, "distance": 320 } },
            { "pzv_pziv_ausf_alfa":            {"$ref": { "path": "seeCircle" }, "distance": 320 } },
            { "sherman_jumbo":                 {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "su_100":                        {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "su100y":                        {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "t150":                          {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "t21":                           {"$ref": { "path": "seeCircle" }, "distance": 390 } },
            { "t_34_85":                       {"$ref": { "path": "seeCircle" }, "distance": 360 } },
            { "vk2801":                        {"$ref": { "path": "seeCircle" }, "distance": 390 } },
            { "vk3001h":                       {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "vk3001p":                       {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "vk3601h":                       {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "vk3002db_v1":                   {"$ref": { "path": "seeCircle" }, "distance": 370 } },
       // 7
            { "amx_13_75":                     {"$ref": { "path": "seeCircle" }, "distance": 390 } },
            { "amx_ac_mle1946":                {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "amx_m4_1945":                   {"$ref": { "path": "seeCircle" }, "distance": 360 } },
            { "ch02_type62":                   {"$ref": { "path": "seeCircle" }, "distance": 390 } },
            { "ch04_t34_1":                    {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "ch10_is2":                      {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "ch16_wz_131":                   {"$ref": { "path": "seeCircle" }, "distance": 390 } },
            { "gb10_black_prince":             {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "gb22_comet":                    {"$ref": { "path": "seeCircle" }, "distance": 380 } },
            { "gb71_at_15a":                   {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "gb75_at7":                      {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "is":                            {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "jagdpanther":                   {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "kv_13":                         {"$ref": { "path": "seeCircle" }, "distance": 360 } },
            { "kv_3":                          {"$ref": { "path": "seeCircle" }, "distance": 340 } },
            { "panther_m10":                   {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "pzv":                           {"$ref": { "path": "seeCircle" }, "distance": 380 } },
            { "pzvi":                          {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "pzvi_tiger_p":                  {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "su100m1":                       {"$ref": { "path": "seeCircle" }, "distance": 360 } },
            { "su122_44":                      {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "su_152":                        {"$ref": { "path": "seeCircle" }, "distance": 330 } },
            { "t20":                           {"$ref": { "path": "seeCircle" }, "distance": 390 } },
            { "t25_2":                         {"$ref": { "path": "seeCircle" }, "distance": 380 } },
            { "t25_at":                        {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "t29":                           {"$ref": { "path": "seeCircle" }, "distance": 380 } },
            { "t_43":                          {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "t71":                           {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "vk3002db":                      {"$ref": { "path": "seeCircle" }, "distance": 380 } },
            { "auf_panther":                   {"$ref": { "path": "seeCircle" }, "distance": 390 } },
       // 8
            { "amx_13_90":                     {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "amx_50_100":                    {"$ref": { "path": "seeCircle" }, "distance": 380 } },
            { "amx_ac_mle1948":                {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "ch01_type59":                   {"$ref": { "path": "seeCircle" }, "distance": 380 } },
            { "ch01_type59_gold":              {"$ref": { "path": "seeCircle" }, "distance": 380 } },
            { "ch03_wz_111":                   {"$ref": { "path": "seeCircle" }, "distance": 380 } },
            { "ch05_t34_2":                    {"$ref": { "path": "seeCircle" }, "distance": 380 } },
            { "ch11_110":                      {"$ref": { "path": "seeCircle" }, "distance": 380 } },
            { "ch17_wz131_1_wz132":            {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "fcm_50t":                       {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "ferdinand":                     {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "gb11_caernarvon":               {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "gb23_centurion":                {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "gb72_at15":                     {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "is_3":                          {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "isu_152":                       {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "jagdpantherii":                 {"$ref": { "path": "seeCircle" }, "distance": 380 } },
            { "jagdtiger_sdkfz_185":           {"$ref": { "path": "seeCircle" }, "distance": 390 } },
            { "kv4":                           {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "kv_5":                          {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "lowe":                          {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "m6a2e1":                        {"$ref": { "path": "seeCircle" }, "distance": 380 } },
            { "object252":                     {"$ref": { "path": "seeCircle" }, "distance": 350 } },
            { "panther_ii":                    {"$ref": { "path": "seeCircle" }, "distance": 390 } },
            { "pershing":                      {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "pzvib_tiger_ii":                {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "su_101":                        {"$ref": { "path": "seeCircle" }, "distance": 380 } },
            { "t23":                           {"$ref": { "path": "seeCircle" }, "distance": 380 } },
            { "t26_e4_superpershing":          {"$ref": { "path": "seeCircle" }, "distance": 380 } },
            { "t28":                           {"$ref": { "path": "seeCircle" }, "distance": 370 } },
            { "t28_prototype":                 {"$ref": { "path": "seeCircle" }, "distance": 380 } },
            { "t32":                           {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "t34_hvy":                       {"$ref": { "path": "seeCircle" }, "distance": 360 } },
            { "t_44":                          {"$ref": { "path": "seeCircle" }, "distance": 380 } },
            { "t69":                           {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "vk4502a":                       {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "indien_panzer":                 {"$ref": { "path": "seeCircle" }, "distance": 380 } },
       // 9
            { "amx_50_120":                    {"$ref": { "path": "seeCircle" }, "distance": 390 } },
            { "amx50_foch":                    {"$ref": { "path": "seeCircle" }, "distance": 390 } },
            { "ch12_111_1_2_3":                {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "ch18_wz_120":                   {"$ref": { "path": "seeCircle" }, "distance": 390 } },
            { "e_50":                          {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "e_75":                          {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "gb12_conqueror":                {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "gb24_centurion_mk3":            {"$ref": { "path": "seeCircle" }, "distance": 410 } },
            { "gb32_tortoise":                 {"$ref": { "path": "seeCircle" }, "distance": 390 } },
            { "is8":                           {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "jagdtiger":                     {"$ref": { "path": "seeCircle" }, "distance": 390 } },
            { "lorraine40t":                   {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "m103":                          {"$ref": { "path": "seeCircle" }, "distance": 390 } },
            { "m46_patton":                    {"$ref": { "path": "seeCircle" }, "distance": 410 } },
            { "object_704":                    {"$ref": { "path": "seeCircle" }, "distance": 390 } },
            { "st_i":                          {"$ref": { "path": "seeCircle" }, "distance": 380 } },
            { "su122_54":                      {"$ref": { "path": "seeCircle" }, "distance": 390 } },
            { "t30":                           {"$ref": { "path": "seeCircle" }, "distance": 380 } },
            { "t_54":                          {"$ref": { "path": "seeCircle" }, "distance": 390 } },
            { "t54e1":                         {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "t95":                           {"$ref": { "path": "seeCircle" }, "distance": 380 } },
            { "vk4502p":                       {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "pro_ag_a":                      {"$ref": { "path": "seeCircle" }, "distance": 400 } },
       // 10
            { "amx_50fosh_155":                {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "bat_chatillon25t":              {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "ch19_121":                      {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "ch22_113":                      {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "e_100":                         {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "e50_ausf_m":                    {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "f10_amx_50b":                   {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "gb13_fv215b":                   {"$ref": { "path": "seeCircle" }, "distance": 410 } },
            { "gb48_fv215b_183":               {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "gb70_fv4202_105":               {"$ref": { "path": "seeCircle" }, "distance": 410 } },
            { "is_4":                          {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "is_7":                          {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "jagdpz_e100":                   {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "m48a1":                         {"$ref": { "path": "seeCircle" }, "distance": 420 } },
            { "maus":                          {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "object263":                     {"$ref": { "path": "seeCircle" }, "distance": 410 } },
            { "object268":                     {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "t110":                          {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "t110e3":                        {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "t110e4":                        {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "t57_58":                        {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "t62a":                          {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "white_tiger":                   {"$ref": { "path": "seeCircle" }, "distance": 460 } },
            { "leopard1":                      {"$ref": { "path": "seeCircle" }, "distance": 410 } },
            { "vk7201":                        {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "object_907":                    {"$ref": { "path": "seeCircle" }, "distance": 400 } },
            { "m60":                           {"$ref": { "path": "seeCircle" }, "distance": 420 } }
        ]
    }
}