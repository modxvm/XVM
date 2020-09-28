package net.wg.gui.battle.views.postmortemPanel
{
    import net.wg.infrastructure.base.meta.impl.EventPostmortemPanelMeta;
    import net.wg.infrastructure.base.meta.IEventPostmortemPanelMeta;
    import flash.text.TextField;
    import scaleform.clik.motion.Tween;
    import net.wg.data.VO.UserVO;
    import net.wg.data.constants.Values;

    public class EventPostmortemPanel extends EventPostmortemPanelMeta implements IEventPostmortemPanelMeta
    {

        private static const OBSERVER_X:int = -33;

        private static const OBSERVER_X_BIG:int = -182;

        private static const FADE_DURATION:uint = 300;

        private static const FADE_DELAY:uint = 200;

        private static const FADE_IN_TARGET_ALPHA:uint = 1;

        public var timer:EventPostmortemTimer = null;

        public var hintTitleTF:TextField = null;

        public var hintDescTF:TextField = null;

        private var _tweens:Vector.<Tween>;

        public function EventPostmortemPanel()
        {
            this._tweens = new Vector.<Tween>();
            super();
            this.timer.visible = false;
        }

        override protected function onDispose() : void
        {
            this.disposeTweens();
            this._tweens = null;
            this.timer.dispose();
            this.timer = null;
            this.hintTitleTF = null;
            this.hintDescTF = null;
            super.onDispose();
        }

        override protected function setDeadReasonInfo(param1:String, param2:Boolean, param3:String, param4:String, param5:String, param6:String, param7:UserVO) : void
        {
            super.setDeadReasonInfo(param1,param2,param3,param4,param5,param6,null);
        }

        override protected function updatePlayerInfoPosition() : void
        {
            playerInfoTF.y = -BasePostmortemPanel.PLAYER_INFO_DELTA_Y - (App.appHeight >> 1);
        }

        public function as_setCanExit(param1:Boolean) : void
        {
            exitToHangarTitleTF.visible = param1;
            exitToHangarDescTF.visible = param1;
            observerModeTitleTF.visible = true;
            observerModeDescTF.visible = true;
            observerModeDescTF.x = observerModeTitleTF.x = param1?OBSERVER_X_BIG:OBSERVER_X;
        }

        public function as_setHintDescr(param1:String) : void
        {
            this.hintDescTF.htmlText = param1;
        }

        public function as_setHintTitle(param1:String) : void
        {
            this.hintTitleTF.text = param1;
        }

        public function as_setTimer(param1:int) : void
        {
            this.timer.visible = param1 > 0;
            bg.visible = observerModeTitleTF.visible = observerModeDescTF.visible = exitToHangarTitleTF.visible = exitToHangarDescTF.visible = !this.timer.visible;
            if(this.timer.visible)
            {
                this.timer.setLockedState(false);
                this.timer.updateRadialTimer(param1,0);
                this.fadeInTimer();
            }
            else
            {
                this.timer.stopTimer();
                this.fadeOutTimer();
            }
        }

        public function as_showLockedLives() : void
        {
            this.timer.setLockedState(true);
            this.timer.visible = true;
        }

        public function fadeInTimer() : void
        {
            this.hintTitleTF.alpha = this.hintDescTF.alpha = this.timer.alpha = 0;
            this.setupTweens(FADE_IN_TARGET_ALPHA);
        }

        public function fadeOutTimer() : void
        {
            this.hintTitleTF.alpha = this.hintDescTF.alpha = this.timer.alpha = 1;
            this.setupTweens(Values.ZERO);
        }

        private function setupTweens(param1:Number) : void
        {
            this.disposeTweens();
            this._tweens.push(new Tween(FADE_DURATION,this.hintTitleTF,{"alpha":param1}));
            this._tweens.push(new Tween(FADE_DURATION,this.hintDescTF,{"alpha":param1}));
            this._tweens.push(new Tween(FADE_DURATION,this.timer,{"alpha":param1},{"delay":FADE_DELAY}));
        }

        private function disposeTweens() : void
        {
            var _loc1_:Tween = null;
            for each(_loc1_ in this._tweens)
            {
                _loc1_.paused = true;
                _loc1_.dispose();
            }
            this._tweens.length = 0;
        }
    }
}
