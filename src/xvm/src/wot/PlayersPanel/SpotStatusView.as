//import wot.utils.Logger;
import wot.PlayersPanel.PlayerListItemRenderer;
import net.wargaming.ingame.PlayersPanel;
import wot.utils.Config;

/**
 * @author ilitvinov87@gmail.com
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
    
    public function update(text:String):Void
    {
        if (renderer[SPOT_STATUS_TF_NAME] == undefined)
        {
            createMarker(renderer);
        }
        
        spotStatusMarker.text = text;
    }
    
    // -- Private
    
    private function createMarker(renderer:PlayerListItemRenderer):Void
    {
        //Logger.add("ssv.createMarker()");
        
        /** Define point relative to which marker is set  */
        var baseX:Number = renderer.vehicleLevel._x + 15; // 8
        var baseY:Number = renderer.vehicleLevel._y; // -445.05
        
        spotStatusMarker = renderer.createTextField
        (
            SPOT_STATUS_TF_NAME,
            renderer.getNextHighestDepth(),
            baseX, baseY, 25, 25
        );
        
        spotStatusMarker.textColor = 0x00FFBB;
        spotStatusMarker.html = true;
    }
    
    // -- Getters
    
    private function get panel():PlayersPanel
    {
        return _root.rightPanel;
    }
    
    private function get cfg():Object
    {
        return Config.s_config.playersPanel.enemySpottedMarker;
    }
}
