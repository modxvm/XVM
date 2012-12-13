import wot.utils.Utils;

/**
 * IconsProxy class
 * provides simple wrapper to Minimap.icons MovieClip
 * which contains clips of tanks, bases and player himself drawed at minimap.
 * 
 * @author ilitvinov87@gmail.com
 */

class wot.Minimap.model.IconsProxy
{
    /** Used by SyncModel to calculate unassigned uids for subsequent syncrinization */
    public static function getSyncedUids():Array
    {
        var syncedEntries:Array = getSyncedEntries();
        var syncedUids:Array = [];
        
        for (var i in syncedEntries)
            syncedUids.push(syncedEntries[i].uid);
        
        return syncedUids;
    }
    
    /** Used by VehiclePositionTracking to get vehicle positions */
    public static function getSyncedEntries():Array
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
    
    // -- Private
    
    private static function getMinimapEntries():Array
    {
        return Utils.getChildrenOf(_root.minimap.icons, false)
    }
}