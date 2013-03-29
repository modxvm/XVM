import wot.utils.Utils;
import wot.Minimap.MinimapEvent;
import wot.utils.GlobalEventDispatcher;
import wot.Minimap.model.externalProxy.IconsProxy;
import wot.Minimap.model.externalProxy.PlayersPanelProxy;

class wot.Minimap.model.iconTracker.LostPlayers
{
    
    /** Keep track of previously lost players to avoid unnecessary event dispatch */
    private var lostPrev:Array;
    
    /** Position tracking of all enemy icons on minimap */
    private var posTrack:Array;
    
    public function LostPlayers(posTrack:Array)
    {
        this.posTrack = posTrack;
    }
    
    /**
     * Find enemy units seen atleast once but lost out of sight.
     * Theese are the candidates to mark last position at map.
     */
    public function find():Void
    {
        /** All the units not revealed at minimap */
        var hiddenUids = Utils.subtractArray(PlayersPanelProxy.getEnemyUids(), IconsProxy.getSyncedUids());
        
        hiddenUids = filterDead(hiddenUids);
        
        /** Lost player are the players that has position tracked and are hidden(currently not revealed) on minimap */
        var lost:Array = [];
        
        for (var i in hiddenUids)
        {
            var uid:Number = hiddenUids[i];
            
            for (var j in posTrack)
            {
                if (posTrack[j].uid == uid) /** If this hidden uid is tracked */
                {
                    lost.push(posTrack[j]); /** This guy is lost! */
                    break;
                }
            }
        }
        
        /** Keep track of previously lost players to avoid unnecessary event dispatch */
        if (lostPrev == undefined)
            lostPrev = lost;
            
        if (lostPrev.toString() != lost.toString())
        {
            lostPrev = lost;
            GlobalEventDispatcher.dispatchEvent(new MinimapEvent(MinimapEvent.LOST_PLAYERS_UPDATE, lost));
        }
    }
    
    // -- Private
    
    /** We do not need to count dead players as lost on minimap */
    private function filterDead(all:Array):Array
    {
        var alive:Array = [];
        for (var i in all)
        {
            if (!PlayersPanelProxy.isDead(all[i]))
            {
                alive.push(all[i]);
            }
        }
        
        return alive;
    }
}
