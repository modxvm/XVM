package net.wg.gui.components.controls
{
   import scaleform.clik.interfaces.IDataProvider;
   import flash.events.Event;


   public class SortableScrollingList extends ScrollingListEx
   {
          
      public function SortableScrollingList() {
         super();
      }

      protected static const SORTING_INVALID:String = "sortingInv";

      public static const DATA_INVALIDATED:String = "dataInvalidated";

      protected var sortMask:uint;

      protected var sortPropName:String;

      override public function set dataProvider(param1:IDataProvider) : void {
         super.dataProvider = param1;
         invalidate(SORTING_INVALID);
      }

      protected function setSortMask(param1:Boolean) : void {
         if(param1)
         {
            this.sortMask = this.sortMask | Array.DESCENDING;
         }
      }

      override protected function draw() : void {
         if(isInvalid(SORTING_INVALID))
         {
            this.sortWithMask(this.sortPropName,this.sortMask);
         }
         super.draw();
      }

      override public function invalidateData() : void {
         super.invalidateData();
         dispatchEvent(new Event(DATA_INVALIDATED,true));
      }

      protected function sortWithMask(param1:String, param2:uint) : void {
         if(dataProvider)
         {
            (dataProvider as Array).sortOn(param1,param2);
            this.invalidateData();
         }
      }
   }

}