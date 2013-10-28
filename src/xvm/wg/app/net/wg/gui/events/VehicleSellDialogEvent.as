package net.wg.gui.events
{
   import flash.events.Event;


   public class VehicleSellDialogEvent extends Event
   {
          
      public function VehicleSellDialogEvent(param1:String, param2:Number=undefined) {
         super(param1,true,true);
         this.listVisibleHight = param2;
      }

      public static const LIST_WAS_DRAWN:String = "listWasDrawn";

      public static const UPDATE_RESULT:String = "updateResult";

      public var listVisibleHight:Number;

      override public function clone() : Event {
         return new VehicleSellDialogEvent(type,this.listVisibleHight);
      }
   }

}