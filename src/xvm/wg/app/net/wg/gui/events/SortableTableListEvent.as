package net.wg.gui.events
{
    import scaleform.clik.events.ListEvent;
    
    public class SortableTableListEvent extends ListEventEx
    {
        
        public function SortableTableListEvent(param1:ListEvent)
        {
            var _loc2_:* = "";
            switch(param1.type)
            {
                case ListEvent.ITEM_CLICK:
                    _loc2_ = RENDERER_CLICK;
                    break;
                case ListEvent.ITEM_PRESS:
                    _loc2_ = RENDERER_PRESS;
                    break;
                case ListEvent.ITEM_ROLL_OVER:
                    _loc2_ = RENDERER_ROLL_OVER;
                    break;
                case ListEvent.ITEM_ROLL_OUT:
                    _loc2_ = RENDERER_ROLL_OUT;
                    break;
                case ListEvent.ITEM_DOUBLE_CLICK:
                    _loc2_ = RENDERER_DOUBLE_CLICK;
                    break;
                case ListEvent.INDEX_CHANGE:
                    _loc2_ = LIST_INDEX_CHANGE;
                    break;
            }
            super(_loc2_,param1.bubbles,param1.cancelable,param1.index,param1.columnIndex,param1.rowIndex,param1.itemRenderer,param1.itemData,param1.controllerIdx,param1.buttonIdx,param1.isKeyboard);
        }
        
        public static var RENDERER_CLICK:String = "tableRendererClick";
        
        public static var RENDERER_PRESS:String = "tableRendererPress";
        
        public static var RENDERER_ROLL_OVER:String = "tableRendererRollOver";
        
        public static var RENDERER_ROLL_OUT:String = "tableRendererRollOut";
        
        public static var RENDERER_DOUBLE_CLICK:String = "tableRendererDoubleClick";
        
        public static var LIST_INDEX_CHANGE:String = "tablelistIndexChange";
    }
}
