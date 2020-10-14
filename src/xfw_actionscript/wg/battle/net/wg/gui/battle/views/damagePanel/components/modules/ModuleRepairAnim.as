package net.wg.gui.battle.views.damagePanel.components.modules
{
    import net.wg.gui.battle.views.damagePanel.components.DamagePanelItemFrameStates;
    import net.wg.data.constants.InvalidationType;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
    import flash.utils.getTimer;

    public class ModuleRepairAnim extends DamagePanelItemFrameStates
    {

        private static const DEFAULT_DELAY:int = 20;

        private static const REPAIR_ANIM_COUNT_FRAMES:int = 42;

        private static const FIRST_FRAME_REPAIR_ANIM:int = 1;

        private static const DEFAULT_PLAYBACK_SPEED:Number = 1;

        private static const REPAIRING_PROGRESS_INVALID_MASK:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;

        private static const IS_REPAIRING_INVALID_MASK:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;

        private var _timer:Timer;

        private var _startTime:int;

        private var _animDuration:int;

        private var _playbackSpeed:Number = 1;

        private var _repairPercents:int = 0;

        private var _isRepairing:Boolean = false;

        public function ModuleRepairAnim()
        {
            super();
            stop();
            var _loc1_:int = REPAIR_ANIM_COUNT_FRAMES + FIRST_FRAME_REPAIR_ANIM - currentFrame + 1;
            this._timer = new Timer(DEFAULT_DELAY,_loc1_);
            this._timer.addEventListener(TimerEvent.TIMER,this.onTimerHandler);
            this._timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerCompleteHandler);
        }

        override protected function onDispose() : void
        {
            this._timer.stop();
            this._timer.removeEventListener(TimerEvent.TIMER,this.onTimerHandler);
            this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerCompleteHandler);
            this._timer = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.STATE))
            {
                visible = state != BATTLE_ITEM_STATES.DESTROYED && state != BATTLE_ITEM_STATES.NORMAL;
            }
            if(isInvalid(IS_REPAIRING_INVALID_MASK))
            {
                visible = this._isRepairing;
            }
            if(isInvalid(REPAIRING_PROGRESS_INVALID_MASK))
            {
                gotoAndStop(this.currentRepairFrame(this._repairPercents));
            }
        }

        public function setPlaybackSpeed(param1:Number) : void
        {
            var _loc2_:* = NaN;
            var _loc3_:* = 0;
            if(param1 < 1.0E-4)
            {
                var param1:Number = 1.0E-4;
            }
            if(this._timer.running)
            {
                _loc2_ = this._playbackSpeed / param1;
                _loc3_ = getTimer();
                this._startTime = _loc3_ - (_loc3_ - this._startTime) * _loc2_;
                this._animDuration = this._animDuration * _loc2_;
                this._timer.delay = this._timer.delay * _loc2_;
            }
            this._playbackSpeed = param1;
        }

        public function setRepairSeconds(param1:int, param2:int) : void
        {
            this.setRepairing(true);
            this.updateTimer(param1,param2);
            this._repairPercents = param1;
            invalidate(REPAIRING_PROGRESS_INVALID_MASK);
        }

        private function updateTimer(param1:int, param2:int) : void
        {
            var param2:int = param2 / this._playbackSpeed;
            var _loc3_:int = param1 * param2 / (100 - param1);
            var _loc4_:int = getTimer();
            this._startTime = _loc4_ - _loc3_;
            var _loc5_:int = _loc4_ + param2;
            this._animDuration = _loc5_ - this._startTime;
            var _loc6_:int = REPAIR_ANIM_COUNT_FRAMES + FIRST_FRAME_REPAIR_ANIM - this.currentRepairFrame(param1);
            var _loc7_:int = param2 / _loc6_;
            this._timer.reset();
            this._timer.delay = _loc7_;
            this._timer.repeatCount = _loc6_;
            this._timer.start();
        }

        private function currentRepairFrame(param1:int) : int
        {
            return FIRST_FRAME_REPAIR_ANIM + param1 * REPAIR_ANIM_COUNT_FRAMES / 100 | 0;
        }

        private function setRepairing(param1:Boolean) : void
        {
            if(this._isRepairing == param1)
            {
                return;
            }
            this._isRepairing = param1;
            invalidate(IS_REPAIRING_INVALID_MASK);
        }

        override public function set state(param1:String) : void
        {
            super.state = param1;
            this.setRepairing(false);
            this._timer.stop();
        }

        private function onTimerHandler(param1:TimerEvent) : void
        {
            this._repairPercents = 100 * (getTimer() - this._startTime) / this._animDuration;
            invalidate(REPAIRING_PROGRESS_INVALID_MASK);
        }

        private function onTimerCompleteHandler(param1:TimerEvent = null) : void
        {
            this.setRepairing(false);
        }
    }
}
