package net.wg.gui.events
{
   import flash.events.Event;


   public class EquipmentEvent extends Event
   {
          
      public function EquipmentEvent(param1:String, param2:int=undefined, param3:int=undefined, param4:String=undefined) {
         super(param1,true,true);
         this.changeIndex = param2;
         this.changePos = param3;
         this.changeCurrency = param4;
      }

      public static const NEED_UPDATE:String = "needUpdate";

      public static const EQUIPMENT_CHANGE:String = "equipmentChange";

      public static const TOTAL_PRICE_CHANGED:String = "totalPriceChanged";

      public static const SHOW_INFO:String = "showInfo";

      public var changeIndex:int = -1;

      public var changePos:int = -1;

      public var changeCurrency:String = "";

      override public function clone() : Event {
         return new EquipmentEvent(type,this.changeIndex,this.changePos,this.changeCurrency);
      }
   }

}