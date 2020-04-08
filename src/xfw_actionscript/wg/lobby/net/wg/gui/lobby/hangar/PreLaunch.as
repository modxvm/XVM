package net.wg.gui.lobby.hangar
{
    import net.wg.gui.components.containers.inject.GFInjectComponent;

    public class PreLaunch extends GFInjectComponent
    {

        private static const WIDTH_BIG:int = 400;

        private static const WIDTH_SMALL:int = 300;

        private static const MARGIN_SMALL:int = 10;

        private static const MARGIN_BIG:int = 30;

        private static const HEIGHT_BIG:int = 240;

        private static const HEIGHT_BASE:int = 52;

        public static const TOP_MARGIN:int = HEIGHT_BASE - HEIGHT_BIG + 10;

        private var _margin:int = 0;

        public function PreLaunch()
        {
            super();
            mouseEnabled = false;
        }

        public function set isSmall(param1:Boolean) : void
        {
            var _loc2_:int = param1?MARGIN_SMALL:MARGIN_BIG;
            if(_loc2_ != this._margin)
            {
                this._margin = _loc2_;
                setSize(param1?WIDTH_SMALL:WIDTH_BIG,HEIGHT_BIG);
            }
        }

        public function getWidth() : Number
        {
            return width + this._margin;
        }

        public function getHeight() : Number
        {
            return height + this._margin;
        }
    }
}
