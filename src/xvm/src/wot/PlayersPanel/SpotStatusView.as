import wot.utils.Logger;
import wot.PlayersPanel.PlayerListItemRenderer;
import net.wargaming.ingame.PlayersPanel;
import wot.utils.Config;

/**
 * @author ilitvinov87@gmail.com
 */
class wot.PlayersPanel.SpotStatusView
{
    var renderer:PlayerListItemRenderer;
    
    var spotStatusMarker:TextField = null;
    
    public function SpotStatusView(renderer:PlayerListItemRenderer) 
    {
        this.renderer = renderer;
    }
    
    public function tryCreateSpotMarker():Void
    {
        if (!cfg.enabled)
            return;
            
        if (spotStatusMarker == null)
        {
            createMarker();
        }
        
        //if ((data.vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_AVIVE) != 0);
    }
    
    // -- Private
    
    private function createMarker():Void
    {
        Logger.add("ssv.createMarker()");
        
        /** Define point relative to which marker is set  */
        var baseX:Number = renderer.vehicleLevel._x; // 8
        var baseY:Number = renderer.vehicleLevel._y; // -445.05
        
        spotStatusMarker = renderer.createTextField
        (
            "spotStatusTF",
            renderer.getNextHighestDepth(),
            baseX, baseY, 25, 25
        );
        
        spotStatusMarker.text = "@";
        spotStatusMarker.textColor = 0x00FFBB;
        spotStatusMarker.html = true;
    }
    
    private function updateText():Void
    {
        Logger.add("ssv.updateText()");
        spotStatusMarker.text = getText(0);;
    }
    
    private function getText(uid):String
    {
        return "text " + uid;
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
