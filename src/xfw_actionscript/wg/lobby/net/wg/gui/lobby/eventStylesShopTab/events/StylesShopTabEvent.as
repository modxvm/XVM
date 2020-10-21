package net.wg.gui.lobby.eventStylesShopTab.events
{
    import flash.events.Event;

    public class StylesShopTabEvent extends Event
    {

        public static const TANK_CLICK:String = "tankClick";

        public static const TANK_OVER:String = "tankOver";

        public static const TANK_OUT:String = "tankOut";

        public static const BANNER_CLICK:String = "bannerClick";

        private var _index:int = 0;

        public function StylesShopTabEvent(param1:String, param2:int = 0)
        {
            super(param1,true,false);
            this._index = param2;
        }

        override public function clone() : Event
        {
            return new StylesShopTabEvent(type,this._index);
        }

        public function get index() : int
        {
            return this._index;
        }
    }
}
