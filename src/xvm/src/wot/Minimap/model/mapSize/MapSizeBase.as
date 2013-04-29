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
            case "Аэродром":
            case "Airfield":
            case "阿拉曼机场":
                return 100;

            case "Уайдпарк":
            case "Widepark":
            case "慕尼黑":
                return 60;

            case "Вестфилд":
            case "Westfield":
            case "韦斯特菲尔德":
                return 100;

            case "Заполярье":
            case "Arctic Region":
            case "极地冰原":
                return 100;

            case "Карелия":
            case "Karelia":
            case "卡累利阿":
                return 100;

            case "Комарин":
            case "Komarin":
            case "科马林":
                return 80;

            case "Лайв Окс":
            case "Live Oaks":
            case "里夫奥克斯":
                return 100;

            case "Ласвилль":
            case "Lakeville":
            case "拉斯威利":
                return 80;

            case "Линия Зигфрида":
            case "Siegfried Line":
            case "齐格菲防线":
                return 100;

            case "Малиновка":
            case "Malinovka":
            case "马利诺夫卡":
                return 100;

            case "Монастырь":
            case "Abbey":
            case "小镇争夺战":
                return 100;

            case "Мурованка":
            case "Murovanka":
            case "穆勒万卡":
                return 80;

            case "Перевал":
            case "Mountain Pass":
            case "胜利之门":
                return 100;

            case "Песчаная река":
            case "Sand River":
            case "荒漠小镇":
                return 100;

            case "Порт":
            case "Port":
            case "钢铁丛林":
                return 83;

            case "Провинция":
            case "Province":
            case "坎帕尼亚":
                return 60;

            case "Прохоровка":
            case "Prokhorovka":
            case "普罗霍洛夫卡":
                return 100;

            case "Редшир":
            case "Redshire":
            case "斯特拉特福":
                return 100;

            case "Рудники":
            case "Mines":
            case "湖边的角逐":
                return 80;

            case "Руинберг":
            case "Ruinberg":
            case "鲁别克":
                return 80;

            case "Рыбацкая бухта":
            case "Fishermans Bay":
            case "费舍尔湾":
                return 100;

            case "Степи":
            case "Steppes":
            case "荒蛮之地":
                return 100;

            case "Тихий берег":
            case "Serene Coast":
            case "寂静海岸":
                return 100;

            case "Топь":
            case "Swamp":
            case "黑暗沼泽":
                return 100;

            case "Утёс":
            case "Cliff":
            case "海岸争霸":
                return 100;

            case "Фьорды":
            case "Fjords":
            case "北欧峡湾":
                return 100;

            case "Хайвей":
            case "Highway":
            case "州际公路":
                return 100;

            case "Химмельсдорф":
            case "Himmelsdorf":
            case "锡默尔斯多夫":
                return 70;

            case "Хребет Дракона":
            case "Dragon Ridge":
            case "香格里拉":
                return 100;

            case "Эль-Халлуф":
            case "El Halluf":
            case "埃里-哈罗夫":
                return 100;

            case "Энск":
            case "Ensk":
            case "安斯克":
                return 60;

            case "Эрленберг":
            case "Erlenberg":
            case "埃勒斯堡":
                return 100;

            case "Южный берег":
            case "South Coast":
            case "雅尔塔小镇":
                return 100;

            case "Жемчужная река":
            case "Pearl River":
                return 100;

            default:
                return undefined;
        }

    }
}