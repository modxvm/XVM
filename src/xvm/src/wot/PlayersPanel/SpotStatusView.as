import wot.PlayersPanel.PlayerListItemRenderer;
import com.xvm.Config;
import wot.PlayersPanel.SpotStatusModel;

/**
 * @author ilitvinov87@gmail.com
 * 
 * Handles Enemy Spotted presentation level (View)
 */
class wot.PlayersPanel.SpotStatusView
{
    public static var SPOT_STATUS_TF_NAME:String = "spotStatusTF";
    
    private var renderer:PlayerListItemRenderer;
    private var spotStatusMarker:TextField;
    
    public function SpotStatusView(renderer:PlayerListItemRenderer) 
    {
        this.renderer = renderer;
    }
    
    public function update(status:Number, isArti:Boolean):Void
    {
        if (renderer[SPOT_STATUS_TF_NAME] == undefined)
        {
            createMarker(renderer);
        }
        
        spotStatusMarker.htmlText = getFormat(status, isArti);
        
        /** Define point relative to which marker is set  */
        spotStatusMarker._x = renderer.vehicleLevel._x + cfg.Xoffset; // vehicleLevel._x is 8 for example
        spotStatusMarker._y = renderer.vehicleLevel._y + cfg.Yoffset; // vehicleLevel._y is -445.05 for example
    }
    
    // -- Private
    
    private function createMarker(renderer:PlayerListItemRenderer):Void
    {
        spotStatusMarker = renderer.createTextField
        (
            SPOT_STATUS_TF_NAME,
            renderer.getNextHighestDepth(),
            0, 0, 25, 25
        );
        
        spotStatusMarker.antiAliasType = "advanced";
        spotStatusMarker.html = true;
    }
    
    /** Return HTML text from config file */
    private function getFormat(status:Number, isArti:Boolean):String
    {
        if (isArti)
        {
            switch (status)
            {
                case SpotStatusModel.NEVER_SEEN:
                    return cfg.format.artillery.neverSeen;
                case SpotStatusModel.LOST:
                    return cfg.format.artillery.lost;
                case SpotStatusModel.REVEALED:
                    return cfg.format.artillery.revealed;
                case SpotStatusModel.DEAD:
                    return cfg.format.artillery.dead;
            }
        }
        else
        {
            switch (status)
            {
                case SpotStatusModel.NEVER_SEEN:
                    return cfg.format.neverSeen;
                case SpotStatusModel.LOST:
                    return cfg.format.lost;
                case SpotStatusModel.REVEALED:
                    return cfg.format.revealed;
                case SpotStatusModel.DEAD:
                    return cfg.format.dead;
            }
        }
        
        return "ERROR";
    }
    
    // -- Getters
    
    private function get cfg():Object
    {
        return Config.s_config.playersPanel.enemySpottedMarker;
    }
}
