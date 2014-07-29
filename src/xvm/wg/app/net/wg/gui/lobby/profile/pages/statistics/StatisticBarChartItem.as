package net.wg.gui.lobby.profile.pages.statistics
{
    import net.wg.gui.lobby.profile.components.chart.FrameChartItem;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import net.wg.gui.utils.ExcludeTweenManager;
    import flash.text.TextFieldAutoSize;
    import flash.events.MouseEvent;
    import net.wg.data.managers.IToolTipParams;
    import fl.transitions.easing.Strong;
    import scaleform.clik.motion.Tween;
    import flash.geom.Point;
    
    public class StatisticBarChartItem extends FrameChartItem
    {
        
        public function StatisticBarChartItem()
        {
            this.tweenManager = new ExcludeTweenManager();
            super();
            this.animationClient = new StatisticsChartItemAnimClient(this);
            stop();
        }
        
        protected static var tweeSpeed:uint = 500;
        
        private static function hideToolTip() : void
        {
            App.toolTipMgr.hide();
        }
        
        public var textField:TextField;
        
        public var mcMask:MovieClip;
        
        public var background:Sprite;
        
        private var _tooltip:String = null;
        
        protected var tweenManager:ExcludeTweenManager;
        
        private var animationClient:StatisticsChartItemAnimClient;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.textField.autoSize = TextFieldAutoSize.LEFT;
        }
        
        protected function mouseRollOutHandler(param1:MouseEvent) : void
        {
            hideToolTip();
        }
        
        protected function mouseRollOverHandler(param1:MouseEvent) : void
        {
            this.showToolTip(null);
        }
        
        protected function showToolTip(param1:IToolTipParams) : void
        {
        }
        
        override protected function applyValueChange() : void
        {
            var _loc1_:Object = {};
            _loc1_[StatisticsChartItemAnimClient.FRAME_NUMBER_PROPERTY] = value + 1;
            var _loc2_:Number = Number(StatisticChartInfo(_data).yField);
            _loc1_[StatisticsChartItemAnimClient.VALUE_PROPERTY] = _loc2_ >= 0?_loc2_:0;
            this.tweenManager.registerAndLaunch(tweeSpeed,this.animationClient,_loc1_,this.getQuickSet());
        }
        
        protected function getQuickSet() : Object
        {
            var _loc1_:Object = {};
            _loc1_.ease = Strong.easeOut;
            _loc1_.onComplete = this.onTweenComplete;
            return _loc1_;
        }
        
        private function onTweenComplete(param1:Tween) : void
        {
            this.tweenManager.unregister(param1);
        }
        
        public function getThumbDimensions() : Point
        {
            return new Point(this.background.width,this.background.height);
        }
        
        private function disposeHandlers() : void
        {
            removeEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHandler);
        }
        
        public function get tooltip() : String
        {
            return this._tooltip;
        }
        
        public function set tooltip(param1:String) : void
        {
            this._tooltip = param1;
            this.disposeHandlers();
            if(this._tooltip)
            {
                addEventListener(MouseEvent.ROLL_OVER,this.mouseRollOverHandler,false,0,true);
                addEventListener(MouseEvent.ROLL_OUT,this.mouseRollOutHandler,false,0,true);
            }
        }
        
        override protected function onDispose() : void
        {
            this.mcMask = null;
            this.textField = null;
            this.background = null;
            this.tweenManager.dispose();
            this.animationClient.dispose();
            this.disposeHandlers();
            super.onDispose();
        }
    }
}
