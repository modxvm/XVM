package net.wg.gui.lobby.eventShopTab.events
{
    import flash.events.Event;

    public class ShopTabEvent extends Event
    {

        public static const MAINBANNER_CLICK:String = "mainBannerClick";

        public static const ITEMSBANNER_CLICK:String = "itemsBannerClick";

        public static const PACKBANNER_CLICK:String = "packBannerClick";

        private var _id:int = 0;

        public function ShopTabEvent(param1:String, param2:Number = 0, param3:Boolean = true, param4:Boolean = false)
        {
            super(param1,param3,param4);
            this._id = param2;
        }

        override public function clone() : Event
        {
            return new ShopTabEvent(type,this._id,bubbles,cancelable);
        }

        public function get id() : int
        {
            return this._id;
        }
    }
}
