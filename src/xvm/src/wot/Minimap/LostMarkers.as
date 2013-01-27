import wot.Minimap.dataTypes.Icon;
import wot.Minimap.MinimapEntry;
import wot.utils.GlobalEventDispatcher;
import wot.Minimap.MinimapEvent;
import wot.Minimap.staticUtils.LabelAppend;
import wot.Minimap.model.externalProxy.IconsProxy;

class wot.Minimap.LostMarkers
{
    private var container:MovieClip;
    
    private var lostMarkersTracking:Array;
    
    public function LostMarkers(container:MovieClip) 
    {
        this.container = container; /** Minimap.icons */
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
        /**
         * LostMarkers does not have scaling applied by parent.
         * Applying manually.
         * Should not be in constructor.
         */
        var self:MinimapEntry = IconsProxy.getSelf();
        var scale:Number = self._xscale;
        
        /** Find UIDs that present in lost but are absent in labels */
        for (var i in lost)
        {
            /* New TextField is attached to Minimap at this moment */
            var tf:TextField = createLabel(lost[i], scale);
            
            /**
             * Pointer to its address is tracked to handle proper remove
             * and to avoid unnecessary new identical TextField creation.
             */
            lostMarkersTracking.push(tf);
        }
    }
    
    private function createLabel(lost:Icon, scale:Number):TextField
    {
        return LabelAppend.append(container, lost.uid, MinimapEntry.MINIMAP_ENTRY_NAME_LOST, lost.vehicleClass, scale, lost.pos);
    }
}
