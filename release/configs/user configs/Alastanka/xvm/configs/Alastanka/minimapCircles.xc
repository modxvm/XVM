/**
 * Minimap circles. Only real map meters. Only for own unit. Works only with xvm-stat.exe for uncommon locales.
 * xvm-stat.exe is not necessary for RU, EN, DE and partially CH locale.
 * Круги на миникарте. Дистанция только в реальных метрах карты. Только для своей техники.
 */
{
  // Artillery gun fire range circle
  // Круг дальности стрельбы арты
  // "enabled": false - выключен; "thickness" - толщина; "alpha" - прозрачность; "color" - цвет.
    // Subject has top turret.
    // Субъект имеет топ башню.
  "rangeCircle_top": { "enabled": true, "thickness": 1, "alpha": 60, "color": "0x7FDC00" },
    // Subject has stock turret.
    // Субъект имеет стоковую башню.
  "rangeCircle_not": { "enabled": true, "thickness": 1, "alpha": 30, "color": "0xF50800" },
    // Subject has optional equipment.
    // Субъект имеет дополнительное оборудование.
  "rangeCircle_add": { "enabled": true, "thickness": 1, "alpha": 40, "color": "0xD042F3" },

  "circles": {
        "enabled": true,
        // Основные круги.
        // "enabled": false - выключен; "distance" - дистанция; "thickness" - толщина; "alpha" - прозрачность; "color" - цвет.
        "major": [
            // 445 meters - maximum reveal distance. / 445 метров - максимальная дистанция засвета.
            { "enabled": true,  "distance": 445, "thickness": 1, "alpha": 30, "color": "0x00EAFF" },
            { "enabled": true, "distance": 50,  "thickness": 1, "alpha": 60, "color": "0x00EAFF" }
        ],
        // Special circles dependent on vehicle type.
        // Many configuration lines for the same vehicle make many circles.
        // Only artillery top gun range by default.
        // See other vehicle types at:
		// http://code.google.com/p/wot-xvm/source/browse/trunk/src/xvm/src/com/xvm/VehicleInfoData2.as
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
        // Подробнее по ссылке: http://goo.gl/ZqlPa                    //default=EE4444 //top=7FDC00 //stok=F50800 //для арты другое измерение а в скобках обзор самого танка()*
        "special": [	// вся информация собрана с сайта http://wiki.worldoftanks.ru/ специально для http://xvm.alastanka.org.ua (Alastanka)
   // Уровень	Название					Включить/Выключить		Дистанция		Толщина			Прозрачность		Цвет				vehicleNames					Башня
   // level 1 
            { "ms_1":						{"$ref": { "path": "rangeCircle_not" },  "distance": 240  } },	// "MS-1"						МС-1 шестигранная
            { "ms_1":						{"$ref": { "path": "rangeCircle_top" },  "distance": 280  } },	// "MS-1"						МС-1 модерн
            { "ms_1":						{"$ref": { "path": "rangeCircle_add" },  "distance": 350  } },	// "MS-1"						МС-1 модерн + труба
            { "ltraktor":					{"$ref": { "path": "rangeCircle_not" },  "distance": 260  } },	// "Ltraktor"					Turm Schwedisch Bofors
            { "ltraktor":					{"$ref": { "path": "rangeCircle_top" },  "distance": 310  } },	// "Ltraktor"					Verbesserter Turm
            { "t1_cunningham":				{"$ref": { "path": "rangeCircle_not" },  "distance": 240  } },	// "T1_Cunningham"				Cunningham D1
            { "t1_cunningham":				{"$ref": { "path": "rangeCircle_top" },  "distance": 280  } },	// "T1_Cunningham"				Cunningham D2
            { "renaultft":					{"$ref": { "path": "rangeCircle_not" },  "distance": 250  } },	// "RenaultFT"					RenaultFT La tour 1
            { "renaultft":					{"$ref": { "path": "rangeCircle_top" },  "distance": 280  } },	// "RenaultFT"					RenaultFT La tour 2
            { "ch06_renault_nc31":			{"$ref": { "path": "rangeCircle_not" },  "distance": 250  } },	// "Ch06_Renault_NC31"			FT-17
            { "ch06_renault_nc31":			{"$ref": { "path": "rangeCircle_top" },  "distance": 280  } },	// "Ch06_Renault_NC31"			FT-18
            { "gb01_medium_mark_i":			{"$ref": { "path": "rangeCircle_not" },  "distance": 260  } },	// "GB01_Medium_Mark_I"			Vickers Medium Mk. I 
            { "gb01_medium_mark_i":			{"$ref": { "path": "rangeCircle_top" },  "distance": 280  } },	// "GB01_Medium_Mark_I"			Vickers Medium Mk. IA*

   // level 2
            { "bt_2":						{"$ref": { "path": "rangeCircle_not" },  "distance": 240  } },	// "BT-2"						Christie
            { "bt_2":						{"$ref": { "path": "rangeCircle_top" },  "distance": 280  } },	// "BT-2"						БТ-2
            { "t_26":						{"$ref": { "path": "rangeCircle_not" },  "distance": 280  } },	// "T-26"						Т-26 цилиндрическая
            { "t_26":						{"$ref": { "path": "rangeCircle_top" },  "distance": 310  } },	// "T-26"						Т-26 коническая
            { "tetrarch_ll":				{"$ref": { "path": "rangeCircle_top" },  "distance": 260  } },	// "Tetrarch_LL"				Tetrarch
            { "h39_captured":				{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "H39_captured" "PzKpfw 38H735 (f)"	38H735-(f)-Turm
            { "pz35t":						{"$ref": { "path": "rangeCircle_not" },  "distance": 290  } },	// "Pz35t"						PzKpfw-35-(t)-Standardturm
            { "pz35t":						{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "Pz35t"						PzKpfw-35-(t)-Verstärkterturm
            { "pzi":						{"$ref": { "path": "rangeCircle_not" },  "distance": 310  } },	// "PzI"						Verbesserter Turm
            { "pzi":						{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "PzI"						Pz.Kpfw. I Breda
            { "pzii":						{"$ref": { "path": "rangeCircle_not" },  "distance": 290  } },	// "PzII"						PzKpfw-II-Turm Ausf. B
            { "pzii":						{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "PzII"						PzKpfw-II-Turm Ausf. F
            { "m2_lt":						{"$ref": { "path": "rangeCircle_not" },  "distance": 260  } },	// "M2_lt"						M2D27810
            { "m2_lt":						{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "M2_lt"						M2D27812
            { "t1_e6":						{"$ref": { "path": "rangeCircle_top" },  "distance": 260  } },	// "T1_E6"						T1
            { "t2_lt":						{"$ref": { "path": "rangeCircle_top" },  "distance": 260  } },	// "T2_lt"						T2D1
            { "d1":							{"$ref": { "path": "rangeCircle_not" },  "distance": 280  } },	// "D1"							D1a
            { "d1":							{"$ref": { "path": "rangeCircle_top" },  "distance": 300  } },	// "D1"							D1b
            { "hotchkiss_h35":				{"$ref": { "path": "rangeCircle_top" },  "distance": 300  } },	// "Hotchkiss_H35"				APX-R
            { "gb03_cruiser_mk_i":			{"$ref": { "path": "rangeCircle_not" },  "distance": 300  } },	// "GB03_Cruiser_Mk_I"			Cruiser Mk. I
            { "gb03_cruiser_mk_i":			{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "GB03_Cruiser_Mk_I"			Cruiser Mk. III
            { "gb58_cruiser_mk_iii":		{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "GB58_Cruiser_Mk_III"		Cruiser Mk. III
            { "gb58_cruiser_mk_iii":		{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "GB58_Cruiser_Mk_III"		Cruiser Mk. III*
            { "ch07_vickers_mke_type_bt26":	{"$ref": { "path": "rangeCircle_not" },  "distance": 280  } },	// "Ch07_Vickers_MkE_Type_BT26"	Vickers Mk. E Type B
            { "ch07_vickers_mke_type_bt26":	{"$ref": { "path": "rangeCircle_top" },  "distance": 310  } },	// "Ch07_Vickers_MkE_Type_BT26"	Т-26 model 1936
            { "t2_med":						{"$ref": { "path": "rangeCircle_not" },  "distance": 300  } },	// "T2_med"						T2T1
            { "t2_med":						{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "T2_med"						T2T2
            { "gb05_vickers_medium_mk_ii":	{"$ref": { "path": "rangeCircle_not" },  "distance": 280  } },	// "GB05_Vickers_Medium_Mk_II"	Vickers Medium Mk. II*
            { "gb05_vickers_medium_mk_ii":	{"$ref": { "path": "rangeCircle_top" },  "distance": 300  } },	// "GB05_Vickers_Medium_Mk_II"	Vickers Medium Mk. II**
            { "at_1":						{"$ref": { "path": "rangeCircle_top" },  "distance": 250  } },	// "AT-1"						-
            { "panzerjager_i":				{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "PanzerJager_I"				-
            { "t18":						{"$ref": { "path": "rangeCircle_top" },  "distance": 240  } },	// "T18"						-
            { "renaultft_ac":				{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "RenaultFT_AC"				-
            { "su_18":						{"$ref": { "path": "rangeCircle_top" },  "distance": 552  } },	// "SU-18"						-	(260)*
            { "bison_i":					{"$ref": { "path": "rangeCircle_top" },  "distance": 605  } },	// "Bison_I"					-	(320)*
            { "t57":						{"$ref": { "path": "rangeCircle_top" },  "distance": 552  } },	// "T57"						-	(330)*
            { "renaultbs":					{"$ref": { "path": "rangeCircle_top" },  "distance": 450  } },	// "RenaultBS"					-	(260)*

   // level 3
            { "bt_7":						{"$ref": { "path": "rangeCircle_not" },  "distance": 260  } },	// "BT-7"						БТ-5 цилиндрическая
            { "bt_7":						{"$ref": { "path": "rangeCircle_top" },  "distance": 280  } },	// "BT-7"						БТ-7 коническая
            { "bt_sv":						{"$ref": { "path": "rangeCircle_top" },  "distance": 280  } },	// "BT-SV"						БТ-СВ
            { "m3_stuart_ll":				{"$ref": { "path": "rangeCircle_top" },  "distance": 280  } },	// "M3_Stuart_LL"				D37812
            { "t_127":						{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "T-127"						Т-127
            { "t_46":						{"$ref": { "path": "rangeCircle_not" },  "distance": 260  } },	// "T-46"						Т-46
            { "t_46":						{"$ref": { "path": "rangeCircle_top" },  "distance": 310  } },	// "T-46"						Т-46 улучшенная
            { "pz_ii_ausfg":				{"$ref": { "path": "rangeCircle_not" },  "distance": 310  } },	// "Pz_II_AusfG"				Pz.Kpfw. II Ausf. C
            { "pz_ii_ausfg":				{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "Pz_II_AusfG"				Pz.Kpfw. II Ausf. G
            { "pz38t":						{"$ref": { "path": "rangeCircle_not" },  "distance": 310  } },	// "Pz38t"						LT-40-Turm
            { "pz38t":						{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "Pz38t"						PzKpfw-38-(t)-Turm Ausf. G
            { "pzi_ausf_c":					{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "PzI_ausf_C"					Pz.Kpfw. I Breda
            { "pzi_ausf_c":					{"$ref": { "path": "rangeCircle_top" },  "distance": 340  } },	// "PzI_ausf_C"					Pz.Kpfw. I Ausf. C
            { "pzii_j":						{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "PzII_J"						PzKpfw-II-Turm Ausf. J
            { "pziii_a":					{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "PzIII_A"					PzKpfw-III-Turm Ausf. A
            { "pziii_a":					{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "PzIII_A"					PzKpfw-III-Turm Ausf. C
            { "t_15":						{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "T-15"						T-15 Turm
            { "m22_locust":					{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "M22_Locust"					M22D1
            { "m3_stuart":					{"$ref": { "path": "rangeCircle_not" },  "distance": 280  } },	// "M3_Stuart"					D37812
            { "m3_stuart":					{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "M3_Stuart"					D39273
            { "mtls_1g14":					{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "MTLS-1G14"					MTLS D1
            { "amx38":						{"$ref": { "path": "rangeCircle_top" },  "distance": 310  } },	// "AMX38"						AMX38
            { "gb59_cruiser_mk_iv":			{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "GB59_Cruiser_Mk_IV"			Cruiser Mk. IV
            { "gb59_cruiser_mk_iv":			{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "GB59_Cruiser_Mk_IV"			Cruiser Mk. IVA
            { "gb69_cruiser_mk_ii":			{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "GB69_Cruiser_Mk_II"			A10E1
            { "gb69_cruiser_mk_ii":			{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "GB69_Cruiser_Mk_II"			Cruiser Mk. II
            { "ch08_type97_chi_ha":			{"$ref": { "path": "rangeCircle_not" },  "distance": 310  } },	// "Ch08_Type97_Chi_Ha"			Type 97
            { "ch08_type97_chi_ha":			{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "Ch08_Type97_Chi_Ha"			Type 97-Kai
            { "s35_captured":				{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "S35_captured"				Somuaturm
            { "m2_med":						{"$ref": { "path": "rangeCircle_not" },  "distance": 280  } },	// "M2_med"						M2M19
            { "m2_med":						{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "M2_med"						M2M7
            { "d2":							{"$ref": { "path": "rangeCircle_not" },  "distance": 300  } },	// "D2"							D2
            { "d2":							{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "D2"							D2 Bis
            { "gb06_vickers_medium_mk_iii":	{"$ref": { "path": "rangeCircle_not" },  "distance": 310  } },	// "GB06_Vickers_Medium_Mk_III"	Vickers Medium А6Е1
            { "gb06_vickers_medium_mk_iii":	{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "GB06_Vickers_Medium_Mk_III"	Vickers Medium А6Е3
            { "su_76":						{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "SU-76"						-
            { "g20_marder_ii":				{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "G20_Marder_II"				-
            { "t82":						{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "T82"						-
            { "fcm_36pak40":				{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "FCM_36Pak40"				-
            { "renaultue57":				{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "RenaultUE57"				-
            { "gb42_valentine_at":			{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "GB42_Valentine_AT"			-
            { "su_26":						{"$ref": { "path": "rangeCircle_top" },  "distance": 578  } },	// "SU-26"						СУ-26	(300)*
            { "sturmpanzer_ii":				{"$ref": { "path": "rangeCircle_top" },  "distance": 605  } },	// "Sturmpanzer_II"				-	(360)*
            { "wespe":						{"$ref": { "path": "rangeCircle_top" },  "distance": 1000 } },	// "Wespe"						-	(350)*
            { "m37":						{"$ref": { "path": "rangeCircle_top" },  "distance": 969  } },	// "M37"						-	(370)*
            { "sexton_i:":					{"$ref": { "path": "rangeCircle_top" },  "distance": 000  } },	// "Sexton_I" },				?	usa pt
            { "lorraine39_l_am":			{"$ref": { "path": "rangeCircle_top" },  "distance": 844  } },	// "Lorraine39_L_AM"			-	(350)*

   // level 4
            { "a_20":						{"$ref": { "path": "rangeCircle_not" },  "distance": 300  } },	// "A-20"						А-20 обр. 1938 г.
            { "a_20":						{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "A-20"						А-20 бис
            { "t_50":						{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "T-50"						Т-50
            { "t_50":						{"$ref": { "path": "rangeCircle_add" },  "distance": 346.5} },	// "T-50"					Т-50 орл.глаз.3%(6,6)+радиоп.3%(9,9)
            { "valentine_ll":				{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "Valentine_LL"				Валентайн II
            { "pz38_na":					{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "Pz38_NA"					PzKpfw-38-nA-Standardturm
            { "pz38_na":					{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "Pz38_NA"					PzKpfw-38-nA-Turm-Ausf. G
            { "pzii_luchs":					{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "PzII_Luchs"					PzKpfw-IIL-Luchsturm
            { "pzii_luchs":					{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "PzII_Luchs"					PzKpfw-IIL-Großturm
            { "m5_stuart":					{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "M5_Stuart"					M5A1
            { "m5_stuart":					{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "M5_Stuart"					M8
            { "amx40":						{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "AMX40"						AMX40
            { "amx40":						{"$ref": { "path": "rangeCircle_top" },  "distance": 340  } },	// "AMX40"						Renault-Balland
            { "gb04_valentine":				{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "GB04_Valentine"				Valentine Mk.I
            { "gb04_valentine":				{"$ref": { "path": "rangeCircle_top" },  "distance": 340  } },	// "GB04_Valentine"				Valentine Mk. XI
            { "gb60_covenanter":			{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "GB60_Covenanter"			Covenanter Mk. I
            { "gb60_covenanter":			{"$ref": { "path": "rangeCircle_top" },  "distance": 340  } },	// "GB60_Covenanter"			Covenanter Mk. IV CS
            { "ch09_m5":					{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "Ch09_M5"					M3A3
            { "ch09_m5":					{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "Ch09_M5"					M5A1
            { "a_32":						{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "A-32"						А-32 обр. 1932 г.
            { "t_28":						{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "T-28"						Т-28 цилиндрическая
            { "t_28":						{"$ref": { "path": "rangeCircle_top" },  "distance": 340  } },	// "T-28"						Т-28 коническая
            { "pziii":						{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "PzIII"						PzKpfw-III-Turm Ausf. E
            { "pziii":						{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "PzIII"						PzKpfw-III-Turm Ausf. M
            { "pziii_training:":			{"$ref": { "path": "rangeCircle_top" },  "distance": 000  } },	// "PzIII_training"				?	
            { "m3_grant":					{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "M3_Grant"					-
            { "gb07_matilda":				{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "GB07_Matilda"				Matilda Mk. IIA
            { "gb07_matilda":				{"$ref": { "path": "rangeCircle_top" },  "distance": 340  } },	// "GB07_Matilda"				Matilda Mk. IIA*
            { "b_1bis_captured":			{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "B-1bis_captured"			B2-740-(f)-Turm
            { "b1":							{"$ref": { "path": "rangeCircle_not" },  "distance": 300  } },	// "B1"							B1a
            { "b1":							{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "B1"							B1b
            { "gaz_74b":					{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "GAZ-74b"					-
            { "hetzer":						{"$ref": { "path": "rangeCircle_top" },  "distance": 260  } },	// "Hetzer"						-
            { "m8a1":						{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "M8A1"						M8A1
            { "m8a1":						{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "M8A1"						T87
            { "t40":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "T40"						-
            { "somua_sau_40":				{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "Somua_Sau_40"				-
            { "gb57_alecto":				{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "GB57_Alecto"				-
            { "su_5":						{"$ref": { "path": "rangeCircle_top" },  "distance": 605  } },	// "SU-5"						-	(320)*
            { "grille":						{"$ref": { "path": "rangeCircle_top" },  "distance": 1210 } },	// "Grille"						-	(360)*
            { "m7_priest":					{"$ref": { "path": "rangeCircle_top" },  "distance": 1047 } },	// "M7_Priest"					-	(370)*
            { "_105_lefh18b2":				{"$ref": { "path": "rangeCircle_top" },  "distance": 1000 } },	// "_105_leFH18B2"				-	(390)*
            { "amx_105am":					{"$ref": { "path": "rangeCircle_top" },  "distance": 1000 } },	// "AMX_105AM"					-	(360)*

   // level 5
            { "t_50_2":						{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "T_50_2"						Т-50-2
            { "t_50_2":						{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "T_50_2"						Т-50-2М
            { "vk1602":						{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "VK1602"						Leopardturm
            { "m24_chaffee":				{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "M24_Chaffee"				T24
            { "m24_chaffee":				{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "M24_Chaffee"				T37
            { "elc_amx":					{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "ELC_AMX"					ELC AMX
            { "gb20_crusader":				{"$ref": { "path": "rangeCircle_not" },  "distance": 340  } },	// "GB20_Crusader"				Crusader Mk. I
            { "gb20_crusader":				{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "GB20_Crusader"				Crusader Mk. III
            { "matilda_ii_ll":				{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "Matilda_II_LL"				Матильда IV
            { "t_34":						{"$ref": { "path": "rangeCircle_not" },  "distance": 240  } },	// "T-34"						Т-34 обр. 1940 г.
            { "t_34":						{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "T-34"						Т-34 обр. 1942 г.
            { "pziii_iv":					{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "PzIII_IV"					PzKpfw-IV-Turm Ausf. F
            { "pziii_iv":					{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "PzIII_IV"					PzKpfw-IV-Turm Ausf. H
            { "pziv":						{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "PzIV"						Turm Ausf. G
            { "pziv":						{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "PzIV"						Turm Ausf. Н
            { "pziv_hydro":					{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "PzIV_Hydro"					PzKpfw-IV-Turm Ausf. J
            { "t_25":						{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "T-25"						T-25 Turm
            { "m4_sherman":					{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "M4_Sherman"					D51066
            { "m4_sherman":					{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "M4_Sherman"					D51072
            { "m4a2e4":						{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "M4A2E4"						M4A2E4D51066
            { "m7_med":						{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "M7_med"						M24A1
            { "m7_med":						{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "M7_med"						M47
            { "ram_ii":						{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "Ram-II"						Ram II D1
            { "gb68_matilda_black_prince":	{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "GB68_Matilda_Black_Prince"	Matilda Black Prince
            { "ch21_t34":					{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "Ch21_T34"					Type T-34
            { "ch21_t34":					{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "Ch21_T34"					Type T-34M
            { "churchill_ll":				{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "Churchill_LL"				Churchill MK III
            { "kv":							{"$ref": { "path": "rangeCircle_not" },  "distance": 310  } },	// "KV"							КВ-1
            { "kv":							{"$ref": { "path": "rangeCircle_top" },  "distance": 310  } },	// "KV"							КВ-2
            { "kv1":						{"$ref": { "path": "rangeCircle_not" },  "distance": 310  } },	// "KV1"						КВ-1
            { "kv1":						{"$ref": { "path": "rangeCircle_top" },  "distance": 310  } },	// "KV1"						Проект ЧТЗ обр. 1942 г.
            { "kv_220":						{"$ref": { "path": "rangeCircle_top" },  "distance": 310  } },	// "KV-220"						КВ-220
            { "kv_220_action":				{"$ref": { "path": "rangeCircle_top" },  "distance": 310  } },	// "KV-220_action"				КВ-220
            { "t1_hvy":						{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "T1_hvy"						T1D5
            { "t1_hvy":						{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "T1_hvy"						T1D6
            { "t14":						{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "T14"						T14
            { "bdr_g1b":					{"$ref": { "path": "rangeCircle_not" },  "distance": 300  } },	// "BDR_G1B"					FCMF4
            { "bdr_g1b":					{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "BDR_G1B"					ARL-3
            { "gb08_churchill_i":			{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "GB08_Churchill_I"			Churchill Mk. I
            { "gb08_churchill_i":			{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "GB08_Churchill_I"			Churchill Mk. III
            { "su_85i":						{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "SU_85I"						-
            { "su_85":						{"$ref": { "path": "rangeCircle_top" },  "distance": 280  } },	// "SU-85"						-
            { "stugiii":					{"$ref": { "path": "rangeCircle_top" },  "distance": 310  } },	// "StuGIII"					-
            { "m10_wolverine":				{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "M10_Wolverine"				M10T72
            { "m10_wolverine":				{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "M10_Wolverine"				M10T72M1
            { "t49":						{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "T49"						?	Rock Island Arsenal
            { "t49":						{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "T49"						?	T49M34
            { "s_35ca":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "S_35CA"						-
            { "gb73_at2":					{"$ref": { "path": "rangeCircle_top" },  "distance": 310  } },	// "GB73_AT2"					-
            { "su_8":						{"$ref": { "path": "rangeCircle_top" },  "distance": 920  } },	// "SU-8"						-	(360)*
            { "hummel":						{"$ref": { "path": "rangeCircle_top" },  "distance": 1264 } },	// "Hummel"						-	(370)*
            { "m41":						{"$ref": { "path": "rangeCircle_top" },  "distance": 1210 } },	// "M41"						-	(370)*
            { "amx_13f3am":					{"$ref": { "path": "rangeCircle_top" },  "distance": 1250 } },	// "AMX_13F3AM"					-	(370)*

   // level 6

            { "vk2801":						{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "VK2801"						VK-2801-Turm Ausf. A 
            { "vk2801":						{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "VK2801"						VK-2801-Turm Ausf. F
            { "t21":						{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "T21"						T21
            { "t21":						{"$ref": { "path": "rangeCircle_add" },  "distance": 429  } },	// "T21"						T21 + просветленка
            { "t21":						{"$ref": { "path": "rangeCircle_add" },  "distance": 468  } },	// "T21"						T21 + труба
            { "amx_12t":					{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "AMX_12t"					AMX B
            { "ch15_59_16":					{"$ref": { "path": "rangeCircle_not" },  "distance": 360  } },	// "Ch15_59_16"					131
            { "ch15_59_16":					{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "Ch15_59_16"					131-1
            { "t_34_85":					{"$ref": { "path": "rangeCircle_not" },  "distance": 350  } },	// "T-34-85"					Т-34-85
            { "t_34_85":					{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "T-34-85"					Т-34-85 расширенная
            { "t_34_85_training":			{"$ref": { "path": "rangeCircle_top" },  "distance": 000  } },	// "T-34-85_training"			?
            { "pziv_schmalturm":			{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "PzIV_schmalturm"			PzKpfw-IV-Schmalturm
            { "pzv_pziv":					{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "PzV_PzIV"					PzKpfw-IV-Turm
            { "pzv_pziv_ausf_alfa":			{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "PzV_PzIV_ausf_Alfa"			PzKpfw-IV-Turm
            { "vk3001h":					{"$ref": { "path": "rangeCircle_not" },  "distance": 350  } },	// "VK3001H"					VK-3001-(H)-Standardturm
            { "vk3001h":					{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "VK3001H"					VK-3001-(H)-Großturm
            { "vk3001p":					{"$ref": { "path": "rangeCircle_not" },  "distance": 350  } },	// "VK3001P"					VK-3001-(P)-Krupp-Turm
            { "vk3001p":					{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "VK3001P"					VK-3001-(P)-Porsche-Turm
            { "vk3601h":					{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "VK3601H"					VK-3601-(H)-Standardturm
            { "vk3601h":					{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "VK3601H"					VK-3601-(H)-Großturm
            { "m4a3e8_sherman":				{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "M4A3E8_Sherman"				D51072
            { "m4a3e8_sherman":				{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "M4A3E8_Sherman"				D51080
            { "m4a3e8_sherman_training":	{"$ref": { "path": "rangeCircle_top" },  "distance": 000  } },	// "M4A3E8_Sherman_training"	?
            { "sherman_jumbo":				{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "Sherman_Jumbo"				M4A2E2T110
            { "sherman_jumbo":				{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "Sherman_Jumbo"				M4A2E2D51080
            { "gb21_cromwell":				{"$ref": { "path": "rangeCircle_not" },  "distance": 360  } },	// "GB21_Cromwell"				Cromwell Mk. I
            { "gb21_cromwell":				{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "GB21_Cromwell"				Cromwell Mk. IV
            { "ch20_type58":				{"$ref": { "path": "rangeCircle_not" },  "distance": 360  } },	// "Ch20_Type58"				T-34-85
            { "ch20_type58":				{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "Ch20_Type58"				Type 58
            { "kv_1s":						{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "KV-1s"						КВ-1С обр. 1942 г.
            { "kv_1s":						{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "KV-1s"						КВ-85
            { "kv2":						{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "KV2"						МТ-1
            { "kv2":						{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "KV2"						МТ-2
            { "t150":						{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "T150"						Т-150-КВ
            { "t150":						{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "T150"						Т-150-220
            { "m6":							{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "M6"							M6D1
            { "m6":							{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "M6"							M6D2
            { "arl_44":						{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "ARL_44"						ARL 44 expérimentale
            { "arl_44":						{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "ARL_44"						ARL 44 nouvelle
            { "gb09_churchill_vii":			{"$ref": { "path": "rangeCircle_not" },  "distance": 350  } },	// "GB09_Churchill_VII"			Churchill Mk. IV
            { "gb09_churchill_vii":			{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "GB09_Churchill_VII"			Churchill Mk. VII 
            { "gb63_tog_ii":				{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "GB63_TOG_II"				TOG II
            { "su_100":						{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "SU-100"						-
            { "su100y":						{"$ref": { "path": "rangeCircle_top" },  "distance": 000  } },	// "SU100Y"						?	(не введен в игру)
            { "dickermax":					{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "DickerMax"					-
            { "jagdpziv":					{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "JagdPzIV"					-
            { "m18_hellcat":				{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "M18_Hellcat"				M18 M34A1
            { "m18_hellcat":				{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "M18_Hellcat"				M18 M1
            { "m36_slagger":				{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "M36_Slagger"				M36T74
            { "m36_slagger":				{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "M36_Slagger"				M36T78
            { "arl_v39":					{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "ARL_V39"					-
            { "gb40_gun_carrier_churchill":	{"$ref": { "path": "rangeCircle_top" },  "distance": 340  } },	// "GB40_Gun_Carrier_Churchill"	-
            { "gb74_at8":					{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "GB74_AT8"					-
            { "s_51":						{"$ref": { "path": "rangeCircle_top" },  "distance": 1229 } },	// "S-51"						-	(370)*
            { "su_14":						{"$ref": { "path": "rangeCircle_top" },  "distance": 1229 } },	// "SU-14"						-	(300)*
            { "g_panther":					{"$ref": { "path": "rangeCircle_top" },  "distance": 1400 } },	// "G_Panther"					GW-Panther-Aufbau Ausf. A(350)*
            { "m12":						{"$ref": { "path": "rangeCircle_top" },  "distance": 1316 } },	// "M12"						-	(380)*
            { "lorraine155_50":				{"$ref": { "path": "rangeCircle_top" },  "distance": 1202 } },	// "Lorraine155_50"				-	(370)*

   // level 7
            { "t71":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "T71"						T71
            { "amx_13_75":					{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "AMX_13_75"					FL10
            { "ch02_type62":				{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "Ch02_Type62"				Type 62
            { "ch16_wz_131":				{"$ref": { "path": "rangeCircle_not" },  "distance": 380  } },	// "Ch16_WZ_131"				132A
            { "ch16_wz_131":				{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "Ch16_WZ_131"				132B
            { "kv_13": 						{"$ref": { "path": "rangeCircle_not" },  "distance": 340  } },	// "KV-13"						КВ-13
            { "kv_13": 						{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "KV-13"						КВ-13М
            { "t_43":						{"$ref": { "path": "rangeCircle_not" },  "distance": 360  } },	// "T-43"						Т-43 обр. 1942 г.
            { "t_43":						{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "T-43"						Т-43 обр. 1943 г.
            { "panther_m10":				{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "Panther_M10"				PzKpfw-V-Turm Ausf. G
            { "pzv":						{"$ref": { "path": "rangeCircle_not" },  "distance": 350  } },	// "PzV"						PzKpfw-V-Turm Ausf. G
            { "pzv":						{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "PzV"						PzKpfw-V-Schmalturm
            { "pzv_training":				{"$ref": { "path": "rangeCircle_top" },  "distance": 000  } },	// "PzV_training"				?
            { "vk3002db":					{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "VK3002DB"					VK-3002-(DB)-Turm
            { "vk3002db":					{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "VK3002DB"					VK-3002-(DB)-Schmalturm
            { "t20":						{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "T20"						T20D1
            { "t20":						{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "T20"						T20D2
            { "gb22_comet":					{"$ref": { "path": "rangeCircle_not" },  "distance": 360  } },	// "GB22_Comet"					Cromwell Mk. IV
            { "gb22_comet":					{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "GB22_Comet"					Comet Mk. I
            { "ch04_t34_1":					{"$ref": { "path": "rangeCircle_not" },  "distance": 360  } },	// "Ch04_T34_1"					T-34-1
            { "ch04_t34_1":					{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "Ch04_T34_1"					T-34-1 model 2
            { "ch04_t34_1_training":		{"$ref": { "path": "rangeCircle_top" },  "distance": 000  } },	// "Ch04_T34_1_training"		?
            { "is":							{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "IS"							ИС-85
            { "is":							{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "IS"							ИС-122
            { "kv_3":						{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "KV-3"						Образца КВ-220
            { "kv_3":						{"$ref": { "path": "rangeCircle_top" },  "distance": 340  } },	// "KV-3"						КВ-3
            { "pzvi":						{"$ref": { "path": "rangeCircle_not" },  "distance": 350  } },	// "PzVI"						PzKpfw-VI-Tiger-I-Turm Ausf.H2
            { "pzvi":						{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "PzVI"						fw-VI-Tiger-I-Porscheturm
            { "pzvi_tiger_p":				{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "PzVI_Tiger_P"				Tiger-(P)-Turm Ausf. A 
            { "pzvi_tiger_p":				{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "PzVI_Tiger_P"				Tiger-(P)-Turm Ausf. F
            { "t29":						{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "T29"						T123
            { "t29":						{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "T29"						T136
            { "amx_m4_1945":				{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "AMX_M4_1945"				Schneider 44B
            { "amx_m4_1945":				{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "AMX_M4_1945"				AMX M4
            { "gb10_black_prince":			{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "GB10_Black_Prince"			Black Prince
            { "ch10_is2":					{"$ref": { "path": "rangeCircle_not" },  "distance": 350  } },	// "Ch10_IS2"					IS-2 early
            { "ch10_is2":					{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "Ch10_IS2"					IS-2 late
            { "su100m1":					{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "SU100M1"					-
            { "su122_44":					{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "SU122_44"					-
            { "su_152":						{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "SU-152"						-
            { "jagdpanther":				{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "JagdPanther"				-
            { "t25_2":						{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "T25_2"						T25/2T3
            { "t25_2":						{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "T25_2"						T25/2T7
            { "t25_at":						{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "T25_AT"						-
            { "amx_ac_mle1946":				{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "AMX_AC_Mle1946"				-
            { "gb71_at_15a":				{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "GB71_AT_15A"				-
            { "gb75_at7":					{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "GB75_AT7"					-
            { "object_212":					{"$ref": { "path": "rangeCircle_top" },  "distance": 1229 } },	// "Object_212"					-	(330)*
            { "g_tiger":					{"$ref": { "path": "rangeCircle_top" },  "distance": 1172 } },	// "G_Tiger"					-	(380)*
            { "m40m43":						{"$ref": { "path": "rangeCircle_top" },  "distance": 1179 } },	// "M40M43"						-	(390)*
            { "lorraine155_51":				{"$ref": { "path": "rangeCircle_top" },  "distance": 1296 } },	// "Lorraine155_51"				-	(380)*

   // level 8
            { "amx_13_90":					{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "AMX_13_90"					FL12
            { "ch17_wz131_1_wz132":			{"$ref": { "path": "rangeCircle_not" },  "distance": 390  } },	// "Ch17_WZ131_1_WZ132"			WZ-131-1
            { "ch17_wz131_1_wz132":			{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "Ch17_WZ131_1_WZ132"			WZ-132
            { "t_44":						{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "T-44"						T-44
            { "t_44":						{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "T-44"						T-44Б
            { "panther_ii":					{"$ref": { "path": "rangeCircle_not" },  "distance": 380  } },	// "Panther_II"					Panther-II-Turm Ausf. A
            { "panther_ii":					{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "Panther_II"					Panther-II-Schmalturm 
            { "pershing":					{"$ref": { "path": "rangeCircle_not" },  "distance": 390  } },	// "Pershing"					M26M67
            { "pershing":					{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "Pershing"					M26M71
            { "t23":						{"$ref": { "path": "rangeCircle_not" },  "distance": 430  } },	// "T23"						T23T80 (баз.)
            { "t23":						{"$ref": { "path": "rangeCircle_top" },  "distance": 430  } },	// "T23"						T23D51080
            { "t26_e4_superpershing":		{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "T26_E4_SuperPershing"		T26E4
            { "t69":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "T69"						T178
            { "gb23_centurion":				{"$ref": { "path": "rangeCircle_not" },  "distance": 380  } },	// "GB23_Centurion"				Centurion Mk. I
            { "gb23_centurion":				{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "GB23_Centurion"				Centurion Mk. III
            { "ch01_type59":				{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "Ch01_Type59"				Type 59
            { "ch01_type59_gold":			{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "Ch01_Type59_Gold"			*	Type 59 G(no russian server)
            { "ch05_t34_2":					{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "Ch05_T34_2"					T-34-2
            { "ch05_t34_2":					{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "Ch05_T34_2"					T-34-2 model 2
            { "is_3":						{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "IS-3"						Кировец-1
            { "is_3":						{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "IS-3"						ИС-3
            { "kv4":						{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "KV4"						КВ-4
            { "kv4":						{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "KV4"						КВ-4-5
            { "kv_5":						{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "KV-5"						КВ-5
            { "object252":					{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "Object252"					ИС-6
            { "lowe":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "Lowe"						Löweturm
            { "pzvib_tiger_ii":				{"$ref": { "path": "rangeCircle_not" },  "distance": 400  } },	// "PzVIB_Tiger_II"				PzKpfw-VIB-Porsche-Turm
            { "pzvib_tiger_ii":				{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "PzVIB_Tiger_II"				PzKpfw-VIB-Henschel-Turm
            { "pzvib_tiger_ii_training":	{"$ref": { "path": "rangeCircle_top" },  "distance": 000  } },	// "PzVIB_Tiger_II_training"	?
            { "vk4502a":					{"$ref": { "path": "rangeCircle_not" },  "distance": 400  } },	// "VK4502A"					VK-4502-(A)-Turm Ausf. A
            { "vk4502a":					{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "VK4502A"					VK-4502-(A)-Turm Ausf. F
            { "m6a2e1":						{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "M6A2E1"						M6A2E1D4
            { "t32":						{"$ref": { "path": "rangeCircle_not" },  "distance": 380  } },	// "T32"						T99E2
            { "t32":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "T32"						T119
            { "t34_hvy":					{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "T34_hvy"					T34T7
            { "amx_50_100":					{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "AMX_50_100"					AMX 50 100
            { "fcm_50t":					{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "FCM_50t"					FCM 50 t
            { "gb11_caernarvon":			{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "GB11_Caernarvon"			Black Prince
            { "gb11_caernarvon":			{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "GB11_Caernarvon"			Centurion Mk. II
            { "ch03_wz_111":				{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "Ch03_WZ-111"				*	WZ-111 model 2(no russian server)
            { "ch11_110":					{"$ref": { "path": "rangeCircle_not" },  "distance": 350  } },	// "Ch11_110"					110
            { "ch11_110":					{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "Ch11_110"					T-10
            { "isu_152":					{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "ISU-152"					-
            { "su_101":						{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "SU-101"						-
            { "ferdinand":					{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "Ferdinand"					-
            { "jagdpantherii":				{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "JagdPantherII"				-
            { "jagdtiger_sdkfz_185":		{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "JagdTiger_SdKfz_185"		-
            { "t28":						{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "T28"						-
            { "t28_prototype":				{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "T28_Prototype"				T28P D1
            { "amx_ac_mle1948":				{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "AMX_AC_Mle1948"				-
            { "gb72_at15":					{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "GB72_AT15"					-
            { "object_261":					{"$ref": { "path": "rangeCircle_top" },  "distance": 1463 } },	// "Object_261"					-	(380)*
            { "g_e":						{"$ref": { "path": "rangeCircle_top" },  "distance": 1172 } },	// "G_E"						-	(390)*
            { "t92":						{"$ref": { "path": "rangeCircle_top" },  "distance": 1248 } },	// "T92"						-	(400)*
            { "bat_chatillon155":			{"$ref": { "path": "rangeCircle_top" },  "distance": 1296 } },	// "Bat_Chatillon155"			Bat Chatillon 155(390)*

   // level 9
            { "t_54":						{"$ref": { "path": "rangeCircle_not" },  "distance": 390  } },	// "T-54"						Т-54 обр. 1946 г.
            { "t_54":						{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "T-54"						Т-54 обр. 1949 г.
            { "e_50":						{"$ref": { "path": "rangeCircle_not" },  "distance": 390  } },	// "E-50"						E-50-Turm Ausf. A
            { "e_50":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "E-50"						E-50-Turm Ausf. F
            { "m46_patton":					{"$ref": { "path": "rangeCircle_not" },  "distance": 400  } },	// "M46_Patton"					M46M73
            { "m46_patton":					{"$ref": { "path": "rangeCircle_top" },  "distance": 410  } },	// "M46_Patton"					M46T119
            { "t54e1":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "T54E1"						T157
            { "lorraine40t":				{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "Lorraine40t"				Lorraine 40 t
            { "gb24_centurion_mk3":			{"$ref": { "path": "rangeCircle_not" },  "distance": 400  } },	// "GB24_Centurion_Mk3"			Centurion Mk. 7
            { "gb24_centurion_mk3":			{"$ref": { "path": "rangeCircle_top" },  "distance": 410  } },	// "GB24_Centurion_Mk3"			Centurion Mk. 9
            { "ch18_wz_120":				{"$ref": { "path": "rangeCircle_not" },  "distance": 380  } },	// "Ch18_WZ-120"				WZ-120
            { "ch18_wz_120":				{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "Ch18_WZ-120"				WZ-120-1
            { "is8":						{"$ref": { "path": "rangeCircle_not" },  "distance": 380  } },	// "IS8"						Т-10
            { "is8":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "IS8"						Т-10М
            { "st_i":						{"$ref": { "path": "rangeCircle_not" },  "distance": 360  } },	// "ST_I"						СТ-I об.701 №4
            { "st_i":						{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "ST_I"						СТ-I
            { "e_75":						{"$ref": { "path": "rangeCircle_not" },  "distance": 400  } },	// "E-75"						E-75-Turm Ausf. A
            { "e_75":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "E-75"						E-75-Turm Ausf. F
            { "vk4502p":					{"$ref": { "path": "rangeCircle_not" },  "distance": 400  } },	// "VK4502P"					VK-4502-(P)-Standardturm
            { "vk4502p":					{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "VK4502P"					VK-4502-(P)-Eliteturm
            { "m103":						{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "M103"						M89
            { "m103":						{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "M103"						T140
            { "amx_50_120":					{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "AMX_50_120"					AMX 50 Tourelle C
            { "gb12_conqueror":				{"$ref": { "path": "rangeCircle_not" },  "distance": 400  } },	// "GB12_Conqueror"				Centurion Mk. III
            { "gb12_conqueror":				{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "GB12_Conqueror"				Conqueror Mk. II
            { "ch12_111_1_2_3":				{"$ref": { "path": "rangeCircle_not" },  "distance": 380  } },	// "Ch12_111_1_2_3"				IS-3
            { "ch12_111_1_2_3":				{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "Ch12_111_1_2_3"				WZ-111
            { "object_704":					{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "Object_704"					-
            { "su122_54":					{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "SU122_54"					-
            { "jagdtiger":					{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "JagdTiger"					-
            { "t30":						{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "T30"						T30D1
            { "t95":						{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "T95"						-
            { "amx50_foch":					{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "AMX50_Foch"					-
            { "gb32_tortoise":				{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "GB32_Tortoise"				-

   // level 10

            { "t62a":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "T62A"						Образца 1959 г.
            { "e50_ausf_m":					{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "E50_Ausf_M"					E-50M-Turm Ausf. F
            { "m48a1":						{"$ref": { "path": "rangeCircle_top" },  "distance": 420  } },	// "M48A1"						M87
            { "bat_chatillon25t":			{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "Bat_Chatillon25t"			Bat Chatillon 25 t Tourelle A
            { "gb70_fv4202_105":			{"$ref": { "path": "rangeCircle_top" },  "distance": 410  } },	// "GB70_FV4202_105"			FV4202
            { "ch19_121":					{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "Ch19_121"					121
            { "is_4":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "IS-4"						об.701 №5
            { "is_7":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "IS-7"						ИС-7
            { "e_100":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "E-100"						E-100-Turm Ausf. B
            { "maus":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "Maus"						Mausturm
            { "t110":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "T110"						T53
            { "t57_58":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "T57_58"						T169
            { "f10_amx_50b":				{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "F10_AMX_50B"				AMX 50B
            { "gb13_fv215b":				{"$ref": { "path": "rangeCircle_top" },  "distance": 410  } },	// "GB13_FV215b"				FV215b
            { "ch22_113":					{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "Ch22_113"					113
            { "object263":					{"$ref": { "path": "rangeCircle_top" },  "distance": 410  } },	// "Object263"					-
            { "object268":					{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "Object268"					-
            { "jagdpz_e100":				{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "JagdPz_E100"				-
            { "t110e3":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "T110E3"						-
            { "t110e4":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "T110E4"						T110E4
            { "amx_50fosh_155":				{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "AMX_50Fosh_155"				-
            { "gb48_fv215b_183":			{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } }	// "GB48_FV215b_183"			-
        ]
    }
}