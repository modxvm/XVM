package net.wg.gui.lobby.fortifications.events
{
   import flash.events.Event;
   
   public class FortBuildingCardPopoverEvent extends Event
   {
      
      public function FortBuildingCardPopoverEvent(param1:String) {
         super(param1,true,true);
      }
      
      public static const BUY_ORDER:String = "buyOrder";
      
      public static const DIRECTION_CONTROLL:String = "directionControl";
      
      public static const UPGRADE_BUILDING:String = "upgradeBuilding";
      
      public static const DESTROY_BUILDING:String = "destroyBuilding";
      
      public static const ASSIGN_PLAYERS:String = "assignPlayers";
   }
}
