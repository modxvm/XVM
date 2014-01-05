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

    private var seen:Object;
    private var artyCache:Object;

    public function SpotStatusModel()
    {
        seen = { };
        artyCache = { };
        GlobalEventDispatcher.addEventListener(MinimapEvent.ENEMY_REVEALED, this, onRevealed)
    }

    public function defineStatus(uid:Number, vehicleState:Number):Number
    {
        //Logger.add("SpotStatusModel.defineStatus()");

        if ((vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_AVIVE) == 0)
            return DEAD;

        if (isRevealedRightNow(uid))
            return REVEALED;

        if (seen.hasOwnProperty(uid.toString()))
            return LOST;

        return NEVER_SEEN;
    }

    public function isArty(uid:Number):Boolean
    {
        //Logger.add("SpotStatusModel.isArty()");

        var uid_str:String = uid.toString();
        if (!artyCache.hasOwnProperty(uid_str))
        {
            var info:Object = PlayersPanelProxy.getPlayerInfo(uid); // "../maps/icons/vehicle/contour/ussr-SU-18.png"
            if (info == null)
                return false;
            var info2:Object = VehicleInfo.getByIcon(info.icon);
            if (info2 == null)
                return false;
            artyCache[uid_str] = info2.vclass == "SPG";
        }

        return artyCache[uid_str];
    }

    // -- Private

    private function isRevealedRightNow(subjUid):Boolean
    {
        //Logger.add("SpotStatusModel.isRevealedRightNow()");
        var uids:Array = IconsProxy.syncedUids;
        var len:Number = uids.length;
        for (var i:Number = 0; i < len; ++i)
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
        seen[mmevent.payload] = true;
    }
}
