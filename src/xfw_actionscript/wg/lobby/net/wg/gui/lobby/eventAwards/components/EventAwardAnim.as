package net.wg.gui.lobby.eventAwards.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.utils.FrameHelper;
    import flash.display.FrameLabel;
    import net.wg.gui.lobby.components.events.RibbonAwardAnimEvent;

    public class EventAwardAnim extends UIComponentEx
    {

        private static const BLINK_LABEL:String = "blink";

        private static const BLINK_HALF_COMPLETE_LABEL:String = "blinkHalfComplete";

        private static const BLINK_COMPLETE_LABEL:String = "blinkComplete";

        private static const FADE_IN_LABEL:String = "fadeIn";

        private static const FADE_IN_COMPLETE_LABEL:String = "fadeInComplete";

        private static const FADE_OUT_LABEL:String = "fadeOut";

        private static const FADE_OUT_COMPLETE_LABEL:String = "fadeOutComplete";

        public var ribbonAward:EventAwardHolder;

        private var _frameHelper:FrameHelper;

        public function EventAwardAnim()
        {
            super();
            this._frameHelper = new FrameHelper(this);
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.setMouseEnabled(false);
            var _loc1_:Array = currentLabels;
            var _loc2_:int = _loc1_.length;
            var _loc3_:FrameLabel = null;
            var _loc4_:uint = 0;
            while(_loc4_ < _loc2_)
            {
                _loc3_ = _loc1_[_loc4_];
                if(_loc3_.name == BLINK_COMPLETE_LABEL)
                {
                    this._frameHelper.addScriptToFrame(_loc3_.frame,this.onBlinkComplete);
                }
                else if(_loc3_.name == FADE_IN_COMPLETE_LABEL)
                {
                    this._frameHelper.addScriptToFrame(_loc3_.frame,this.onFadeInComplete);
                }
                else if(_loc3_.name == FADE_OUT_COMPLETE_LABEL)
                {
                    this._frameHelper.addScriptToFrame(_loc3_.frame,this.onFadeOutComplete);
                }
                _loc4_++;
            }
        }

        override protected function onDispose() : void
        {
            stop();
            App.utils.scheduler.cancelTask(gotoAndPlay);
            this._frameHelper.dispose();
            this._frameHelper = null;
            if(this.ribbonAward != null)
            {
                this.ribbonAward.dispose();
                this.ribbonAward = null;
            }
            super.onDispose();
        }

        public function blink(param1:Number = 0) : void
        {
            this.setMouseEnabled(false);
            this.playAnim(BLINK_LABEL,param1);
        }

        public function fadeIn(param1:Number = 0) : void
        {
            this.playAnim(FADE_IN_LABEL,param1);
        }

        public function fadeOut(param1:Number = 0) : void
        {
            this.setMouseEnabled(false);
            this.playAnim(FADE_OUT_LABEL,param1);
        }

        public function setData(param1:Object) : void
        {
            this.ribbonAward.setData(param1);
        }

        public function setLinkage(param1:String) : void
        {
            this.ribbonAward.setLinkageID(param1);
            setSize(this.ribbonAward.width,this.ribbonAward.height);
        }

        protected function setMouseEnabled(param1:Boolean) : void
        {
            mouseEnabled = mouseChildren = param1;
        }

        protected function onBlinkComplete() : void
        {
            this.setMouseEnabled(true);
            dispatchEvent(new RibbonAwardAnimEvent(RibbonAwardAnimEvent.AWARD_BLINK_COMPLETE));
        }

        protected function onFadeInComplete() : void
        {
            this.setMouseEnabled(true);
            dispatchEvent(new RibbonAwardAnimEvent(RibbonAwardAnimEvent.AWARD_FADE_IN_COMPLETE));
        }

        protected function onFadeOutComplete() : void
        {
            dispatchEvent(new RibbonAwardAnimEvent(RibbonAwardAnimEvent.AWARD_FADE_OUT_COMPLETE));
        }

        private function playAnim(param1:String, param2:Number = 0) : void
        {
            if(param2 > 0)
            {
                App.utils.scheduler.scheduleTask(gotoAndPlay,param2,param1);
            }
            else
            {
                gotoAndPlay(param1);
            }
        }
    }
}
