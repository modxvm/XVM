import wot.Minimap.dataTypes.Icon;
import wot.Minimap.MinimapEntry;
import wot.utils.GlobalEventDispatcher;
import wot.Minimap.MinimapEvent;
import wot.Minimap.staticUtils.LabelAppend;

class wot.Minimap.LostMarkers
{
    private var markersContainer:MovieClip;
    private var icons:MovieClip;
    
    private var lostMarkersTracking:Array;
    
    public function LostMarkers(icons:MovieClip) 
    {
        this.icons = icons;
        this.markersContainer = icons.createEmptyMovieClip("lostMarkers", icons.getNextHighestDepth());
        GlobalEventDispatcher.addEventListener(MinimapEvent.LOST_PLAYERS_UPDATE, this, onLost);
        lostMarkersTracking = [];
    }
    
    // -- Private
    
    private function onLost(event:MinimapEvent):Void
    {
        /** No optimization needed. Performance is acceptable. */
        removeAllLabels();
        createAllLabels(Array(event.payload)); /** Array of lost players by UnitPositionTracking */
    }
    
    private function removeAllLabels():Void
    {
        for (var i in lostMarkersTracking)
        {
            var tf:TextField = lostMarkersTracking[i];
            tf.removeTextField();
        }
    }
    
    private function createAllLabels(lost:Array):Void
    {
        var scale:Number = 100;
        
        /** Find UIDs that present in lost but are absent in labels */
        for (var i in lost)
        {
            var lostGuy:Icon = lost[i];
            var depth:Number = markersContainer.getNextHighestDepth();
            var marker:MovieClip = markersContainer.createEmptyMovieClip("marker" + depth, depth);
            /** Set lost position */
            marker._x = lostGuy.pos.x;
            marker._y = lostGuy.pos.y;
            /* New TextField is attached to Minimap at this moment */
            var tf:TextField = LabelAppend.append(marker, lostGuy.uid, MinimapEntry.MINIMAP_ENTRY_NAME_LOST, lostGuy.vehicleClass, scale);
            
            /**
             * Pointer to its address is tracked to handle proper remove
             * and to avoid unnecessary new identical TextField creation.
             */
            lostMarkersTracking.push(tf);
        }
    }
}
