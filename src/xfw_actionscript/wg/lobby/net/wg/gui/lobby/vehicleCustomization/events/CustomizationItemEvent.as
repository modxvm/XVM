package net.wg.gui.lobby.vehicleCustomization.events
{
    import flash.events.Event;

    public class CustomizationItemEvent extends Event
    {

        public static const INSTALL_ITEM:String = "installItemEvent";

        public static const SELECT_ITEM:String = "selectItemEvent";

        public static const DESELECT_ITEM:String = "deselectItemEvent";

        public static const REMOVE_ITEM:String = "removeItemEvent";

        public static const INSTALL_STYLES:String = "installStyles";

        public static const INSTALL_CUSTOM_STYLE:String = "installStyle";

        public static const DISPLAYED_CONTEXT_MENU:String = "displayedContextMenu";

        public static const SEEN_ITEM:String = "seenItem";

        private var _itemId:int = 0;

        private var _groupId:int = 0;

        private var _fromStorage:Boolean = false;

        public function CustomizationItemEvent(param1:String, param2:uint = 0, param3:uint = 0, param4:Boolean = false, param5:Boolean = true, param6:Boolean = false)
        {
            super(param1,param5,param6);
            this._itemId = param2;
            this._groupId = param3;
            this._fromStorage = param4;
        }

        override public function clone() : Event
        {
            return new CustomizationItemEvent(type,this._itemId,this._groupId,bubbles,cancelable);
        }

        override public function toString() : String
        {
            return formatToString("CustomizationItemEvent","type","itemId","fromStorage","groupId","bubbles","cancelable");
        }

        public function get itemId() : uint
        {
            return this._itemId;
        }

        public function get groupId() : uint
        {
            return this._groupId;
        }

        public function get fromStorage() : Boolean
        {
            return this._fromStorage;
        }
    }
}
