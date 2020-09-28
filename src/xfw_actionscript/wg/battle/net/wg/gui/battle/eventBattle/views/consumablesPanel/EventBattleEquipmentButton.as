package net.wg.gui.battle.eventBattle.views.consumablesPanel
{
    import net.wg.gui.battle.views.consumablesPanel.BattleEquipmentButton;
    import net.wg.data.constants.InvalidationType;
    import flash.text.TextField;
    import net.wg.utils.IScheduler;
    import net.wg.data.constants.generated.ANIMATION_TYPES;
    import net.wg.data.constants.Time;
    import scaleform.gfx.TextFieldEx;

    public class EventBattleEquipmentButton extends BattleEquipmentButton
    {

        private static const EQUIPMENT_STAGE_READY:int = 3;

        private static const EQUIPMENT_STAGE_ACTIVE:int = 5;

        private static const EQUIPMENT_STAGE_COOLDOWN:int = 6;

        private static const INVALID_COOLDOWN:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 5;

        private static const INVALID_ABILITY_READY_CHECK:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 6;

        public var activeGlow:EventBattleEquipmentActiveGlow = null;

        public var modifierTF:TextField = null;

        private var _eventGlow:EventBattleEquipmentButtonGlow;

        private var _isAbility:Boolean;

        private var _timeRemaining:Number;

        private var _maxTime:Number;

        private var _startTime:Number;

        private var _animation:int;

        private var _currentTime:int = 0;

        private var _stage:int = 0;

        private var _scheduler:IScheduler = null;

        public function EventBattleEquipmentButton()
        {
            super();
            this._scheduler = App.utils.scheduler;
            if(this.modifierTF != null)
            {
                TextFieldEx.setNoTranslate(this.modifierTF,true);
                this.modifierTF.visible = false;
            }
            this.activeGlow.mouseEnabled = this.activeGlow.mouseChildren = false;
            this._eventGlow = glow as EventBattleEquipmentButtonGlow;
        }

        public function setIsAbility(param1:Boolean) : void
        {
            this._isAbility = param1;
            invalidate(INVALID_COOLDOWN);
            invalidate(INVALID_ABILITY_READY_CHECK);
        }

        override public function clearCoolDownTime() : void
        {
            super.clearCoolDownTime();
            this._scheduler.cancelTask(this.updateCoolDown);
        }

        override public function set activated(param1:Boolean) : void
        {
            super.activated = param1;
            if(param1)
            {
                this._eventGlow.hideText();
                this.activeGlow.glowBlue();
            }
        }

        override protected function setDefaultColor() : void
        {
            cooldownTimerTf.textColor = BLUE_TEXT_COLOR;
            counterBg.gotoAndStop(COOLDOWN_COUNTER_BG_BLUE);
        }

        override public function setCoolDownTime(param1:Number, param2:Number, param3:Number, param4:int = 1) : void
        {
            this._timeRemaining = param1;
            this._maxTime = param2;
            this._startTime = param3;
            this._animation = param4;
            invalidate(INVALID_COOLDOWN);
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            super.draw();
            if(isInvalid(INVALID_COOLDOWN))
            {
                this._scheduler.cancelTask(this.updateCoolDown);
                if(this._isAbility && this._stage == EQUIPMENT_STAGE_ACTIVE)
                {
                    this._currentTime = this._timeRemaining;
                    _loc1_ = ANIMATION_TYPES.MOVE_ORANGE_BAR_DOWN | ANIMATION_TYPES.DARK_COLOR_TRANSFORM | ANIMATION_TYPES.SHOW_PROGRESSBAR_BLUE | ANIMATION_TYPES.SHOW_COUNTER_BLUE;
                    super.setCoolDownTime(this._timeRemaining,this._maxTime,this._startTime,_loc1_);
                    cooldownTimerTf.text = this._currentTime.toString();
                    this._scheduler.scheduleRepeatableTask(this.updateCoolDown,Time.MILLISECOND_IN_SECOND,this._timeRemaining);
                }
                else
                {
                    super.setCoolDownTime(this._timeRemaining,this._maxTime,this._startTime,this._animation);
                }
                switch(this._stage)
                {
                    case EQUIPMENT_STAGE_COOLDOWN:
                        this.activeGlow.hideGlow();
                    case EQUIPMENT_STAGE_ACTIVE:
                        this._eventGlow.hideGlow();
                        break;
                }
            }
            if(isInvalid(INVALID_ABILITY_READY_CHECK))
            {
                if(this._stage == EQUIPMENT_STAGE_READY)
                {
                    if(this._isAbility)
                    {
                        this._eventGlow.abilityReady();
                        this.activeGlow.glowBlue();
                        clearCoolDownText();
                    }
                }
            }
        }

        override public function setStage(param1:int) : void
        {
            this._stage = param1;
            invalidate(INVALID_ABILITY_READY_CHECK);
        }

        override public function showGlow(param1:int) : void
        {
            if(enabled)
            {
                glow.showGlow(param1);
            }
            this.activeGlow.glowBlue();
        }

        override public function hideGlow() : void
        {
            super.hideGlow();
            if(!this._isAbility)
            {
                this.activeGlow.hideGlow();
            }
        }

        override protected function onDispose() : void
        {
            this._scheduler.cancelTask(this.updateCoolDown);
            this._scheduler = null;
            this.modifierTF = null;
            this.activeGlow.dispose();
            this.activeGlow = null;
            this._eventGlow = null;
            super.onDispose();
        }

        private function updateCoolDown() : void
        {
            this._currentTime = this._currentTime - 1;
            cooldownTimerTf.text = this._currentTime.toString();
            if(this._currentTime <= 0)
            {
                this._scheduler.cancelTask(this.updateCoolDown);
            }
        }

        override public function set mouseEnabled(param1:Boolean) : void
        {
            super.buttonMode = param1;
        }
    }
}
