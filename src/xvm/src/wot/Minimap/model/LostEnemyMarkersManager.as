import wot.utils.GlobalEventDispatcher;
import wot.Minimap.MinimapEvent;
import wot.Minimap.MinimapEntry
import wot.Minimap.model.MapConfig;
import wot.Minimap.staticUtils.LostEnemyIconFactory;
import wot.Minimap.staticUtils.LabelAppend;

/**
 * LostEnemyMarkersManager
 * ) appends enemy lost markers at minimap
 * ) removes enemy lost markers when subject is found or dies
 */

class wot.Minimap.model.LostEnemyMarkersManager
{
    private var container:MovieClip;
    private var lostAccounting:Array;
    
    public function LostEnemyMarkersManager(container:MovieClip)
    {
        this.container = container;
        lostAccounting = [];
        
        GlobalEventDispatcher.addEventListener(MinimapEvent.ENEMY_ICON_REMOVE, this, onEnemyIconRemove);
        GlobalEventDispatcher.addEventListener(MinimapEvent.ENEMY_ICON_INIT, this, onEnemyIconInit);
        GlobalEventDispatcher.addEventListener(MinimapEvent.ENEMY_DIES, this, onEnemyDies);
    }
    
    // -- Private
    
    /** IconRemove at Minimap should create lost marker */
    private function onEnemyIconRemove(event:MinimapEvent):Void
    {
        /**
         * Create unit icon.
         * See LostEnemyIconFactory why I chose new MovieClip creation with external images.
         */
        var lostIcon:MovieClip = LostEnemyIconFactory.createIcon(container, event.payload.vehClass, event.payload.x, event.payload.y);
        
        /** Attach text info to icon */
        LabelAppend.append(lostIcon, event.payload.player, MinimapEntry.MINIMAP_ENTRY_TYPE_LOST, MapConfig.losttextOffset);
        
        /** Keep track of marker for proper removal procedure */
        lostAccounting.push( { uid: event.payload.player.uid, mc: lostIcon } );
    }

    /** IconInit at Minimap should remove lost marker. Subject is found. */
    private function onEnemyIconInit(event:MinimapEvent):Void
    {
        removeLostUid(event.payload.uid);
    }

    /** Enemy dead event at PlayersPanel should remove lost marker. Subject is dead. */
    private function onEnemyDies(event:MinimapEvent):Void
    {
        removeLostUid(event.payload.uid);
    }
    
    private function removeLostUid(uid:Number):Void
    {
        var temp:Array = [];
        
        for (var i in lostAccounting)
        {
            if (lostAccounting[i].uid == uid)
            {
                var lostMc:MovieClip = lostAccounting[i].mc;
                lostMc.removeMovieClip();
            }
            else
            {
                /** omit removed */
                temp.push(lostAccounting[i]);
            }
        }
        lostAccounting = temp;
    }
}
