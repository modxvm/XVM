/**
 * Minimap circles. Only real map meters. Only for own unit. Works only with xvm-stat.exe for uncommon locales.
 * xvm-stat.exe is not necessary for RU, EN, DE and partially CH locale.
 * Круги на миникарте. Дистанция только в реальных метрах карты. Только для своей техники.
 */
{
  "circles": { // Круги дальности. Дистанция только в реальных метрах карты. Только для своей техники. 
        // Работает только с xvm-stat.exe
        // Основные круги.
        // "enabled": false - выключен; "distance" - дистанция; "thickness" - толщина; "alpha" - прозрачность; "color" - цвет.
        "enabled": true, 
        "major": [ // Основные круги. thickness - толщина. 445 метров - максимальная дистанция засвета. 
            { "enabled": true, "distance": 445, "thickness": 1, "alpha": 30, "color": "0x00EAFF" }, //000000 
            { "enabled": true, "distance": 50, "thickness": 1, "alpha": 60, "color": "0x00EAFF" } //FFFFFF 
        ], 
        // Специальные круги, зависящие от модели техники.
        // Несколько строк для одной техники делают несколько кругов.
        // По умолчанию в списке только круги дальнобойности артиллерии с топ орудиями.
        //   Типы для дополнения брать по ссылке
        // http://code.google.com/p/wot-xvm/source/browse/trunk/src/xvm/src/wot/utils/VehicleInfoData2.as
        //   Дальнобойность арты може менятся в зависимости от углов постановки машины на склонах местности
        // и высоте расположения машины относительно цели. на миникарте эти факторы не учитываются.
        // Подробнее по ссылке: http://goo.gl/ZqlPa                    //default=EE4444 //top=7FDC00 //stok=F50800 //для арты другое измерение а в скобках обзор самого танка()*
        "special": [	// вся информация собрана с сайта http://wiki.worldoftanks.ru/ специально для http://xvm.alastanka.org.ua (Alastanka)
// Уровень	Название			Включить/Выключить	Дистанция	Толщина		Прозрачность	Цвет			vehicleNames				Башня
   // level 1 
            { "ms_1":				{ "enabled": true,  "distance": 240,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "MS-1"				МС-1 шестигранная
            { "ms_1":				{ "enabled": true,  "distance": 280,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "MS-1"				МС-1 модерн
            { "ms_1":				{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 40, "color": "0xD042F3" } },	// "MS-1"				МС-1 модерн + труба
            { "ltraktor":			{ "enabled": true,  "distance": 260,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "Ltraktor"				Turm Schwedisch Bofors
            { "ltraktor":			{ "enabled": true,  "distance": 310,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Ltraktor"				Verbesserter Turm
            { "t1_cunningham":			{ "enabled": true,  "distance": 240,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "T1_Cunningham"			Cunningham D1
            { "t1_cunningham":			{ "enabled": true,  "distance": 280,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T1_Cunningham"			Cunningham D2
            { "renaultft":			{ "enabled": true,  "distance": 250,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "RenaultFT"				RenaultFT La tour 1
            { "renaultft":			{ "enabled": true,  "distance": 280,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "RenaultFT"				RenaultFT La tour 2
            { "ch06_renault_nc31":		{ "enabled": true,  "distance": 250,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "Ch06_Renault_NC31"			FT-17
            { "ch06_renault_nc31":		{ "enabled": true,  "distance": 280,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Ch06_Renault_NC31"			FT-18
            { "gb01_medium_mark_i":		{ "enabled": true,  "distance": 260,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "GB01_Medium_Mark_I"			Vickers Medium Mk. I 
            { "gb01_medium_mark_i":		{ "enabled": true,  "distance": 280,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB01_Medium_Mark_I"			Vickers Medium Mk. IA*

   // level 2
            { "bt_2":				{ "enabled": true,  "distance": 240,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "BT-2"				Christie
            { "bt_2":				{ "enabled": true,  "distance": 280,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "BT-2"				БТ-2
            { "t_26":				{ "enabled": true,  "distance": 280,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "T-26"				Т-26 цилиндрическая
            { "t_26":				{ "enabled": true,  "distance": 310,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T-26"				Т-26 коническая
            { "tetrarch_ll":			{ "enabled": true,  "distance": 260,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Tetrarch_LL"			Tetrarch
            { "h39_captured":			{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "H39_captured" "PzKpfw 38H735 (f)"	38H735-(f)-Turm
            { "pz35t":				{ "enabled": true,  "distance": 290,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "Pz35t"				PzKpfw-35-(t)-Standardturm
            { "pz35t":				{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Pz35t"				PzKpfw-35-(t)-Verstärkterturm
            { "pzi":				{ "enabled": true,  "distance": 310,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "PzI"				Verbesserter Turm
            { "pzi":				{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "PzI"				Pz.Kpfw. I Breda
            { "pzii":				{ "enabled": true,  "distance": 290,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "PzII"				PzKpfw-II-Turm Ausf. B
            { "pzii":				{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "PzII"				PzKpfw-II-Turm Ausf. F
            { "m2_lt":				{ "enabled": true,  "distance": 260,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "M2_lt"				M2D27810
            { "m2_lt":				{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "M2_lt"				M2D27812
            { "t1_e6":				{ "enabled": true,  "distance": 260,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T1_E6"				T1
            { "t2_lt":				{ "enabled": true,  "distance": 260,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T2_lt"				T2D1
            { "d1":				{ "enabled": true,  "distance": 280,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "D1"					D1a
            { "d1":				{ "enabled": true,  "distance": 300,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "D1"					D1b
            { "hotchkiss_h35":			{ "enabled": true,  "distance": 300,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Hotchkiss_H35"			APX-R
            { "gb03_cruiser_mk_i":		{ "enabled": true,  "distance": 300,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "GB03_Cruiser_Mk_I"			Cruiser Mk. I
            { "gb03_cruiser_mk_i":		{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB03_Cruiser_Mk_I"			Cruiser Mk. III
            { "gb58_cruiser_mk_iii":		{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "GB58_Cruiser_Mk_III"		Cruiser Mk. III
            { "gb58_cruiser_mk_iii":		{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB58_Cruiser_Mk_III"		Cruiser Mk. III*
            { "ch07_vickers_mke_type_bt26":	{ "enabled": true,  "distance": 280,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "Ch07_Vickers_MkE_Type_BT26"		Vickers Mk. E Type B
            { "ch07_vickers_mke_type_bt26":	{ "enabled": true,  "distance": 310,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Ch07_Vickers_MkE_Type_BT26"		Т-26 model 1936
            { "t2_med":				{ "enabled": true,  "distance": 300,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "T2_med"				T2T1
            { "t2_med":				{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T2_med"				T2T2
            { "gb05_vickers_medium_mk_ii":	{ "enabled": true,  "distance": 280,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "GB05_Vickers_Medium_Mk_II"		Vickers Medium Mk. II*
            { "gb05_vickers_medium_mk_ii":	{ "enabled": true,  "distance": 300,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB05_Vickers_Medium_Mk_II"		Vickers Medium Mk. II**
            { "at_1":				{ "enabled": true,  "distance": 250,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "AT-1"				-
            { "panzerjager_i":			{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "PanzerJager_I"			-
            { "t18":				{ "enabled": true,  "distance": 240,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T18"				-
            { "renaultft_ac":			{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "RenaultFT_AC"			-
            { "su_18":				{ "enabled": true,  "distance": 552,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "SU-18"				-	(260)*
            { "bison_i":			{ "enabled": true,  "distance": 605,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Bison_I"				-	(320)*
            { "t57":				{ "enabled": true,  "distance": 552,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T57"				-	(330)*
            { "renaultbs":			{ "enabled": true,  "distance": 450,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "RenaultBS"				-	(260)*

   // level 3
            { "bt_7":				{ "enabled": true,  "distance": 260,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "BT-7"				БТ-5 цилиндрическая
            { "bt_7":				{ "enabled": true,  "distance": 280,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "BT-7"				БТ-7 коническая
            { "bt_sv":				{ "enabled": true,  "distance": 280,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "BT-SV"				БТ-СВ
            { "m3_stuart_ll":			{ "enabled": true,  "distance": 280,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "M3_Stuart_LL"			D37812
            { "t_127":				{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T-127"				Т-127
            { "t_46":				{ "enabled": true,  "distance": 260,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "T-46"				Т-46
            { "t_46":				{ "enabled": true,  "distance": 310,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T-46"				Т-46 улучшенная
            { "pz_ii_ausfg":			{ "enabled": true,  "distance": 310,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "Pz_II_AusfG"			Pz.Kpfw. II Ausf. C
            { "pz_ii_ausfg":			{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Pz_II_AusfG"			Pz.Kpfw. II Ausf. G
            { "pz38t":				{ "enabled": true,  "distance": 310,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "Pz38t"				LT-40-Turm
            { "pz38t":				{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Pz38t"				PzKpfw-38-(t)-Turm Ausf. G
            { "pzi_ausf_c":			{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "PzI_ausf_C"				Pz.Kpfw. I Breda
            { "pzi_ausf_c":			{ "enabled": true,  "distance": 340,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "PzI_ausf_C"				Pz.Kpfw. I Ausf. C
            { "pzii_j":				{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "PzII_J"				PzKpfw-II-Turm Ausf. J
            { "pziii_a":			{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "PzIII_A"				PzKpfw-III-Turm Ausf. A
            { "pziii_a":			{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "PzIII_A"				PzKpfw-III-Turm Ausf. C
            { "t_15":				{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T-15"				T-15 Turm
            { "m22_locust":			{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "M22_Locust"				M22D1
            { "m3_stuart":			{ "enabled": true,  "distance": 280,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "M3_Stuart"				D37812
            { "m3_stuart":			{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "M3_Stuart"				D39273
            { "mtls_1g14":			{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "MTLS-1G14"				MTLS D1
            { "amx38":				{ "enabled": true,  "distance": 310,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "AMX38"				AMX38
            { "gb59_cruiser_mk_iv":		{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "GB59_Cruiser_Mk_IV"			Cruiser Mk. IV
            { "gb59_cruiser_mk_iv":		{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB59_Cruiser_Mk_IV"			Cruiser Mk. IVA
            { "gb69_cruiser_mk_ii":		{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "GB69_Cruiser_Mk_II"			A10E1
            { "gb69_cruiser_mk_ii":		{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB69_Cruiser_Mk_II"			Cruiser Mk. II
            { "ch08_type97_chi_ha":		{ "enabled": true,  "distance": 310,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "Ch08_Type97_Chi_Ha"			Type 97
            { "ch08_type97_chi_ha":		{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Ch08_Type97_Chi_Ha"			Type 97-Kai
            { "s35_captured":			{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "S35_captured"			Somuaturm
            { "m2_med":				{ "enabled": true,  "distance": 280,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "M2_med"				M2M19
            { "m2_med":				{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "M2_med"				M2M7
            { "d2":				{ "enabled": true,  "distance": 300,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "D2"					D2
            { "d2":				{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "D2"					D2 Bis
            { "gb06_vickers_medium_mk_iii":	{ "enabled": true,  "distance": 310,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "GB06_Vickers_Medium_Mk_III"		Vickers Medium А6Е1
            { "gb06_vickers_medium_mk_iii":	{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB06_Vickers_Medium_Mk_III"		Vickers Medium А6Е3
            { "su_76":				{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "SU-76"				-
            { "g20_marder_ii":			{ "enabled": true,  "distance": 360,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "G20_Marder_II"			-
            { "t82":				{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T82"				-
            { "fcm_36pak40":			{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "FCM_36Pak40"			-
            { "renaultue57":			{ "enabled": true,  "distance": 360,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "RenaultUE57"			-
            { "gb42_valentine_at":		{ "enabled": true,  "distance": 360,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB42_Valentine_AT"			-
            { "su_26":				{ "enabled": true,  "distance": 578,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "SU-26"				СУ-26	(300)*
            { "sturmpanzer_ii":			{ "enabled": true,  "distance": 605,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Sturmpanzer_II"			-	(360)*
            { "wespe":				{ "enabled": true,  "distance": 1000, "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Wespe"				-	(350)*
            { "m37":				{ "enabled": true,  "distance": 969,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "M37"				-	(370)*
            { "sexton_i:":			{ "enabled": true,  "distance": 000,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Sexton_I" },		?	usa pt
            { "lorraine39_l_am":		{ "enabled": true,  "distance": 844,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Lorraine39_L_AM"			-	(350)*

   // level 4
            { "a_20":				{ "enabled": true,  "distance": 300,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "A-20"				А-20 обр. 1938 г.
            { "a_20":				{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "A-20"				А-20 бис
            { "t_50":				{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T-50"				Т-50
            { "t_50":				{ "enabled": true,  "distance": 346.5,  "thickness": 1, "alpha": 40, "color": "0xD042F3" } },	// "T-50"				Т-50 орл.глаз.3%(6,6)+радиоп.3%(9,9)
            { "valentine_ll":			{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Valentine_LL"			Валентайн II
            { "pz38_na":			{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "Pz38_NA"				PzKpfw-38-nA-Standardturm
            { "pz38_na":			{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Pz38_NA"				PzKpfw-38-nA-Turm-Ausf. G
            { "pzii_luchs":			{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "PzII_Luchs"				PzKpfw-IIL-Luchsturm
            { "pzii_luchs":			{ "enabled": true,  "distance": 360,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "PzII_Luchs"				PzKpfw-IIL-Großturm
            { "m5_stuart":			{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "M5_Stuart"				M5A1
            { "m5_stuart":			{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "M5_Stuart"				M8
            { "amx40":				{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "AMX40"				AMX40
            { "amx40":				{ "enabled": true,  "distance": 340,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "AMX40"				Renault-Balland
            { "gb04_valentine":			{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "GB04_Valentine"			Valentine Mk.I
            { "gb04_valentine":			{ "enabled": true,  "distance": 340,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB04_Valentine"			Valentine Mk. XI
            { "gb60_covenanter":		{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "GB60_Covenanter"			Covenanter Mk. I
            { "gb60_covenanter":		{ "enabled": true,  "distance": 340,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB60_Covenanter"			Covenanter Mk. IV CS
            { "ch09_m5":			{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "Ch09_M5"				M3A3
            { "ch09_m5":			{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Ch09_M5"				M5A1
            { "a_32":				{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "A-32"				А-32 обр. 1932 г.
            { "t_28":				{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "T-28"				Т-28 цилиндрическая
            { "t_28":				{ "enabled": true,  "distance": 340,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T-28"				Т-28 коническая
            { "pziii":				{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "PzIII"				PzKpfw-III-Turm Ausf. E
            { "pziii":				{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "PzIII"				PzKpfw-III-Turm Ausf. M
            { "pziii_training:":		{ "enabled": true,  "distance": 000,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "PzIII_training"		?	
            { "m3_grant":			{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "M3_Grant"				-
            { "gb07_matilda":			{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "GB07_Matilda"			Matilda Mk. IIA
            { "gb07_matilda":			{ "enabled": true,  "distance": 340,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB07_Matilda"			Matilda Mk. IIA*
            { "b_1bis_captured":		{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "B-1bis_captured"			B2-740-(f)-Turm
            { "b1":				{ "enabled": true,  "distance": 300,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "B1"					B1a
            { "b1":				{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "B1"					B1b
            { "gaz_74b":			{ "enabled": true,  "distance": 390,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GAZ-74b"				-
            { "hetzer":				{ "enabled": true,  "distance": 260,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Hetzer"				-
            { "m8a1":				{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "M8A1"				M8A1
            { "m8a1":				{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "M8A1"				T87
            { "t40":				{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T40"				-
            { "somua_sau_40":			{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Somua_Sau_40"			-
            { "gb57_alecto":			{ "enabled": true,  "distance": 390,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB57_Alecto"			-
            { "su_5":				{ "enabled": true,  "distance": 605,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "SU-5"				-	(320)*
            { "grille":				{ "enabled": true,  "distance": 1210, "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Grille"				-	(360)*
            { "m7_priest":			{ "enabled": true,  "distance": 1047, "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "M7_Priest"				-	(370)*
            { "_105_lefh18b2":			{ "enabled": true,  "distance": 1000, "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "_105_leFH18B2"			-	(390)*
            { "amx_105am":			{ "enabled": true,  "distance": 1000, "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "AMX_105AM"				-	(360)*

   // level 5
            { "t_50_2":				{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "T_50_2"				Т-50-2
            { "t_50_2":				{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T_50_2"				Т-50-2М
            { "vk1602":				{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "VK1602"				Leopardturm
            { "m24_chaffee":			{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "M24_Chaffee"			T24
            { "m24_chaffee":			{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "M24_Chaffee"			T37
            { "elc_amx":			{ "enabled": true,  "distance": 360,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "ELC_AMX"				ELC AMX
            { "gb20_crusader":			{ "enabled": true,  "distance": 340,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "GB20_Crusader"			Crusader Mk. I
            { "gb20_crusader":			{ "enabled": true,  "distance": 360,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB20_Crusader"			Crusader Mk. III
            { "matilda_ii_ll":			{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Matilda_II_LL"			Матильда IV
            { "t_34":				{ "enabled": true,  "distance": 240,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "T-34"				Т-34 обр. 1940 г.
            { "t_34":				{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T-34"				Т-34 обр. 1942 г.
            { "pziii_iv":			{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "PzIII_IV"				PzKpfw-IV-Turm Ausf. F
            { "pziii_iv":			{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "PzIII_IV"				PzKpfw-IV-Turm Ausf. H
            { "pziv":				{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "PzIV"				Turm Ausf. G
            { "pziv":				{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "PzIV"				Turm Ausf. Н
            { "pziv_hydro":			{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "PzIV_Hydro"				PzKpfw-IV-Turm Ausf. J
            { "t_25":				{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T-25"				T-25 Turm
            { "m4_sherman":			{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "M4_Sherman"				D51066
            { "m4_sherman":			{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "M4_Sherman"				D51072
            { "m4a2e4":				{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "M4A2E4"				M4A2E4D51066
            { "m7_med":				{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "M7_med"				M24A1
            { "m7_med":				{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "M7_med"				M47
            { "ram_ii":				{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Ram-II"				Ram II D1
            { "gb68_matilda_black_prince":	{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB68_Matilda_Black_Prince"		Matilda Black Prince
            { "ch21_t34":			{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "Ch21_T34"				Type T-34
            { "ch21_t34":			{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Ch21_T34"				Type T-34M
            { "churchill_ll":			{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Churchill_LL"			Churchill MK III
            { "kv":				{ "enabled": true,  "distance": 310,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "KV"					КВ-1
            { "kv":				{ "enabled": true,  "distance": 310,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "KV"					КВ-2
            { "kv1":				{ "enabled": true,  "distance": 310,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "KV1"				КВ-1
            { "kv1":				{ "enabled": true,  "distance": 310,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "KV1"				Проект ЧТЗ обр. 1942 г.
            { "kv_220":				{ "enabled": true,  "distance": 310,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "KV-220"				КВ-220
            { "kv_220_action":			{ "enabled": true,  "distance": 310,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "KV-220_action"			КВ-220
            { "t1_hvy":				{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "T1_hvy"				T1D5
            { "t1_hvy":				{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T1_hvy"				T1D6
            { "t14":				{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T14"				T14
            { "bdr_g1b":			{ "enabled": true,  "distance": 300,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "BDR_G1B"				FCMF4
            { "bdr_g1b":			{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "BDR_G1B"				ARL-3
            { "gb08_churchill_i":		{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "GB08_Churchill_I"			Churchill Mk. I
            { "gb08_churchill_i":		{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB08_Churchill_I"			Churchill Mk. III
            { "su_85i":				{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "SU_85I"				-
            { "su_85":				{ "enabled": true,  "distance": 280,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "SU-85"				-
            { "stugiii":			{ "enabled": true,  "distance": 310,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "StuGIII"				-
            { "m10_wolverine":			{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "M10_Wolverine"			M10T72
            { "m10_wolverine":			{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "M10_Wolverine"			M10T72M1
            { "t49":				{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "T49"			?	Rock Island Arsenal
            { "t49":				{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T49"			?	T49M34
            { "s_35ca":				{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "S_35CA"				-
            { "gb73_at2":			{ "enabled": true,  "distance": 310,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB73_AT2"				-
            { "su_8":				{ "enabled": true,  "distance": 920,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "SU-8"				-	(360)*
            { "hummel":				{ "enabled": true,  "distance": 1264, "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Hummel"				-	(370)*
            { "m41":				{ "enabled": true,  "distance": 1210, "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "M41"				-	(370)*
            { "amx_13f3am":			{ "enabled": true,  "distance": 1250, "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "AMX_13F3AM"				-	(370)*

   // level 6

            { "vk2801":				{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "VK2801"				VK-2801-Turm Ausf. A 
            { "vk2801":				{ "enabled": true,  "distance": 390,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "VK2801"				VK-2801-Turm Ausf. F
            { "t21":				{ "enabled": true,  "distance": 390,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T21"				T21
            { "t21":				{ "enabled": true,  "distance": 429,  "thickness": 1, "alpha": 40, "color": "0xD042F3" } },	// "T21"				T21 + просветленка
            { "t21":				{ "enabled": true,  "distance": 468,  "thickness": 1, "alpha": 40, "color": "0xD042F3" } },	// "T21"				T21 + труба
            { "amx_12t":			{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "AMX_12t"				AMX B
            { "ch15_59_16":			{ "enabled": true,  "distance": 360,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "Ch15_59_16"				131
            { "ch15_59_16":			{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Ch15_59_16"				131-1
            { "t_34_85":			{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "T-34-85"				Т-34-85
            { "t_34_85":			{ "enabled": true,  "distance": 360,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T-34-85"				Т-34-85 расширенная
            { "t_34_85_training":		{ "enabled": true,  "distance": 000,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T-34-85_training"		?
            { "pziv_schmalturm":		{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "PzIV_schmalturm"			PzKpfw-IV-Schmalturm
            { "pzv_pziv":			{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "PzV_PzIV"				PzKpfw-IV-Turm
            { "pzv_pziv_ausf_alfa":		{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "PzV_PzIV_ausf_Alfa"			PzKpfw-IV-Turm
            { "vk3001h":			{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "VK3001H"				VK-3001-(H)-Standardturm
            { "vk3001h":			{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "VK3001H"				VK-3001-(H)-Großturm
            { "vk3001p":			{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "VK3001P"				VK-3001-(P)-Krupp-Turm
            { "vk3001p":			{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "VK3001P"				VK-3001-(P)-Porsche-Turm
            { "vk3601h":			{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "VK3601H"				VK-3601-(H)-Standardturm
            { "vk3601h":			{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "VK3601H"				VK-3601-(H)-Großturm
            { "m4a3e8_sherman":			{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "M4A3E8_Sherman"			D51072
            { "m4a3e8_sherman":			{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "M4A3E8_Sherman"			D51080
            { "m4a3e8_sherman_training":	{ "enabled": true,  "distance": 000,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "M4A3E8_Sherman_training"	?
            { "sherman_jumbo":			{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "Sherman_Jumbo"			M4A2E2T110
            { "sherman_jumbo":			{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Sherman_Jumbo"			M4A2E2D51080
            { "gb21_cromwell":			{ "enabled": true,  "distance": 360,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "GB21_Cromwell"			Cromwell Mk. I
            { "gb21_cromwell":			{ "enabled": true,  "distance": 360,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB21_Cromwell"			Cromwell Mk. IV
            { "ch20_type58":			{ "enabled": true,  "distance": 360,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "Ch20_Type58"			T-34-85
            { "ch20_type58":			{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Ch20_Type58"			Type 58
            { "kv_1s":				{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "KV-1s"				КВ-1С обр. 1942 г.
            { "kv_1s":				{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "KV-1s"				КВ-85
            { "kv2":				{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "KV2"				МТ-1
            { "kv2":				{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "KV2"				МТ-2
            { "t150":				{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "T150"				Т-150-КВ
            { "t150":				{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T150"				Т-150-220
            { "m6":				{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "M6"					M6D1
            { "m6":				{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "M6"					M6D2
            { "arl_44":				{ "enabled": true,  "distance": 320,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "ARL_44"				ARL 44 expérimentale
            { "arl_44":				{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "ARL_44"				ARL 44 nouvelle
            { "gb09_churchill_vii":		{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "GB09_Churchill_VII"			Churchill Mk. IV
            { "gb09_churchill_vii":		{ "enabled": true,  "distance": 360,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB09_Churchill_VII"			Churchill Mk. VII 
            { "gb63_tog_ii":			{ "enabled": true,  "distance": 360,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB63_TOG_II"			TOG II
            { "su_100":				{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "SU-100"				-
            { "su100y":				{ "enabled": true,  "distance": 000,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "SU100Y"			?	(не введен в игру)
            { "dickermax":			{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "DickerMax"				-
            { "jagdpziv":			{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "JagdPzIV"				-
            { "m18_hellcat":			{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "M18_Hellcat"			M18 M34A1
            { "m18_hellcat":			{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "M18_Hellcat"			M18 M1
            { "m36_slagger":			{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "M36_Slagger"			M36T74
            { "m36_slagger":			{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "M36_Slagger"			M36T78
            { "arl_v39":			{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "ARL_V39"				-
            { "gb40_gun_carrier_churchill":	{ "enabled": true,  "distance": 340,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB40_Gun_Carrier_Churchill"		-
            { "gb74_at8":			{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB74_AT8"				-
            { "s_51":				{ "enabled": true,  "distance": 1229, "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "S-51"				-	(370)*
            { "su_14":				{ "enabled": true,  "distance": 1229, "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "SU-14"				-	(300)*
            { "g_panther":			{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "G_Panther"				GW-Panther-Aufbau Ausf. A(350)*
            { "g_panther":			{ "enabled": true,  "distance": 1400, "thickness": 1, "alpha": 60, "color": "0xFFFFFF" } },	// "G_Panther"				GW-Panther-Aufbau Ausf. A(350)*
            { "m12":				{ "enabled": true,  "distance": 1316, "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "M12"				-	(380)*
            { "lorraine155_50":			{ "enabled": true,  "distance": 1202, "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Lorraine155_50"			-	(370)*

   // level 7
            { "t71":				{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T71"				T71
            { "amx_13_75":			{ "enabled": true,  "distance": 390,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "AMX_13_75"				FL10
            { "ch02_type62":			{ "enabled": true,  "distance": 390,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Ch02_Type62"			Type 62
            { "ch16_wz_131":			{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "Ch16_WZ_131"			132A
            { "ch16_wz_131":			{ "enabled": true,  "distance": 390,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Ch16_WZ_131"			132B
            { "kv_13": 				{ "enabled": true,  "distance": 340,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "KV-13"				КВ-13
            { "kv_13": 				{ "enabled": true,  "distance": 360,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "KV-13"				КВ-13М
            { "t_43":				{ "enabled": true,  "distance": 360,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "T-43"				Т-43 обр. 1942 г.
            { "t_43":				{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T-43"				Т-43 обр. 1943 г.
            { "panther_m10":			{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Panther_M10"			PzKpfw-V-Turm Ausf. G
            { "pzv":				{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "PzV"				PzKpfw-V-Turm Ausf. G
            { "pzv":				{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "PzV"				PzKpfw-V-Schmalturm
            { "pzv_training":			{ "enabled": true,  "distance": 000,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "PzV_training"		?
            { "vk3002db":			{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "VK3002DB"				VK-3002-(DB)-Turm
            { "vk3002db":			{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "VK3002DB"				VK-3002-(DB)-Schmalturm
            { "t20":				{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "T20"				T20D1
            { "t20":				{ "enabled": true,  "distance": 390,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T20"				T20D2
            { "gb22_comet":			{ "enabled": true,  "distance": 360,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "GB22_Comet"				Cromwell Mk. IV
            { "gb22_comet":			{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB22_Comet"				Comet Mk. I
            { "ch04_t34_1":			{ "enabled": true,  "distance": 360,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "Ch04_T34_1"				T-34-1
            { "ch04_t34_1":			{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Ch04_T34_1"				T-34-1 model 2
            { "ch04_t34_1_training":		{ "enabled": true,  "distance": 000,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Ch04_T34_1_training"	?
            { "is":				{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "IS"					ИС-85
            { "is":				{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "IS"					ИС-122
            { "kv_3":				{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "KV-3"				Образца КВ-220
            { "kv_3":				{ "enabled": true,  "distance": 340,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "KV-3"				КВ-3
            { "pzvi":				{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "PzVI"				PzKpfw-VI-Tiger-I-Turm Ausf.H2
            { "pzvi":				{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "PzVI"				fw-VI-Tiger-I-Porscheturm
            { "pzvi_tiger_p":			{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "PzVI_Tiger_P"			Tiger-(P)-Turm Ausf. A 
            { "pzvi_tiger_p":			{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "PzVI_Tiger_P"			Tiger-(P)-Turm Ausf. F
            { "t29":				{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "T29"				T123
            { "t29":				{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T29"				T136
            { "amx_m4_1945":			{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "AMX_M4_1945"			Schneider 44B
            { "amx_m4_1945":			{ "enabled": true,  "distance": 360,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "AMX_M4_1945"			AMX M4
            { "gb10_black_prince":		{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB10_Black_Prince"			Black Prince
            { "ch10_is2":			{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "Ch10_IS2"				IS-2 early
            { "ch10_is2":			{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Ch10_IS2"				IS-2 late
            { "su100m1":			{ "enabled": true,  "distance": 360,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "SU100M1"				-
            { "su122_44":			{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "SU122_44"				-
            { "su_152":				{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "SU-152"				-
            { "jagdpanther":			{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "JagdPanther"			-
            { "t25_2":				{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T25_2"				T25/2T3
            { "t25_2":				{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T25_2"				T25/2T7
            { "t25_at":				{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T25_AT"				-
            { "amx_ac_mle1946":			{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "AMX_AC_Mle1946"			-
            { "gb71_at_15a":			{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB71_AT_15A"			-
            { "gb75_at7":			{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB75_AT7"				-
            { "object_212":			{ "enabled": true,  "distance": 1229, "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Object_212"				-	(330)*
            { "g_tiger":			{ "enabled": true,  "distance": 1172, "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "G_Tiger"				-	(380)*
            { "m40m43":				{ "enabled": true,  "distance": 1179, "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "M40M43"				-	(390)*
            { "lorraine155_51":			{ "enabled": true,  "distance": 1296, "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Lorraine155_51"			-	(380)*

   // level 8
            { "amx_13_90":			{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "AMX_13_90"				FL12
            { "ch17_wz131_1_wz132":		{ "enabled": true,  "distance": 390,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "Ch17_WZ131_1_WZ132"			WZ-131-1
            { "ch17_wz131_1_wz132":		{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Ch17_WZ131_1_WZ132"			WZ-132
            { "t_44":				{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "T-44"				T-44
            { "t_44":				{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T-44"				T-44Б
            { "panther_ii":			{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "Panther_II"				Panther-II-Turm Ausf. A
            { "panther_ii":			{ "enabled": true,  "distance": 390,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Panther_II"				Panther-II-Schmalturm 
            { "pershing":			{ "enabled": true,  "distance": 390,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "Pershing"				M26M67
            { "pershing":			{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Pershing"				M26M71
            { "t23":				{ "enabled": true,  "distance": 430,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "T23"				T23T80 (баз.)
            { "t23":				{ "enabled": true,  "distance": 430,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T23"				T23D51080
            { "t26_e4_superpershing":		{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T26_E4_SuperPershing"		T26E4
            { "t69":				{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T69"				T178
            { "gb23_centurion":			{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "GB23_Centurion"			Centurion Mk. I
            { "gb23_centurion":			{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB23_Centurion"			Centurion Mk. III
            { "ch01_type59":			{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Ch01_Type59"			Type 59
            { "ch01_type59_gold":		{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Ch01_Type59_Gold"		*	Type 59 G(no russian server)
            { "ch05_t34_2":			{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "Ch05_T34_2"				T-34-2
            { "ch05_t34_2":			{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Ch05_T34_2"				T-34-2 model 2
            { "is_3":				{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "IS-3"				Кировец-1
            { "is_3":				{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "IS-3"				ИС-3
            { "kv4":				{ "enabled": true,  "distance": 330,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "KV4"				КВ-4
            { "kv4":				{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "KV4"				КВ-4-5
            { "kv_5":				{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "KV-5"				КВ-5
            { "object252":			{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Object252"				ИС-6
            { "lowe":				{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Lowe"				Löweturm
            { "pzvib_tiger_ii":			{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "PzVIB_Tiger_II"			PzKpfw-VIB-Porsche-Turm
            { "pzvib_tiger_ii":			{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "PzVIB_Tiger_II"			PzKpfw-VIB-Henschel-Turm
            { "pzvib_tiger_ii_training":	{ "enabled": true,  "distance": 000,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "PzVIB_Tiger_II_training"	?
            { "vk4502a":			{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "VK4502A"				VK-4502-(A)-Turm Ausf. A
            { "vk4502a":			{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "VK4502A"				VK-4502-(A)-Turm Ausf. F
            { "m6a2e1":				{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "M6A2E1"				M6A2E1D4
            { "t32":				{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "T32"				T99E2
            { "t32":				{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T32"				T119
            { "t34_hvy":			{ "enabled": true,  "distance": 360,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T34_hvy"				T34T7
            { "amx_50_100":			{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "AMX_50_100"				AMX 50 100
            { "fcm_50t":			{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "FCM_50t"				FCM 50 t
            { "gb11_caernarvon":		{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "GB11_Caernarvon"			Black Prince
            { "gb11_caernarvon":		{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB11_Caernarvon"			Centurion Mk. II
            { "ch03_wz_111":			{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Ch03_WZ-111"		*	WZ-111 model 2(no russian server)
            { "ch11_110":			{ "enabled": true,  "distance": 350,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "Ch11_110"				110
            { "ch11_110":			{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Ch11_110"				T-10
            { "isu_152":			{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "ISU-152"				-
            { "su_101":				{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "SU-101"				-
            { "ferdinand":			{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Ferdinand"				-
            { "jagdpantherii":			{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "JagdPantherII"			-
            { "jagdtiger_sdkfz_185":		{ "enabled": true,  "distance": 390,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "JagdTiger_SdKfz_185"		-
            { "t28":				{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T28"				-
            { "t28_prototype":			{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T28_Prototype"			T28P D1
            { "amx_ac_mle1948":			{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "AMX_AC_Mle1948"			-
            { "gb72_at15":			{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB72_AT15"				-
            { "object_261":			{ "enabled": true,  "distance": 1463, "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Object_261"				-	(380)*
            { "g_e":				{ "enabled": true,  "distance": 1172, "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "G_E"				-	(390)*
            { "t92":				{ "enabled": true,  "distance": 1248, "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T92"				-	(400)*
            { "bat_chatillon155":		{ "enabled": true,  "distance": 1296, "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Bat_Chatillon155"			Bat Chatillon 155(390)*

   // level 9
            { "t_54":				{ "enabled": true,  "distance": 390,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "T-54"				Т-54 обр. 1946 г.
            { "t_54":				{ "enabled": true,  "distance": 390,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T-54"				Т-54 обр. 1949 г.
            { "e_50":				{ "enabled": true,  "distance": 390,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "E-50"				E-50-Turm Ausf. A
            { "e_50":				{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "E-50"				E-50-Turm Ausf. F
            { "m46_patton":			{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "M46_Patton"				M46M73
            { "m46_patton":			{ "enabled": true,  "distance": 410,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "M46_Patton"				M46T119
            { "t54e1":				{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T54E1"				T157
            { "lorraine40t":			{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Lorraine40t"			Lorraine 40 t
            { "gb24_centurion_mk3":		{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "GB24_Centurion_Mk3"			Centurion Mk. 7
            { "gb24_centurion_mk3":		{ "enabled": true,  "distance": 410,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB24_Centurion_Mk3"			Centurion Mk. 9
            { "ch18_wz_120":			{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "Ch18_WZ-120"			WZ-120
            { "ch18_wz_120":			{ "enabled": true,  "distance": 390,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Ch18_WZ-120"			WZ-120-1
            { "is8":				{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "IS8"				Т-10
            { "is8":				{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "IS8"				Т-10М
            { "st_i":				{ "enabled": true,  "distance": 360,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "ST_I"				СТ-I об.701 №4
            { "st_i":				{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "ST_I"				СТ-I
            { "e_75":				{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "E-75"				E-75-Turm Ausf. A
            { "e_75":				{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "E-75"				E-75-Turm Ausf. F
            { "vk4502p":			{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "VK4502P"				VK-4502-(P)-Standardturm
            { "vk4502p":			{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "VK4502P"				VK-4502-(P)-Eliteturm
            { "m103":				{ "enabled": true,  "distance": 370,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "M103"				M89
            { "m103":				{ "enabled": true,  "distance": 390,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "M103"				T140
            { "amx_50_120":			{ "enabled": true,  "distance": 390,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "AMX_50_120"				AMX 50 Tourelle C
            { "gb12_conqueror":			{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "GB12_Conqueror"			Centurion Mk. III
            { "gb12_conqueror":			{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB12_Conqueror"			Conqueror Mk. II
            { "ch12_111_1_2_3":			{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 30, "color": "0xF50800" } },	// "Ch12_111_1_2_3"			IS-3
            { "ch12_111_1_2_3":			{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Ch12_111_1_2_3"			WZ-111
            { "object_704":			{ "enabled": true,  "distance": 390,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Object_704"				-
            { "su122_54":			{ "enabled": true,  "distance": 390,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "SU122_54"				-
            { "jagdtiger":			{ "enabled": true,  "distance": 390,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "JagdTiger"				-
            { "t30":				{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T30"				T30D1
            { "t95":				{ "enabled": true,  "distance": 380,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T95"				-
            { "amx50_foch":			{ "enabled": true,  "distance": 390,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "AMX50_Foch"				-
            { "gb32_tortoise":			{ "enabled": true,  "distance": 390,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB32_Tortoise"			-

   // level 10

            { "t62a":				{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T62A"				Образца 1959 г.
            { "e50_ausf_m":			{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "E50_Ausf_M"				E-50M-Turm Ausf. F
            { "m48a1":				{ "enabled": true,  "distance": 420,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "M48A1"				M87
            { "bat_chatillon25t":		{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Bat_Chatillon25t"			Bat Chatillon 25 t Tourelle A
            { "gb70_fv4202_105":		{ "enabled": true,  "distance": 410,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB70_FV4202_105"			FV4202
            { "ch19_121":			{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Ch19_121"				121
            { "is_4":				{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "IS-4"				об.701 №5
            { "is_7":				{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "IS-7"				ИС-7
            { "e_100":				{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "E-100"				E-100-Turm Ausf. B
            { "maus":				{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Maus"				Mausturm
            { "t110":				{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T110"				T53
            { "t57_58":				{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T57_58"				T169
            { "f10_amx_50b":			{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "F10_AMX_50B"			AMX 50B
            { "gb13_fv215b":			{ "enabled": true,  "distance": 410,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "GB13_FV215b"			FV215b
            { "ch22_113":			{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Ch22_113"				113
            { "object263":			{ "enabled": true,  "distance": 410,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Object263"				-
            { "object268":			{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "Object268"				-
            { "jagdpz_e100":			{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "JagdPz_E100"			-
            { "t110e3":				{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T110E3"				-
            { "t110e4":				{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "T110E4"				T110E4
            { "amx_50fosh_155":			{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } },	// "AMX_50Fosh_155"			-
            { "gb48_fv215b_183":		{ "enabled": true,  "distance": 400,  "thickness": 1, "alpha": 60, "color": "0x7FDC00" } }	// "GB48_FV215b_183"			-
        ]
    }
}