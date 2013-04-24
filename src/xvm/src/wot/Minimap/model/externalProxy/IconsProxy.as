import com.xvm.Utils;

/**
 * IconsProxy class
 * provides simple wrapper to Minimap.icons MovieClip
 * which contains clips of tanks, bases and player himself drawed at minimap.
 * 
 * @author ilitvinov87@gmail.com
 */

class wot.Minimap.model.externalProxy.IconsProxy
{
    /** Used by SyncModel to calculate unassigned uids for subsequent syncrinization */
    public static function getSyncedUids():Array
    {
        var syncedEntries:Array = getAllSyncedEntries();
        var syncedUids:Array = [];
        
        for (var i in syncedEntries)
            syncedUids.push(syncedEntries[i].uid);
        
        return syncedUids;
    }
    
    /** Used by VehiclePositionTracking to get vehicle positions */
    public static function getAllSyncedEntries():Array
    {
        var minimapEntries:Array = getMinimapEntries();
        var assigned:Array = [];
        
        for (var i:Number = 0; i < minimapEntries.length; i++)
        {
            if (minimapEntries[i].uid)
                assigned.push(minimapEntries[i]);
        }
        
        return assigned;
    }
    
    public static function getAllEntries():Array
    {
        return getMinimapEntries();
    }
    
    /** Used by VehiclePositionTracking to get vehicle positions */
    public static function getEntry(uid:Number):net.wargaming.ingame.MinimapEntry
    {
        var minimapEntries:Array = getMinimapEntries();
        var assigned:Array = [];
        
        for (var i:Number = 0; i < minimapEntries.length; i++)
        {
            if (minimapEntries[i].uid == uid)
                return minimapEntries[i];
        }
        
        return null;
    }
    
    /** Looks like white arrow */
    public static function getSelf():net.wargaming.ingame.MinimapEntry
    {
        var icons:MovieClip = getIcons();
        return net.wargaming.ingame.MinimapEntry(icons.getInstanceAtDepth(wot.Minimap.Minimap.SELF_ZINDEX));
    }
    
    /** Looks like green highlighted corner */
    public static function getCamera():net.wargaming.ingame.MinimapEntry
    {
        var icons:MovieClip = getIcons();
        return net.wargaming.ingame.MinimapEntry(icons.getInstanceAtDepth(wot.Minimap.Minimap.CAMERA_NORMAL_ZINDEX));
    }
    
    public static function getIcons():MovieClip
    {
        return _root.minimap.icons;
    }
    
    // -- Private
    
    private static function getMinimapEntries():Array
    {
        return Utils.getChildrenOf(getIcons(), false);
    }
}
