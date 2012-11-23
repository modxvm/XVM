import wot.utils.Logger;
import wot.Minimap.MapConfig;

class wot.Minimap.MinimapEntry extends net.wargaming.ingame.MinimapEntry
{
    function setDead(isPermanent)
    {
        /** Does not work. No idea why */
        //Logger.add("- MinimapEntry.setDead(" + MapConfig.isDeadPermanent + ")");
        //MapConfig.isDeadPermanent
        Logger.addObject(_root, "_root", 2);
        super.setDead(MapConfig.isDeadPermanent);
    }
    
    function init(markerType, entryName, vehicleClass, markLabel)
    {
        //Logger.add("- MinimapEntry.init(" + markerType + " " + entryName + " " + vehicleClass + " " + markLabel + ")");
        super.init(markerType, entryName, vehicleClass, markLabel)
    }
    
    function setEntryName(value)
    {
        //Logger.add("- MinimapEntry.setEntryName(" + value + ")");
        super.setEntryName(value);
    }
}