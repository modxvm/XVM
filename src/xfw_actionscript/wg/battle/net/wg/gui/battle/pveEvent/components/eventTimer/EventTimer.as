package net.wg.gui.battle.pveEvent.components.eventTimer
{
    import net.wg.infrastructure.base.meta.impl.EventTimerMeta;
    import net.wg.infrastructure.base.meta.IEventTimerMeta;
    import net.wg.data.constants.InvalidationType;
    import net.wg.gui.battle.pveEvent.components.eventTimer.controls.TimerMovie;
    import flash.display.MovieClip;
    import net.wg.gui.battle.pveEvent.components.eventTimer.controls.TimerTask;
    import net.wg.gui.battle.pveEvent.components.eventTimer.controls.TimerMessage;
    import net.wg.gui.battle.pveEvent.components.eventTimer.controls.TimerPhase;
    import org.idmedia.as3commons.util.StringUtils;

    public class EventTimer extends EventTimerMeta implements IEventTimerMeta
    {

        private static const STATE_VALIDATION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;

        private static const STATE_SMALL:String = "go_small";

        private static const STATE_BIG:String = "go_big";

        private static const STATE_SMALL_IDLE:String = "small";

        private static const STATE_BIG_IDLE:String = "big";

        private static const STATE_APPEAR:String = "appear";

        private static const STATE_DISAPPEAR:String = "disappear";

        private static const HINT_NO_TIMER_Y:int = 43;

        private static const HINT_TIMER_Y:int = 84;

        public var timer:TimerMovie = null;

        public var hintBg:MovieClip = null;

        public var hintTask:TimerTask = null;

        public var timerMessage:TimerMessage = null;

        public var phase:TimerPhase = null;

        private var _state:int = -1;

        private var _header:String = "";

        private var _objective:String = "";

        private var _objectiveBig:String = "";

        private var _time:String = "";

        public function EventTimer()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.mouseChildren = false;
            this.mouseEnabled = false;
            this.hintBg.visible = false;
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(STATE_VALIDATION))
            {
                if(StringUtils.isEmpty(this._time))
                {
                    this.hintTask.y = HINT_NO_TIMER_Y;
                }
                else
                {
                    this.hintTask.y = HINT_TIMER_Y;
                }
                this.hintTask.setText(this._header,this._objectiveBig);
                this.timer.setText(this._objective);
                this.timer.setTimer(this._time);
            }
        }

        override protected function onDispose() : void
        {
            this.timerMessage.dispose();
            this.timerMessage = null;
            this.timer.dispose();
            this.timer = null;
            this.phase.dispose();
            this.phase = null;
            this.hintTask.dispose();
            this.hintTask = null;
            this.hintBg = null;
            super.onDispose();
        }

        public function as_hideMessage() : void
        {
            this.timerMessage.hideMessage();
        }

        public function as_updateProgressPhase(param1:int, param2:int) : void
        {
            this.phase.setProgress(param1,param2);
            if(!this.phase.visible)
            {
                this.phase.visible = true;
            }
        }

        public function as_playFx(param1:Boolean, param2:Boolean) : void
        {
            this.timer.playFx(param1,param2);
        }

        public function as_setTimerBackground(param1:Boolean) : void
        {
            this.hintBg.visible = true;
            if(param1)
            {
                this.timer.gotoAndPlay(STATE_APPEAR);
            }
            var _loc2_:String = param1?STATE_APPEAR:STATE_DISAPPEAR;
            if(this.hintBg)
            {
                this.hintBg.gotoAndPlay(_loc2_);
            }
            if(this.hintTask)
            {
                this.hintTask.gotoAndPlay(_loc2_);
            }
            invalidate(STATE_VALIDATION);
        }

        public function as_setTimerState(param1:int) : void
        {
            var _loc2_:String = null;
            if(this._state != param1)
            {
                this._state = param1;
                if(param1 == 0)
                {
                    this.timer.gotoAndPlay(STATE_SMALL);
                }
                else
                {
                    this.timer.gotoAndPlay(STATE_BIG);
                }
                invalidate(STATE_VALIDATION);
            }
            else
            {
                _loc2_ = param1 == 0?STATE_SMALL_IDLE:STATE_BIG_IDLE;
                if(_loc2_ != this.timer.currentLabel)
                {
                    this.timer.gotoAndStop(_loc2_);
                    invalidate(STATE_VALIDATION);
                }
            }
        }

        public function as_showMessage(param1:String) : void
        {
            this.timerMessage.showMessage(param1);
        }

        public function as_updateObjectiveBig(param1:String) : void
        {
            this._objectiveBig = param1;
            invalidate(STATE_VALIDATION);
        }

        public function as_updateObjective(param1:String) : void
        {
            this._objective = param1;
            invalidate(STATE_VALIDATION);
        }

        public function as_updateProgressBar(param1:int, param2:Boolean) : void
        {
            this.timer.updateProgressBar(param1,param2);
        }

        public function as_updateTime(param1:String) : void
        {
            this._time = param1;
            invalidate(STATE_VALIDATION);
        }

        public function as_updateTitle(param1:String) : void
        {
            this._header = param1;
            invalidate(STATE_VALIDATION);
        }

        public function updateStage(param1:int, param2:int) : void
        {
            this.hintBg.width = param1;
            this.hintBg.x = -this.hintBg.width >> 1;
            this.phase.x = param1 >> 1;
        }
    }
}
