package net.wg.gui.historicalBattles.events
{
   import flash.events.Event;


   public class TeamsVehicleListEvent extends Event
   {
          
      public function TeamsVehicleListEvent(param1:String, param2:Number=undefined, param3:Boolean=false, param4:Boolean=false) {
         super(param1,param3,param4);
         this.vehicleID = param2;
      }

      public static const VEHICLE_SELECTED:String = "vehicleSelected";

      public var vehicleID:Number = -1;
   }

}