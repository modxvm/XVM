package net.wg.gui.battle.components
{
    import net.wg.infrastructure.base.meta.impl.TimersPanelMeta;
    import net.wg.infrastructure.base.meta.ITimersPanelMeta;
    import net.wg.data.constants.InvalidationType;
    import flash.display.MovieClip;
    import net.wg.utils.IScheduler;
    import net.wg.gui.battle.views.destroyTimers.data.TimersPanelInitVO;
    import net.wg.gui.battle.views.destroyTimers.data.NotificationTimerSettingVO;
    import net.wg.gui.battle.components.interfaces.IStatusNotification;
    import flash.display.DisplayObject;
    import net.wg.data.constants.generated.BATTLE_NOTIFICATIONS_TIMER_TYPES;
    import net.wg.gui.battle.views.destroyTimers.components.secondaryTimerFx.StunTimerFX;
    import net.wg.gui.battle.views.destroyTimers.DestroyTimer;
    import net.wg.gui.battle.views.destroyTimers.SecondaryTimerBase;
    import net.wg.gui.battle.views.destroyTimers.events.DestroyTimerEvent;

    public class TimersPanel extends TimersPanelMeta implements ITimersPanelMeta
    {

        protected static const INVALID_STATE:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;

        protected static const SECONDARY_TIMER_OFFSET_X:int = 110;

        private static const TOP_OFFSET_Y:int = 114;

        private static const TIMER_OFFSET_X:int = 180;

        private static const INVALIDATE_DELAY_TIME:int = 700;

        private static const X_SHIFT:int = 8;

        private static const X_ADDITIONAL_SHIFT:int = TIMER_OFFSET_X - X_SHIFT;

        private static const SHOW_STUN:String = "showStun";

        private static const HIDE_STATUS:String = "hideStatus";

        private static const ONLY_STUN:String = "onlyStun";

        private static const NO_STUN:String = "noStun";

        private static const STATUS_AND_STUN:String = "statusAndStun";

        private static const MAX_DISPLAYED_SECONDARY_TIMERS:int = 2;

        public var statusContainer:MovieClip = null;

        public var secondaryContainer:MovieClip = null;

        protected var stageWidth:int = 0;

        protected var stageHeight:int = 0;

        protected var activeSecondaryTimers:Vector.<int> = null;

        protected var secondaryTimers:Object;

        private var _additionalTopOffset:int = 0;

        private var _statusVisibleBefore:Boolean = false;

        private var _secondaryTimerVisibleBefore:Boolean = false;

        private var _timers:Object;

        private var _stackView:Boolean = true;

        private var _scheduler:IScheduler = null;

        public function TimersPanel()
        {
            this.secondaryTimers = {};
            this._timers = {};
            super();
            this._scheduler = App.utils.scheduler;
        }

        override protected function setInitData(param1:TimersPanelInitVO) : void
        {
            var _loc4_:NotificationTimerSettingVO = null;
            var _loc2_:Vector.<NotificationTimerSettingVO> = param1.mainTimers;
            var _loc3_:IStatusNotification = null;
            for each(_loc4_ in _loc2_)
            {
                _loc3_ = App.utils.classFactory.getComponent(_loc4_.linkage,IStatusNotification);
                _loc3_.setSettings(_loc4_);
                _loc3_.visible = false;
                this.statusContainer.addChild(DisplayObject(_loc3_));
                this._timers[_loc4_.typeId] = _loc3_;
            }
            _loc2_ = param1.secondaryTimers;
            for each(_loc4_ in _loc2_)
            {
                _loc3_ = App.utils.classFactory.getComponent(_loc4_.linkage,IStatusNotification);
                _loc3_.setSettings(_loc4_);
                _loc3_.visible = false;
                this.secondaryContainer.addChild(DisplayObject(_loc3_));
                this.secondaryTimers[_loc4_.typeId] = _loc3_;
                if(_loc4_.typeId == BATTLE_NOTIFICATIONS_TIMER_TYPES.STUN)
                {
                    _loc3_.setTimerFx(new StunTimerFX());
                }
            }
            invalidateState();
        }

        override protected function configUI() : void
        {
            super.configUI();
            mouseChildren = false;
            mouseEnabled = false;
            this.activeSecondaryTimers = new Vector.<int>(0);
        }

        override protected function draw() : void
        {
            var _loc1_:* = false;
            var _loc2_:* = false;
            var _loc3_:DestroyTimer = null;
            var _loc4_:* = 0;
            var _loc5_:DestroyTimer = null;
            super.draw();
            if(isInvalid(INVALID_STATE))
            {
                if(this._stackView)
                {
                    _loc2_ = this.activeSecondaryTimers.length > 0;
                    x = this.stageWidth >> 1;
                    y = (this.stageHeight >> 1) + TOP_OFFSET_Y;
                    for each(_loc3_ in this._timers)
                    {
                        _loc1_ = _loc3_.isActive;
                        if(_loc1_)
                        {
                            break;
                        }
                    }
                    this.evaluateState(_loc1_,_loc2_);
                    this._secondaryTimerVisibleBefore = _loc2_;
                    this._statusVisibleBefore = _loc1_;
                }
                else
                {
                    _loc4_ = 0;
                    for each(_loc5_ in this._timers)
                    {
                        if(_loc5_.isActive)
                        {
                            _loc4_ = _loc4_ + TIMER_OFFSET_X;
                            _loc5_.x = _loc4_;
                        }
                    }
                    _loc4_ = _loc4_ + X_ADDITIONAL_SHIFT;
                    x = this.stageWidth - _loc4_ >> 1;
                    y = (this.stageHeight >> 1) + TOP_OFFSET_Y;
                }
                y = y + this._additionalTopOffset;
                invalidateSize();
            }
        }

        override protected function onDispose() : void
        {
            var _loc1_:DestroyTimer = null;
            var _loc2_:SecondaryTimerBase = null;
            this._scheduler.cancelTask(this.onTimerCompleteTask);
            this._scheduler = null;
            stop();
            for each(_loc1_ in this._timers)
            {
                _loc1_.stop();
                _loc1_.removeEventListener(DestroyTimerEvent.TIMER_HIDDEN_EVENT,this.onCurrentTimerTimerHiddenEventHandler);
                _loc1_.dispose();
                _loc1_ = null;
            }
            this._timers = null;
            for each(_loc2_ in this.secondaryTimers)
            {
                _loc2_.stop();
                this.secondaryContainer.removeChild(_loc2_);
                _loc2_.dispose();
                _loc2_ = null;
            }
            this.secondaryTimers = null;
            this.statusContainer = null;
            this.secondaryContainer = null;
            this.activeSecondaryTimers.splice(0,this.activeSecondaryTimers.length);
            this.activeSecondaryTimers = null;
            super.onDispose();
        }

        public function as_hide(param1:String) : void
        {
            this.hideTimer(this._timers[param1]);
        }

        public function as_hideSecondaryTimer(param1:String) : void
        {
            this.hideSecondaryTimer(param1);
        }

        public function as_setSecondaryTimeSnapshot(param1:String, param2:int, param3:Number) : void
        {
            var _loc4_:SecondaryTimerBase = this.getSecondaryTimer(param1);
            if(!_loc4_)
            {
                return;
            }
            _loc4_.updateRadialTimer(param2,param3);
        }

        public function as_setSecondaryTimerText(param1:String, param2:String, param3:String) : void
        {
            var _loc4_:SecondaryTimerBase = this.getSecondaryTimer(param1);
            if(!_loc4_)
            {
                return;
            }
            _loc4_.setStaticText(param2,param3);
        }

        public function as_setSpeed(param1:Number) : void
        {
            var _loc2_:DestroyTimer = null;
            var _loc3_:SecondaryTimerBase = null;
            for each(_loc2_ in this._timers)
            {
                _loc2_.setSpeed(param1);
            }
            for each(_loc3_ in this.secondaryTimers)
            {
                _loc3_.setSpeed(param1);
            }
        }

        public function as_setTimeInSeconds(param1:String, param2:int, param3:Number) : void
        {
            var param3:Number = Math.round(param3);
            this._timers[param1].updateRadialTimer(param2,param3);
        }

        public function as_setTimeSnapshot(param1:String, param2:int, param3:int) : void
        {
            this._timers[param1].updateRadialTimer(param2,param3);
        }

        public function as_setTimerText(param1:String, param2:String, param3:String) : void
        {
            var _loc4_:DestroyTimer = this._timers[param1];
            if(_loc4_)
            {
                _loc4_.setStaticText(param2,param3);
            }
        }

        public function as_setVerticalOffset(param1:int) : void
        {
            if(this._additionalTopOffset != param1)
            {
                this._additionalTopOffset = param1;
                invalidate(INVALID_STATE);
            }
        }

        public function as_show(param1:String, param2:String, param3:Boolean) : void
        {
            this.showTimer(param1,param2,param3);
        }

        public function as_showSecondaryTimer(param1:String, param2:int, param3:Number, param4:Boolean) : void
        {
            this.showSecondaryTimer(param1,param2,param3,param4);
        }

        public function as_turnOnStackView(param1:Boolean) : void
        {
            this._stackView = param1;
            invalidate(INVALID_STATE);
        }

        public function updateStage(param1:int, param2:int) : void
        {
            this.stageWidth = param1;
            this.stageHeight = param2;
            invalidate(INVALID_STATE);
        }

        protected function hideTimer(param1:DestroyTimer) : void
        {
            param1.resetTimer();
            param1.removeEventListener(DestroyTimerEvent.TIMER_HIDDEN_EVENT,this.onCurrentTimerTimerHiddenEventHandler);
            param1.isActive = false;
            invalidate(INVALID_STATE);
        }

        protected function hideSecondaryTimer(param1:String) : void
        {
            var _loc2_:SecondaryTimerBase = this.getSecondaryTimer(param1);
            if(!_loc2_)
            {
                return;
            }
            var _loc3_:int = this.activeSecondaryTimers.length;
            /*
            if(this.activeSecondaryTimers.indexOf(param1) != -1)
            {
                this.activeSecondaryTimers.splice(this.activeSecondaryTimers.indexOf(param1),1);
            }
            */
            _loc2_.resetTimer();
            _loc2_.isActive = false;
            this._secondaryTimerVisibleBefore = false;
            _loc2_.hideTimer();
            if(_loc3_ > 1)
            {
                this._scheduler.scheduleTask(this.onTimerCompleteTask,INVALIDATE_DELAY_TIME);
            }
            else
            {
                invalidate(INVALID_STATE);
            }
        }

        protected function showTimer(param1:String, param2:String, param3:Boolean) : void
        {
            var _loc4_:DestroyTimer = this._timers[param1];
            _loc4_.addEventListener(DestroyTimerEvent.TIMER_HIDDEN_EVENT,this.onCurrentTimerTimerHiddenEventHandler);
            _loc4_.isActive = true;
            _loc4_.updateViewID(param2,param3);
            _loc4_.visible = true;
            invalidate(INVALID_STATE);
        }

        protected function showSecondaryTimer(param1:String, param2:int, param3:Number, param4:Boolean = false) : void
        {
            var _loc5_:SecondaryTimerBase = this.getSecondaryTimer(param1);
            if(!_loc5_)
            {
                return;
            }
            /*
            if(this.activeSecondaryTimers.indexOf(param1) == -1)
            {
                this.activeSecondaryTimers.push(param1);
            }
            */
            _loc5_.updateRadialTimer(param2,param3);
            _loc5_.visible = true;
            _loc5_.isActive = true;
            _loc5_.showTimer(param4);
            invalidate(INVALID_STATE);
        }

        protected function evaluateState(param1:Boolean, param2:Boolean) : void
        {
            if(param1)
            {
                if(param2)
                {
                    if(!this.statusVisibleBefore)
                    {
                        gotoAndPlay(SHOW_STUN);
                    }
                    else
                    {
                        gotoAndStop(STATUS_AND_STUN);
                    }
                    this.updateSecondaryTimersPositions(true);
                }
                else if(this.secondaryTimerVisibleBefore)
                {
                    gotoAndStop(NO_STUN);
                }
            }
            else if(param2)
            {
                if(this.statusVisibleBefore)
                {
                    gotoAndPlay(HIDE_STATUS);
                }
                else
                {
                    gotoAndStop(ONLY_STUN);
                }
                this.updateSecondaryTimersPositions(false);
            }
            else
            {
                gotoAndStop(NO_STUN);
            }
        }

        protected function updateSecondaryTimersPositions(param1:Boolean) : void
        {
            var _loc2_:SecondaryTimerBase = null;
            var _loc3_:* = 0;
            for each(_loc2_ in this.secondaryTimers)
            {
                if(_loc2_.isActive)
                {
                    if(param1 || this.activeSecondaryTimers.length > 1)
                    {
                        _loc2_.cropSize();
                        _loc2_.x = _loc3_;
                        _loc3_ = _loc3_ + SECONDARY_TIMER_OFFSET_X;
                    }
                    else if(!param1 || this.activeSecondaryTimers.length < MAX_DISPLAYED_SECONDARY_TIMERS)
                    {
                        _loc2_.x = 0;
                        _loc2_.fullSize();
                    }
                }
            }
        }

        protected function getSecondaryTimer(param1:String) : SecondaryTimerBase
        {
            return this.secondaryTimers[param1];
        }

        private function onTimerCompleteTask() : void
        {
            invalidate(INVALID_STATE);
        }

        public function get statusVisibleBefore() : Boolean
        {
            return this._statusVisibleBefore;
        }

        public function set statusVisibleBefore(param1:Boolean) : void
        {
            this._statusVisibleBefore = param1;
        }

        public function get secondaryTimerVisibleBefore() : Boolean
        {
            return this._secondaryTimerVisibleBefore;
        }

        public function set secondaryTimerVisibleBefore(param1:Boolean) : void
        {
            this._secondaryTimerVisibleBefore = param1;
        }

        private function onCurrentTimerTimerHiddenEventHandler(param1:DestroyTimerEvent) : void
        {
            this.hideTimer(param1.destroyTimer);
        }
    }
}
