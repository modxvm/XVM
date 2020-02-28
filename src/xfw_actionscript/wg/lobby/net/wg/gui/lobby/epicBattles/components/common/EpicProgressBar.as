package net.wg.gui.lobby.epicBattles.components.common
{
    import net.wg.gui.components.controls.StatusIndicatorEx;
    import net.wg.gui.components.controls.IProgressBar;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.BitmapFill;
    import flash.display.Sprite;
    import net.wg.gui.components.advanced.vo.ProgressBarAnimVO;

    public class EpicProgressBar extends StatusIndicatorEx implements IProgressBar
    {

        public var marker:MovieClip = null;

        public var commonBar:BitmapFill = null;

        public var bg:BitmapFill = null;

        public var gradient:Sprite = null;

        private var _onePercent:Number = 0;

        private var _onePercentWidth:Number = 0;

        public function EpicProgressBar()
        {
            super();
        }

        public function setData(param1:ProgressBarAnimVO) : void
        {
            if(param1 == null)
            {
                return;
            }
            minimum = param1.minValue;
            maximum = param1.maxValue;
            value = param1.value;
            this._onePercent = (_maximum - _minimum) / 100;
        }

        override protected function onDispose() : void
        {
            this.bg.dispose();
            this.commonBar.dispose();
            this.bg = null;
            this.gradient = null;
            this.commonBar = null;
            this.marker = null;
            super.onDispose();
        }

        override public function get width() : Number
        {
            return this.bg.widthFill;
        }

        override public function get height() : Number
        {
            return this.bg.heightFill;
        }

        override protected function updatePosition() : void
        {
            this._onePercentWidth = this.width / scaleX / 100;
            this.commonBar.width = _value / this._onePercent * this._onePercentWidth ^ 0;
            this.marker.visible = value > 0;
            this.marker.x = this.commonBar.widthFill;
            this.gradient.width = value > 0?this.commonBar.widthFill:0;
        }
    }
}
