package net.wg.gui.lobby.fortifications.events
{
    import flash.events.Event;
    
    public class FortBuildingCardPopoverEvent extends Event
    {
        
        public function FortBuildingCardPopoverEvent(param1:String)
        {
            super(param1,true,true);
        }
        
        public static var BUY_ORDER:String = "buyOrder";
        
        public static var DIRECTION_CONTROLL:String = "directionControl";
        
        public static var UPGRADE_BUILDING:String = "upgradeBuilding";
        
        public static var DESTROY_BUILDING:String = "destroyBuilding";
        
        public static var ASSIGN_PLAYERS:String = "assignPlayers";
    }
}
