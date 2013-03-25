import wot.PlayersPanel.PlayersPanelEvent;
import wot.utils.GlobalEventDispatcher;
import wot.Minimap.MinimapEvent;
//import wot.utils.Logger;
import wot.PlayersPanel.PlayersPanel;
import wot.Minimap.model.externalProxy.PlayersPanelProxy;

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
        if (PlayersPanelProxy.isDead(uid))
        {
            //Logger.add("idDead " + uid);
            return "d";
        }
        
        var text:String = revealed[uid] ? "+" : "█";
        
        //Logger.add("ssmodel.uid " + uid + " text " + text);
        
        return text;
    }
    
    private function onRevealed(mmevent:MinimapEvent):Void
    {
        var uid:Number = Number(mmevent.payload);
        revealed[uid] = true;
        
        var ppevent:PlayersPanelEvent = new PlayersPanelEvent(PlayersPanelEvent.ENEMY_REVEALED);
        GlobalEventDispatcher.dispatchEvent(ppevent);
    }
    
    private function get panel():PlayersPanel
    {
        return _root.rightPanel;
    }
}
