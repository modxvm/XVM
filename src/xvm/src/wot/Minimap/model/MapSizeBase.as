import wot.utils.Logger;

class wot.Minimap.model.MapSizeBase
{
    public static function define(localizedMapName:String):Number
    {
        switch(localizedMapName)
        {
            case "Аэродром":
                return 80;
            case "Airfield":
                return 80;
                
            case "Вайдпарк":
                return 60; 
            case "Widepark":
                return 60;     
                
            case "Вестфилд":
                return 100; 
            case "Westfield":
                return 100; 
                
            case "Заполярье":
                return 100; 
            case "Arctic Region":
                return 100; 
                
            case "Карелия":
                return 100; 
            case "Karelia":
                return 100; 
                
            case "Комарин":
                return 80; 
            case "Komarin":
                return 80; 
                
            case "Лайв Окс":
                return 100; 
            case "Live Oaks":
                return 100; 
                
            case "Ласвилль":
                return 80; 
            case "Lakeville":
                return 80; 
                
            case "Линия Зигфрида":
                return 100; 
            case "Siegfried Line":
                return 100; 
                
            case "Малиновка":
                return 100; 
            case "Malinovka":
                return 100; 
                
            case "Монастырь":
                return 100; 
            case "Abbey":
                return 100; 
                
            case "Мурованка":
                return 80; 
            case "Murovanka":
                return 80; 
                
            case "Перевал":
                return 100; 
            case "Mountain Pass":
                return 100; 
                
            case "Песчаная река":
                return 100; 
            case "Sand River":
                return 100; 
                
            case "Порт":
                return 83; 
            case "Port":
                return 83; 
                
            case "Провинция":
                return 60; 
            case "Province":
                return 60; 
                
            case "Прохоровка":
                return 100; 
            case "Prokhorovka":
                return 100; 
                
            case "Редшир":
                return 100; 
            case "Redshire":
                return 100; 
                
            case "Рудники":
                return 80; 
            case "Mines":
                return 80; 
               
            case "Руинберг":
                return 80; 
            case "Ruinberg":
                return 80; 
                
            case "Рыбацкая бухта":
                return 100; 
            case "Fishermans Bay":
                return 100; 
                
            case "Степи":
                return 100; 
            case "Steppes":
                return 100; 
                
            case "Тихий берег":
                return 100; 
            case "Serene Coast":
                return 100; 
                
            case "Топь":
                return 100; 
            case "Swamp":
                return 100; 
                
            case "Утёс":
                return 100; 
            case "Cliff":
                return 100; 
                
            case "Фьорды":
                return 85; 
            case "Fjords":
                return 85; 
                
            case "Хайвэй":
                return 85; 
            case "Highway":
                return 85; 
                
            case "Химмельсдорф":
                return 70; 
            case "Himmelsdorf":
                return 70; 
                
            case "Хребет Дракона":
                return 100; 
            case "Dragon Ridge":
                return 100;
                
            case "Эль-Халлуф":
                return 100; 
            case "El Halluf":
                return 100; 
                
            case "Энск":
                return 60;
            case "Ensk":
                return 60;
                
            case "Эрленберг":
                return 100; 
            case "Erlenberg":
                return 100; 
                
            case "Южный берег":
                return 100; 
            case "South Coast":
                return 100; 
            
            default: 
                Logger.add("Minimap ERROR: MapSize.localizedMapName not recognized: " + localizedMapName)
                return undefined;
        }
    }
}