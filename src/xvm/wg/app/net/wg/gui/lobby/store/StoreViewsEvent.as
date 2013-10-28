package net.wg.gui.lobby.store
{
   import flash.events.Event;


   public class StoreViewsEvent extends Event
   {
          
      public function StoreViewsEvent(param1:String, param2:String) {
         super(param1,false,false);
         this.viewType = param2;
      }

      public static const POPULATE_MENU_FILTER:String = "populateMenuFilter";

      public static const VIEW_CHANGE:String = "onStoreViewChange";

      public var viewType:String = null;
   }

}