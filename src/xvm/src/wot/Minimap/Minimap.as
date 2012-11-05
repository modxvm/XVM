/**
 * @author ilitvinov87@gmail.com
 */

import wot.utils.Logger;

class wot.Minimap.Minimap extends net.wargaming.ingame.Minimap
{
    function Minimap()
    {
        MARKERS_SCALING = 15;
        super();
        Logger.add("Minimap@@@@@@@@@@@@@@@@@   @@");
    }
    
    function configUI()
    {
        super.configUI();
        Logger.add("Minimap@@@@@@@@@@@@@@@   @@@");
    }
}