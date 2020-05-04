package net.wg.gui.lobby.eventAwards.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.utils.FrameHelper;
    import flash.display.FrameLabel;
    import net.wg.gui.lobby.personalMissions.events.AnimationStateEvent;

    public class EventAwardScreenAnim extends UIComponentEx
    {

        protected static const FADE_IN_LABEL:String = "fadeIn";

        protected static const FADE_OUT_LABEL:String = "fadeOut";

        private static const MOVE_START_LABEL:String = "moveStart";

        private static const FADE_IN_COMPLETE_LABEL:String = "fadeInComplete";

        private static const FADE_OUT_COMPLETE_LABEL:String = "fadeOutComplete";

        protected var screenW:Number = 0;

        protected var screenH:Number = 0;

        protected var frameHelper:FrameHelper;

        public function EventAwardScreenAnim()
        {
            super();
            mouseEnabled = mouseChildren = false;
            this.frameHelper = new FrameHelper(this);
            var _loc1_:Array = currentLabels;
            var _loc2_:int = _loc1_.length;
            var _loc3_:uint = 0;
            while(_loc3_ < _loc2_)
            {
                this.handleLabelSubscription(_loc1_[_loc3_]);
                _loc3_++;
            }
        }

        override protected function onDispose() : void
        {
            this.frameHelper.dispose();
            this.frameHelper = null;
            stop();
            super.onDispose();
        }

        public function fadeIn() : void
        {
            gotoAndPlay(FADE_IN_LABEL);
        }

        public function fadeOut() : void
        {
            gotoAndPlay(FADE_OUT_LABEL);
        }

        public function setData(param1:Object) : void
        {
        }

        public function stageUpdate(param1:Number, param2:Number) : void
        {
            this.screenW = param1;
            this.screenH = param2;
        }

        protected function handleLabelSubscription(param1:FrameLabel) : void
        {
            if(param1.name == FADE_IN_COMPLETE_LABEL)
            {
                this.frameHelper.addScriptToFrame(param1.frame,this.onFadeInComplete);
            }
            else if(param1.name == FADE_OUT_COMPLETE_LABEL)
            {
                this.frameHelper.addScriptToFrame(param1.frame,this.onFadeOutComplete);
            }
            else if(param1.name == MOVE_START_LABEL)
            {
                this.frameHelper.addScriptToFrame(param1.frame,this.onMoveStarted);
            }
        }

        protected function onFadeInComplete() : void
        {
            dispatchEvent(new AnimationStateEvent(AnimationStateEvent.FADE_IN_COMPLETE));
        }

        protected function onFadeOutComplete() : void
        {
            dispatchEvent(new AnimationStateEvent(AnimationStateEvent.FADE_OUT_COMPLETE));
        }

        protected function onMoveStarted() : void
        {
            dispatchEvent(new AnimationStateEvent(AnimationStateEvent.MOVE_START));
        }
    }
}
