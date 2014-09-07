package net.wg.gui.lobby.header.events
{
    import flash.events.Event;
    
    public class HeaderEvents extends Event
    {
        
        public function HeaderEvents(param1:String, param2:Number, param3:Number = 0, param4:Number = 0, param5:Boolean = false, param6:Boolean = false)
        {
            super(param1,param5,param6);
            this.itemBounds = param2;
            this.leftPadding = param3;
            this.rightPadding = param4;
            this.contentWidth = this.itemBounds + this.leftPadding + this.rightPadding;
        }
        
        public static var HBC_SIZE_UPDATED:String = "HBCSizeUpdated";
        
        public static var HEADER_ITEMS_REPOSITION:String = "HeaderItemsReposition";
        
        public var itemBounds:Number;
        
        public var leftPadding:Number;
        
        public var rightPadding:Number;
        
        public var contentWidth:Number;
        
        override public function clone() : Event
        {
            return new HeaderEvents(type,this.itemBounds,this.leftPadding,this.rightPadding,bubbles,cancelable);
        }
        
        override public function toString() : String
        {
            return formatToString("HBC_Events","type","itemBounds","leftPadding","rightPadding","bubbles","cancelable");
        }
    }
}
