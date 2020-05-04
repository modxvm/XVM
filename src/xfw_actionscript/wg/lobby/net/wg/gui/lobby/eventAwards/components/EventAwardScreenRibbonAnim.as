package net.wg.gui.lobby.eventAwards.components
{
    import net.wg.gui.lobby.components.data.RibbonAwardsVO;
    import net.wg.utils.IClassFactory;
    import flash.display.FrameLabel;
    import scaleform.clik.constants.InvalidationType;

    public class EventAwardScreenRibbonAnim extends EventAwardScreenAnim
    {

        private static const FADE_IN_DELAY:uint = 100;

        private static const GAP:uint = 20;

        private static const RENDERER_Y_OFFSET:uint = 77;

        private static const SEPARATOR_LINKAGE:String = "RibbonSeparatorItemRendererUI";

        private static const AWARD_LINKAGE:String = "RibbonAwardItemRendererUI";

        private static const ANIM_LINKAGE:String = "RibbonAwardAnimUI";

        private static const REWARDS_FADE_IN_LABEL:String = "rewardsFadeIn";

        private var _awardItemRenderers:Vector.<EventAwardAnim>;

        private var _data:Vector.<RibbonAwardsVO>;

        private var _classFactory:IClassFactory;

        public function EventAwardScreenRibbonAnim()
        {
            this._classFactory = App.utils.classFactory;
            super();
            this._awardItemRenderers = new Vector.<EventAwardAnim>();
        }

        override public function fadeOut() : void
        {
            super.fadeOut();
            this.fadeOutAwards();
        }

        override protected function handleLabelSubscription(param1:FrameLabel) : void
        {
            if(param1.name == REWARDS_FADE_IN_LABEL)
            {
                frameHelper.addScriptToFrame(param1.frame,this.fadeInAwards);
            }
            super.handleLabelSubscription(param1);
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                this.clear();
                this.drawRenderers();
            }
        }

        override protected function onDispose() : void
        {
            this.clear();
            this._data = null;
            this._classFactory = null;
            this._awardItemRenderers = null;
            super.onDispose();
        }

        override protected function onFadeInComplete() : void
        {
            mouseChildren = true;
            super.onFadeInComplete();
        }

        public function blink() : void
        {
            var _loc1_:uint = this._awardItemRenderers.length;
            var _loc2_:EventAwardAnim = null;
            var _loc3_:uint = 0;
            while(_loc3_ < _loc1_)
            {
                _loc2_ = this._awardItemRenderers[_loc3_];
                _loc2_.blink();
                _loc3_++;
            }
        }

        public function clear() : void
        {
            var _loc1_:EventAwardAnim = null;
            while(this._awardItemRenderers.length > 0)
            {
                _loc1_ = this._awardItemRenderers.pop();
                removeChild(_loc1_);
                _loc1_.dispose();
            }
        }

        public function setRibbonAwardsData(param1:Vector.<RibbonAwardsVO>) : void
        {
            this._data = param1;
            invalidateData();
        }

        protected function fadeOutAwards() : void
        {
            var _loc1_:EventAwardAnim = null;
            var _loc2_:uint = this._awardItemRenderers.length;
            var _loc3_:uint = 0;
            while(_loc3_ < _loc2_)
            {
                _loc1_ = this._awardItemRenderers[_loc3_];
                _loc1_.fadeOut();
                _loc3_++;
            }
        }

        protected function fadeInAwards() : void
        {
            var _loc1_:EventAwardAnim = null;
            var _loc2_:uint = this._awardItemRenderers.length;
            var _loc3_:uint = 0;
            while(_loc3_ < _loc2_)
            {
                _loc1_ = this._awardItemRenderers[_loc3_];
                _loc1_.fadeIn(FADE_IN_DELAY * _loc3_);
                _loc3_++;
            }
        }

        private function drawRenderers() : void
        {
            var _loc1_:EventAwardAnim = null;
            var _loc2_:RibbonAwardsVO = null;
            var _loc7_:* = 0;
            var _loc8_:uint = 0;
            var _loc3_:* = 0;
            var _loc4_:int = this._data.length;
            var _loc5_:uint = 0;
            while(_loc5_ < _loc4_)
            {
                _loc2_ = this._data[_loc5_];
                if(_loc5_ > 0)
                {
                    _loc1_ = this.placeRenderer(SEPARATOR_LINKAGE,_loc3_,_loc2_.rendererYOffset);
                    _loc1_.validateNow();
                    _loc3_ = _loc3_ + (GAP + _loc1_.width);
                }
                _loc7_ = _loc2_.awards.length;
                _loc8_ = 0;
                while(_loc8_ < _loc7_)
                {
                    _loc1_ = this.placeRenderer(AWARD_LINKAGE,_loc3_,_loc2_.rendererYOffset);
                    _loc1_.setData(_loc2_.awards[_loc8_]);
                    _loc3_ = _loc3_ + (GAP + _loc1_.width);
                    _loc8_++;
                }
                _loc5_++;
            }
            _loc7_ = this._awardItemRenderers.length;
            var _loc6_:* = _loc3_ - GAP >> 1;
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
                this._awardItemRenderers[_loc5_].x = this._awardItemRenderers[_loc5_].x - _loc6_;
                _loc5_++;
            }
        }

        private function placeRenderer(param1:String, param2:int, param3:int) : EventAwardAnim
        {
            var _loc4_:EventAwardAnim = this._classFactory.getComponent(ANIM_LINKAGE,EventAwardAnim);
            _loc4_.setLinkage(param1);
            _loc4_.x = param2;
            _loc4_.y = RENDERER_Y_OFFSET + param3 - (_loc4_.height >> 1);
            this._awardItemRenderers.push(_loc4_);
            addChild(_loc4_);
            return _loc4_;
        }
    }
}
