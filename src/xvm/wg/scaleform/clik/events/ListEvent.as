package scaleform.clik.events 
{
    import flash.events.*;
    import scaleform.clik.interfaces.*;
    
    public class ListEvent extends flash.events.Event
    {
        public function ListEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=true, arg4:int=-1, arg5:int=-1, arg6:int=-1, arg7:scaleform.clik.interfaces.IListItemRenderer=null, arg8:Object=null, arg9:uint=0, arg10:uint=0, arg11:Boolean=false)
        {
            super(arg1, arg2, arg3);
            this.itemRenderer = arg7;
            this.itemData = arg8;
            this.index = arg4;
            this.rowIndex = arg6;
            this.columnIndex = arg5;
            this.controllerIdx = arg9;
            this.buttonIdx = arg10;
            this.isKeyboard = arg11;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new scaleform.clik.events.ListEvent(type, bubbles, cancelable, this.index, this.columnIndex, this.rowIndex, this.itemRenderer, this.itemData, this.controllerIdx, this.buttonIdx, this.isKeyboard);
        }

        public override function toString():String
        {
            return formatToString("ListEvent", "type", "bubbles", "cancelable", "index", "columnIndex", "rowIndex", "itemRenderer", "itemData", "controllerIdx", "buttonIdx", "isKeyboard");
        }

        public static const ITEM_CLICK:String="itemClick";

        public static const ITEM_PRESS:String="itemPress";

        public static const ITEM_ROLL_OVER:String="itemRollOver";

        public static const ITEM_ROLL_OUT:String="itemRollOut";

        public static const ITEM_DOUBLE_CLICK:String="itemDoubleClick";

        public static const INDEX_CHANGE:String="listIndexChange";

        public var itemRenderer:scaleform.clik.interfaces.IListItemRenderer;

        public var itemData:Object;

        public var index:int=-1;

        public var columnIndex:int=-1;

        public var rowIndex:int=-1;

        public var controllerIdx:uint=0;

        public var buttonIdx:uint=0;

        public var isKeyboard:Boolean=false;
    }
}
