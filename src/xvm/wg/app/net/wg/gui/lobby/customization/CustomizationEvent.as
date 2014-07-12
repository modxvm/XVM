package net.wg.gui.lobby.customization
{
   import flash.events.Event;
   
   public class CustomizationEvent extends Event
   {
      
      public function CustomizationEvent(param1:String) {
         super(param1,true,true);
      }
      
      public static const PRICE_ITEM_CLICK:String = "priceItemClick";
      
      public static const CHANGE_ACTIONS_LOCK:String = "changeActionsLock";
      
      public static const RESET_NEW_ITEM:String = "resetNewItem";
      
      public static const SELECT_NEW:String = "selectNew";
      
      public static const DROP_ITEM:String = "dropItem";
      
      public static const COLLECTION_CHANGE:String = "collectionChange";
      
      public static const ITEM_SELECT:String = "itemSelect";
      
      public var locked:Boolean = false;
      
      public var persistent:Boolean = false;
      
      public var kind:int = 0;
      
      public var index:int = 0;
      
      public var lastIndex:int = 0;
      
      public var data:Object;
      
      override public function clone() : Event {
         return new CustomizationEvent(type);
      }
   }
}
