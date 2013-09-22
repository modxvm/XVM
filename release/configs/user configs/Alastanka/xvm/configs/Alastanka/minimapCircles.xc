/**
 * Minimap circles. Only real map meters. Only for own unit.
 * Круги на миникарте. Дистанция только в реальных метрах карты. Только для своей техники.
 */
{
  // Artillery gun fire range circle
  // Круг дальности стрельбы арты
  // "enabled": false - выключен; "thickness" - толщина; "alpha" - прозрачность; "color" - цвет.
    // Subject has top turret.
    // Субъект имеет топ башню.
  "rangeCircle_top": { "enabled": true, "thickness": 1, "alpha": 60, "color": "0x60FF00" },		//0x7FDC00	${"def.colorRating.good"   }
    // Subject has stock turret.
    // Субъект имеет стоковую башню.
  "rangeCircle_not": { "enabled": false, "thickness": 1, "alpha": 60, "color": "0xFE0E00" },		//0xF50800	${"def.colorRating.very_bad"   }
    // Subject has optional equipment.
    // Субъект имеет дополнительное оборудование.
  "rangeCircle_add": { "enabled": true, "thickness": 1, "alpha": 60, "color": "0xD042F3" },		//0xD042F3	${"def.colorRating.very_good"   }
  "rangeCircle_add2": { "enabled": true, "thickness": 1, "alpha": 60, "color": "0xFFFFFF" },		//0xD042F3	${"def.colorRating.very_good"   }

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
		// http://code.google.com/p/wot-xvm/source/browse/trunk/src/xvm/src/com/xvm/VehicleInfoData2.as			version r2052
        // Artillery gun fire range may differ depending on vehicle angle relative to ground
        // and vehicle height positioning relative to target. These factors are not considered.
        // See pics at http://goo.gl/ZqlPa								//for the arts and in another dimension parentheses overview of the tank () *
        // ------------------------------------------------------------------------------------------------
        // Специальные круги, зависящие от модели техники.
        // Несколько строк для одной техники делают несколько кругов.
        // По умолчанию в списке только круги дальнобойности артиллерии с топ орудиями.
        // Названия танков для дополнения брать по ссылке
		// http://code.google.com/p/wot-xvm/source/browse/trunk/src/xvm/src/com/xvm/VehicleInfoData2.as			version r2052
        // Дальнобойность арты может меняться в зависимости от углов постановки машины на склонах местности
        // и высоте расположения машины относительно цели. На миникарте эти факторы не учитываются.
        // Подробнее по ссылке: http://goo.gl/ZqlPa                    //для арты другое измерение а в скобках обзор самого танка()*
        "special": [	// вся информация собрана с сайта http://wiki.worldoftanks.ru/ специально для http://xvm.alastanka.org.ua (Alastanka)
   // Уровень	Название					Включить/Выключить/Дистанция/Толщина/Прозрачность/Цвет			vehicleNames					Башня								+8.6	++8.7
   // level 1 
            { "ms_1":						{"$ref": { "path": "rangeCircle_top" },  "distance": 280  } },	// "MS-1"						МС-1 модерн							+
            { "ltraktor":					{"$ref": { "path": "rangeCircle_top" },  "distance": 310  } },	// "Ltraktor"					Verbesserter Turm					+
            { "t1_cunningham":				{"$ref": { "path": "rangeCircle_top" },  "distance": 280  } },	// "T1_Cunningham"				Cunningham D2						+
            { "ch06_renault_nc31":			{"$ref": { "path": "rangeCircle_top" },  "distance": 280  } },	// "Ch06_Renault_NC31"			FT-18								+
            { "renaultft":					{"$ref": { "path": "rangeCircle_top" },  "distance": 280  } },	// "RenaultFT"					RenaultFT La tour 2					+
            { "gb01_medium_mark_i":			{"$ref": { "path": "rangeCircle_top" },  "distance": 280  } },	// "GB01_Medium_Mark_I"			Vickers Medium Mk. IA*				+

   // level 2
            { "bt_2":						{"$ref": { "path": "rangeCircle_top" },  "distance": 280  } },	// "BT-2"						БТ-5								+
            { "t_26":						{"$ref": { "path": "rangeCircle_top" },  "distance": 310  } },	// "T-26"						Т-26 обр. 1938 г					+	
			{ "t_60":						{"$ref": { "path": "rangeCircle_top" },  "distance": 300  } },	// "T-60"						Т-60								+
            { "tetrarch_ll":				{"$ref": { "path": "rangeCircle_top" },  "distance": 260  } },	// "Tetrarch_LL"				Tetrarch							+
            { "h39_captured":				{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "H39_captured"				38H735-(f)-Turm						+
            { "pz35t":						{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "Pz35t"						PzKpfw-35-(t)-Verstärkterturm		+
            { "pzi":						{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "PzI"						Pz.Kpfw. I Breda					+
            { "pzii":						{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "PzII"						PzKpfw-II-Turm Ausf. F				+
            { "m2_lt":						{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "M2_lt"						M2D27812							+
            { "t1_e6":						{"$ref": { "path": "rangeCircle_top" },  "distance": 260  } },	// "T1_E6"						T1									+
            { "t2_lt":						{"$ref": { "path": "rangeCircle_top" },  "distance": 260  } },	// "T2_lt"						T2D1								+
            { "d1":							{"$ref": { "path": "rangeCircle_top" },  "distance": 300  } },	// "D1"							Schneider Tourelle 2				+
            { "hotchkiss_h35":				{"$ref": { "path": "rangeCircle_top" },  "distance": 300  } },	// "Hotchkiss_H35"				APX-R								+
            { "gb03_cruiser_mk_i":			{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "GB03_Cruiser_Mk_I"			Cruiser Mk. III						+
            { "gb58_cruiser_mk_iii":		{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "GB58_Cruiser_Mk_III"		Cruiser Mk. III*					+
            { "ch07_vickers_mke_type_bt26":	{"$ref": { "path": "rangeCircle_top" },  "distance": 310  } },	// "Ch07_Vickers_MkE_Type_BT26"	Т-26 model 1936						+
            { "t2_med":						{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "T2_med"						T2T2								+
            { "gb05_vickers_medium_mk_ii":	{"$ref": { "path": "rangeCircle_top" },  "distance": 300  } },	// "GB05_Vickers_Medium_Mk_II"	Vickers Medium Mk. II**				+
            { "at_1":						{"$ref": { "path": "rangeCircle_top" },  "distance": 250  } },	// "AT-1"						-									+
            { "panzerjager_i":				{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "PanzerJager_I"				-									+
            { "t18":						{"$ref": { "path": "rangeCircle_top" },  "distance": 240  } },	// "T18"						-									+
            { "renaultft_ac":				{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "RenaultFT_AC"				-									+
			{ "gb39_universal_carrierqf2":	{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "GB39_Universal_CarrierQF2	-									+
            { "su_18":						{"$ref": { "path": "rangeCircle_top" },  "distance": 500  } },	// "SU-18"						-	(260)*									+
            { "gw_mk_vie":					{"$ref": { "path": "rangeCircle_top" },  "distance": 850  } },	// "GW_Mk_VIe"					-	(320)*									+
			{ "t57":						{"$ref": { "path": "rangeCircle_top" },  "distance": 553  } },	// "T57"						-	(330)*									+
            { "renaultbs":					{"$ref": { "path": "rangeCircle_top" },  "distance": 483  } },	// "RenaultBS"					-	(260)*									+
            { "gb25_loyd_carrier":			{"$ref": { "path": "rangeCircle_top" },  "distance": 509  } },	// "GB25_Loyd_Carrier"			-	(320)* 1)509(11.16)						++

   // level 3
            { "bt_7":						{"$ref": { "path": "rangeCircle_top" },  "distance": 280  } },	// "BT-7"						БТ-7 обр. 1937 г. 					+
            { "bt_sv":						{"$ref": { "path": "rangeCircle_top" },  "distance": 280  } },	// "BT-SV"						БТ-СВ								+
            { "ltp":						{"$ref": { "path": "rangeCircle_top" },  "distance": 000  } },	// "LTP"						?									?нет описания	++
			{ "m3_stuart_ll":				{"$ref": { "path": "rangeCircle_top" },  "distance": 280  } },	// "M3_Stuart_LL"				D37812								+
            { "t_127":						{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "T-127"						Т-127								+
            { "t_46":						{"$ref": { "path": "rangeCircle_top" },  "distance": 310  } },	// "T-46"						Т-46-1								+
            { "t_70":						{"$ref": { "path": "rangeCircle_top" },  "distance": 310  } },	// "T-70"						Т-70М								+
			{ "pz_ii_ausfg":				{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "Pz_II_AusfG"				Pz.Kpfw. II Ausf. G					+
            { "pz38t":						{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "Pz38t"						PzKpfw-38-(t)-Turm Ausf. G			+
            { "pzi_ausf_c":					{"$ref": { "path": "rangeCircle_top" },  "distance": 340  } },	// "PzI_ausf_C"					Pz.Kpfw. I Ausf. C					+
            { "pzii_j":						{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "PzII_J"						PzKpfw-II-Turm Ausf. J				+
            { "pziii_a":					{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "PzIII_A"					PzKpfw-III-Turm Ausf. C				+
            { "t_15":						{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "T-15"						T-15 Turm							+
            { "m22_locust":					{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "M22_Locust"					M22D1								+
            { "m3_stuart":					{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "M3_Stuart"					D39273								+
            { "mtls_1g14":					{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "MTLS-1G14"					MTLS D1								+
            { "amx38":						{"$ref": { "path": "rangeCircle_top" },  "distance": 310  } },	// "AMX38"						AMX 38								+
            { "gb59_cruiser_mk_iv":			{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "GB59_Cruiser_Mk_IV"			Cruiser Mk. IVA						+
            { "gb69_cruiser_mk_ii":			{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "GB69_Cruiser_Mk_II"			Cruiser Mk. II						+
            { "ch08_type97_chi_ha":			{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "Ch08_Type97_Chi_Ha"			Type 97-Kai							+
            { "s35_captured":				{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "S35_captured"				Somuaturm							+
            { "m2_med":						{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "M2_med"						M2M7								+
            { "d2":							{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "D2"							D2 APX 4							+
            { "gb06_vickers_medium_mk_iii":	{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "GB06_Vickers_Medium_Mk_III"	Vickers Medium А6Е3					+
            { "su_76":						{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "SU-76"						-									+
            { "g20_marder_ii":				{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "G20_Marder_II"				-									+
            { "t82":						{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "T82"						-									+
            { "fcm_36pak40":				{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "FCM_36Pak40"				-									+
            { "renaultue57":				{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "RenaultUE57"				-									+
            { "gb42_valentine_at":			{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "GB42_Valentine_AT"			-									+
            { "su_26":						{"$ref": { "path": "rangeCircle_top" },  "distance": 1218 } },	// "SU-26"						-	(300)* 1)500(6.9)   2)1165(6.33) 3)1218(6.33)	+
            { "bison_i":					{"$ref": { "path": "rangeCircle_top" },  "distance": 602  } },	// "Bison_I"					-	(320)* 1)602(22.16)						+
			{ "wespe":						{"$ref": { "path": "rangeCircle_top" },  "distance": 989 } },	// "Wespe"						-	(350)*									+
            { "m7_priest":					{"$ref": { "path": "rangeCircle_top" },  "distance": 989 } },	// "M7_Priest"					-	(370)*									+
            { "sexton_i:":					{"$ref": { "path": "rangeCircle_top" },  "distance": 000  } },	// "Sexton_I" },				-	*usa pt							?
            { "lorraine39_l_am":			{"$ref": { "path": "rangeCircle_top" },  "distance": 983  } },	// "Lorraine39_L_AM"			-	(350)*									+
            { "gb27_sexton":				{"$ref": { "path": "rangeCircle_top" },  "distance": 1051  } },	// "GB27_Sexton_II"				-	(330)* 1)885(13.64) 2)1051(14.88)		++
			{ "gb78_sexton_i":				{"$ref": { "path": "rangeCircle_top" },  "distance": 1051  } },	// "GB78_Sexton_I"				-	(330)* 1)1051(14.88)					++
			
   // level 4
            { "a_20":						{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "A-20"						СП-3								+
            { "t_50":						{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "T-50"						Т-50								+
            { "t80":						{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "T80"						Т-80								+
			{ "valentine_ll":				{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "Valentine_LL"				Валентайн II						+
            { "pz38_na":					{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "Pz38_NA"					PzKpfw-38-nA-Turm-Ausf. G			+
            { "pzii_luchs":					{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "PzII_Luchs"					Luchs 5 cm							+
            { "m5_stuart":					{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "M5_Stuart"					M8									+
            { "amx40":						{"$ref": { "path": "rangeCircle_top" },  "distance": 340  } },	// "AMX40"						Renault-Balland						+
			{ "gb04_valentine":				{"$ref": { "path": "rangeCircle_top" },  "distance": 340  } },	// "GB04_Valentine"				Valentine Mk. XI					+
            { "gb60_covenanter":			{"$ref": { "path": "rangeCircle_top" },  "distance": 340  } },	// "GB60_Covenanter"			Covenanter Mk. IV CS				+
            { "ch09_m5":					{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "Ch09_M5"					M5A1								+
            { "a_32":						{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "A-32"						А-32								+
            { "t_28":						{"$ref": { "path": "rangeCircle_top" },  "distance": 340  } },	// "T-28"						Т-28 коническая						+
            { "pziii":						{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "PzIII"						PzKpfw-III-Turm Ausf. M				+
            { "pziii_training:":			{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "PzIII_training"				PzKpfw-III-Turm Ausf. M				+
            { "vk2001db":					{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "VK2001DB"					Pz.Kpfw. III Ausf. M				+
			{ "m3_grant":					{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "M3_Grant"					-									+
            { "gb07_matilda":				{"$ref": { "path": "rangeCircle_top" },  "distance": 340  } },	// "GB07_Matilda"				Matilda Mk. IIA*					+
            { "b_1bis_captured":			{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "B-1bis_captured"			B2-740-(f)-Turm						+
            { "b1":							{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "B1"							B1 APX 4							+
            { "gaz_74b":					{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "GAZ-74b"					-									+
            { "hetzer":						{"$ref": { "path": "rangeCircle_top" },  "distance": 260  } },	// "Hetzer"						-									+
            { "m8a1":						{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "M8A1"						T87									+
            { "t40":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "T40"						-									+
            { "somua_sau_40":				{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "Somua_Sau_40"				-									+
            { "gb57_alecto":				{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "GB57_Alecto"				-									+
            { "su_5":						{"$ref": { "path": "rangeCircle_top" },  "distance": 613  } },	// "SU-5"						-	(320)* 1)1165(6.23) 2)1218(6.21)  3)841(16.03) 4)613(17.57)	+
            { "pz_sfl_ivb":					{"$ref": { "path": "rangeCircle_top" },  "distance": 989  } },	// "Pz_Sfl_IVb"					-	(340)*									+
            { "sturmpanzer_ii":				{"$ref": { "path": "rangeCircle_top" },  "distance": 602  } },	// "Sturmpanzer_II"				-	(360)*									+
            { "m37":						{"$ref": { "path": "rangeCircle_top" },  "distance": 989  } },	// "M37"						-	(370)*									+
			{ "amx_ob_am105":				{"$ref": { "path": "rangeCircle_top" },  "distance": 1288 } },	// "AMX_Ob_Am105"				-	(340)*									+
			{ "gb26_birch_gun":				{"$ref": { "path": "rangeCircle_top" },  "distance": 1051 } },	// "GB26_Birch_Gun"				-	(340)* 1)885(10.91) 2)1051(11.9)		++

   // level 5
            { "t_50_2":						{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "T_50_2"						Т-50-2М								?удален
            { "vk1602":						{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "VK1602"						VK 16.02 Leopard					+
            { "m24_chaffee":				{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "M24_Chaffee"				T37									+
            { "elc_amx":					{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "ELC_AMX"					AMX ELC bis							+
            { "gb20_crusader":				{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "GB20_Crusader"				Crusader Mk. III					+
            { "matilda_ii_ll":				{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "Matilda_II_LL"				Матильда IV							+
            { "t_34":						{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "T-34"						Т-34 обр. 1942 г.					+
            { "pziii_iv":					{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "PzIII_IV"					Pz.Kpfw. III/IV Ausf. B				+
            { "pziv":						{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "PzIV"						Pz.Kpfw. IV Ausf. H					+
            { "pziv_hydro":					{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "PzIV_Hydro"					PzKpfw-IV-Turm Ausf. J				+
            { "t_25":						{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "T-25"						T-25 Turm							+
            { "m4_sherman":					{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "M4_Sherman"					D51072								+
            { "m4a2e4":						{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "M4A2E4"						M4A2E4D51066						+
            { "m7_med":						{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "M7_med"						M47									+
            { "ram_ii":						{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "Ram-II"						Ram II D1							+
            { "gb68_matilda_black_prince":	{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "GB68_Matilda_Black_Prince"	Matilda Black Prince				+
            { "ch21_t34":					{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "Ch21_T34"					Type T-34M							+
            { "churchill_ll":				{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "Churchill_LL"				Черчилль III						+
            { "kv":							{"$ref": { "path": "rangeCircle_top" },  "distance": 310  } },	// "KV"							КВ-2								+
            { "kv1":						{"$ref": { "path": "rangeCircle_top" },  "distance": 310  } },	// "KV1"						КВ-1 ЧТЗ обр. 1942 г. 				+
            { "kv_220":						{"$ref": { "path": "rangeCircle_top" },  "distance": 310  } },	// "KV-220"						КВ-220								+
            { "kv_220_action":				{"$ref": { "path": "rangeCircle_top" },  "distance": 310  } },	// "KV-220_action"				КВ-220								+
            { "t1_hvy":						{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "T1_hvy"						T1D6								+
            { "t14":						{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "T14"						T14									+
            { "bdr_g1b":					{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "BDR_G1B"					FCM F1								+
            { "gb08_churchill_i":			{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "GB08_Churchill_I"			Churchill III						+
            { "gb51_excelsior":				{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "GB51_Excelsior"				Excelsior							+
			{ "su_85i":						{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "SU_85I"						-									+
            { "su_85":						{"$ref": { "path": "rangeCircle_top" },  "distance": 280  } },	// "SU-85"						-									+
            { "stugiii":					{"$ref": { "path": "rangeCircle_top" },  "distance": 310  } },	// "StuGIII"					-									+
            { "m10_wolverine":				{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "M10_Wolverine"				M10T72M1							+
            { "t49":						{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "T49"						T49									+
            { "s_35ca":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "S_35CA"						-									+
            { "gb73_at2":					{"$ref": { "path": "rangeCircle_top" },  "distance": 310  } },	// "GB73_AT2"					-									+
            { "su122a":						{"$ref": { "path": "rangeCircle_top" },  "distance": 1201 } },	// "SU122A"						-	(340)*									+
			{ "grille":						{"$ref": { "path": "rangeCircle_top" },  "distance": 836  } },	// "Grille"						-	(360)* 1)602(15.34)	2)836(22.53)		+
            { "m41":						{"$ref": { "path": "rangeCircle_top" },  "distance": 1294 } },	// "M41"						-	(370)*									+
            { "_105_lefh18b2":				{"$ref": { "path": "rangeCircle_top" },  "distance": 989  } },	// "_105_leFH18B2"				-	(390)*									+
            { "amx_105am":					{"$ref": { "path": "rangeCircle_top" },  "distance": 1288 } },	// "AMX_105AM"					-	(360)*									+
            { "gb28_bishop":				{"$ref": { "path": "rangeCircle_top" },  "distance": 500  } },	// "GB28_Bishop"				-	(300)* 1)1051-518?(10.85) 2)500(16)		++?

   // level 6
            { "mt25":						{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "MT25"						Башня Т-34М обр. 1941 г.			++
            { "vk2801":						{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "VK2801"						VK 28.01 Ausf. B					+
            { "t21":						{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "T21"						T21									+
            { "amx_12t":					{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "AMX_12t"					AMX B								+
            { "ch15_59_16":					{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "Ch15_59_16"					131-1								+
            { "t_34_85":					{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "T-34-85"					Т-34-85 расширенная					+
            { "t_34_85_training":			{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "T-34-85_training"			Т-34-85 расширенная					+
            { "pziv_schmalturm":			{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "PzIV_schmalturm"			PzKpfw-IV-Schmalturm				+
            { "pzv_pziv":					{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "PzV_PzIV"					PzKpfw-IV-Turm						+
            { "pzv_pziv_ausf_alfa":			{"$ref": { "path": "rangeCircle_top" },  "distance": 320  } },	// "PzV_PzIV_ausf_Alfa"			PzKpfw-IV-Turm						+
            { "vk3001h":					{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "VK3001H"					VK-3001-(H)-Großturm				+
            { "vk3001p":					{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "VK3001P"					VK-3001-(P)-Porsche-Turm			+
            { "vk3002db_v1":				{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "VK3002DB_V1"				VK 30.01 (D)						+
			{ "vk3601h":					{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "VK3601H"					VK-3601-(H)-Großturm				+
            { "m4a3e8_sherman":				{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "M4A3E8_Sherman"				D51080								+
            { "m4a3e8_sherman_training":	{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "M4A3E8_Sherman_training"	D51080								+
            { "sherman_jumbo":				{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "Sherman_Jumbo"				M4A2E2D51080						+
            { "gb21_cromwell":				{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "GB21_Cromwell"				Cromwell Mk. IV						+
            { "ch20_type58":				{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "Ch20_Type58"				Type 58								+
            { "kv_1s":						{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "KV-1s"						КВ-85								+
            { "kv2":						{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "KV2"						МТ-2								+
            { "t150":						{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "T150"						Т-150-220							+
            { "m6":							{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "M6"							M6D2								+
            { "arl_44":						{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "ARL_44"						ARL 44								+
            { "gb09_churchill_vii":			{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "GB09_Churchill_VII"			Churchill VII 						+
            { "gb63_tog_ii":				{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "GB63_TOG_II"				TOG II								+
            { "su_100":						{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "SU-100"						-									+
            { "su100y":						{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "SU100Y"						-									+
            { "dickermax":					{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "DickerMax"					-									+
            { "jagdpziv":					{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "JagdPzIV"					-									+
            { "m18_hellcat":				{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "M18_Hellcat"				M18 M1								+
            { "m36_slagger":				{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "M36_Slagger"				M36T78								+
            { "arl_v39":					{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "ARL_V39"					-									+
            { "gb40_gun_carrier_churchill":	{"$ref": { "path": "rangeCircle_top" },  "distance": 340  } },	// "GB40_Gun_Carrier_Churchill"	-									+
            { "gb74_at8":					{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "GB74_AT8"					-									+
			{ "su_8":						{"$ref": { "path": "rangeCircle_top" },  "distance": 1345 } },	// "SU-8"						-	(360)*									+
            { "hummel":						{"$ref": { "path": "rangeCircle_top" },  "distance": 1260 } },	// "Hummel"						-	(370)*									+
            { "m44":						{"$ref": { "path": "rangeCircle_top" },  "distance": 1294 } },	// "M44"						-	(360)*									+
			{ "amx_13f3am":					{"$ref": { "path": "rangeCircle_top" },  "distance": 1381 } },	// "AMX_13F3AM"					-	(370)*									+
            { "gb77_fv304":					{"$ref": { "path": "rangeCircle_top" },  "distance": 500  } },	// "GB77_FV304"					-	(310)* 1)1051(10.6) 2)500(14.88)		++

   // level 7
            { "auf_panther":				{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "Auf_Panther"				VK 28.01 Ausf. C 					+
			{ "t71":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "T71"						T71									+
            { "amx_13_75":					{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "AMX_13_75"					FL 10 Type C						+
            { "ch02_type62":				{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "Ch02_Type62"				Type 62								+
            { "ch16_wz_131":				{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "Ch16_WZ_131"				132B								+
            { "kv_13": 						{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "KV-13"						КВ-13 обр. 1943 г.					+
            { "t_43":						{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "T-43"						Т-43 обр. 1943 г.					+
            { "panther_m10":				{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "Panther_M10"				PzKpfw-V-Turm Ausf. G				+
            { "pzv":						{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "PzV"						PzKpfw-V-Schmalturm					+
            { "pzv_training":				{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "PzV_training"				PzKpfw-V-Schmalturm					+
            { "vk3002db":					{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "VK3002DB"					VK 30.02 (D) Schmalturm				+
            { "t20":						{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "T20"						T20D2								+
            { "gb22_comet":					{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "GB22_Comet"					Comet Mk. I							+
            { "ch04_t34_1":					{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "Ch04_T34_1"					T-34-1 model 2						+
            { "ch04_t34_1_training":		{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "Ch04_T34_1_training"		T-34-1 model 2						+
            { "is":							{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "IS"							ИС-122								+
            { "kv_3":						{"$ref": { "path": "rangeCircle_top" },  "distance": 340  } },	// "KV-3"						КВ-3								+
            { "pzvi":						{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "PzVI"						PzKpfw-VI-Tiger-I-Porscheturm		+
            { "pzvi_tiger_p":				{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "PzVI_Tiger_P"				Tiger-(P)-Turm Ausf. F				+
            { "t29":						{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "T29"						T136								+
            { "amx_m4_1945":				{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "AMX_M4_1945"				AMX M4 mle. 45						+
            { "gb10_black_prince":			{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "GB10_Black_Prince"			Black Prince						+
            { "ch10_is2":					{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "Ch10_IS2"					IS-2 late							+
            { "su100m1":					{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "SU100M1"					-									+
            { "su122_44":					{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "SU122_44"					-									+
            { "su_152":						{"$ref": { "path": "rangeCircle_top" },  "distance": 330  } },	// "SU-152"						-									+
            { "e_25":						{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "E-25"						-									++
			{ "jagdpanther":				{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "JagdPanther"				-									+
            { "t25_2":						{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "T25_2"						T25/2T7								+
            { "t25_at":						{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "T25_AT"						-									+
            { "amx_ac_mle1946":				{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "AMX_AC_Mle1946"				-									+
            { "gb71_at_15a":				{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "GB71_AT_15A"				-									+
            { "gb75_at7":					{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "GB75_AT7"					-									+
            { "s_51":						{"$ref": { "path": "rangeCircle_top" },  "distance": 1264 } },	// "S-51"						-	(370)* 1)1429(26.75) 2)1264(31.1)		+
			{ "su14_1":						{"$ref": { "path": "rangeCircle_top" },  "distance": 1264 } },	// "SU14_1"						-	(360)*									+
            { "g_panther":					{"$ref": { "path": "rangeCircle_top" },  "distance": 1300 } },	// "G_Panther"					-	(350)* 1)1260(27.33) 2)1300(33.08)		+
            { "m12":						{"$ref": { "path": "rangeCircle_top" },  "distance": 1413 } },	// "M12"						-	(380)*									+
            { "lorraine155_50":				{"$ref": { "path": "rangeCircle_top" },  "distance": 1350 } },	// "Lorraine155_50"				-	(370)*									+
            { "gb29_crusader_5inch":		{"$ref": { "path": "rangeCircle_top" },  "distance": 1327 } },	// "GB29_Crusader_5inch"		-	(370)* 1)500(14.88) 2)1327(34.72)		++

   // level 8
            { "amx_13_90":					{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "AMX_13_90"					FL 10 Type D						+
            { "ch17_wz131_1_wz132":			{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "Ch17_WZ131_1_WZ132"			WZ-132								+
            { "t_44":						{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "T-44"						Т-44-100							+
            { "indien_panzer":				{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "Indien_Panzer"				Indien-Panzer						+
			{ "panther_ii":					{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "Panther_II"					Panther-II-Schmalturm 				+
            { "pershing":					{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "Pershing"					M26M71								+
            { "t23":						{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "T23"						T23D51080							?удален
            { "t26_e4_superpershing":		{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "T26_E4_SuperPershing"		T26E4								+
            { "t69":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "T69"						T178								+
            { "gb23_centurion":				{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "GB23_Centurion"				Centurion Mk. III					+
            { "ch01_type59":				{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "Ch01_Type59"				Type 59								+
            { "ch01_type59_gold":			{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "Ch01_Type59_Gold"			Type 59 G							?(no russian server)
            { "ch05_t34_2":					{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "Ch05_T34_2"					T-34-2 model 2						+
            { "ch14_t34_3":					{"$ref": { "path": "rangeCircle_top" },  "distance": 000  } },	// "Ch14_T34_3"					?									?нет описания
            { "is_3":						{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "IS-3"						ИС-3								+
            { "kv4":						{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "KV4"						КВ-4-5								+
            { "kv_5":						{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "KV-5"						КВ-5								+
            { "object252":					{"$ref": { "path": "rangeCircle_top" },  "distance": 350  } },	// "Object252"					ИС-6								+
            { "lowe":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "Lowe"						Löweturm							+
            { "pzvib_tiger_ii":				{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "PzVIB_Tiger_II"				PzKpfw-VIB-Henschel-Turm			+
            { "pzvib_tiger_ii_training":	{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "PzVIB_Tiger_II_training"	PzKpfw-VIB-Henschel-Turm			+
            { "vk4502a":					{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "VK4502A"					VK-4502-(A)-Turm Ausf. F			+
            { "m6a2e1":						{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "M6A2E1"						M6A2E1D4							+
            { "t32":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "T32"						T119								+
            { "t34_hvy":					{"$ref": { "path": "rangeCircle_top" },  "distance": 360  } },	// "T34_hvy"					T34T7								+
            { "amx_50_100":					{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "AMX_50_100"					AMX 50 100							+
            { "fcm_50t":					{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "FCM_50t"					FCM 50 t							+
            { "gb11_caernarvon":			{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "GB11_Caernarvon"			Centurion Mk. II					+
            { "ch03_wz_111":				{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "Ch03_WZ-111"				WZ-111 model 2						?(no russian server)
            { "ch11_110":					{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "Ch11_110"					T-10								+
            { "ch23_112":					{"$ref": { "path": "rangeCircle_top" },  "distance": 000  } },	// "Ch23_112"					?									?нет описания
			{ "isu_152":					{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "ISU-152"					-									+
            { "su_101":						{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "SU-101"						-									+
            { "ferdinand":					{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "Ferdinand"					-									+
            { "jagdpantherii":				{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "JagdPantherII"				-									+
            { "jagdtiger_sdkfz_185":		{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "JagdTiger_SdKfz_185"		-									+
            { "t28":						{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "T28"						-									+
            { "t28_prototype":				{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "T28_Prototype"				T28P D1								+
            { "amx_ac_mle1948":				{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "AMX_AC_Mle1948"				-									+
            { "gb72_at15":					{"$ref": { "path": "rangeCircle_top" },  "distance": 370  } },	// "GB72_AT15"					-									+
            { "su_14":						{"$ref": { "path": "rangeCircle_top" },  "distance": 1264 } },	// "SU-14"						-	(300)*									+
			{ "gw_tiger_p":					{"$ref": { "path": "rangeCircle_top" },  "distance": 1333 } },	// "GW_Tiger_P"					-	(380)*									+
            { "m40m43":						{"$ref": { "path": "rangeCircle_top" },  "distance": 1336 } },	// "M40M43"						-	(390)*									+
            { "lorraine155_51":				{"$ref": { "path": "rangeCircle_top" },  "distance": 1368 } },	// "Lorraine155_51"				-	(380)*									+
            { "gb79_fv206":					{"$ref": { "path": "rangeCircle_top" },  "distance": 1405 } },	// "GB79_FV206"					-	(330)* 1)1327(27.2) 2)1405(40.92)		++

   // level 9
            { "t_54":						{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "T-54"						Т-54 обр. 1949 г.					+
            { "e_50":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "E-50"						E-50-Turm Ausf. F					+
            { "pro_ag_a":					{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "Pro_Ag_A"					Porsche Standardpanzer				+
			{ "m46_patton":					{"$ref": { "path": "rangeCircle_top" },  "distance": 410  } },	// "M46_Patton"					M46T119								+
            { "t54e1":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "T54E1"						T157								+
            { "ch18_wz_120":				{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "Ch18_WZ-120"				WZ-120-1							+
            { "lorraine40t":				{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "Lorraine40t"				Lorraine 40 t						+
            { "gb24_centurion_mk3":			{"$ref": { "path": "rangeCircle_top" },  "distance": 410  } },	// "GB24_Centurion_Mk3"			Centurion Mk. 9						+
            { "is8":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "IS8"						Т-10М								+
            { "st_i":						{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "ST_I"						СТ-I								+
            { "e_75":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "E-75"						E-75-Turm Ausf. F					+
            { "vk4502p":					{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "VK4502P"					VK-4502-(P)-Eliteturm				+
            { "m103":						{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "M103"						T140								+
            { "ch12_111_1_2_3":				{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "Ch12_111_1_2_3"				WZ-111								+
            { "amx_50_120":					{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "AMX_50_120"					AMX 50 120							+
            { "gb12_conqueror":				{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "GB12_Conqueror"				Conqueror Mk. II					+
            { "object_704":					{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "Object_704"					-									+
            { "su122_54":					{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "SU122_54"					-									+
            { "jagdtiger":					{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "JagdTiger"					-									+
            { "t30":						{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "T30"						T30D1								+
            { "t95":						{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "T95"						-									+
            { "amx50_foch":					{"$ref": { "path": "rangeCircle_top" },  "distance": 380  } },	// "AMX50_Foch"					-									+
            { "gb32_tortoise":				{"$ref": { "path": "rangeCircle_top" },  "distance": 390  } },	// "GB32_Tortoise"				-									+
            { "object_212":					{"$ref": { "path": "rangeCircle_top" },  "distance": 1264 } },	// "Object_212"					-	(330)*									+
            { "g_tiger":					{"$ref": { "path": "rangeCircle_top" },  "distance": 1333 } },	// "G_Tiger"					-	(380)*									+
			{ "m53_55":						{"$ref": { "path": "rangeCircle_top" },  "distance": 1291 } },	// "M53_55"						-	(350)*									+
			{ "bat_chatillon155_55":		{"$ref": { "path": "rangeCircle_top" },  "distance": 1413 } },	// "Bat_Chatillon155_55"		-	(370)*									+
			{ "gb30_fv3805":				{"$ref": { "path": "rangeCircle_top" },  "distance": 1354 } },	// "GB30_FV3805"				-	(340)* 1)1327(29.58) 2)1405(38.44) 3)1354(51.08)	++

   // level 10
            { "object_907":					{"$ref": { "path": "rangeCircle_top" },  "distance": 000  } },	// "Object_907"					?									?нет описания
			{ "t62a":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "T62A"						Т-62А								+
            { "e50_ausf_m":					{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "E50_Ausf_M"					E-50M-Turm Ausf. F					+
            { "leopard1":					{"$ref": { "path": "rangeCircle_top" },  "distance": 410  } },	// "Leopard1"					Leopard 1							+
			{ "m48a1":						{"$ref": { "path": "rangeCircle_top" },  "distance": 420  } },	// "M48A1"						M87									+
            { "m60":						{"$ref": { "path": "rangeCircle_top" },  "distance": 000  } },	// "M60"						?									?Первая кампания
			{ "bat_chatillon25t":			{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "Bat_Chatillon25t"			Batignolles-Châtillon 25 t			+
            { "gb70_fv4202_105":			{"$ref": { "path": "rangeCircle_top" },  "distance": 410  } },	// "GB70_FV4202_105"			FV4202								+
            { "ch19_121":					{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "Ch19_121"					121									+
            { "is_4":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "IS-4"						ИС-4М								+
            { "is_7":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "IS-7"						ИС-7								+
            { "e_100":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "E-100"						E-100-Turm Ausf. B					+
            { "maus":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "Maus"						Mausturm							+
            { "vk7201":						{"$ref": { "path": "rangeCircle_top" },  "distance": 000  } },	// "VK7201"						?									?нет описания
			{ "t110":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "T110"						T53									+
            { "t57_58":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "T57_58"						T169								+
            { "f10_amx_50b":				{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "F10_AMX_50B"				AMX 50 B							+
            { "gb13_fv215b":				{"$ref": { "path": "rangeCircle_top" },  "distance": 410  } },	// "GB13_FV215b"				FV215								+
            { "ch22_113":					{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "Ch22_113"					113									+
            { "object263":					{"$ref": { "path": "rangeCircle_top" },  "distance": 410  } },	// "Object263"					-									+
            { "object268":					{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "Object268"					-									+
            { "jagdpz_e100":				{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "JagdPz_E100"				-									+
            { "t110e3":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "T110E3"						-									+
            { "t110e4":						{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "T110E4"						T110E4								+
            { "amx_50fosh_155":				{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "AMX_50Fosh_155"				-									+
            { "gb48_fv215b_183":			{"$ref": { "path": "rangeCircle_top" },  "distance": 400  } },	// "GB48_FV215b_183"			-									+
            { "object_261":					{"$ref": { "path": "rangeCircle_top" },  "distance": 1470 } },	// "Object_261"					-	(380)*									+
            { "g_e":						{"$ref": { "path": "rangeCircle_top" },  "distance": 1333 } },	// "G_E"						-	(390)*									+
            { "t92":						{"$ref": { "path": "rangeCircle_top" },  "distance": 1411 } },	// "T92"						-	(400)*									+
			{ "bat_chatillon155_58":		{"$ref": { "path": "rangeCircle_top" },  "distance": 1413 } },	// "Bat_Chatillon155_58"		-	(380)*									+
			{ "gb31_conqueror_gun":			{"$ref": { "path": "rangeCircle_top" },  "distance": 1007 } },	// "GB31_Conqueror_Gun"			-	(350)* 1)1007(72.04)					++



//NOT TOP //НЕ ТОП //rangeCircle_not
   // level 1 
            { "ms_1":						{"$ref": { "path": "rangeCircle_not" },  "distance": 240  } },	// "MS-1"						МС-1 обр. 1927 г.					+
            { "ltraktor":					{"$ref": { "path": "rangeCircle_not" },  "distance": 260  } },	// "Ltraktor"					Turm Schwedisch Bofors				+
            { "t1_cunningham":				{"$ref": { "path": "rangeCircle_not" },  "distance": 240  } },	// "T1_Cunningham"				Cunningham D1						+
            { "ch06_renault_nc31":			{"$ref": { "path": "rangeCircle_not" },  "distance": 250  } },	// "Ch06_Renault_NC31"			FT-17								+
            { "renaultft":					{"$ref": { "path": "rangeCircle_not" },  "distance": 250  } },	// "RenaultFT"					Renault FT Omnibus					+
            { "gb01_medium_mark_i":			{"$ref": { "path": "rangeCircle_not" },  "distance": 260  } },	// "GB01_Medium_Mark_I"			Vickers Medium Mk. I				+

   // level 2
            { "bt_2":						{"$ref": { "path": "rangeCircle_not" },  "distance": 240  } },	// "BT-2"						БТ-2								+
            { "t_26":						{"$ref": { "path": "rangeCircle_not" },  "distance": 280  } },	// "T-26"						Т-26 обр. 1936–1937 гг. 			+
			{ "t_60":						{"$ref": { "path": "rangeCircle_not" },  "distance": 280  } },	// "T-60"						Т-40								+
            { "tetrarch_ll":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Tetrarch_LL"				not									+
            { "h39_captured":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "H39_captured"				not									+
            { "pz35t":						{"$ref": { "path": "rangeCircle_not" },  "distance": 280  } },	// "Pz35t"						PzKpfw-35-(t)-Standardturm			+
            { "pzi":						{"$ref": { "path": "rangeCircle_not" },  "distance": 310  } },	// "PzI"						L.K.A. 2							+
            { "pzii":						{"$ref": { "path": "rangeCircle_not" },  "distance": 290  } },	// "PzII"						PzKpfw-II-Turm Ausf. B				+
            { "m2_lt":						{"$ref": { "path": "rangeCircle_not" },  "distance": 260  } },	// "M2_lt"						M2D27810							+
            { "t1_e6":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "T1_E6"						not									+
            { "t2_lt":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "T2_lt"						not									+								
            { "d1":							{"$ref": { "path": "rangeCircle_not" },  "distance": 280  } },	// "D1"							D1 Berliet							+
            { "hotchkiss_h35":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Hotchkiss_H35"				not									+
            { "gb03_cruiser_mk_i":			{"$ref": { "path": "rangeCircle_not" },  "distance": 300  } },	// "GB03_Cruiser_Mk_I"			Cruiser Mk. I						+
            { "gb58_cruiser_mk_iii":		{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "GB58_Cruiser_Mk_III"		Cruiser Mk. III						+
            { "ch07_vickers_mke_type_bt26":	{"$ref": { "path": "rangeCircle_not" },  "distance": 280  } },	// "Ch07_Vickers_MkE_Type_BT26"	Vickers Mk. E Type B				+
            { "t2_med":						{"$ref": { "path": "rangeCircle_not" },  "distance": 300  } },	// "T2_med"						T2T1								+
            { "gb05_vickers_medium_mk_ii":	{"$ref": { "path": "rangeCircle_not" },  "distance": 280  } },	// "GB05_Vickers_Medium_Mk_II"	Vickers Medium Mk. II*				+
            { "at_1":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "AT-1"						-									+
            { "panzerjager_i":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "PanzerJager_I"				-									+
            { "t18":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "T18"						-									+
            { "renaultft_ac":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "RenaultFT_AC"				-									+
			{ "gb39_universal_carrierqf2":	{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "GB39_Universal_CarrierQF2	-									+
            { "su_18":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "SU-18"						-	(260)*									+
            { "gw_mk_vie":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "GW_Mk_VIe"					-	(320)*									+
			{ "t57":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "T57"						-	(330)*									+
            { "renaultbs":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "RenaultBS"					-	(260)*									+
            { "gb25_loyd_carrier":			{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "GB25_Loyd_Carrier"			-	(320)* 1)509(11.16)						++

   // level 3
            { "bt_7":						{"$ref": { "path": "rangeCircle_not" },  "distance": 260  } },	// "BT-7"						БТ-7 обр. 1935 г. 					+
            { "bt_sv":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "BT-SV"						not									+
            { "ltp":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "LTP"						?									?нет описания	++
            { "m3_stuart_ll":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "M3_Stuart_LL"				not									+
            { "t_127":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "T-127"						not									+
            { "t_46":						{"$ref": { "path": "rangeCircle_not" },  "distance": 260  } },	// "T-46"						Т-26								+
            { "t_70":						{"$ref": { "path": "rangeCircle_not" },  "distance": 300  } },	// "T-70"						Т-70								+
			{ "pz_ii_ausfg":				{"$ref": { "path": "rangeCircle_not" },  "distance": 310  } },	// "Pz_II_AusfG"				Pz.Kpfw. II Ausf. C					+
            { "pz38t":						{"$ref": { "path": "rangeCircle_not" },  "distance": 310  } },	// "Pz38t"						LT-40-Turm							+
            { "pzi_ausf_c":					{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "PzI_ausf_C"					Pz.Kpfw. I Breda					+
            { "pzii_j":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "PzII_J"						not									+
            { "pziii_a":					{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "PzIII_A"					PzKpfw-III-Turm Ausf. A				+320 обе
            { "t_15":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "T-15"						not									+
            { "m22_locust":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "M22_Locust"					not									+
            { "m3_stuart":					{"$ref": { "path": "rangeCircle_not" },  "distance": 280  } },	// "M3_Stuart"					D37812								+
            { "mtls_1g14":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "MTLS-1G14"					not									+
            { "amx38":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "AMX38"						not									+
            { "gb59_cruiser_mk_iv":			{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "GB59_Cruiser_Mk_IV"			Cruiser Mk. IV						+
            { "gb69_cruiser_mk_ii":			{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "GB69_Cruiser_Mk_II"			A10E1								+
            { "ch08_type97_chi_ha":			{"$ref": { "path": "rangeCircle_not" },  "distance": 310  } },	// "Ch08_Type97_Chi_Ha"			Type 97								+
            { "s35_captured":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "S35_captured"				not									+
            { "m2_med":						{"$ref": { "path": "rangeCircle_not" },  "distance": 280  } },	// "M2_med"						M2M19								+
            { "d2":							{"$ref": { "path": "rangeCircle_not" },  "distance": 300  } },	// "D2"							D2 APX 1							+
            { "gb06_vickers_medium_mk_iii":	{"$ref": { "path": "rangeCircle_not" },  "distance": 310  } },	// "GB06_Vickers_Medium_Mk_III"	Vickers Medium А6Е1					+
            { "su_76":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "SU-76"						-not								+
            { "g20_marder_ii":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "G20_Marder_II"				-not								+
            { "t82":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "T82"						-not								+
            { "fcm_36pak40":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "FCM_36Pak40"				-not								+
            { "renaultue57":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "RenaultUE57"				-not								+
            { "gb42_valentine_at":			{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "GB42_Valentine_AT"			-not								+
            { "su_26":						{"$ref": { "path": "rangeCircle_not" },  "distance": 1165 } },	// "SU-26"						-	(300)* 1)500(6.9)   2)1165(6.33) 3)1218(6.33)	+
            { "bison_i":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Bison_I"					-	(320)* 1)602(22.16)						+
			{ "wespe":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Wespe"						-	(350)*									+
            { "m7_priest":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "M7_Priest"					-	(370)*									+
            { "sexton_i:":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Sexton_I" },				-	?								?
            { "lorraine39_l_am":			{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Lorraine39_L_AM"			-	(350)*									+
            { "gb27_sexton":				{"$ref": { "path": "rangeCircle_not" },  "distance": 885  } },	// "GB27_Sexton_II"				-	(330)* 1)885(13.64) 2)1051(14.88)		++
			{ "gb78_sexton_i":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "GB78_Sexton_I"				-	(330)* 1)1051(14.88)					++

   // level 4
            { "a_20":						{"$ref": { "path": "rangeCircle_not" },  "distance": 300  } },	// "A-20"						А-20 обр. 1938 г.					+
            { "t_50":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "T-50"						not									+
            { "t80":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "T80"						not									+
			{ "valentine_ll":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Valentine_LL"				not									+
            { "pz38_na":					{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "Pz38_NA"					PzKpfw-38-nA-Standardturm			+
            { "pzii_luchs":					{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "PzII_Luchs"					Luchs 2 cm							+
            { "m5_stuart":					{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "M5_Stuart"					M5A1								+
            { "amx40":						{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "AMX40"						AMX 40								+
            { "gb04_valentine":				{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "GB04_Valentine"				Valentine Mk. I						+
            { "gb60_covenanter":			{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "GB60_Covenanter"			Covenanter Mk. I					+
            { "ch09_m5":					{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "Ch09_M5"					M3A3								+
            { "a_32":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "A-32"						not									+
            { "t_28":						{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "T-28"						Т-28 цилиндрическая					+
            { "pziii":						{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "PzIII"						PzKpfw-III-Turm Ausf. E				+330 обе
            { "pziii_training:":			{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "PzIII_training"				PzKpfw-III-Turm Ausf. E				+330 обе	
            { "vk2001db":					{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "VK2001DB"					VK 20.01 (D)						+330 обе
			{ "m3_grant":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "M3_Grant"					-not								+
            { "gb07_matilda":				{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "GB07_Matilda"				Matilda Mk. IIA						+
            { "b_1bis_captured":			{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "B-1bis_captured"			not									+
            { "b1":							{"$ref": { "path": "rangeCircle_not" },  "distance": 300  } },	// "B1"							B1 APX 1							+
            { "gaz_74b":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "GAZ-74b"					-not								+
            { "hetzer":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Hetzer"						-not								+
            { "m8a1":						{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "M8A1"						M8A1								+370 обе
            { "t40":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "T40"						-not								+
            { "somua_sau_40":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Somua_Sau_40"				-not								+
            { "gb57_alecto":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "GB57_Alecto"				-not								+
            { "su_5":						{"$ref": { "path": "rangeCircle_not" },  "distance": 841  } },	// "SU-5"						-	(320)* 1)1165(6.23) 2)1218(6.21)  3)841(16.03) 4)613(17.57)	+
            { "pz_sfl_ivb":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Pz_Sfl_IVb"					-	(340)*									+
            { "sturmpanzer_ii":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Sturmpanzer_II"				-	(360)*									+
            { "m37":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "M37"						-	(370)*									+
			{ "amx_ob_am105":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "AMX_Ob_Am105"				-	(340)*									+
			{ "gb26_birch_gun":				{"$ref": { "path": "rangeCircle_not" },  "distance": 885  } },	// "GB26_Birch_Gun"				-	(340)* 1)885(10.91) 2)1051(11.9)		++

   // level 5
            { "t_50_2":						{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "T_50_2"						Т-50-2								+
            { "vk1602":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "VK1602"						not									+
            { "m24_chaffee":				{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "M24_Chaffee"				T24									+
            { "elc_amx":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "ELC_AMX"					not									+
            { "gb20_crusader":				{"$ref": { "path": "rangeCircle_not" },  "distance": 340  } },	// "GB20_Crusader"				Crusader Mk. I						+
            { "matilda_ii_ll":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Matilda_II_LL"				not									+
            { "t_34":						{"$ref": { "path": "rangeCircle_not" },  "distance": 240  } },	// "T-34"						Т-34 обр. 1940 г.					+
            { "pziii_iv":					{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "PzIII_IV"					Pz.Kpfw. III/IV Ausf. A				+320 обе
            { "pziv":						{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "PzIV"						Pz.Kpfw. IV Ausf. G					+
            { "pziv_hydro":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "PzIV_Hydro"					not									+
            { "t_25":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "T-25"						not									+
            { "m4_sherman":					{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "M4_Sherman"					D51066								+
            { "m4a2e4":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "M4A2E4"						not									+
            { "m7_med":						{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "M7_med"						M24A1								+
            { "ram_ii":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Ram-II"						not									+
            { "gb68_matilda_black_prince":	{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "GB68_Matilda_Black_Prince"	not									+
            { "ch21_t34":					{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "Ch21_T34"					Type T-34							+
            { "churchill_ll":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Churchill_LL"				not									+
            { "kv":							{"$ref": { "path": "rangeCircle_not" },  "distance": 310  } },	// "KV"							КВ-1								+310 обе удален
            { "kv1":						{"$ref": { "path": "rangeCircle_not" },  "distance": 310  } },	// "KV1"						КВ-1 ЛКЗ обр. 1940 г.				+310 обе
            { "kv_220":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "KV-220"						not									+
            { "kv_220_action":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "KV-220_action"				not									+
            { "t1_hvy":						{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "T1_hvy"						T1D5								+
            { "t14":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "T14"						not									+
            { "bdr_g1b":					{"$ref": { "path": "rangeCircle_not" },  "distance": 300  } },	// "BDR_G1B"					FCM F4								+
            { "gb08_churchill_i":			{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "GB08_Churchill_I"			Churchill I							+
            { "gb51_excelsior":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "GB51_Excelsior"				not									+
			{ "su_85i":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "SU_85I"						-not								+
            { "su_85":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "SU-85"						-not								+
            { "stugiii":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "StuGIII"					-not								+
            { "m10_wolverine":				{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "M10_Wolverine"				M10T72								+370 обе
            { "t49":						{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "T49"						T42									+
            { "s_35ca":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "S_35CA"						-not								+
            { "gb73_at2":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "GB73_AT2"					-not								+
            { "su122a":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "SU122A"						-	(340)*									+
			{ "grille":						{"$ref": { "path": "rangeCircle_not" },  "distance": 602  } },	// "Grille"						-	(360)* 1)602(15.34)	2)836(22.53)		+
            { "m41":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "M41"						-	(370)*									+
            { "_105_lefh18b2":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "_105_leFH18B2"				-	(390)*									+
            { "amx_105am":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "AMX_105AM"					-	(360)*									+
            { "gb28_bishop":				{"$ref": { "path": "rangeCircle_not" },  "distance": 518  } },	// "GB28_Bishop"				-	(300)* 1)1051-518?(10.85) 2)500(16)		++?

   // level 6
            { "mt25":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "MT25"						not									++
            { "vk2801":						{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "VK2801"						VK 28.01 Ausf. A					+
            { "t21":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "T21"						not									+
            { "amx_12t":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "AMX_12t"					not									+
            { "ch15_59_16":					{"$ref": { "path": "rangeCircle_not" },  "distance": 360  } },	// "Ch15_59_16"					131									+
            { "t_34_85":					{"$ref": { "path": "rangeCircle_not" },  "distance": 350  } },	// "T-34-85"					Т-34-85								+
            { "t_34_85_training":			{"$ref": { "path": "rangeCircle_not" },  "distance": 350  } },	// "T-34-85_training"			Т-34-85 расширенная					+
            { "pziv_schmalturm":			{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "PzIV_schmalturm"			not									+
            { "pzv_pziv":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "PzV_PzIV"					not									+
            { "pzv_pziv_ausf_alfa":			{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "PzV_PzIV_ausf_Alfa"			not									+
            { "vk3001h":					{"$ref": { "path": "rangeCircle_not" },  "distance": 350  } },	// "VK3001H"					VK-3001-(H)-Standardturm			+
            { "vk3001p":					{"$ref": { "path": "rangeCircle_not" },  "distance": 350  } },	// "VK3001P"					VK-3001-(P)-Krupp-Turm				+
            { "vk3002db_v1":				{"$ref": { "path": "rangeCircle_not" },  "distance": 350  } },	// "VK3002DB_V1"				Pz.Kpfw. III/IV Ausf. B				+
			{ "vk3601h":					{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "VK3601H"					VK-3601-(H)-Standardturm			+370 обе
            { "m4a3e8_sherman":				{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "M4A3E8_Sherman"				D51072								+
            { "m4a3e8_sherman_training":	{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "M4A3E8_Sherman_training"	D51072								+
            { "sherman_jumbo":				{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "Sherman_Jumbo"				M4A2E2T110							+
            { "gb21_cromwell":				{"$ref": { "path": "rangeCircle_not" },  "distance": 360  } },	// "GB21_Cromwell"				Cromwell Mk. I						+360 обе
            { "ch20_type58":				{"$ref": { "path": "rangeCircle_not" },  "distance": 360  } },	// "Ch20_Type58"				T-34-85								+
            { "kv_1s":						{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "KV-1s"						КВ-1С обр. 1942 г.					+
            { "kv2":						{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "KV2"						МТ-1								+
            { "t150":						{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "T150"						Т-150-КВ							+
            { "m6":							{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "M6"							M6D1								+
            { "arl_44":						{"$ref": { "path": "rangeCircle_not" },  "distance": 320  } },	// "ARL_44"						FCM F1								+
            { "gb09_churchill_vii":			{"$ref": { "path": "rangeCircle_not" },  "distance": 350  } },	// "GB09_Churchill_VII"			Churchill IV						+
            { "gb63_tog_ii":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "GB63_TOG_II"				not									+
            { "su_100":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "SU-100"						-									+
            { "su100y":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "SU100Y"						-									+
            { "dickermax":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "DickerMax"					-									+
            { "jagdpziv":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "JagdPzIV"					-									+
            { "m18_hellcat":				{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "M18_Hellcat"				M18 M34A1							+370 обе
            { "m36_slagger":				{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "M36_Slagger"				M36T74								+370 обе
            { "arl_v39":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "ARL_V39"					-									+
            { "gb40_gun_carrier_churchill":	{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "GB40_Gun_Carrier_Churchill"	-									+
            { "gb74_at8":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "GB74_AT8"					-									+
			{ "su_8":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "SU-8"						-	(360)*									+
            { "hummel":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Hummel"						-	(370)*									+
            { "m44":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "M44"						-	(360)*									+
			{ "amx_13f3am":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "AMX_13F3AM"					-	(370)*									+
            { "gb77_fv304":					{"$ref": { "path": "rangeCircle_not" },  "distance": 1051 } },	// "GB77_FV304"					-	(310)* 1)1051(10.6) 2)500(14.88)		++

   // level 7
            { "auf_panther":				{"$ref": { "path": "rangeCircle_not" },  "distance": 380  } },	// "Auf_Panther"				VK 16.02 Leopard					+
			{ "t71":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "T71"						not									+
            { "amx_13_75":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "AMX_13_75"					not									+
            { "ch02_type62":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Ch02_Type62"				not									+
            { "ch16_wz_131":				{"$ref": { "path": "rangeCircle_not" },  "distance": 380  } },	// "Ch16_WZ_131"				132A								+
            { "kv_13": 						{"$ref": { "path": "rangeCircle_not" },  "distance": 340  } },	// "KV-13"						КВ-13 обр. 1942 г.					+
            { "t_43":						{"$ref": { "path": "rangeCircle_not" },  "distance": 360  } },	// "T-43"						Т-43 обр. 1942 г.					+
            { "panther_m10":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Panther_M10"				not									+
            { "pzv":						{"$ref": { "path": "rangeCircle_not" },  "distance": 350  } },	// "PzV"						PzKpfw-V-Turm Ausf. G				+
            { "pzv_training":				{"$ref": { "path": "rangeCircle_not" },  "distance": 350  } },	// "PzV_training"				PzKpfw-V-Turm Ausf. G				+
            { "vk3002db":					{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "VK3002DB"					VK 30.02 (D)						+
            { "t20":						{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "T20"						T20D1								+
            { "gb22_comet":					{"$ref": { "path": "rangeCircle_not" },  "distance": 360  } },	// "GB22_Comet"					Cromwell Mk. IV						+
            { "ch04_t34_1":					{"$ref": { "path": "rangeCircle_not" },  "distance": 360  } },	// "Ch04_T34_1"					T-34-1								+
            { "ch04_t34_1_training":		{"$ref": { "path": "rangeCircle_not" },  "distance": 360  } },	// "Ch04_T34_1_training"		T-34-1								+
            { "is":							{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "IS"							ИС-85								+
            { "kv_3":						{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "KV-3"						Т-220								+
            { "pzvi":						{"$ref": { "path": "rangeCircle_not" },  "distance": 350  } },	// "PzVI"						PzKpfw-VI-Tiger-I-Turm Ausf.H2		+
            { "pzvi_tiger_p":				{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "PzVI_Tiger_P"				Tiger-(P)-Turm Ausf. A				+370 обе
            { "t29":						{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "T29"						T123								+
            { "amx_m4_1945":				{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "AMX_M4_1945"				ARL 44								+
            { "gb10_black_prince":			{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "GB10_Black_Prince"			not									+
            { "ch10_is2":					{"$ref": { "path": "rangeCircle_not" },  "distance": 350  } },	// "Ch10_IS2"					IS-2 early							+370 обе
            { "su100m1":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "SU100M1"					-									+
            { "su122_44":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "SU122_44"					-									+
            { "su_152":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "SU-152"						-									+
            { "e_25":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "E-25"						-									++
			{ "jagdpanther":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "JagdPanther"				-									+
            { "t25_2":						{"$ref": { "path": "rangeCircle_not" },  "distance": 380  } },	// "T25_2"						T25/2T3								+370 обе
            { "t25_at":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "T25_AT"						-									+
            { "amx_ac_mle1946":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "AMX_AC_Mle1946"				-									+
            { "gb71_at_15a":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "GB71_AT_15A"				-									+
            { "gb75_at7":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "GB75_AT7"					-									+
            { "s_51":						{"$ref": { "path": "rangeCircle_not" },  "distance": 1429 } },	// "S-51"						-	(370)* 1)1429(26.75) 2)1264(31.1)		+
			{ "su14_1":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "SU14_1"						-	(360)*									+
            { "g_panther":					{"$ref": { "path": "rangeCircle_not" },  "distance": 1260 } },	// "G_Panther"					-	(350)* 1)1260(27.33) 2)1300(33.08)		+
            { "m12":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "M12"						-	(380)*									+
            { "lorraine155_50":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Lorraine155_50"				-	(370)*									+
            { "gb29_crusader_5inch":		{"$ref": { "path": "rangeCircle_not" },  "distance": 500  } },	// "GB29_Crusader_5inch"		-	(370)* 1)500(14.88) 2)1327(34.72)		++

   // level 8
            { "amx_13_90":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "AMX_13_90"					not									+
            { "ch17_wz131_1_wz132":			{"$ref": { "path": "rangeCircle_not" },  "distance": 390  } },	// "Ch17_WZ131_1_WZ132"			WZ-131-1							+
            { "t_44":						{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "T-44"						Т-44								+
            { "indien_panzer":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Indien_Panzer"				not									+
			{ "panther_ii":					{"$ref": { "path": "rangeCircle_not" },  "distance": 380  } },	// "Panther_II"					Panther-II-Turm Ausf. A 			+
            { "pershing":					{"$ref": { "path": "rangeCircle_not" },  "distance": 390  } },	// "Pershing"					M26M67								+
            { "t23":						{"$ref": { "path": "rangeCircle_not" },  "distance": 380  } },	// "T23"						T23T80								?380 обе удален
            { "t26_e4_superpershing":		{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "T26_E4_SuperPershing"		not									+
            { "t69":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "T69"						not									+
            { "gb23_centurion":				{"$ref": { "path": "rangeCircle_not" },  "distance": 380  } },	// "GB23_Centurion"				Centurion Mk. I						+
            { "ch01_type59":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Ch01_Type59"				not									+
            { "ch01_type59_gold":			{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Ch01_Type59_Gold"			not									?(no russian server)
            { "ch05_t34_2":					{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "Ch05_T34_2"					T-34-2								+
            { "ch14_t34_3":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Ch14_T34_3"					?									?нет описания
            { "is_3":						{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "IS-3"						Кировец-1							+
            { "kv4":						{"$ref": { "path": "rangeCircle_not" },  "distance": 330  } },	// "KV4"						КВ-4								+
            { "kv_5":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "KV-5"						not									+
            { "object252":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Object252"					not									+
            { "lowe":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Lowe"						not									+
            { "pzvib_tiger_ii":				{"$ref": { "path": "rangeCircle_not" },  "distance": 400  } },	// "PzVIB_Tiger_II"				PzKpfw-VIB-Porsche-Turm				+400 обе
            { "pzvib_tiger_ii_training":	{"$ref": { "path": "rangeCircle_not" },  "distance": 400  } },	// "PzVIB_Tiger_II_training"	PzKpfw-VIB-Porsche-Turm				+400 обе
            { "vk4502a":					{"$ref": { "path": "rangeCircle_not" },  "distance": 400  } },	// "VK4502A"					VK-4502-(A)-Turm Ausf. A			+400 обе
            { "m6a2e1":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "M6A2E1"						not									+
            { "t32":						{"$ref": { "path": "rangeCircle_not" },  "distance": 380  } },	// "T32"						T99E2								+
            { "t34_hvy":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "T34_hvy"					not									+
            { "amx_50_100":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "AMX_50_100"					not									+
            { "fcm_50t":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "FCM_50t"					not									+
            { "gb11_caernarvon":			{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "GB11_Caernarvon"			Black Prince						+
            { "ch03_wz_111":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Ch03_WZ-111"				not									?(no russian server)
            { "ch11_110":					{"$ref": { "path": "rangeCircle_not" },  "distance": 350  } },	// "Ch11_110"					110									+
            { "ch23_112":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Ch23_112"					?									?нет описания
			{ "isu_152":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "ISU-152"					-									+
            { "su_101":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "SU-101"						-									+
            { "ferdinand":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Ferdinand"					-									+
            { "jagdpantherii":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "JagdPantherII"				-									+
            { "jagdtiger_sdkfz_185":		{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "JagdTiger_SdKfz_185"		-									+
            { "t28":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "T28"						-									+
            { "t28_prototype":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "T28_Prototype"				not									+
            { "amx_ac_mle1948":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "AMX_AC_Mle1948"				-									+
            { "gb72_at15":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "GB72_AT15"					-									+
            { "su_14":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "SU-14"						-	(300)*									+
			{ "gw_tiger_p":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "GW_Tiger_P"					-	(380)*									+
            { "m40m43":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "M40M43"						-	(390)*									+
            { "lorraine155_51":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Lorraine155_51"				-	(380)*									+
            { "gb79_fv206":					{"$ref": { "path": "rangeCircle_not" },  "distance": 1327 } },	// "GB79_FV206"					-	(330)* 1)1327(27.2) 2)1405(40.92)		++

   // level 9
            { "t_54":						{"$ref": { "path": "rangeCircle_not" },  "distance": 390  } },	// "T-54"						Т-54 обр. 1946 г					+390 обе
            { "e_50":						{"$ref": { "path": "rangeCircle_not" },  "distance": 390  } },	// "E-50"						E-50-Turm Ausf. A					+
            { "pro_ag_a":					{"$ref": { "path": "rangeCircle_not" },  "distance": 390  } },	// "Pro_Ag_A"					Leopard prototyp A2					+
			{ "m46_patton":					{"$ref": { "path": "rangeCircle_not" },  "distance": 400  } },	// "M46_Patton"					M46M73								+
            { "t54e1":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "T54E1"						not									+
            { "ch18_wz_120":				{"$ref": { "path": "rangeCircle_not" },  "distance": 380  } },	// "Ch18_WZ-120"				WZ-120								+
            { "lorraine40t":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Lorraine40t"				Lorraine 40 t						+
            { "gb24_centurion_mk3":			{"$ref": { "path": "rangeCircle_not" },  "distance": 400  } },	// "GB24_Centurion_Mk3"			Centurion Mk. 7						+
            { "is8":						{"$ref": { "path": "rangeCircle_not" },  "distance": 380  } },	// "IS8"						Т-10								+
            { "st_i":						{"$ref": { "path": "rangeCircle_not" },  "distance": 360  } },	// "ST_I"						Объект 701-1						+
            { "e_75":						{"$ref": { "path": "rangeCircle_not" },  "distance": 400  } },	// "E-75"						E-75-Turm Ausf. A					+400 обе
            { "vk4502p":					{"$ref": { "path": "rangeCircle_not" },  "distance": 400  } },	// "VK4502P"					VK-4502-(P)-Standardturm			+400 обе
            { "m103":						{"$ref": { "path": "rangeCircle_not" },  "distance": 370  } },	// "M103"						M89									+
            { "ch12_111_1_2_3":				{"$ref": { "path": "rangeCircle_not" },  "distance": 380  } },	// "Ch12_111_1_2_3"				IS-3								+
            { "amx_50_120":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "AMX_50_120"					not									+
            { "gb12_conqueror":				{"$ref": { "path": "rangeCircle_not" },  "distance": 400  } },	// "GB12_Conqueror"				Centurion Mk. III					+400 обе
            { "object_704":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Object_704"					-									+
            { "su122_54":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "SU122_54"					-									+
            { "jagdtiger":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "JagdTiger"					-									+
            { "t30":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "T30"						not									+
            { "t95":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "T95"						-									+
            { "amx50_foch":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "AMX50_Foch"					-									+
            { "gb32_tortoise":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "GB32_Tortoise"				-									+
            { "object_212":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Object_212"					-	(330)*									+
            { "g_tiger":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "G_Tiger"					-	(380)*									+
			{ "m53_55":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "M53_55"						-	(350)*									+
			{ "bat_chatillon155_55":		{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Bat_Chatillon155_55"		-	(370)*									+
			{ "gb30_fv3805":				{"$ref": { "path": "rangeCircle_not" },  "distance": 1405 } },	// "GB30_FV3805"				-	(340)* 1)1327(29.58) 2)1405(38.44) 3)1354(51.08)	++

   // level 10
            { "object_907":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Object_907"					?									?нет описания
			{ "t62a":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "T62A"						not									+
            { "e50_ausf_m":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "E50_Ausf_M"					not									+
            { "leopard1":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Leopard1"					not									+
			{ "m48a1":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "M48A1"						not									+
            { "m60":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "M60"						?									?Первая кампания
			{ "bat_chatillon25t":			{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Bat_Chatillon25t"			not									+
            { "gb70_fv4202_105":			{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "GB70_FV4202_105"			not									+
            { "ch19_121":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Ch19_121"					not									+
            { "is_4":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "IS-4"						not									+
            { "is_7":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "IS-7"						not									+
            { "e_100":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "E-100"						not									+
            { "maus":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Maus"						not									+
            { "vk7201":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "VK7201"						?									?нет описания
			{ "t110":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "T110"						not									+
            { "t57_58":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "T57_58"						not									+
            { "f10_amx_50b":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "F10_AMX_50B"				not									+
            { "gb13_fv215b":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "GB13_FV215b"				not									+
            { "ch22_113":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Ch22_113"					not									+
            { "object263":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Object263"					-									+
            { "object268":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Object268"					-									+
            { "jagdpz_e100":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "JagdPz_E100"				-									+
            { "t110e3":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "T110E3"						-									+
            { "t110e4":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "T110E4"						T110E4								+
            { "amx_50fosh_155":				{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "AMX_50Fosh_155"				-									+
            { "gb48_fv215b_183":			{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "GB48_FV215b_183"			-									+
            { "object_261":					{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Object_261"					-	(380)*									+
            { "g_e":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "G_E"						-	(390)*									+
            { "t92":						{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "T92"						-	(400)*									+
			{ "bat_chatillon155_58":		{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "Bat_Chatillon155_58"		-	(380)*									+
			{ "gb31_conqueror_gun":			{"$ref": { "path": "rangeCircle_not" },  "distance": 000  } },	// "GB31_Conqueror_Gun"			-	(350)* 1)1007(72.04)					++



//TOP+module //ТОП+модули //rangeCircle_add		//орл.глаз.2% //радиоп.3% //просветленка.10% //труба.20%
            { "ms_1":						{"$ref": { "path": "rangeCircle_add" },  "distance": 350  } },	// "MS-1"						МС-1 модерн + труба.20%(
            { "t2_lt":						{"$ref": { "path": "rangeCircle_add" },  "distance": 317.2 } },	// "T2_lt"						2%(5.2) + 20% (52)
            { "t_50":						{"$ref": { "path": "rangeCircle_add" },  "distance": 379.5} },	// "T-50"						330 + орл.глаз.2%(6,6) + радиоп.3%(9,9) + просветленка.10%(33)
            { "kv_1s":						{"$ref": { "path": "rangeCircle_add" },  "distance": 379.5} },	// "KV-1s"						330 + орл.глаз.2%(6,6) + радиоп.3%(9,9) + просветленка.10%(33)
            { "gb21_cromwell":				{"$ref": { "path": "rangeCircle_add" },  "distance": 403.2} },	// "GB21_Cromwell"				360 + просветленка.10%(36) + радиоп.3%(7,2)
            { "m18_hellcat":				{"$ref": { "path": "rangeCircle_add" },  "distance": 407  } },	// "M18_Hellcat"				370 + просветленка.10%(37)
            { "m18_hellcat":				{"$ref": { "path": "rangeCircle_add2" },  "distance": 444  } },	// "M18_Hellcat"				370 + труба.20%(74)
            { "t69":						{"$ref": { "path": "rangeCircle_add" },  "distance": 440  } },	// "T69"						400 + просветленка.10%(40)
            { "t69":						{"$ref": { "path": "rangeCircle_add2" },  "distance": 480  } },	// "T69"						400 + труба.20%(80)
            { "amx_13_90":					{"$ref": { "path": "rangeCircle_add" },  "distance": 480  } },	// "AMX_13_90"					400 + просветленка.10%(40)
            { "amx_13_90":					{"$ref": { "path": "rangeCircle_add2" },  "distance": 440  } },	// "AMX_13_90"					400 + труба.20%(80)
            { "amx_ac_mle1946":				{"$ref": { "path": "rangeCircle_add2" },  "distance": 420  } },	// "AMX_AC_Mle1946"				350 + труба.20%(70)
            { "t21":						{"$ref": { "path": "rangeCircle_add" },  "distance": 429  } },	// "T21"						T21 + просветленка.10%(39)
            { "t21":						{"$ref": { "path": "rangeCircle_add2" },  "distance": 468  } }	// "T21"						T21 + труба.20%(78)

        ]
    }
}