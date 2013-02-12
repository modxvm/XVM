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
            case "airfield":
                return 100;
            case "arctic region":
                return 100; 
            case "cliff":
                return 100; // Утёс
            case "dragon ridge":
                return 100;
            case "el Halluf":
                return 100; 
            case "ensk":
                return 60;
            case "erlenberg":
                return 100; 
            case "fishermans bay":
                return 100; 
            case "fjords":
                return 100; 
            case "highway":
                return 100; 
            case "himmelsdorf":
                return 70; 
            case "karelia":
                return 100; 
            case "komarin":
                return 80; 
            case "lakeville":
                return 80; // Ласвилль 
            case "live oaks":
                return 100; 
            case "malinovka":
                return 100; 
            case "mines":
                return 80; // Рудиник
            case "mountain pass":
                return 100; // Перевал
            case "monastery":
                return 100; // Монастырь 
            case "murovanka":
                return 80; 
            case "port":
                return 83; 
            case "prokhorovka":
                return 100; 
            case "province":
                return 60; 
            case "redshire":
                return 100; 
            case "ruinberg":
                return 80; 
            case "sand river":
                return 100; 
            case "serene coast":
                return 100; // Тихий берег
            case "siegfried line":
                return 100; 
            case "south Coast":
                return 100; 
            case "steppes":
                return 100; // Степи
            case "swamp":
                return 100; // Топь
            case "westfield":
                return 100; 
            case "widepark":
                return 60;      
            default: 
                Logger.add("Minimap ERROR: MapSizeBase mapName not recognized: " + mapName)
                return undefined;
        }
    }
}