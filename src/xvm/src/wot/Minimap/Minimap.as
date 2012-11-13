/**
 * @author ilitvinov87@gmail.com
 */

import wot.utils.Utils;
import wot.Minimap.MapConfig;

/**
 * Minimap manages all kinds size, border, drawing and clicking.
 * Nothing of interest except icon scaling.
 * Marker scaling adjusts tank and base icon size.
 * 
 * Minimap extends MinimapEntity
 */

class wot.Minimap.Minimap extends net.wargaming.ingame.Minimap
{
    function Minimap()
    {
        super();
        //MARKERS_SCALING = MapConfig.iconScale;
        Utils.TraceXvmModule("Minimap");
    }
}