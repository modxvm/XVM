package net.wg.gui.components.controls 
{
    import scaleform.clik.interfaces.*;
    
    public class SortableScrollingList extends net.wg.gui.components.controls.ScrollingListEx
    {
        public function SortableScrollingList()
        {
            super();
            return;
        }

        public override function set dataProvider(arg1:scaleform.clik.interfaces.IDataProvider):void
        {
            super.dataProvider = arg1;
            invalidate(SORTING_INVALID);
            return;
        }

        protected function setSortMask(arg1:Boolean):void
        {
            if (arg1) 
                this.sortMask = this.sortMask | Array.DESCENDING;
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(SORTING_INVALID)) 
                this.sortWithMask(this.sortPropName, this.sortMask);
            super.draw();
            return;
        }

        protected function sortWithMask(arg1:String, arg2:uint):void
        {
            if (dataProvider) 
            {
                (dataProvider as Array).sortOn(arg1, arg2);
                invalidateData();
            }
            return;
        }

        protected static const SORTING_INVALID:String="sortingInv";

        protected var sortMask:uint;

        protected var sortPropName:String;
    }
}
