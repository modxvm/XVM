package net.wg.gui.lobby.customization 
{
    import flash.events.*;
    
    public class CustomizationEvent extends flash.events.Event
    {
        public function CustomizationEvent(arg1:String)
        {
            super(arg1, true, true);
            return;
        }

        public override function clone():flash.events.Event
        {
            return new net.wg.gui.lobby.customization.CustomizationEvent(type);
        }

        public static const PRICE_ITEM_CLICK:String="priceItemClick";

        public static const CHANGE_ACTIONS_LOCK:String="changeActionsLock";

        public static const RESET_NEW_ITEM:String="resetNewItem";

        public static const SELECT_NEW:String="selectNew";

        public static const DROP_ITEM:String="dropItem";

        public static const COLLECTION_CHANGE:String="collectionChange";

        public static const ITEM_SELECT:String="itemSelect";

        public var locked:Boolean=false;

        public var persistent:Boolean=false;

        public var kind:int=0;

        public var index:int=0;

        public var lastIndex:int=0;

        public var data:Object;
    }
}
