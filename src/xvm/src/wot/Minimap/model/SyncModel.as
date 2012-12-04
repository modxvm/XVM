import wot.utils.Utils;
import wot.Minimap.model.PlayersPanelProxy;
import wot.Minimap.model.IconsProxy;

/**
 * SyncModel class
 * handles tank data syncronization from PlayersPanel to Minimap
 * by means of altered WG event.
 * 
 * @author ilitvinov87@gmail.com
 */

class wot.Minimap.model.SyncModel
{
    /**
     * Testing uid during delegate event lighting cycle stored here.
     * Is set before light delegate event.
     * In case individual icon:MinimapEntry captures light event
     * this var is considered actula uid of icon:MinimapEntry.
     */
    private var testUid:Number;
    
    /** Invoked by Minimap when its ready */
    public function updateIconsExtension():Void
    {
        /**
         * Optimizations are possible to decrease "gfx.io.GameDelegate.call" invocations.
         * But it looks like "gfx.io.GameDelegate.call" has acceptable performance and even
         * assigned\unassigned uid separation is unnecessary.
         * I could have touched all the players all the time without noticable FPS drop.
         * 
         * - Filter ally/type/alive -> much less unassigned to test.
         * 
         * - Exclusion. Only one alive enemy of type heavy in PlayersPanel
         *   means no other alive enemy of type heavy present on Minimap.
         *   Exact match without GameDelegate call.
         * 
         * - With each successful touch getUnassignedUids has to be recalculated
         *   to work with exclusion for its best results.
         *   By other words - remove successfully synced uid from unassignedUids and reevaluate Exclusion..
         */
        
        var unassignedUids:Array = getUnassignedUids();
        for (var i in unassignedUids)
        {
            /**
             * Optimization is possible to decrease "gfx.io.GameDelegate.call" invocations.
             * 
             * - Stop touching if everybody on Minimap is in sync.
             *   Keep count of unsynced icons?
             */
            testUid = unassignedUids[i];
            touchPlayer(unassignedUids[i]);
        }
    }
    
    /** Used at MinimapEntry to define uid if syncronization succeeded */
    public function getTestUid():Number
    {
        return testUid;
    }
    
    // -- Private
    
    /** Defines current unassigned uid-s at Minimaps icons */
    private function getUnassignedUids():Array
    {
        return Utils.subtractArray(PlayersPanelProxy.getAllUids(), IconsProxy.getAssignedUids());
    }
    
    /** Touched players MinimapEntry receives event */
    private function touchPlayer(uid:Number):Void
    {
        /**
         * Delegate call purpose is altered to extend Minimap functionality.
         * Lighting event is used at Minimap to define icon-user relation.
         */
        var player:Object = PlayersPanelProxy.getPlayerInfo(uid);
        gfx.io.GameDelegate.call("minimap.lightPlayer", [player.vehId, true]);
    }
}