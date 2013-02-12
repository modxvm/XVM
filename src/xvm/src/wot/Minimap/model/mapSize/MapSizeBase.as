import wot.utils.Logger;

/**
 * Chineese by adri1
 */

class wot.Minimap.model.mapSize.MapSizeBase
{
    public static function define(mapName:String):Number
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
            default: 
                Logger.add("Minimap ERROR: MapSizeBase mapName not recognized: " + mapName)
                return undefined;
        }
    }
}