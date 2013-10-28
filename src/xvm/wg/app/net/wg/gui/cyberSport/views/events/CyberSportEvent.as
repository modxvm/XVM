package net.wg.gui.cyberSport.views.events
{
   import flash.events.Event;


   public class CyberSportEvent extends Event
   {
          
      public function CyberSportEvent(param1:String, param2:String, param3:Number=undefined, param4:int=undefined) {
         super(param1,true,false);
         this.alias = param2;
         this.itemId = param3;
         this.slotIndex = param4;
      }

      public static const LOAD_VIEW_REQUEST:String = "loadViewRequest";

      public var alias:String;

      public var itemId:Number;

      public var slotIndex:int = -1;

      override public function clone() : Event {
         return new CyberSportEvent(type,this.alias,this.itemId);
      }
   }

}