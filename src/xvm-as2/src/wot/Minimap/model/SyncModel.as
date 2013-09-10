import com.xvm.Logger;
import com.xvm.Utils;
import wot.PlayersPanel.PlayersPanelProxy;
import wot.Minimap.model.externalProxy.IconsProxy;
import wot.Minimap.model.externalProxy.MapConfig;

/**
 * SyncModel class
 * handles tank data syncronization from PlayersPanel to Minimap
 * by means of altered WG event.
 *
 * @author ilitvinov87@gmail.com
 */

class wot.Minimap.model.SyncModel
{
    private static var _instance:SyncModel;
    
    /**
     * Temporary behavior alteration switch.
     * Allows original icon highlighting behavior.
     */
    public var isSyncProcedureInProgress:Boolean;
    
    /**
     * Testing uid during delegate event lighting cycle stored here.
     * Is set before light delegate event.
     * In case individual icon:MinimapEntry captures light event
     * this var is considered actula uid of icon:MinimapEntry.
     */
    private var testUid:Number;
    
    public function SyncModel()
    {
        updateIconUids();
    }
    
    public static function get instance():SyncModel
    {
        if (!_instance && MapConfig.enabled)
        {
            _instance = new SyncModel();
        }
        
        return _instance;
    }

    /** Invoked by Minimap when its ready */
    public function updateIconUids():Void
    {
        isSyncProcedureInProgress = true;
        var unassignedUids:Array = getUnassignedUids();
        for (var i in unassignedUids)
        {
            testUid = unassignedUids[i];
            touchPlayer(unassignedUids[i]);
        }
        isSyncProcedureInProgress = false;
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
        return Utils.subtractArray(PlayersPanelProxy.allUids, IconsProxy.syncedUids);
    }

    /** Touched players MinimapEntry receives event */
    private function touchPlayer(uid:Number):Void
    {
        /**
         * Delegate call purpose is altered to extend Minimap functionality.
         * Lighting event is used at Minimap to define icon-user relation.
         */
        var player:Object = PlayersPanelProxy.getPlayerInfo(uid);
        gfx.io.GameDelegate.call("minimap.lightPlayer", [player.vehId, false]);
    }
}