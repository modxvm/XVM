import flash.display.BitmapData;
import wot.Minimap.model.mapSize.MapSizeBase;

/**
 * Defines real map size in meters.
 * Common values are 1km^2, 600m^2
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
        cellSide = MapSizeBase.define(_root.statsData.arenaData.mapText);
    }
    
    public function getSide():Number
    {
        return cellSide;
    }
}