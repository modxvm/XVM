package net.wg.gui.lobby.store
{
   import flash.events.Event;
   import net.wg.data.VO.StoreTableData;
   
   public class StoreEvent extends Event
   {
      
      public function StoreEvent(param1:String, param2:StoreTableData) {
         super(param1,true,true);
         this._data = param2;
      }
      
      public static const BUY:String = "storeBuy";
      
      public static const SELL:String = "storeSell";
      
      public static const INFO:String = "storeInfo";
      
      private var _data:StoreTableData = null;
      
      public function get data() : StoreTableData {
         return this._data;
      }
   }
}
