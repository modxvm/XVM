package net.wg.gui.notification
{
   import net.wg.gui.components.controls.ScrollingListPx;
   import scaleform.clik.data.DataProvider;
   import flash.events.Event;


   public class NotificationsList extends ScrollingListPx
   {
          
      public function NotificationsList() {
         this.pendingDataList = [];
         super();
      }

      public static const PENDING_DATA_INV:String = "pendingDataInv";

      private var pendingDataList:Array;

      public function appendData(param1:Object) : void {
         this.pendingDataList.push(param1);
         invalidate(PENDING_DATA_INV);
      }

      override protected function draw() : void {
         var _loc1_:* = false;
         super.draw();
         if(isInvalid(PENDING_DATA_INV))
         {
            _loc1_ = scrollPosition == 0 || scrollPosition == maxScroll;
            if(!dataProvider)
            {
               dataProvider = new DataProvider([]);
            }
            while(this.pendingDataList.length > 0)
            {
               _dataProvider.removeEventListener(Event.CHANGE,handleDataChange);
               DataProvider(_dataProvider).push(this.pendingDataList.shift());
               createRendererByDataIndex(_dataProvider.length-1);
               _dataProvider.addEventListener(Event.CHANGE,handleDataChange,false,0,true);
            }
            if(_loc1_)
            {
               scrollPosition = maxScroll;
            }
            container.y = -(scrollStepFactor * _scrollPosition);
            scrollBar.setScrollProperties(scrollPageSize,0,maxScroll);
            scrollBar.position = scrollPosition;
            scrollBar.trackScrollPageSize = scrollPageSize;
         }
      }

      override protected function drawRenderers(param1:Number) : void {
         super.drawRenderers(param1);
         if(totalHeight > maskObject.height)
         {
            scrollPosition = maxScroll;
         }
      }
   }

}