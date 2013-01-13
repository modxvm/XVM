import wot.utils.Utils;
import wot.Minimap.MinimapEntry;

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
    
    /** Used by VehiclePositionTracking to get vehicle positions */
    public static function getEntry(uid:Number):MinimapEntry
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
    public static function getSelf():MinimapEntry
    {
        var minimapEntries:Array = getMinimapEntries();
        
        for (var i:Number = 0; i < minimapEntries.length; i++)
        {
            if (minimapEntries[i].selfIcon)
                return minimapEntries[i]; /** Looks like it is always the first one */
        }
        
        return null;
    }
    
    /** Looks like green highlighted corner */
    public static function getCamera():MinimapEntry
    {
        var minimapEntries:Array = getMinimapEntries();
        
        for (var i:Number = 0; i < minimapEntries.length; i++)
        {
            var entry:MinimapEntry = minimapEntries[i];
            
            /**
             * Camera does not have any distinguishable fields.
             * But other minimap entries have.
             * Find by exclusion method.
             */
            if (entry.m_type != "ally" && !entry.selfIcon && !entry.teamPoint)
            {
                return entry;
            }
        }
        
        return null;
    }
    
    // -- Private
    
    private static function getMinimapEntries():Array
    {
        return Utils.getChildrenOf(_root.minimap.icons, false)
    }
}