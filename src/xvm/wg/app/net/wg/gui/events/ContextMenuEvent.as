package net.wg.gui.events
{
   import flash.events.Event;


   public class ContextMenuEvent extends Event
   {
          
      public function ContextMenuEvent(param1:String, param2:String=undefined, param3:Object=null, param4:Object=null, param5:Boolean=false, param6:Boolean=false) {
         this.data = new Object();
         this.memberItemData = new Object();
         super(param1,param5,param6);
         this.id = param2;
         this.data = param3;
         this.memberItemData = param4;
      }

      public static const ON_ITEM_SELECT:String = "on_item_select";

      public static const ON_MENU_RELEASE_OUTSIDE:String = "on_menu_release_outside";

      public var id:String = "";

      public var data:Object;

      public var memberItemData:Object;

      override public function clone() : Event {
         return new ContextMenuEvent(type,this.id,this.data,this.memberItemData,bubbles,cancelable);
      }

      override public function toString() : String {
         return formatToString("ContextMenuEvent","type","bubbles","cancelable","eventPhase");
      }
   }

}