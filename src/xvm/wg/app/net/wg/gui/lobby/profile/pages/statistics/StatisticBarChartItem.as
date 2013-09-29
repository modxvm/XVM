package net.wg.gui.lobby.profile.pages.statistics 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import net.wg.data.managers.*;
    import net.wg.gui.lobby.profile.components.chart.*;
    
    public class StatisticBarChartItem extends net.wg.gui.lobby.profile.components.chart.FrameChartItem
    {
        public function StatisticBarChartItem()
        {
            super();
            stop();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.textField.autoSize = flash.text.TextFieldAutoSize.LEFT;
            return;
        }

        protected function mouseRollOutHandler(arg1:flash.events.MouseEvent):void
        {
            hideToolTip();
            return;
        }

        protected function mouseRollOverHandler(arg1:flash.events.MouseEvent):void
        {
            this.showToolTip(null);
            return;
        }

        protected function showToolTip(arg1:net.wg.data.managers.IToolTipParams):void
        {
            return;
        }

        protected override function applyValueChange():void
        {
            this.gotoAndStop(value + 1);
            var loc1:*=net.wg.gui.lobby.profile.pages.statistics.StatisticChartInfo(_data);
            this.textField.text = loc1.yField.toString();
            this.textField.textColor = value != 100 ? textColor : topTextColor;
            this.textField.y = this.mcMask.y - this.mcMask.height - this.textField.height;
            this.textField.x = Math.round(this.background.x + this.background.width / 2 - this.textField.width / 2);
            return;
        }

        public function getThumbDimensions():flash.geom.Point
        {
            return new flash.geom.Point(this.background.width, this.background.height);
        }

        public override function dispose():void
        {
            this.disposeHandlers();
            super.dispose();
            return;
        }

        internal function disposeHandlers():void
        {
            removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.mouseRollOverHandler);
            removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.mouseRollOutHandler);
            return;
        }

        public function get tooltip():String
        {
            return this._tooltip;
        }

        public function set tooltip(arg1:String):void
        {
            this._tooltip = arg1;
            this.disposeHandlers();
            if (this._tooltip) 
            {
                addEventListener(flash.events.MouseEvent.ROLL_OVER, this.mouseRollOverHandler, false, 0, true);
                addEventListener(flash.events.MouseEvent.ROLL_OUT, this.mouseRollOutHandler, false, 0, true);
            }
            return;
        }

        internal static function hideToolTip():void
        {
            App.toolTipMgr.hide();
            return;
        }

        public static const topTextColor:uint=16777215;

        public static const textColor:uint=12696220;

        public var textField:flash.text.TextField;

        public var mcMask:flash.display.MovieClip;

        public var background:flash.display.Sprite;

        internal var _tooltip:String=null;
    }
}
