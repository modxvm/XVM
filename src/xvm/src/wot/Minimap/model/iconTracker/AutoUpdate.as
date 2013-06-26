import com.xvm.GlobalEventDispatcher;
import wot.Minimap.MinimapEvent;
import wot.PlayersPanel.PlayersPanelProxy;
import wot.Minimap.model.iconTracker.PositionTracking;
import wot.Minimap.model.iconTracker.LostPlayers;

/**
 * Minimap icons status tracking by uid.
 * Alive? Dead? Lost?
 */

class wot.Minimap.model.iconTracker.AutoUpdate
{
    private static var TICK_INTERVAL_MS:Number = 300; // 300ms
    private static var SELF_DESTRUCT_TICKS_THRESHOLD:Number = 16 * 60 * 1000; /** Maximum battle duration */

    private var flashTimer;
    private var destructionTimer:Number;

    public function AutoUpdate()
    {
        destructionTimer = 0;
        flashTimer = _global.setInterval(this, "update", TICK_INTERVAL_MS);
    }

    // -- Private

    /** Touched by timer */
    private function update():Void
    {
        timeSelfDestruct();

        // TODO: why is it here? cut out?
        /** Refreshes enemy spotted feature */
        // TODO: translate to Event; move out from Minimap?
        GlobalEventDispatcher.dispatchEvent(new MinimapEvent(MinimapEvent.TICK));
        PlayersPanelProxy.rightPanel.xvm_worker.updateSpotStatusMarkers();
    }

    /** Selfdestruct if timer have not been used for long time */
    private function timeSelfDestruct():Void
    {
        destructionTimer += TICK_INTERVAL_MS;
        if (destructionTimer > SELF_DESTRUCT_TICKS_THRESHOLD)
            _global.clearInterval(flashTimer);
    }
}
