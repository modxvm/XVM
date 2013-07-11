import com.xvm.Logger;
import com.xvm.Config;
import flash.external.ExternalInterface;
import net.wargaming.managers.Localization;
import wot.Minimap.model.mapSize.MapInfoData;

/**
 * Defines real map side size in meters.
 * Common values are 1km, 800m
 */

class wot.Minimap.model.mapSize.MapSizeModel
{
    private static var _instance:MapSizeModel;
    
    private var cellSide:Number;
    
    public static function get instance():MapSizeModel
    {
        if (!_instance)
        {
            _instance = new MapSizeModel();
        }
        
        return _instance;
    }

    private function MapSizeModel()
    {
        /**
         * Translate map name back to system name.
         * Map must be added in MapInfoData.
         */
        var mapText:String = _root.statsData.arenaData.mapText;
        cellSide = sizeByLocalizedMapName(mapText);
        Logger.add("Minimap: localized map name: " + mapText);

        if (!cellSide)
        {
            /** This can be seen only when map isn't set in MapInfoData */
            Logger.add("Minimap ERROR: map no recognized");
        }
    }

    public function getCellSide():Number
    {
        return cellSide;
    }
    
    public function getFullSide():Number
    {
        return cellSide * 10;
    }
    
    // -- Private

    /**
     * Create loop from all system map names and compare given value agins arenas.mo names.
     * @param translated mapname
     * @return map size
     */
    private function sizeByLocalizedMapName(localizedMapName:String):Number
    {
        /** TODO: is it necessary? (Localization using ExternalInterface) */
        if (!ExternalInterface.available) 
            Logger.add("Minimap: Error - ExternalInterface not ready");
            
        for (var systemMapName:String in MapInfoData.getData()) {
            var tmp:String = Localization.makeString("#arenas:" + systemMapName + "/name", {});
            if (tmp == localizedMapName) {
                return MapInfoData.getData()[systemMapName].size;
            }
        }
        return undefined;
    }
}
