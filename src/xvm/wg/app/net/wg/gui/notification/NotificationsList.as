package net.wg.gui.notification
{
   import net.wg.gui.components.controls.ScrollingListPx;
   import net.wg.gui.notification.vo.NotificationInfoVO;
   import scaleform.clik.data.DataProvider;
   import flash.events.Event;
   import net.wg.gui.notification.events.NotificationListEvent;


   public class NotificationsList extends ScrollingListPx
   {
          
      public function NotificationsList() {
         this.pendingDataList = [];
         super();
      }

      public static const PENDING_DATA_INV:String = "pendingDataInv";

      private var pendingDataList:Array;

      public function appendData(param1:NotificationInfoVO) : void {
         this.pendingDataList.push(param1);
         invalidate(PENDING_DATA_INV);
      }

      public function updateData(param1:NotificationInfoVO) : void {
         var _loc5_:* = 0;
         var _loc2_:uint = _dataProvider.length;
         var _loc3_:NotificationInfoVO = null;
         var _loc4_:* = -1;
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = NotificationInfoVO(_dataProvider[_loc5_]);
            if(param1.isEquals(_loc3_))
            {
               _dataProvider[_loc5_] = param1;
               _loc4_ = _loc5_;
            }
            _loc5_++;
         }
         if(_loc4_ > -1)
         {
            invalidate();
         }
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
            dispatchEvent(new NotificationListEvent(NotificationListEvent.UPDATE_INDEXES,_dataProvider.length));
         }
      }

      override protected function drawRenderers(param1:Number) : void {
         super.drawRenderers(param1);
         if(totalHeight > maskObject.height)
         {
            scrollPosition = maxScroll;
         }
         dispatchEvent(new NotificationListEvent(NotificationListEvent.UPDATE_INDEXES,_dataProvider.length));
      }
   }

}