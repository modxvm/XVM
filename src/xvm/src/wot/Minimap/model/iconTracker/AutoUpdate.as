import wot.Minimap.model.iconTracker.PositionTracking;
import wot.Minimap.model.iconTracker.LostPlayers;

/**
 * Minimap icon position tracking to show disappeared vehicles last position
 */

class wot.Minimap.model.iconTracker.AutoUpdate
{
    private static var TICK_INTERVAL_MS:Number = 300; // 300ms
    private static var SELF_DESTRUCT_TICKS_THRESHOLD:Number = 16 * 60 * 1000; /** Maximum battle duration */
    
    private var flashTimer;
    private var destructionTimer:Number;
    
    private var lost:LostPlayers;
    
    /**
     * Position tracking array.
     * uid -> minimap coordinates
     * posTrack[1234567] = Point(50, 60)
     */
    private var posTrack:PositionTracking;
    
    public function AutoUpdate() 
    {
        posTrack = new PositionTracking();
        lost = new LostPlayers(posTrack.getArray());
        destructionTimer = 0;
        flashTimer = setInterval(this, "update", TICK_INTERVAL_MS);
    }
    
    // -- Private
    
    /** Touched by timer */
    private function update():Void
    {
        timeSelfDestruct();
        
        posTrack.update();
        
        lost.find();
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
