package net.wg.gui.lobby.window
{
   import net.wg.gui.components.controls.SortableScrollingList;
   
   public class ExchangeXPList extends SortableScrollingList
   {
      
      public function ExchangeXPList() {
         super();
      }
      
      public function applySelection(param1:Boolean) : void {
         var _loc2_:ExchangeXPVehicleVO = null;
         var _loc3_:* = 0;
         while(_loc3_ < dataProvider.length)
         {
            _loc2_ = dataProvider[_loc3_];
            _loc2_.isSelectCandidate = param1;
            _loc3_++;
         }
         invalidateData();
      }
   }
}
