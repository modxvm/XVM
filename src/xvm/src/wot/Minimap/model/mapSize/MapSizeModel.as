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

    public function MapSizeModel()
    {
        /**
         * Read map name previously written by Battleloading.setMapBG().
         * Best method to define map size without Python so far.
         * Method does not depend on locale,
         * but depends on xvm-stat.exe presence.
         */
        var mapName:String = Config.s_vars.map_name;
        Logger.add("Minimap: Config.s_vars " + mapName);
        cellSide = sizeBySytemMapName(mapName);
        Logger.add("Minimap: cellSide " + cellSide);

        if (!cellSide)
        {
            Logger.add("Minimap: system map name not set: " + mapName);
            /**
             * Map is not recognized with xvm-stat.exe.
             * Possibly due to xvm-stat.exe absence or new map name with old XVM.
             * Method does not depend on xvm-stat.exe,
             * but depends on localilized map names in Base.
             */
            var mapText:String = _root.statsData.arenaData.mapText;
            cellSide = sizeByLocalizedMapName(mapText);
            Logger.add("Minimap: localized map name: " + mapText);

            if (!cellSide)
            {
                /** This can be seen only for new maps */
                Logger.add("Minimap ERROR: map no recognized");
            }
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
    
    private function sizeBySytemMapName(mapName:String):Number
    {
        return MapInfoData.getData()[mapName.toLowerCase()].size;
    }

    /**
     * Create loop from all system mapnames and compare given value agins arenas.mo mapnames.
     * @param translated mapname
     * @return map size
     */
    private function sizeByLocalizedMapName(localizedMapName:String):Number
    {
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
