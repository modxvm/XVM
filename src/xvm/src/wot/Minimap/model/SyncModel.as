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
    
    /**
     * Temporary behavior alteration switch.
     * Allows original icon highlighting behavior.
     */
    public var syncProcedureInProgress:Boolean;
    
    /** Invoked by Minimap when its ready */
    public function updateIconsExtension():Void
    {
        syncProcedureInProgress = true;
        var unassignedUids:Array = getUnassignedUids();
        for (var i in unassignedUids)
        {
            testUid = unassignedUids[i];
            touchPlayer(unassignedUids[i]);
        }
        syncProcedureInProgress = false;
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
        return Utils.subtractArray(PlayersPanelProxy.getAllUids(), IconsProxy.getSyncedUids());
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