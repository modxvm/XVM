package net.wg.gui.notification 
{
    import flash.events.*;
    import net.wg.gui.components.controls.*;
    import scaleform.clik.data.*;
    
    public class NotificationsList extends net.wg.gui.components.controls.ScrollingListPx
    {
        public function NotificationsList()
        {
            this.pendingDataList = [];
            super();
            return;
        }

        public function appendData(arg1:Object):void
        {
            this.pendingDataList.push(arg1);
            invalidate(PENDING_DATA_INV);
            return;
        }

        protected override function draw():void
        {
            var loc1:*=false;
            super.draw();
            if (isInvalid(PENDING_DATA_INV)) 
            {
                loc1 = scrollPosition == 0 || scrollPosition == maxScroll;
                if (!dataProvider) 
                {
                    dataProvider = new scaleform.clik.data.DataProvider([]);
                }
                while (this.pendingDataList.length > 0) 
                {
                    _dataProvider.removeEventListener(flash.events.Event.CHANGE, handleDataChange);
                    scaleform.clik.data.DataProvider(_dataProvider).push(this.pendingDataList.shift());
                    createRendererByDataIndex((_dataProvider.length - 1));
                    _dataProvider.addEventListener(flash.events.Event.CHANGE, handleDataChange, false, 0, true);
                }
                if (loc1) 
                {
                    scrollPosition = maxScroll;
                }
                container.y = -scrollStepFactor * _scrollPosition;
                scrollBar.setScrollProperties(scrollPageSize, 0, maxScroll);
                scrollBar.position = scrollPosition;
                scrollBar.trackScrollPageSize = scrollPageSize;
            }
            return;
        }

        protected override function drawRenderers(arg1:Number):void
        {
            super.drawRenderers(arg1);
            if (totalHeight > maskObject.height) 
            {
                scrollPosition = maxScroll;
            }
            return;
        }

        public static const PENDING_DATA_INV:String="pendingDataInv";

        internal var pendingDataList:Array;
    }
}
