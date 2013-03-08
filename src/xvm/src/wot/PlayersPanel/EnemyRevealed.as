import wot.PlayersPanel.PlayersPanel;
import wot.utils.Logger;
import wot.utils.GlobalEventDispatcher;
import wot.Minimap.MinimapEvent;

/**
 * 
 * 
 * @author ilitvinov87@gmail.com
 */
class wot.PlayersPanel.EnemyRevealed
{
    var panel:PlayersPanel;
    
    public function EnemyRevealed(panel:PlayersPanel) 
    {
        this.panel = panel;
        GlobalEventDispatcher.addEventListener(MinimapEvent.ENEMY_REVEALED, this, onRevealed);
        
        /**
         * All enemy items are faded by 
         * wot.PlayersPanel.PlayerListItemRenderer.fadeHiddenEnemyIcon()
         */
    }
    
    private function onRevealed(event:MinimapEvent):Void
    {
        reveal(Number(event.payload));
    }
    
    // TODO: onDead
    
    private function reveal(uid:Number):Void
    {
        // TODO: greensock fade
        //Logger.add("reveal: " + uid);
        
        for (var i in renderers)
        {
            if (renderers[i].data.uid == uid)
            {
                renderers[i]._alpha = 100;
                break;
            }
        }
    }
    
    private function get renderers():Array
    {
        return panel.m_list.renderers;
    }
}
