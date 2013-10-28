package net.wg.gui.lobby.techtree
{
   import flash.events.Event;


   public class TechTreeEvent extends Event
   {
          
      public function TechTreeEvent(param1:String, param2:int=undefined, param3:int=undefined, param4:uint=undefined, param5:Boolean=true, param6:Boolean=false) {
         super(param1,param5,param6);
         this.primary = param2;
         this.index = param3;
         this.entityType = param4;
      }

      public static const DATA_BUILD_COMPLETE:String = "buildComplete";

      public static const RETURN_2_TECHTREE:String = "techTree";

      public static const STATE_CHANGED:String = "stateChanged";

      public static const CLICK_2_OPEN:String = "clickToOpen";

      public static const CLICK_2_UNLOCK:String = "unlock";

      public static const CLICK_2_BUY:String = "buy";

      public static const CLICK_2_SELL:String = "sell";

      public static const CLICK_2_INSTALL:String = "install";

      public static const CLICK_2_MODULE_INFO:String = "moduleInfo";

      public static const CLICK_2_VEHICLE_INFO:String = "vehicleInfo";

      public var primary:int = -1;

      public var index:int = -1;

      public var entityType:uint = 0;

      override public function clone() : Event {
         return new TechTreeEvent(type,this.primary,this.index,this.entityType,bubbles,cancelable);
      }

      override public function toString() : String {
         return formatToString("TTEventTypes","type","primary","index","entityType","bubbles","cancelable");
      }
   }

}