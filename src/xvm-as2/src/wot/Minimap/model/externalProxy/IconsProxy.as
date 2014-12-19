/**
 * IconsProxy class
 * provides simple wrapper to Minimap.icons MovieClip
 * which contains clips of tanks, bases and player himself drawed at minimap.
 *
 * @author ilitvinov87(at)gmail.com
 * @author m.schedriviy(at)gmail.com
 */

import com.xvm.*;
import wot.Minimap.*;

class wot.Minimap.model.externalProxy.IconsProxy
{
    public static function get allEntries():Array
    {
        return _allEntries;
    }

    /** Used by VehiclePositionTracking to get vehicle positions */
    public static function entry(playerId:Number):MinimapEntry
    {
        var minimapEntries:Array = _allEntries;

        var len:Number = minimapEntries.length;
        for (var i:Number = 0; i < len; ++i)
        {
            var entry = MinimapEntry(minimapEntries[i]);
            if (entry.playerId == playerId)
                return entry;
        }

        return null;
    }

    /** Looks like white arrow */
    public static function get selfEntry():MinimapEntry
    {
        return net.wargaming.ingame.MinimapEntry(_icons.getInstanceAtDepth(MinimapConstants.SELF_ZINDEX)).xvm_worker;
    }

    /** Looks like green highlighted corner */
    public static function get cameraEntry():MinimapEntry
    {
        return net.wargaming.ingame.MinimapEntry(_icons.getInstanceAtDepth(MinimapConstants.CAMERA_NORMAL_ZINDEX)).xvm_worker;
    }

    public static function createEmptyMovieClip(name:String, depth:Number):MovieClip
    {
        return _icons.createEmptyMovieClip(name, depth);
    }

    public static function setOnEnterFrame(func:Function):Void
    {
        _icons.onEnterFrame = func;
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
