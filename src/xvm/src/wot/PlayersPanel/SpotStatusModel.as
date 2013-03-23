import wot.utils.GlobalEventDispatcher;
import wot.Minimap.MinimapEvent;
import wot.utils.Logger;
import wot.PlayersPanel.PlayersPanel;

/**
 * @author ilitvinov87@gmail.com
 */
class wot.PlayersPanel.SpotStatusModel
{
    var revealed:Array;
    
    public function SpotStatusModel() 
    {
        revealed = [];
        GlobalEventDispatcher.addEventListener(MinimapEvent.ENEMY_REVEALED, this, onRevealed);
    }
    
    public function defineMarkerText(uid):String
    {
        var text:String = revealed[uid] ? "" : "█";
        
        Logger.add("ssmodel.uid " + uid + " text " + text);
        
        return text;
    }
    
    private function onRevealed(event:MinimapEvent):Void
    {
        var uid:Number = Number(event.payload);
        revealed[uid] = true;
        
        Logger.add("panel.update() invoke by Model");
        panel.update();
    }
    
    private function get panel():PlayersPanel
    {
        return _root.rightPanel;
    }
}
