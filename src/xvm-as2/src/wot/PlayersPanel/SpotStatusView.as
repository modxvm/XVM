import com.xvm.Config;
import com.xvm.Utils;
import wot.PlayersPanel.PlayerListItemRenderer;
import wot.PlayersPanel.SpotStatusModel;

/**
 * @author ilitvinov87@gmail.com
 *
 * Handles Enemy Spotted presentation level (View)
 */
class wot.PlayersPanel.SpotStatusView
{
    private static var SPOT_STATUS_TF_NAME:String = "spotStatusTF";

    private var renderer:PlayerListItemRenderer;
    private var cfg:Object;
    private var formatsCache:Object;
    private var spotStatusMarker:TextField;
    private var lastText:String;

    public function SpotStatusView(renderer:PlayerListItemRenderer)
    {
        this.renderer = renderer;
        cfg = null;
        spotStatusMarker = createMarker(renderer);
        lastText = "";
    }

    public function update(status:Number, isArty:Boolean):Void
    {
        if (!Config.s_loaded)
            return;

        if (cfg == null)
        {
            cfg = Config.s_config.playersPanel.enemySpottedMarker;

            formatsCache = { };
            formatsCache[SpotStatusModel.DEAD] = [ Utils.fixImgTag(cfg.format.dead), Utils.fixImgTag(cfg.format.artillery.dead) ];
            formatsCache[SpotStatusModel.NEVER_SEEN] = [ Utils.fixImgTag(cfg.format.neverSeen), Utils.fixImgTag(cfg.format.artillery.neverSeen) ];
            formatsCache[SpotStatusModel.LOST] = [ Utils.fixImgTag(cfg.format.lost), Utils.fixImgTag(cfg.format.artillery.lost) ];
            formatsCache[SpotStatusModel.REVEALED] = [ Utils.fixImgTag(cfg.format.revealed), Utils.fixImgTag(cfg.format.artillery.revealed) ];

            /** Define point relative to which marker is set  */
            spotStatusMarker._x = renderer.wrapper.vehicleLevel._x + cfg.Xoffset; // vehicleLevel._x is 8 for example
            spotStatusMarker._y = renderer.wrapper.vehicleLevel._y + cfg.Yoffset; // vehicleLevel._y is -445.05 for example
        }

        var txt:String = formatsCache[status][isArty ? 1 : 0];
        if (lastText != txt)
        {
            lastText = txt;
            spotStatusMarker.htmlText = txt;
        }
    }

    // -- Private

    private static function createMarker(renderer:PlayerListItemRenderer):TextField
    {
        var marker:TextField = renderer.wrapper.createTextField(SPOT_STATUS_TF_NAME, renderer.wrapper.getNextHighestDepth(), 0, 0, 25, 25);
        marker.antiAliasType = "advanced";
        marker.selectable = false;
        marker.html = true;
        return marker;
    }
}
