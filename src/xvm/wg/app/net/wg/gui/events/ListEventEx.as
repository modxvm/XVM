package net.wg.gui.events 
{
    import scaleform.clik.events.*;
    import scaleform.clik.interfaces.*;
    
    public class ListEventEx extends scaleform.clik.events.ListEvent
    {
        public function ListEventEx(arg1:String, arg2:Boolean=false, arg3:Boolean=true, arg4:int=-1, arg5:int=-1, arg6:int=-1, arg7:scaleform.clik.interfaces.IListItemRenderer=null, arg8:Object=null, arg9:uint=0, arg10:uint=0, arg11:Boolean=false)
        {
            super(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
            return;
        }

        public static const ITEM_CLICK:String="itemClick";

        public static const ITEM_PRESS:String="itemPress";

        public static const ITEM_ROLL_OVER:String="itemRollOver";

        public static const ITEM_ROLL_OUT:String="itemRollOut";

        public static const ITEM_DOUBLE_CLICK:String="itemDoubleClick";

        public static const INDEX_CHANGE:String="listIndexChange";

        public static const ITEM_TEXT_CHANGE:String="itemTextChange";

        public static const ITEM_DRAG_OVER:String="itemDragOver";

        public static const ITEM_DRAG_OUT:String="itemDragOut";

        public static const ITEM_RELEASE_OUTSIDE:String="itemReleaseOutside";

        public static const ITEM_DRAG_START:String="dragStart";

        public static const ITEM_DRAG_STOP:String="dragStop";
    }
}
