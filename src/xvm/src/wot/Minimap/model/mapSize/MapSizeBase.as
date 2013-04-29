class wot.Minimap.model.mapSize.MapSizeBase
{
    public static function sizeBySytemMapName(mapName:String):Number
    {
        mapName = mapName.toLowerCase();
        switch(mapName)
        {
            case "31_airfield":    // Аэропорт
                return 100;
            case "38_mannerheim_line": // Заполярье
                return 100;
            case "18_cliff": // Утёс
                return 100;
            case "51_asia":   // Хребет дракона
                return 100;
            case "29_el_hallouf": // Халлуф
                return 100;
            case "06_ensk":       // Энас
                return 60;
            case "13_erlenberg":   // Эрленберг
                return 100;
            case "36_fishing_bay":  // Рыбацкая бхута
                return 100;
            case "33_fjord":        // Фьёрды
                return 100;
            case "45_north_america": // Хайвей
                return 100;
            case "04_himmelsdorf":  // Химмельсдорф
                return 70;
            case "01_karelia":  // Карелия
                return 100;
            case "15_komarin": // Комарин
                return 80;
            case "07_lakeville": // Ласвилль
                return 80;
            case "44_north_america": // Лайвокс
                return 100;
            case "02_malinovka":    // Малиновка
                return 100;
            case "10_hills":       // Рудники
                return 80;
            case "37_caucasus":  // Перевал
                return 100;
            case "19_monastery": // Монастырь
                return 100;
            case "11_murovanka": // Мурованка
                return 80;
            case "42_north_america": // Порт
                return 83;
            case "05_prohorovka": // Прохоровка
                return 100;
            case "03_campania":  // Провинция
                return 60;
            case "34_redshire": // Редшир
                return 100;
            case "08_ruinberg": // Руинберг
                return 80;
            case "28_desert":   // Песчанная река
                return 100;
            case "47_canada_a": // Тихий берег
                return 100;
            case "14_siegfried_line": // Зигфрида
                return 100;
            case "39_crimea": // Южный берег
                return 100;
            case "35_steppes": // Степи
                return 100;
            case "23_westfeld": // Вестфилд
                return 100;
            case "17_munchen": // Вайдпарк
                return 60;
            case "60_asia_miao": // Жемчужная река
                return 100;
            default:
                return undefined;
        }
    }

    public static function sizeByLocalizedMapName(localizedMapName:String):Number
    {
        switch(localizedMapName)
        {
            /**
             * Deustch locale by PusteBlumeKuchen
             * http://code.google.com/p/wot-xvm/issues/detail?id=367
             */
            case "Аэродром":
            case "Airfield":
            case "Flugplatz":
            case "阿拉曼机场":
                return sizeBySytemMapName("31_airfield");
 
            case "Уайдпарк":
            case "Widepark":
            case "Weitpark":
            case "慕尼黑":
                return sizeBySytemMapName("17_munchen");
 
            case "Вестфилд":
            case "Westfield":
            case "韦斯特菲尔德":
                return sizeBySytemMapName("23_westfeld");
 
            case "Заполярье":
            case "Arctic Region":
            case "Polargebiet":
            case "极地冰原":
                return sizeBySytemMapName("38_mannerheim_line");
 
            case "Карелия":
            case "Karelia":
            case "Karelien":
            case "卡累利阿":
                return sizeBySytemMapName("01_karelia");
 
            case "Комарин":
            case "Komarin":
            case "科马林":
                return sizeBySytemMapName("15_komarin");
 
            case "Лайв Окс":
            case "Live Oaks":
            case "里夫奥克斯":
                return sizeBySytemMapName("44_north_america");
 
            case "Ласвилль":
            case "Lakeville":
            case "拉斯威利":
                return sizeBySytemMapName("07_lakeville");
 
            case "Линия Зигфрида":
            case "Siegfried Line":
            case "Siegfriedlinie":
            case "齐格菲防线":
                return sizeBySytemMapName("14_siegfried_line");
 
            case "Малиновка":
            case "Malinovka":
            case "Malinowka":
            case "马利诺夫卡":
                return sizeBySytemMapName("02_malinovka");
 
            case "Монастырь":
            case "Abbey":
            case "Kloster":
            case "小镇争夺战":
                return sizeBySytemMapName("19_monastery");
 
            case "Мурованка":
            case "Murovanka":
            case "Murowanka":
            case "穆勒万卡":
                return sizeBySytemMapName("11_murovanka");
 
            case "Перевал":
            case "Mountain Pass":
            case "Bergpass":
            case "胜利之门":
                return sizeBySytemMapName("37_caucasus");
 
            case "Песчаная река":
            case "Sand River":
            case "Wadi":
            case "荒漠小镇":
                return sizeBySytemMapName("28_desert");
 
            case "Порт":
            case "Port":
            case "Hafen":
            case "钢铁丛林":
                return sizeBySytemMapName("42_north_america");
 
            case "Провинция":
            case "Province":
            case "Provinz":
            case "坎帕尼亚":
                return sizeBySytemMapName("03_campania");
 
            case "Прохоровка":
            case "Prokhorovka":
            case "Prokhorowka":
            case "普罗霍洛夫卡":
                return sizeBySytemMapName("05_prohorovka");
 
            case "Редшир":
            case "Redshire":
            case "斯特拉特福":
                return sizeBySytemMapName("34_redshire");
 
            case "Рудники":
            case "Mines":
            case "Minen":
            case "湖边的角逐":
                return sizeBySytemMapName("10_hills");
 
            case "Руинберг":
            case "Ruinberg":
            case "鲁别克":
                return sizeBySytemMapName("08_ruinberg");
 
            case "Рыбацкая бухта":
            case "Fisherman's Bay":
            case "Fischerbucht":
            case "费舍尔湾":
                return sizeBySytemMapName("36_fishing_bay");
 
            case "Степи":
            case "Steppes":
            case "Steppen":
            case "荒蛮之地":
                return sizeBySytemMapName("35_steppes");
 
            case "Тихий берег":
            case "Serene Coast":
            case "Küste":
            case "寂静海岸":
                return sizeBySytemMapName("47_canada_a");
 
            case "Утёс":
            case "Cliff":
            case "Klippe":
            case "海岸争霸":
                return sizeBySytemMapName("18_cliff");
 
            case "Фьорды":
            case "Fjords":
            case "Fjorde":
            case "北欧峡湾":
                return sizeBySytemMapName("33_fjord");
 
            case "Хайвей":
            case "Highway":
            case "州际公路":
                return sizeBySytemMapName("45_north_america");
 
            case "Химмельсдорф":
            case "Himmelsdorf":
            case "锡默尔斯多夫":
                return sizeBySytemMapName("04_himmelsdorf");
 
            case "Хребет Дракона":
            case "Dragon Ridge":
            case "Drachenkamm":
            case "香格里拉":
                return sizeBySytemMapName("51_asia");
 
            case "Эль-Халлуф":
            case "El Halluf":
            case "埃里-哈罗夫":
                return sizeBySytemMapName("29_el_hallouf");
 
            case "Энск":
            case "Ensk":
            case "安斯克":
                return sizeBySytemMapName("06_ensk");
 
            case "Эрленберг":
            case "Erlenberg":
            case "埃勒斯堡":
                return sizeBySytemMapName("13_erlenberg");
 
            case "Южный берег":
            case "South Coast":
            case "Südküste":
            case "雅尔塔小镇":
                return sizeBySytemMapName("39_crimea");
 
            case "Жемчужная река":
            case "Pearl River":
            case "Perlenfluss":
                return sizeBySytemMapName("60_asia_miao")

            default:
                return undefined;
        }

    }
}