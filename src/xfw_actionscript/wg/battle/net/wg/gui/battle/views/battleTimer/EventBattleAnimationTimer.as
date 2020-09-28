package net.wg.gui.battle.views.battleTimer
{
    import net.wg.infrastructure.base.meta.impl.EventBattleTimerMeta;
    import net.wg.infrastructure.base.meta.IEventBattleTimerMeta;
    import scaleform.clik.motion.Tween;
    import flash.utils.getTimer;

    public class EventBattleAnimationTimer extends EventBattleTimerMeta implements IEventBattleTimerMeta
    {

        private static const FIRST_FRAME:uint = 1;

        private static const SECOND_FRAME:uint = 2;

        private static const FADE_IN_DURATION:uint = 500;

        private static const FADE_OUT_DURATION:uint = 600;

        private static const FADE_IN_DELAY:uint = FADE_OUT_DURATION + 100;

        public var addTimeAnim:EventAdditionalTimeAnimation = null;

        private var _isEnlarged:Boolean = false;

        private var _tweens:Vector.<Tween>;

        private var _extraTimeUpdateTime:int = 0;

        private var _checkExtraTime:Boolean = false;

        public function EventBattleAnimationTimer()
        {
            this._tweens = new Vector.<Tween>();
            super();
            gotoAndStop(FIRST_FRAME);
        }

        override public function as_setTotalTime(param1:String, param2:String) : void
        {
            super.as_setTotalTime(param1,param2);
            if(this._checkExtraTime)
            {
                if(getTimer() - this._extraTimeUpdateTime < 2000)
                {
                    this.addTimeAnim.updateTextMargin(secondsTF.width - secondsTF.textWidth);
                }
                else
                {
                    this._checkExtraTime = false;
                }
            }
        }

        override protected function onDispose() : void
        {
            this.disposeTweens();
            this._tweens = null;
            this.addTimeAnim.dispose();
            this.addTimeAnim = null;
            super.onDispose();
        }

        public function as_setIsEnlarged(param1:Boolean) : void
        {
            if(this._isEnlarged == param1)
            {
                return;
            }
            this._isEnlarged = param1;
            this.disposeTweens();
            this.blinkTween();
        }

        public function as_showAddExtraTime(param1:String, param2:Boolean) : void
        {
            this._checkExtraTime = true;
            this._extraTimeUpdateTime = getTimer();
            this.addTimeAnim.playAddExtraTime(param1,param2,secondsTF.width - secondsTF.textWidth);
        }

        private function blinkTween() : void
        {
            alpha = 1;
            this._tweens.push(new Tween(FADE_OUT_DURATION,this,{"alpha":0},{"onComplete":this.onItemfadeOutComplete}));
            this._tweens.push(new Tween(FADE_IN_DURATION,this,{"alpha":1},{"delay":FADE_IN_DELAY}));
        }

        private function onItemfadeOutComplete(param1:Tween) : void
        {
            var _loc2_:String = minutesTF.text;
            var _loc3_:String = secondsTF.text;
            if(this._isEnlarged)
            {
                gotoAndStop(SECOND_FRAME);
            }
            else
            {
                gotoAndStop(FIRST_FRAME);
            }
            minutesTF.text = _loc2_;
            secondsTF.text = _loc3_;
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
