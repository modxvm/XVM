import com.xvm.Utils;
import com.xvm.Logger;

/**
 * IconsProxy class
 * provides simple wrapper to Minimap.icons MovieClip
 * which contains clips of tanks, bases and player himself drawed at minimap.
 *
 * @author ilitvinov87@gmail.com
 */

import wot.Minimap.Minimap;
import wot.Minimap.MinimapEntry;

class wot.Minimap.model.externalProxy.IconsProxy
{
    /** Used by SyncModel to calculate unassigned uids for subsequent syncrinization */
    public static function get syncedUids():Array
    {
        var syncedEntries:Array = allSyncedEntries;
        var syncedUids:Array = [];

        var len:Number = syncedEntries.length;
        for (var i = 0; i < len; ++i)
            syncedUids.push(syncedEntries[i].uid);

        return syncedUids;
    }

    /** Used by VehiclePositionTracking to get vehicle positions */
    public static function get allSyncedEntries():Array
    {
        var minimapEntries:Array = _allEntries;
        var assigned:Array = [];

        var len:Number = minimapEntries.length;
        for (var i:Number = 0; i < len; ++i)
        {
            var entry = MinimapEntry(minimapEntries[i]);
            if (entry.uid)
                assigned.push(entry);
        }

        return assigned;
    }

    public static function get allEntries():Array
    {
        return _allEntries;
    }

    /** Used by VehiclePositionTracking to get vehicle positions */
    public static function entry(uid:Number):MinimapEntry
    {
        var minimapEntries:Array = _allEntries;
        var assigned:Array = [];

        var len:Number = minimapEntries.length;
        for (var i:Number = 0; i < len; ++i)
        {
            var entry = MinimapEntry(minimapEntries[i]);
            if (entry.uid == uid)
                return entry;
        }

        return null;
    }

    /** Looks like white arrow */
    public static function get selfEntry():MinimapEntry
    {
        return net.wargaming.ingame.MinimapEntry(_icons.getInstanceAtDepth(Minimap.SELF_ZINDEX)).xvm_worker;
    }

    /** Looks like green highlighted corner */
    public static function get cameraEntry():MinimapEntry
    {
        return net.wargaming.ingame.MinimapEntry(_icons.getInstanceAtDepth(Minimap.CAMERA_NORMAL_ZINDEX)).xvm_worker;
    }

    public static function createEmptyMovieClip(name:String, depth:Number):MovieClip
    {
        return _icons.createEmptyMovieClip(name, depth);
    }

    public static function setOnEnterFrame(func:Function):Void
    {
        _icons.onEnterFrame = func;
    }

    public static function isIconIsPresentAtMinimap(uid:Number):Boolean
    {
        var presentUids:Array = syncedUids;
        for (var i in presentUids)
        {
            if (presentUids[i] == uid)
            {
                return true;
            }
        }

        return false;
    }

    // -- Private

    private static function get _icons():MovieClip
    {
        var ret:MovieClip = _root.minimap.icons;
        if (ret == null)
        {
            Logger.add("## ERROR wot.Minimap.model.externalProxy.IconsProxy: _root.minimap.icons == null");
        }

        return ret;
    }

    public static function get _allEntries():Array
    {
        var children:Array = Utils.getChildrenOf(_icons, false);
        var entries:Array = [];
        var len = children.length;
        for (var i = 0; i < len; ++i)
            entries.push(net.wargaming.ingame.MinimapEntry(children[i]).xvm_worker);
        return entries;
    }
}
