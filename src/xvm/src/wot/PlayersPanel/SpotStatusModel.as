import wot.utils.GlobalEventDispatcher;
import wot.Minimap.MinimapEvent;

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
    
    private function onRevealed(event:MinimapEvent):Void
    {
        var uid:Number = Number(event.payload);
        revealed.push(uid);
    }
    
    private function defineMarkerText(uid):String
    {
        return "text";
    }
}
