import com.xvm.Config;
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
    private var spotStatusMarker:TextField;

    public function SpotStatusView(renderer:PlayerListItemRenderer)
    {
        this.renderer = renderer;
        spotStatusMarker = null;
    }

    public function update(status:Number, isArty:Boolean):Void
    {
        if (spotStatusMarker == null)
            spotStatusMarker = createMarker(renderer);

        spotStatusMarker.htmlText = getFormat(status, isArty);

        /** Define point relative to which marker is set  */
        spotStatusMarker._x = renderer.wrapper.vehicleLevel._x + cfg.Xoffset; // vehicleLevel._x is 8 for example
        spotStatusMarker._y = renderer.wrapper.vehicleLevel._y + cfg.Yoffset; // vehicleLevel._y is -445.05 for example
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

    /** Return HTML text from config file */
    private function getFormat(status:Number, isArty:Boolean):String
    {
        switch (status)
        {
            case SpotStatusModel.NEVER_SEEN:
                return isArty ? cfg.format.artillery.neverSeen : cfg.format.neverSeen;
            case SpotStatusModel.LOST:
                return isArty ? cfg.format.artillery.lost : cfg.format.lost;
            case SpotStatusModel.REVEALED:
                return isArty ? cfg.format.artillery.revealed : cfg.format.revealed;
            case SpotStatusModel.DEAD:
                return isArty ? cfg.format.artillery.dead : cfg.format.dead;
        }
        return "ERROR";
    }

    // -- Getters

    private function get cfg():Object
    {
        return Config.s_config.playersPanel.enemySpottedMarker;
    }
}
