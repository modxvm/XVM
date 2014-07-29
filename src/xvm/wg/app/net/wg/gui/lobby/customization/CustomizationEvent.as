package net.wg.gui.lobby.customization
{
    import flash.events.Event;
    
    public class CustomizationEvent extends Event
    {
        
        public function CustomizationEvent(param1:String)
        {
            super(param1,true,true);
        }
        
        public static var PRICE_ITEM_CLICK:String = "priceItemClick";
        
        public static var CHANGE_ACTIONS_LOCK:String = "changeActionsLock";
        
        public static var RESET_NEW_ITEM:String = "resetNewItem";
        
        public static var SELECT_NEW:String = "selectNew";
        
        public static var DROP_ITEM:String = "dropItem";
        
        public static var COLLECTION_CHANGE:String = "collectionChange";
        
        public static var ITEM_SELECT:String = "itemSelect";
        
        public var locked:Boolean = false;
        
        public var persistent:Boolean = false;
        
        public var kind:int = 0;
        
        public var index:int = 0;
        
        public var lastIndex:int = 0;
        
        public var data:Object;
        
        override public function clone() : Event
        {
            return new CustomizationEvent(type);
        }
    }
}
