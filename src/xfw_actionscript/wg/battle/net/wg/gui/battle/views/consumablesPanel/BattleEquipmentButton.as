package net.wg.gui.battle.views.consumablesPanel
{
    import net.wg.gui.battle.components.buttons.BattleToolTipButton;
    import net.wg.gui.battle.views.consumablesPanel.interfaces.IConsumablesButton;
    import net.wg.gui.battle.components.interfaces.ICoolDownCompleteHandler;
    import net.wg.data.constants.InvalidationType;
    import net.wg.gui.components.controls.UILoaderAlt;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.geom.ColorTransform;
    import net.wg.gui.battle.views.consumablesPanel.VO.ConsumablesVO;
    import net.wg.gui.battle.components.CoolDownTimer;
    import net.wg.utils.IScheduler;
    import net.wg.data.constants.KeyProps;
    import net.wg.gui.battle.views.consumablesPanel.constants.COLOR_STATES;
    import net.wg.data.constants.InteractiveStates;
    import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
    import net.wg.data.constants.generated.CONSUMABLES_PANEL_SETTINGS;
    import net.wg.data.constants.Values;

    public class BattleEquipmentButton extends BattleToolTipButton implements IConsumablesButton, ICoolDownCompleteHandler
    {

        public static const COOLDOWN_START_FRAME:int = 0;

        protected static const KEY_VALIDATION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;

        private static const COOLDOWN_COUNTER_BG_RED:String = "red";

        private static const COOLDOWN_COUNTER_BG_GREEN:String = "green";

        private static const COOLDOWN_COUNTER_BG_HIDE:String = "hide";

        private static const COOLDOWN_END_FRAME:int = 51;

        private static const DEFAULT_TIME_COEF:Number = 1;

        private static const INTERVAL_SIZE:Number = 1000;

        private static const COOLDOWN_TEXT_COLOR:uint = 16768409;

        private static const NORMAL_TEXT_COLOR:uint = 11854471;

        public var iconLoader:UILoaderAlt = null;

        public var hit:MovieClip = null;

        public var consumableBackground:MovieClip = null;

        public var glow:BattleEquipmentButtonGlow = null;

        public var cooldownTimerTf:TextField = null;

        public var counterBg:MovieClip = null;

        public var cooldown:MovieClip = null;

        public var isReplay:Boolean;

        private var _lockColorTransform:Boolean = false;

        private var _isPermanent:Boolean;

        private var _isActivated:Boolean;

        private var _bindSfKeyCode:Number;

        private var _isEmpty:Boolean;

        private var _delayColorTransform:ColorTransform = null;

        private var _consumablesVO:ConsumablesVO = null;

        private var _isReloading:Boolean = false;

        private var _coolDownTimer:CoolDownTimer = null;

        private var _currentIntervalTime:int;

        private var _baseTime:int = 0;

        private var _firstShow:Boolean = true;

        private var _isBaseTimeSnapshot:Boolean = false;

        private var _scheduler:IScheduler;

        public function BattleEquipmentButton()
        {
            this._scheduler = App.utils.scheduler;
            super();
            this._coolDownTimer = new CoolDownTimer(this.cooldown);
            this._coolDownTimer.setFrames(COOLDOWN_START_FRAME,COOLDOWN_END_FRAME);
            isAllowedToShowToolTipOnDisabledState = true;
            this._consumablesVO = new ConsumablesVO();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.hit.mouseEnabled = false;
            hitArea = this.hit;
            this.consumableBackground.visible = false;
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(KEY_VALIDATION))
            {
                if(this._bindSfKeyCode == KeyProps.KEY_NONE)
                {
                    this.glow.setBindKeyText(App.utils.locale.makeString(READABLE_KEY_NAMES.KEY_NONE_ALT));
                }
                else
                {
                    this.glow.setBindKeyText(App.utils.commons.keyToString(this._bindSfKeyCode).keyName);
                }
            }
        }

        override protected function onDispose() : void
        {
            this._scheduler.cancelTask(this.intervalRun);
            this._scheduler = null;
            this.iconLoader.dispose();
            this.iconLoader = null;
            this.cooldownTimerTf = null;
            this.glow.dispose();
            this.glow = null;
            this._delayColorTransform = null;
            this._consumablesVO = null;
            this.counterBg = null;
            this._coolDownTimer.dispose();
            this._coolDownTimer = null;
            this.consumableBackground = null;
            this.cooldown = null;
            this.hit = null;
            super.onDispose();
        }

        public function clearColorTransform() : void
        {
            if(this._isReloading)
            {
                return;
            }
            this._delayColorTransform = null;
            if(this._lockColorTransform)
            {
                return;
            }
            this.iconLoader.transform.colorTransform = COLOR_STATES.NORMAL_COLOR_TRANSFORM;
        }

        public function clearCoolDownTime() : void
        {
            this._isActivated = false;
            this._coolDownTimer.end();
            this._isReloading = false;
            this.state = InteractiveStates.UP;
            if(this._baseTime > 0)
            {
                if(!this._firstShow)
                {
                    this.cooldownTimerTf.text = this._baseTime.toString();
                }
            }
            else
            {
                this.clearCoolDownText();
            }
        }

        public function flushColorTransform() : void
        {
            this._lockColorTransform = this._isEmpty;
            if(this._delayColorTransform)
            {
                if(!this._lockColorTransform)
                {
                    this.setColorTransform(this._delayColorTransform);
                    this._delayColorTransform = null;
                }
            }
            else
            {
                this.clearColorTransform();
            }
        }

        public function hideGlow() : void
        {
            this.glow.hideGlow();
        }

        public function onCoolDownComplete() : void
        {
        }

        public function setActivated() : void
        {
            this.state = BATTLE_ITEM_STATES.RELOADED;
            this._isActivated = true;
        }

        public function setColorTransform(param1:ColorTransform) : void
        {
            if(this._lockColorTransform)
            {
                this._delayColorTransform = param1;
                return;
            }
            if(param1)
            {
                this.iconLoader.transform.colorTransform = param1;
            }
        }

        public function setCoolDownPosAsPercent(param1:Number) : void
        {
            if(param1 < 100)
            {
                this._coolDownTimer.setPositionAsPercent(param1);
            }
            else if(!this.isReplay)
            {
                this.setCoolDownTime(0,this._baseTime,0,false);
            }
        }

        public function setCoolDownTime(param1:Number, param2:Number, param3:Number, param4:Boolean) : void
        {
            this._isActivated = false;
            this._isPermanent = false;
            this._baseTime = param2;
            if(param1 > 0)
            {
                this._firstShow = false;
                this._isReloading = true;
                this.setColorTransform(COLOR_STATES.DARK_COLOR_TRANSFORM);
                this._lockColorTransform = true;
                this.cooldownTimerTf.textColor = COOLDOWN_TEXT_COLOR;
                this._delayColorTransform = COLOR_STATES.DARK_COLOR_TRANSFORM;
                this.counterBg.gotoAndStop(COOLDOWN_COUNTER_BG_RED);
                if(!this.isReplay)
                {
                    this._currentIntervalTime = param2 - param3 + 1;
                    this._coolDownTimer.start(param1,this,(COOLDOWN_END_FRAME - COOLDOWN_START_FRAME) * param3 / param2,DEFAULT_TIME_COEF);
                    this.intervalRun();
                    this._scheduler.scheduleRepeatableTask(this.intervalRun,INTERVAL_SIZE,param2);
                }
            }
            else
            {
                this._isReloading = false;
                this._coolDownTimer.end();
                this._scheduler.cancelTask(this.intervalRun);
                this._delayColorTransform = null;
                this.flushColorTransform();
                this.cooldownTimerTf.textColor = NORMAL_TEXT_COLOR;
                this.counterBg.gotoAndStop(COOLDOWN_COUNTER_BG_GREEN);
                if(param2 > 0)
                {
                    this.cooldownTimerTf.text = param2.toString();
                }
                if(param1 == -1)
                {
                    this.clearCoolDownText();
                    this._isPermanent = true;
                    super.state = BATTLE_ITEM_STATES.PERMANENT;
                }
                else if(param1 == 0)
                {
                    this.clearCoolDownTime();
                }
            }
        }

        public function setTimerSnapshot(param1:int, param2:Boolean) : void
        {
            this.cooldownTimerTf.text = param1.toString();
            if(this._isBaseTimeSnapshot != param2)
            {
                this._isBaseTimeSnapshot = param2;
                if(param2)
                {
                    this.cooldownTimerTf.textColor = NORMAL_TEXT_COLOR;
                    this.clearColorTransform();
                }
                else
                {
                    this.cooldownTimerTf.textColor = COOLDOWN_TEXT_COLOR;
                    this.setColorTransform(COLOR_STATES.DARK_COLOR_TRANSFORM);
                }
            }
        }

        public function showGlow(param1:int) : void
        {
            if(!enabled || this._isReloading)
            {
                return;
            }
            if(param1 == CONSUMABLES_PANEL_SETTINGS.GLOW_ID_GREEN)
            {
                this.glow.glowGreen();
            }
            else if(param1 == CONSUMABLES_PANEL_SETTINGS.GLOW_ID_ORANGE)
            {
                this.glow.glowOrange();
            }
            else if(param1 == CONSUMABLES_PANEL_SETTINGS.GLOW_ID_GREEN_SPECIAL)
            {
                this.glow.glowGreenSpecial();
            }
        }

        private function intervalRun() : void
        {
            this._currentIntervalTime = this._currentIntervalTime - 1;
            this.cooldownTimerTf.text = this._currentIntervalTime.toString();
        }

        private function clearCoolDownText() : void
        {
            this.cooldownTimerTf.text = Values.EMPTY_STR;
            this.counterBg.gotoAndStop(COOLDOWN_COUNTER_BG_HIDE);
        }

        override public function set state(param1:String) : void
        {
            if(!this._isPermanent && !this._isActivated)
            {
                super.state = param1;
            }
        }

        public function get consumablesVO() : ConsumablesVO
        {
            return this._consumablesVO;
        }

        public function get icon() : String
        {
            return this.iconLoader.source;
        }

        public function set icon(param1:String) : void
        {
            this.iconLoader.source = param1;
        }

        public function set quantity(param1:int) : void
        {
            this.empty = param1 == 0;
        }

        public function set key(param1:Number) : void
        {
            if(this._bindSfKeyCode == param1)
            {
                return;
            }
            this._bindSfKeyCode = param1;
            invalidate(KEY_VALIDATION);
        }

        public function get empty() : Boolean
        {
            return this._isEmpty;
        }

        public function set empty(param1:Boolean) : void
        {
            this._isEmpty = param1;
            enabled = !param1;
            if(param1)
            {
                this.state = InteractiveStates.EMPTY_UP;
                if(this.icon)
                {
                    this.setColorTransform(COLOR_STATES.DARK_COLOR_TRANSFORM);
                    this._lockColorTransform = true;
                }
            }
            else
            {
                this.state = InteractiveStates.UP;
                if(this.icon)
                {
                    this.flushColorTransform();
                }
            }
        }

        public function get showConsumableBorder() : Boolean
        {
            return this.consumableBackground.visible;
        }

        public function set showConsumableBorder(param1:Boolean) : void
        {
            this.consumableBackground.visible = param1;
        }
    }
}
