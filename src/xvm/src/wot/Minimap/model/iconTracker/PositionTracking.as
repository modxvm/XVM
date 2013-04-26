import com.xvm.GlobalEventDispatcher;
import wot.Minimap.MinimapEntry;
import wot.Minimap.MinimapEvent;
import wot.Minimap.dataTypes.Icon;
import wot.Minimap.model.externalProxy.IconsProxy;

class wot.Minimap.model.iconTracker.PositionTracking
{
    /**
     * Store curretly drawn enemy units position.
     * Later can be used to show last position enemy unit has been seen.
     */

    private var posTrack:Array; /** Of Icon */

    public function PositionTracking()
    {
        posTrack = [];
    }

    public function update():Void
    {
        var entries:Array = IconsProxy.allSyncedEntries;
        /** entry is MinimapEntry */
        var len:Number = entries.length;
        for (var i:Number = 0; i < len; ++i)
        {
            var entry:MinimapEntry = entries[i];

            if (entry.wrapper.entryName != "enemy")
                continue;

            if (trackThisOne(entry))
            {
                rememberLost(entry);
                informPlayersPanel(entry.uid);
            }
        }
    }

    // -- Private

    private function rememberLost(entry:MinimapEntry):Void
    {
        posTrack.push(new Icon(entry.uid, entry.wrapper._x, entry.wrapper._y, entry.wrapper.vehicleClass));
    }

    private function informPlayersPanel(uid:Number):Void
    {
        GlobalEventDispatcher.dispatchEvent(new MinimapEvent(MinimapEvent.ENEMY_REVEALED, uid));
    }

    private function trackThisOne(entry:MinimapEntry):Boolean
    {
        var firstTimeSeen:Boolean = true;

        for (var j in posTrack)
        {
            var track:Icon = posTrack[j];

            if (entry.uid == track.uid)
            {
                firstTimeSeen = false;
                track.pos.x = entry.wrapper._x;
                track.pos.y = entry.wrapper._y;
                break;
            }
        }

        return firstTimeSeen;
    }

    public function getArray():Array
    {
        return posTrack;
    }
}
