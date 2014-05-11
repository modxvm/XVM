/**
 * @author ilitvinov87(at)gmail.com
 * @author m.schedriviy(at)gmail.com
 */
import com.xvm.*;
import wot.Minimap.MinimapEvent;
import wot.Minimap.model.externalProxy.IconsProxy;
import wot.PlayersPanel.PlayersPanelProxy;

class wot.PlayersPanel.SpotStatusModel
{
    public static var DEAD:Number = 0;
    public static var NEVER_SEEN:Number = 1;
    public static var LOST:Number = 2;
    public static var REVEALED:Number = 3;

    public static function defineStatus(uid:Number, vehicleState:Number):Number
    {
        return instance._defineStatus(uid, vehicleState);
    }

    public static function isArty(uid:Number):Boolean
    {
        return instance._isArty(uid);
    }

    // PRIVATE

    private var revealed:Object;
    private var artyCache:Object;

    private static var _instance:SpotStatusModel = null;
    private static function get instance()
    {
        if (_instance == null)
            _instance = new SpotStatusModel();
        return _instance;
    }

    private function SpotStatusModel()
    {
        revealed = { };
        artyCache = { };
        GlobalEventDispatcher.addEventListener(MinimapEvent.ENTRY_REVEALED, this, onRevealed)
        GlobalEventDispatcher.addEventListener(MinimapEvent.ENTRY_LOST, this, onLost)
    }

    private function _defineStatus(uid:Number, vehicleState:Number):Number
    {
        //Logger.add("SpotStatusModel.defineStatus()");

        if ((vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_AVIVE) == 0)
            return DEAD;

        var status = revealed[uid.toString()];
        if (status == null)
            return NEVER_SEEN;

        if (status == true)
            return REVEALED;

        return LOST;
    }

    private function _isArty(uid:Number):Boolean
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

    private function onRevealed(e:MinimapEvent)
    {
        //Logger.add("SpotStatusModel.onRevealed(" + e.value + ")");
        revealed[e.value] = true;
        GlobalEventDispatcher.dispatchEvent( { type: Defines.E_SPOT_STATUS_UPDATED, data: e.value } );
    }

    private function onLost(e:MinimapEvent)
    {
        //Logger.add("SpotStatusModel.onLost(" + e.value + ")");
        revealed[e.value] = false;
        GlobalEventDispatcher.dispatchEvent( { type: Defines.E_SPOT_STATUS_UPDATED, data: e.value } );
    }
}
