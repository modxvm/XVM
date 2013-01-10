import wot.Minimap.model.MapConfig;
import wot.Minimap.staticUtils.LabelAppend;
import wot.Minimap.dto.Player;

/**
 * MinimapEntry represent individual object on map.
 * One tank icon, base capture point, starting point or player himself.
 * 
 * MinimapEntry object at Minimap is called icon.
 * 
 * Extended behaviour:
 * ) Appending extra information about unit like level, type, nick etc.
 *   This aspect is handled by Minimap class also.
 * ) Remain disappeared icons to indicate last enemy position.
 *   Only this class handles this aspect.
 * 
 * @author ilitvinov87@gmail.com
 */

class wot.Minimap.MinimapEntry extends net.wargaming.ingame.MinimapEntry
{
    /** Entry type: enemy, ally, squadman, empty possible */
    public static var MINIMAP_ENTRY_TYPE_ENEMY:String = "enemy";
    public static var MINIMAP_ENTRY_TYPE_ALLY:String = "ally";
    public static var MINIMAP_ENTRY_TYPE_SQUAD:String = "squadman";
    public static var MINIMAP_ENTRY_TYPE_SELF:String = ""; /** Type of player himself and ? */
    public static var MINIMAP_ENTRY_TYPE_LOST:String = "lostenemy"; /** New type for last enemy position markers */
    public static var MINIMAP_ENTRY_VEH_CLASS_LIGHT:String = "lightTank";
    public static var MINIMAP_ENTRY_VEH_CLASS_MEDIUM:String = "mediumTank";
    public static var MINIMAP_ENTRY_VEH_CLASS_HEAVY:String = "heavyTank";
    public static var MINIMAP_ENTRY_VEH_CLASS_TD:String = "AT-SPG";
    public static var MINIMAP_ENTRY_VEH_CLASS_SPG:String = "SPG";
    
    /**
     * Subject of PlayersPanel <-> Minimap syncronization.
     * Syncronized during light delegate event.
     */
    public var uid:Number;
    
    public var player:Player;
    
    function lightPlayer(visibility)
    {
        /** Behavior is altered temporarily so original icon highlighting works */
        if (syncProcedureInProgress)
        {
            initExtendedBehaviour();
        }
        else
        {
            super.lightPlayer(visibility);
        }
    }
    
    // -- Private
    
    private function initExtendedBehaviour():Void
    {
        uid = _root.minimap.sync.getTestUid();
        
        if (MapConfig.revealedEnabled)
            LabelAppend.append(markMC, uid, this.entryName, MapConfig.revealedOffset, this.vehicleClass);
    }
    
    private function get syncProcedureInProgress():Boolean
    {
        return _root.minimap.sync.syncProcedureInProgress;
    }
}
