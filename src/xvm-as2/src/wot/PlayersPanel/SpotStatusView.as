import com.xvm.*;
import wot.Minimap.*;
import wot.PlayersPanel.*;

/**
 * @author ilitvinov87@gmail.com
 *
 * Handles Enemy Spotted presentation level (View)
 */
class wot.PlayersPanel.SpotStatusView
{
    private static var SPOT_STATUS_TF_NAME:String = "spotStatusTF";
    private static var formatsCache:Object = null;

    private var renderer:PlayerListItemRenderer;
    private var cfg:Object;
    private var spotStatusMarker:TextField;

    public function SpotStatusView(renderer:PlayerListItemRenderer, cfg:Object)
    {
        this.renderer = renderer;
        this.cfg = cfg;

        GlobalEventDispatcher.addEventListener(Defines.E_SPOT_STATUS_UPDATED, this, updateStatus);

        if (formatsCache == null)
        {
            formatsCache = { };
            formatsCache[SpotStatusModel.DEAD] = [ Utils.fixImgTag(cfg.format.dead), Utils.fixImgTag(cfg.format.artillery.dead) ];
            formatsCache[SpotStatusModel.NEVER_SEEN] = [ Utils.fixImgTag(cfg.format.neverSeen), Utils.fixImgTag(cfg.format.artillery.neverSeen) ];
            formatsCache[SpotStatusModel.LOST] = [ Utils.fixImgTag(cfg.format.lost), Utils.fixImgTag(cfg.format.artillery.lost) ];
            formatsCache[SpotStatusModel.REVEALED] = [ Utils.fixImgTag(cfg.format.revealed), Utils.fixImgTag(cfg.format.artillery.revealed) ];
        }

        spotStatusMarker = createMarker(renderer);

        update();
    }

    public function updateStatus(e):Void
    {
        if (renderer.wrapper.data.uid != e.data)
            return;
        //Logger.addObject(e);
        update();
    }

    public function update():Void
    {
        // Define point relative to which marker is set
        // Set every update for correct position in the fog of war mode.
        spotStatusMarker._x = renderer.wrapper.vehicleLevel._x + cfg.Xoffset; // vehicleLevel._x is 8 for example
        spotStatusMarker._y = renderer.wrapper.vehicleLevel._y + cfg.Yoffset; // vehicleLevel._y is -445.05 for example

        var data = renderer.wrapper.data;
        var uid:Number = data.uid;
        var status:Number = SpotStatusModel.defineStatus(uid, data.vehicleState);
        var isArty:Boolean = SpotStatusModel.isArty(uid);

        var txt:String = formatsCache[status][isArty ? 1 : 0];

        var name:String = Utils.GetPlayerName(data.label);

        var obj = Defines.battleStates[name] || { };
        var deadState = ((data.vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_AVIVE) == 0) ? Defines.DEADSTATE_DEAD : Defines.DEADSTATE_ALIVE;
        if (deadState == Defines.DEADSTATE_DEAD && obj.dead == false)
        {
            obj.dead = true;
            if (obj.curHealth > 0)
                obj.curHealth = 0;
        }
        obj.darken = deadState == Defines.DEADSTATE_DEAD;

        txt = Macros.Format(name, txt, obj);
        //Logger.add(txt);
        spotStatusMarker.htmlText = txt;
    }

    // -- Private

    private static function createMarker(renderer:PlayerListItemRenderer):TextField
    {
        var marker:TextField = renderer.wrapper.createTextField(SPOT_STATUS_TF_NAME, renderer.wrapper.getNextHighestDepth(), 0, 0, 100, 25);
        marker.antiAliasType = "advanced";
        marker.selectable = false;
        marker.html = true;
        return marker;
    }
}
