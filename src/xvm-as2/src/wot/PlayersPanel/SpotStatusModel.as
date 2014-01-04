import com.xvm.*;
import wot.Minimap.MinimapEvent;
import wot.Minimap.model.externalProxy.IconsProxy;
import wot.PlayersPanel.PlayersPanelProxy;

/**
 * @author ilitvinov87@gmail.com
 */
class wot.PlayersPanel.SpotStatusModel
{
    public static var DEAD:Number = 0;
    public static var NEVER_SEEN:Number = 1;
    public static var LOST:Number = 2;
    public static var REVEALED:Number = 3;

    private var seen:Array;

    public function SpotStatusModel()
    {
        seen = [];
        GlobalEventDispatcher.addEventListener(MinimapEvent.ENEMY_REVEALED, this, onRevealed)
    }

    public function defineStatus(uid:Number, vehicleState:Number):Number
    {
        //Logger.add("SpotStatusModel.defineStatus()");

        if ((vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_AVIVE) == 0)
            return DEAD;

        if (isRevealedRightNow(uid))
            return REVEALED;

        return wasSeen(uid) ? LOST : NEVER_SEEN;
    }

    public function isArty(uid:Number):Boolean
    {
        //Logger.add("SpotStatusModel.isArty()");
        var info:Object = PlayersPanelProxy.getPlayerInfo(uid); // "../maps/icons/vehicle/contour/ussr-SU-18.png"
        var info2:Object = VehicleInfo.getByIcon(info.icon);
        return info2.vclass == "SPG";
    }

    // -- Private

    private function isRevealedRightNow(subjUid):Boolean
    {
        //Logger.add("SpotStatusModel.isRevealedRightNow()");
        var uids:Array = IconsProxy.syncedUids;
        for (var i in uids)
        {
            if (uids[i] == subjUid)
                return true;
        }
        return false;
    }

    private function onRevealed(mmevent:MinimapEvent)
    {
        //Logger.add("SpotStatusModel.onRevealed()");
        /** Save a guy to revealed enemies list */
        var uid:Number = Number(mmevent.payload);
        seen.push(uid);
    }

    private function wasSeen(uid:Number):Boolean
    {
        //Logger.add("SpotStatusModel.wasSeen()");
        for (var i in seen)
        {
            if (seen[i] == uid)
                return true;
        }
        return false;
    }
}
