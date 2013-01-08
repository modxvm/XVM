
import flash.geom.Point;
import wot.Minimap.dto.Icon;
import wot.Minimap.MinimapEntry;
import wot.utils.GlobalEventDispatcher;
import wot.Minimap.MinimapEvent;
import wot.Minimap.staticUtils.LabelAppend;
import wot.Minimap.model.MapConfig;

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
        /** Find UIDs that present in lost but are absent in labels */
        for (var i in lost)
        {
            /* New TextField is attached to Minimap at this moment */
            var tf:TextField = createLabel(lost[i]);
            tf._alpha = MapConfig.lostEnemyAlpha;
            
            /**
             * Pointer to its address is tracked to handle proper remove
             * and to avoid unnecessary new identical TextField creation.
             */
            lostMarkersTracking.push(tf);
        }
    }
    
    private function createLabel(lost:Icon):TextField
    {
        var pos:Point = lost.pos; /** Major lost label position */
        pos = pos.add(MapConfig.lostEnemyOffset);  /** Minor offset to place label at removed icon position */
        return LabelAppend.append(container, lost.uid, MinimapEntry.MINIMAP_ENTRY_TYPE_LOST, pos, lost.vehicleClass);
    }
}
