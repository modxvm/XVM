import wot.Minimap.MinimapEvent;
import wot.utils.GlobalEventDispatcher;
import wot.Minimap.dataTypes.Icon;
import wot.Minimap.MinimapEntry;
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
        var entries:Array = IconsProxy.getSyncedEntries();
        /** entry is MinimapEntry */
        for (var i in entries)
        {
            var entry:MinimapEntry = entries[i];
            
            /** We dont need to track allied units. Omit. */
            if (entry.entryName != "enemy")
                continue;
                
            /** Check if already exist -> update track position */
            var exist:Boolean = false;
            for (var j in posTrack)
            {
                var track:Icon = posTrack[j];
                
                if (entry.uid == track.uid)
                {
                    exist = true;
                    
                    track.pos.x = entry._x;
                    track.pos.y = entry._y;

                    break;
                }
            }
            
            if (!exist)
            {
                /** Does not exist -> guy revealed first time */
                
                /** Track this guy position for LostMarkers */
                posTrack.push(new Icon(entry.uid, entry._x, entry._y, entry.vehicleClass));
                
                /** Inform PlayersPanel about this first time seen guy */
                var event:MinimapEvent = new MinimapEvent(MinimapEvent.ENEMY_REVEALED, entry.uid);
                GlobalEventDispatcher.dispatchEvent(event);
            }
        }
    }
    
    public function getArray():Array
    {
        return posTrack;
    }
}
