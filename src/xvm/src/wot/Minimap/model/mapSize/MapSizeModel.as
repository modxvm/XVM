import wot.utils.Config;
import wot.Minimap.model.mapSize.MapSizeBase;

/**
 * Defines real map side size in meters.
 * Common values are 1km, 600m
 * 
 * Localized map name at _root.statsData.arenaData.mapText is used to define map.
 * "Эль-Халлуф" == "El-Halloof"
 * 
 * Did not find any generalized map name at _root flash resources. Working around locale.
 */

class wot.Minimap.model.mapSize.MapSizeModel
{
    private var cellSide:Number;
    
    public function MapSizeModel() 
    {
        /**
         * Read map name previously written by Battleloading.setMapBG(). 
         * Best method to define map size without Python so far.
         */
        cellSide = MapSizeBase.define(Config.s_vars.map_name);
    }
    
    public function getSide():Number
    {
        return cellSide;
    }
}
