/**
 * IconsProxy class
 * provides simple wrapper to Minimap.icons MovieClip
 * which contains clips of tanks, bases and player himself drawed at minimap.
 *
 * @author ilitvinov87(at)gmail.com
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */

import com.xvm.*;

class wot.Minimap.model.externalProxy.IconsProxy
{
    public static var playerIds:Object = {}

    public static function get allEntries():Array
    {
        return _allEntries;
    }

    /** Used by VehiclePositionTracking to get vehicle positions */
    public static function entry(playerId:Number):net.wargaming.ingame.MinimapEntry
    {
        var minimapEntries:Array = _allEntries;

        var len:Number = minimapEntries.length;
        for (var i:Number = 0; i < len; ++i)
        {
            var entry = net.wargaming.ingame.MinimapEntry(minimapEntries[i]);
            if (entry.xvm_worker.playerId == playerId)
                return entry;
        }

        return null;
    }

    // Looks like white arrow
    public static function get selfEntry():net.wargaming.ingame.MinimapEntry
    {
        return net.wargaming.ingame.MinimapEntry(_icons.getInstanceAtDepth(wot.Minimap.MinimapConstants.SELF_ZINDEX));
    }

    // Looks like green highlighted corner
    public static function get cameraEntry():net.wargaming.ingame.MinimapEntry
    {
        return net.wargaming.ingame.MinimapEntry(_icons.getInstanceAtDepth(wot.Minimap.MinimapConstants.CAMERA_NORMAL_ZINDEX));
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
            entries.push(net.wargaming.ingame.MinimapEntry(children[i]));
        return entries;
    }
}
