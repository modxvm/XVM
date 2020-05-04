package net.wg.gui.battle.components
{
    import net.wg.infrastructure.base.meta.impl.DestroyTimersPanelMeta;
    import net.wg.infrastructure.base.meta.IDestroyTimersPanelMeta;
    import net.wg.data.constants.generated.BATTLE_DESTROY_TIMER_STATES;
    import flash.utils.Dictionary;
    import net.wg.gui.battle.views.destroyTimers.components.SecondaryTimerSetting;
    import net.wg.data.constants.Linkages;
    import net.wg.gui.battle.views.destroyTimers.components.SecondaryTimerContainer;
    import net.wg.data.constants.InvalidationType;
    import flash.display.MovieClip;
    import net.wg.gui.battle.views.destroyTimers.SecondaryTimer;
    import net.wg.gui.battle.views.destroyTimers.DestroyTimer;
    import net.wg.utils.IScheduler;
    import net.wg.gui.battle.views.destroyTimers.components.secondaryTimerFx.StunTimerFX;
    import net.wg.gui.battle.views.destroyTimers.events.DestroyTimerEvent;

    public class DestroyTimersPanel extends DestroyTimersPanelMeta implements IDestroyTimersPanelMeta
    {

        protected static const INVALID_STATE:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;

        private static const TOP_OFFSET_Y:int = 114;

        private static const TIMER_OFFSET_X:int = 180;

        private static const SECONDARY_TIMER_OFFSET_X:int = 110;

        private static const INVALIDATE_DELAY_TIME:int = 700;

        private static const X_SHIFT:int = 8;

        private static const X_ADDITIONAL_SHIFT:int = TIMER_OFFSET_X - X_SHIFT;

        private static const SHOW_STUN:String = "showStun";

        private static const HIDE_STATUS:String = "hideStatus";

        private static const ONLY_STUN:String = "onlyStun";

        private static const NO_STUN:String = "noStun";

        private static const STATUS_AND_STUN:String = "statusAndStun";

        private static const SECONDARY_TIMER_NAME:String = "secondaryTimer";

        private static const MAX_DISPLAYED_SECONDARY_TIMERS:int = 2;

        public var statusContainer:MovieClip = null;

        public var secondaryContainer:MovieClip = null;

        protected var stageWidth:int = 0;

        protected var stageHeight:int = 0;

        private var _additionalTopOffset:int = 0;

        private var _statusVisibleBefore:Boolean = false;

        private var _secondaryTimerVisibleBefore:Boolean = false;

        private var _secondaryTimers:Vector.<SecondaryTimer>;

        private var _activeSecondaryTimers:Vector.<int> = null;

        private var _secondaryTimerIDs:Vector.<int> = null;

        private var _timers:Vector.<DestroyTimer>;

        private var _stackView:Boolean = true;

        private var _scheduler:IScheduler = null;

        public function DestroyTimersPanel()
        {
            this._secondaryTimers = new Vector.<SecondaryTimer>();
            this._timers = new Vector.<DestroyTimer>();
            super();
            this._scheduler = App.utils.scheduler;
        }

        private static function getSecondaryTimerIDs() : Vector.<int>
        {
            return new <int>[BATTLE_DESTROY_TIMER_STATES.STUN,BATTLE_DESTROY_TIMER_STATES.CAPTURE_BLOCK,BATTLE_DESTROY_TIMER_STATES.SMOKE,BATTLE_DESTROY_TIMER_STATES.INSPIRE,BATTLE_DESTROY_TIMER_STATES.INSPIRE_CD];
        }

        private static function generateSecondaryTimerSettings() : Dictionary
        {
            var _loc1_:Dictionary = new Dictionary();
            _loc1_[BATTLE_DESTROY_TIMER_STATES.STUN] = new SecondaryTimerSetting(INGAME_GUI.STUN_INDICATOR,Linkages.STUN_ICON,SecondaryTimerContainer.ORANGE_STATE,true,false);
            _loc1_[BATTLE_DESTROY_TIMER_STATES.CAPTURE_BLOCK] = new SecondaryTimerSetting(EPIC_BATTLE.PROGRESS_TIMERS_BLOCKED,Linkages.BLOCKED_ICON,SecondaryTimerContainer.ORANGE_STATE,false,false);
            _loc1_[BATTLE_DESTROY_TIMER_STATES.SMOKE] = new SecondaryTimerSetting(EPIC_BATTLE.SMOKE_IN_SMOKE,Linkages.SMOKE_ICON,SecondaryTimerContainer.GREEN_STATE,false,false);
            _loc1_[BATTLE_DESTROY_TIMER_STATES.INSPIRE] = new SecondaryTimerSetting(EPIC_BATTLE.INSPIRE_INSPIRED,Linkages.INSPIRE_ICON,SecondaryTimerContainer.GREEN_STATE,false,true);
            _loc1_[BATTLE_DESTROY_TIMER_STATES.INSPIRE_CD] = new SecondaryTimerSetting(EPIC_BATTLE.INSPIRE_INSPIRED,Linkages.INSPIRE_ICON,SecondaryTimerContainer.GREEN_STATE,false,false);
            return _loc1_;
        }

        override protected function configUI() : void
        {
            var _loc1_:String = null;
            var _loc2_:DestroyTimer = null;
            var _loc4_:* = 0;
            var _loc5_:Dictionary = null;
            var _loc6_:SecondaryTimer = null;
            var _loc7_:* = 0;
            var _loc8_:* = 0;
            super.configUI();
            mouseChildren = false;
            mouseEnabled = false;
            var _loc3_:Vector.<String> = this.getTimersIcons();
            for each(_loc1_ in _loc3_)
            {
                _loc2_ = App.utils.classFactory.getComponent(Linkages.DESTROY_TIMER_UI,DestroyTimer);
                _loc2_.stop();
                _loc2_.visible = false;
                _loc2_.setIcon(_loc1_);
                this.statusContainer.addChild(_loc2_);
                this._timers.push(_loc2_);
            }
            this._activeSecondaryTimers = new Vector.<int>(0);
            this._secondaryTimerIDs = getSecondaryTimerIDs();
            _loc4_ = this._secondaryTimerIDs.length;
            _loc5_ = generateSecondaryTimerSettings();
            this._secondaryTimers = new Vector.<SecondaryTimer>(0);
            _loc7_ = 0;
            while(_loc7_ < _loc4_)
            {
                _loc8_ = this._secondaryTimerIDs[_loc7_];
                _loc6_ = App.utils.classFactory.getComponent(Linkages.SECONDARY_TIMER_UI,SecondaryTimer);
                _loc6_.name = SECONDARY_TIMER_NAME;
                _loc6_.setSettings(_loc5_[_loc8_]);
                _loc6_.stop();
                _loc6_.visible = false;
                _loc6_.mouseEnabled = false;
                _loc6_.mouseChildren = false;
                this.secondaryContainer.addChild(_loc6_);
                this._secondaryTimers.push(_loc6_);
                if(_loc8_ == BATTLE_DESTROY_TIMER_STATES.STUN)
                {
                    _loc6_.setTimerFx(new StunTimerFX());
                }
                _loc7_++;
            }
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
                    _loc2_ = this._activeSecondaryTimers.length > 0;
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
            var _loc2_:SecondaryTimer = null;
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
            this._timers.splice(0,this._timers.length);
            this._timers = null;
            for each(_loc2_ in this._secondaryTimers)
            {
                _loc2_.stop();
                this.secondaryContainer.removeChild(_loc2_);
                _loc2_.dispose();
                _loc2_ = null;
            }
            this._secondaryTimers.splice(0,this._secondaryTimers.length);
            this._secondaryTimers = null;
            this.statusContainer = null;
            this.secondaryContainer = null;
            this._activeSecondaryTimers.splice(0,this._activeSecondaryTimers.length);
            this._activeSecondaryTimers = null;
            this._secondaryTimerIDs.splice(0,this._secondaryTimerIDs.length);
            this._secondaryTimerIDs = null;
            super.onDispose();
        }

        public function as_hide(param1:int) : void
        {
            this.hideTimer(this._timers[param1]);
        }

        public function as_hideSecondaryTimer(param1:int) : void
        {
            this.hideSecondaryTimer(param1);
        }

        public function as_setSecondaryTimeSnapshot(param1:int, param2:int, param3:Number) : void
        {
            var _loc4_:SecondaryTimer = this.getSecondaryTimer(param1);
            if(!_loc4_)
            {
                return;
            }
            _loc4_.updateRadialTimer(param2,param3);
        }

        public function as_setSecondaryTimerText(param1:int, param2:String) : void
        {
            var _loc3_:SecondaryTimer = this.getSecondaryTimer(param1);
            if(!_loc3_)
            {
                return;
            }
            _loc3_.setStaticText(param2);
        }

        public function as_setSpeed(param1:Number) : void
        {
            var _loc2_:DestroyTimer = null;
            var _loc3_:SecondaryTimer = null;
            for each(_loc2_ in this._timers)
            {
                _loc2_.setSpeed(param1);
            }
            for each(_loc3_ in this._secondaryTimers)
            {
                _loc3_.setSpeed(param1);
            }
        }

        public function as_setTimeInSeconds(param1:int, param2:int, param3:Number) : void
        {
            var param3:Number = Math.round(param3);
            this._timers[param1].updateRadialTimer(param2,param3);
        }

        public function as_setTimeSnapshot(param1:int, param2:int, param3:int) : void
        {
            this._timers[param1].updateRadialTimer(param2,param3);
        }

        public function as_setVerticalOffset(param1:int) : void
        {
            if(this._additionalTopOffset != param1)
            {
                this._additionalTopOffset = param1;
                invalidate(INVALID_STATE);
            }
        }

        public function as_show(param1:int, param2:int, param3:Boolean) : void
        {
            this.showTimer(param1,param2,param3);
        }

        public function as_showSecondaryTimer(param1:int, param2:int, param3:Number, param4:Boolean) : void
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

        protected function hideSecondaryTimer(param1:int) : void
        {
            var _loc2_:SecondaryTimer = this.getSecondaryTimer(param1);
            if(!_loc2_)
            {
                return;
            }
            var _loc3_:int = this._activeSecondaryTimers.length;
            if(this._activeSecondaryTimers.indexOf(param1) != -1)
            {
                this._activeSecondaryTimers.splice(this._activeSecondaryTimers.indexOf(param1),1);
            }
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

        protected function showTimer(param1:int, param2:int, param3:Boolean) : void
        {
            var _loc4_:DestroyTimer = this._timers[param1];
            _loc4_.addEventListener(DestroyTimerEvent.TIMER_HIDDEN_EVENT,this.onCurrentTimerTimerHiddenEventHandler);
            _loc4_.isActive = true;
            _loc4_.updateViewID(param2,param3);
            _loc4_.visible = true;
            invalidate(INVALID_STATE);
        }

        protected function showSecondaryTimer(param1:int, param2:int, param3:Number, param4:Boolean = false) : void
        {
            var _loc5_:SecondaryTimer = this.getSecondaryTimer(param1);
            if(!_loc5_)
            {
                return;
            }
            if(this._activeSecondaryTimers.indexOf(param1) == -1)
            {
                this._activeSecondaryTimers.push(param1);
            }
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
                    if(!this._statusVisibleBefore)
                    {
                        gotoAndPlay(SHOW_STUN);
                    }
                    else
                    {
                        gotoAndStop(STATUS_AND_STUN);
                    }
                    this.updateSecondaryTimersPositions(true);
                }
                else if(this._secondaryTimerVisibleBefore)
                {
                    gotoAndStop(NO_STUN);
                }
            }
            else if(param2)
            {
                if(this._statusVisibleBefore)
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

        protected function getTimersIcons() : Vector.<String>
        {
            return new <String>[Linkages.DROWN_ICON,Linkages.DEATHZONE_ICON,Linkages.OVERTURNED_ICON,Linkages.FIRE_ICON,Linkages.EVENT_DEATH_ZONE,Linkages.EVENT_PERSONAL_DEATH_ZONE];
        }

        private function updateSecondaryTimersPositions(param1:Boolean) : void
        {
            var _loc2_:SecondaryTimer = null;
            var _loc3_:* = 0;
            for each(_loc2_ in this._secondaryTimers)
            {
                if(_loc2_.isActive)
                {
                    if(param1 || this._activeSecondaryTimers.length > 1)
                    {
                        _loc2_.cropSize();
                        _loc2_.x = _loc3_;
                        _loc3_ = _loc3_ + SECONDARY_TIMER_OFFSET_X;
                    }
                    else if(!param1 || this._activeSecondaryTimers.length < MAX_DISPLAYED_SECONDARY_TIMERS)
                    {
                        _loc2_.x = 0;
                        _loc2_.fullSize();
                    }
                }
            }
        }

        private function getSecondaryTimer(param1:int) : SecondaryTimer
        {
            return this._secondaryTimers[this._secondaryTimerIDs.indexOf(param1)];
        }

        private function onTimerCompleteTask() : void
        {
            invalidate(INVALID_STATE);
        }

        private function onCurrentTimerTimerHiddenEventHandler(param1:DestroyTimerEvent) : void
        {
            this.hideTimer(param1.destroyTimer);
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
    }
}
