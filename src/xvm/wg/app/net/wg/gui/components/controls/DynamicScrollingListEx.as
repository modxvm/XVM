package net.wg.gui.components.controls
{
   import net.wg.infrastructure.interfaces.IDynamicContent;
   import flash.events.Event;


   public class DynamicScrollingListEx extends ScrollingListEx implements IDynamicContent
   {
          
      public function DynamicScrollingListEx() {
         super();
      }

      override protected function cleanData() : void {
         if(_dataProvider)
         {
            _dataProvider.removeEventListener(Event.CHANGE,handleDataChange,false);
            _dataProvider = null;
         }
      }
   }

}