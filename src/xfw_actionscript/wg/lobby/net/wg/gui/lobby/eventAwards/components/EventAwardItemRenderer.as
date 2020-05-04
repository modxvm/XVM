package net.wg.gui.lobby.eventAwards.components
{
    import net.wg.gui.lobby.components.AwardItemRendererEx;
    import net.wg.gui.lobby.components.data.AwardItemRendererExVO;

    public class EventAwardItemRenderer extends EventAwardItemRendererBase
    {

        public static const SIZE:int = 80;

        public static const COUNTER_GAP:int = 3;

        public var ribbonAward:AwardItemRendererEx;

        private var _data:AwardItemRendererExVO;

        public function EventAwardItemRenderer()
        {
            super();
            this.ribbonAward.setSize(SIZE,SIZE);
        }

        override protected function onDispose() : void
        {
            if(this.ribbonAward != null)
            {
                this.ribbonAward.dispose();
                this.ribbonAward = null;
            }
            if(this._data != null)
            {
                this._data.dispose();
                this._data = null;
            }
            super.onDispose();
        }

        override public function setData(param1:Object) : void
        {
            this._data = new AwardItemRendererExVO(param1);
            this._data.gap = COUNTER_GAP;
            this.ribbonAward.setData(this._data);
        }

        override public function get width() : Number
        {
            return SIZE;
        }

        override public function get height() : Number
        {
            return SIZE;
        }
    }
}
