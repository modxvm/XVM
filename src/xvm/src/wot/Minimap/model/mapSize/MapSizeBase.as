import com.xvm.Config;
import com.xvm.Locale;
import com.xvm.Logger;

class wot.Minimap.model.mapSize.MapSizeBase
{
    public static var s_mapname = { };
    private static var _initialized = false;

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
            case "36_fishing_bay":  // Рыбацкая бухта
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
            case "73_asia_korea": // Священная долина
                return 100;
            case "85_winter": // Белогорск-19
                return 100;
            default:
                return undefined;
        }
    }

    public static function sizeByLocalizedMapName(localizedMapName:String):Number
    {
        MapSizeBaseL10NDefaultValues();
        //Logger.add("Locale[mapsizebase]: string: " + localizedMapName + " | value: " +  Locale.s_lang.locale.mapname[localizedMapName] + " | fallback string: " + s_mapname[localizedMapName] );
        return Locale.s_lang.locale.mapname[localizedMapName] || s_mapname[localizedMapName] || localizedMapName ;
    }

    private static function MapSizeBaseL10NDefaultValues() {
        if (_initialized)
            return;
        _initialized = true;
        
        s_mapname["Карелия"]="01_karelia";
        s_mapname["Karelia"]="01_karelia";
        s_mapname["Karelien"]="01_karelia";
        s_mapname["卡累利阿"]="01_karelia";

        s_mapname["Малиновка"]="02_malinovka";
        s_mapname["Malinovka"]="02_malinovka";
        s_mapname["Malinowka"]="02_malinovka";
        s_mapname["马利诺夫卡"]="02_malinovka";

        s_mapname["Провинция"]="03_campania";
        s_mapname["Province"]="03_campania";
        s_mapname["Provinz"]="03_campania";
        s_mapname["坎帕尼亚"]="03_campania";

        s_mapname["Химмельсдорф"]="04_himmelsdorf";
        s_mapname["Himmelsdorf"]="04_himmelsdorf";
        s_mapname["锡默尔斯多夫"]="04_himmelsdorf";

        s_mapname["Прохоровка"]="05_prohorovka";
        s_mapname["Prokhorovka"]="05_prohorovka";
        s_mapname["Prokhorowka"]="05_prohorovka";
        s_mapname["普罗霍洛夫卡"]="05_prohorovka";

        s_mapname["Энск"]="06_ensk";
        s_mapname["Ensk"]="06_ensk";
        s_mapname["安斯克"]="06_ensk";

        s_mapname["Ласвилль"]="07_lakeville";
        s_mapname["Lakeville"]="07_lakeville";
        s_mapname["拉斯威利"]="07_lakeville";

        s_mapname["Руинберг"]="08_ruinberg";
        s_mapname["Ruinberg"]="08_ruinberg";
        s_mapname["鲁别克"]="08_ruinberg";

        s_mapname["Рудники"]="10_hills";
        s_mapname["Mines"]="10_hills";
        s_mapname["Minen"]="10_hills";
        s_mapname["湖边的角逐"]="10_hills";

        s_mapname["Мурованка"]="11_murovanka";
        s_mapname["Murovanka"]="11_murovanka";
        s_mapname["Murowanka"]="11_murovanka";
        s_mapname["穆勒万卡"]="11_murovanka";

        s_mapname["Эрленберг"]="13_erlenberg";
        s_mapname["Erlenberg"]="13_erlenberg";
        s_mapname["埃勒斯堡"]="13_erlenberg";

        s_mapname["Линия Зигфрида"]="14_siegfried_line";
        s_mapname["Siegfried Line"]="14_siegfried_line";
        s_mapname["Siegfriedlinie"]="14_siegfried_line";
        s_mapname["齐格菲防线"]="14_siegfried_line";

        s_mapname["Комарин"]="15_komarin";
        s_mapname["Komarin"]="15_komarin";
        s_mapname["科马林"]="15_komarin";

        s_mapname["Уайдпарк"]="17_munchen";
        s_mapname["Widepark"]="17_munchen";
        s_mapname["Weitpark"]="17_munchen";
        s_mapname["慕尼黑"]="17_munchen";

        s_mapname["Утёс"]="18_cliff";
        s_mapname["Cliff"]="18_cliff";
        s_mapname["Klippe"]="18_cliff";
        s_mapname["海岸争霸"]="18_cliff";

        s_mapname["Монастырь"]="19_monastery";
        s_mapname["Abbey"]="19_monastery";
        s_mapname["Kloster"]="19_monastery";
        s_mapname["小镇争夺战"]="19_monastery"; 

        s_mapname["Топь"] = "22_slough";
        s_mapname["Swamp"] = "22_slough";

        s_mapname["Вестфилд"]="23_westfeld";
        s_mapname["Westfield"]="23_westfeld";
        s_mapname["韦斯特菲尔德"]="23_westfeld";

        s_mapname["Песчаная река"]="28_desert";
        s_mapname["Sand River"]="28_desert";
        s_mapname["Wadi"]="28_desert";
        s_mapname["荒漠小镇"]="28_desert";

        s_mapname["Эль-Халлуф"]="29_el_hallouf";
        s_mapname["El Halluf"]="29_el_hallouf";
        s_mapname["埃里-哈罗夫"]="29_el_hallouf";

        s_mapname["Аэродром"]="31_airfield";
        s_mapname["Airfield"]="31_airfield";
        s_mapname["Flugplatz"]="31_airfield";
        s_mapname["阿拉曼机场"]="31_airfield";

        s_mapname["Фьорды"]="33_fjord";
        s_mapname["Fjords"]="33_fjord";
        s_mapname["Fjorde"]="33_fjord";
        s_mapname["北欧峡湾"]="33_fjord"; 

        s_mapname["Редшир"]="34_redshire";
        s_mapname["Redshire"]="34_redshire";
        s_mapname["斯特拉特福"]="34_redshire";

        s_mapname["Степи"]="35_steppes";
        s_mapname["Steppes"]="35_steppes";
        s_mapname["Steppen"]="35_steppes";
        s_mapname["荒蛮之地"]="35_steppes";

        s_mapname["Рыбацкая бухта"]="36_fishing_bay";
        s_mapname["Fisherman's Bay"]="36_fishing_bay";
        s_mapname["Fischerbucht"]="36_fishing_bay";
        s_mapname["费舍尔湾"]="36_fishing_bay"; 

        s_mapname["Перевал"]="37_caucasus";
        s_mapname["Mountain Pass"]="37_caucasus";
        s_mapname["Bergpass"]="37_caucasus";
        s_mapname["胜利之门"]="37_caucasus"; 

        s_mapname["Заполярье"]="38_mannerheim_line";
        s_mapname["Arctic Region"]="38_mannerheim_line";
        s_mapname["Polargebiet"]="38_mannerheim_line";
        s_mapname["极地冰原"]="38_mannerheim_line";

        s_mapname["Южный берег"]="39_crimea";
        s_mapname["South Coast"]="39_crimea";
        s_mapname["Südküste"]="39_crimea";
        s_mapname["雅尔塔小镇"]="39_crimea";

        s_mapname["Порт"]="42_north_america";
        s_mapname["Port"]="42_north_america";
        s_mapname["Hafen"]="42_north_america";
        s_mapname["钢铁丛林"]="42_north_america"; 

        s_mapname["Лайв Окс"]="44_north_america";
        s_mapname["Live Oaks"]="44_north_america";
        s_mapname["里夫奥克斯"]="44_north_america";

        s_mapname["Хайвей"]="45_north_america";
        s_mapname["Highway"]="45_north_america";
        s_mapname["州际公路"]="45_north_america";

        s_mapname["Тихий берег"]="47_canada_a";
        s_mapname["Serene Coast"]="47_canada_a";
        s_mapname["Küste"]="47_canada_a";
        s_mapname["寂静海岸"]="47_canada_a";

        s_mapname["Хребет Дракона"]="51_asia";
        s_mapname["Dragon Ridge"]="51_asia";
        s_mapname["Drachenkamm"]="51_asia";
        s_mapname["香格里拉"]="51_asia";

        s_mapname["Жемчужная река"]="60_asia_miao";
        s_mapname["Pearl River"]="60_asia_miao";
        s_mapname["Perlenfluss"]="60_asia_miao";

        s_mapname["Священная долина"]="73_asia_korea";
        s_mapname["Sacred Valley"]="73_asia_korea";
        
        s_mapname["Белогорск-19"]="85_winter";
        s_mapname["Belogorsk-19"]="85_winter";
    }
}