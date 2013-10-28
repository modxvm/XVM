package net.wg.gui.lobby.window
{
   import net.wg.gui.components.controls.SortableScrollingList;


   public class ExchangeXPList extends SortableScrollingList
   {
          
      public function ExchangeXPList() {
         super();
      }

      override protected function configUI() : void {
         super.configUI();
      }

      public function sortSelection(param1:Boolean) : void {
         if(dataProvider)
         {
            sortMask = Array.NUMERIC;
            setSortMask(param1);
            sortPropName = "isSelectCandidate";
            invalidate(SORTING_INVALID);
         }
      }

      public function sortByVehicleName(param1:Boolean) : void {
         if(dataProvider)
         {
            sortMask = Array.CASEINSENSITIVE;
            if(!param1)
            {
               sortMask = sortMask | Array.DESCENDING;
            }
            sortPropName = "vehicleName";
            invalidate(SORTING_INVALID);
         }
      }

      public function sortByExperience(param1:Boolean) : void {
         if(dataProvider)
         {
            sortMask = Array.NUMERIC;
            setSortMask(param1);
            sortPropName = "xp";
            invalidate(SORTING_INVALID);
         }
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