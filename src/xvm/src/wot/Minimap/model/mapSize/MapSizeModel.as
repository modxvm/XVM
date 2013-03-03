import wot.utils.Config;
import wot.Minimap.model.mapSize.MapSizeBase;

/**
 * Defines real map side size in meters.
 * Common values are 1km, 800m
 */

class wot.Minimap.model.mapSize.MapSizeModel
{
    private var cellSide:Number;
    
    public function MapSizeModel() 
    {
        /**
         * Read map name previously written by Battleloading.setMapBG().
         * Best method to define map size without Python so far.
         * Method does not depend on locale,
         * but depends on 
         */
        cellSide = MapSizeBase.sizeBySytemMapName(Config.s_vars.map_name)
        
        if (!cellSide)
        {
            /*
             * Method does not depend on xvm-stat.exe,
             * but depends on localilized map names in Base.
             */
            MapSizeBase.sizeByLocalizedMapName(_root.statsData.arenaData.mapText);
        }
    }
    
    public function getSide():Number
    {
        return cellSide;
    }
}
