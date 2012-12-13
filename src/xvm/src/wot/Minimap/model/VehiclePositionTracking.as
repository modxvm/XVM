import wot.utils.Logger;
import wot.Minimap.MinimapEvent;
import wot.utils.GlobalEventDispatcher;
import wot.Minimap.model.IconsProxy;
import wot.Minimap.model.PlayersPanelProxy;
import wot.utils.Utils;

/**
 * Minimap icon position tracking to show disappeared vehicles last position
 */

class wot.Minimap.model.VehiclePositionTracking
{
    private static var TICK_INTERVAL_MS:Number = 300; // 500ms
    private static var SELF_DESTRUCT_TICKS_THRESHOLD:Number = 16 * 60 * 1000;
    
    private var flashTimer;
    private var destructionTimer:Number;
    
    /** Keep track of previously lost players to avoid unnecessary event dispatch */
    private var lostPrev:Array;
    
    /**
     * Position tracking array.
     * posTrack[1234567] = Point(50, 60)
     */
    private var posTrack:Array;
    
    public function VehiclePositionTracking() 
    {
        posTrack = [];
        destructionTimer = 0;
        flashTimer = setInterval(this, "tick", TICK_INTERVAL_MS);
    }
    
    // -- Private
    
    private function tick():Void
    {
        timeSelfDestruct();
        
        updatePositions();
        
        findLostPlayers();
    }
    
    /**
     * Store curretly drawn vehicles position.
     * Later is used as last seen position.
     */
    private function updatePositions():Void
    {
        var entries:Array = IconsProxy.getSyncedEntries();
        /** entry is MinimapEntry */
        for (var i in entries)
        {
            /** We dont need to track allied units. Omit. */
            if (entries[i].entryName != "enemy")
                continue;
                
            /** Check if already exist -> update track position */
            var exist:Boolean = false;
            for (var j in posTrack)
            {
                if (entries[i].uid == posTrack[j].uid)
                {
                    exist = true;
                    
                    posTrack[j].x = entries[i]._x;
                    posTrack[j].y = entries[i]._y;

                    break;
                }
            }
            
            if (!exist)
            {
                /** Does not exist -> new track */
                posTrack.push({
                        uid: entries[i].uid, x: entries[i]._x, y: entries[i]._y,
                        entryName: entries[i].entryName});
            }
        }
    }
    
    /**
     * Players seen atleast once but lost out of sight.
     * Theese are the candidates to mark last position at map.
     */
    private function findLostPlayers():Void
    {
        /** All the vehicles not present at minimap */
        var hiddenUids = Utils.subtractArray(PlayersPanelProxy.getAllUids(), IconsProxy.getSyncedUids());
        
        var lost:Array = [];
        /** Lost player are the players that has position tracked and are hidden on minimap*/
        
        // This loops is extreme heavyweight 
        // TODO: optimize
        for (var i in hiddenUids)
        {
            var uid:Number = hiddenUids[i];
            
            for (var j in posTrack)
            {
                if (posTrack[j].uid == uid) /** If this hidden uid is tracked */
                {
                    lost.push(posTrack[j]); /** This guy is lost! */
                    break;
                }
            }
        }
        
        lost = filterDead(lost);
        
        /** Keep track of previously lost players to avoid unnecessary event dispatch */
        if (lostPrev == undefined)
            lostPrev = lost;
            
        if (lostPrev.toString() != lost.toString())
        {
            lostPrev = lost;
            GlobalEventDispatcher.dispatchEvent(new MinimapEvent(MinimapEvent.LOST_PLAYERS_UPDATE, lost));
        }
    }
    
    /** We do not need to count dead players as lost on minimap */
    private function filterDead(all:Array):Array
    {
        var alive:Array = [];
        for (var i in all)
        {
            if (!PlayersPanelProxy.isDead(all[i].uid))
                alive.push(all[i]);
        }
        
        return alive;
    }
    
    /** Selfdestruct if timer have not been used for long time */
    private function timeSelfDestruct():Void
    {
        // TODO: check minimap existence
        destructionTimer += TICK_INTERVAL_MS;
        if (destructionTimer > SELF_DESTRUCT_TICKS_THRESHOLD)
            clearInterval(flashTimer);
    }
}