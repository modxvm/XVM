package net.wg.gui.battle.views.consumablesPanel
{
    import net.wg.gui.battle.components.buttons.BattleToolTipButton;
    import net.wg.gui.battle.views.consumablesPanel.interfaces.IBattleShellButton;
    import net.wg.data.constants.InvalidationType;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.battle.components.CoolDownTimer;
    import net.wg.gui.battle.views.consumablesPanel.VO.ConsumablesVO;
    import net.wg.data.constants.KeyProps;
    import net.wg.gui.battle.views.consumablesPanel.constants.COLOR_STATES;
    import net.wg.data.constants.InteractiveStates;
    import flash.geom.ColorTransform;
    import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
    import scaleform.gfx.TextFieldEx;

    public class BattleShellButton extends BattleToolTipButton implements IBattleShellButton
    {

        private static const FIRST_FRAME:int = 0;

        private static const START_FRAME:int = 51;

        private static const END_FRAME:int = 101;

        private static const END_RELOADING_FRAME:int = 142;

        private static const DEFAULT_TIME_COEF:Number = 1;

        private static const KEY_VALIDATION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;

        private static const QUANTITY_VALIDATION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;

        private static const SELECTED_INDICATOR_VISIBILITY:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 4;

        public var quantityField:TextField = null;

        public var nextIndicator:MovieClip = null;

        public var selectedIndicator:MovieClip = null;

        public var iconLoader:UILoaderAlt = null;

        public var bindKeyField:TextField = null;

        private var _isCurrent:Boolean;

        private var _isNext:Boolean;

        private var _isReloading:Boolean;

        private var _bindSfKeyCode:Number;

        private var _quantity:int;

        private var _isEmpty:Boolean;

        private var _isAfterCoolDown:Boolean;

        private var _isSelectedIndicatorVisible:Boolean = false;

        private var _coolDownTimer:CoolDownTimer = null;

        private var _consumablesVO:ConsumablesVO = null;

        public function BattleShellButton()
        {
            super();
            this._coolDownTimer = new CoolDownTimer(this);
            this._coolDownTimer.setFrames(START_FRAME,END_FRAME);
            this._consumablesVO = new ConsumablesVO();
            isAllowedToShowToolTipOnDisabledState = true;
            hideToolTipOnClickActions = false;
            addFrameScript(END_RELOADING_FRAME,this.reloadingEnd);
            TextFieldEx.setNoTranslate(this.bindKeyField,true);
            TextFieldEx.setNoTranslate(this.quantityField,true);
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.nextIndicator.visible = this._isNext;
        }

        protected function setBindKeyText() : void
        {
            if(this._bindSfKeyCode == KeyProps.KEY_NONE)
            {
                this.bindKeyField.text = App.utils.locale.makeString(READABLE_KEY_NAMES.KEY_NONE_ALT);
            }
            else
            {
                this.bindKeyField.text = App.utils.commons.keyToString(this._bindSfKeyCode).keyName;
            }
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(KEY_VALIDATION))
            {
                this.setBindKeyText();
            }
            if(isInvalid(QUANTITY_VALIDATION))
            {
                if(this.quantityField)
                {
                    this.quantityField.text = this._quantity.toString();
                }
            }
            if(isInvalid(SELECTED_INDICATOR_VISIBILITY))
            {
                this.selectedIndicator.visible = this._isSelectedIndicatorVisible;
            }
        }

        override protected function onDispose() : void
        {
            this.iconLoader.dispose();
            this.iconLoader = null;
            this._coolDownTimer.dispose();
            this._coolDownTimer = null;
            this.bindKeyField = null;
            this.selectedIndicator = null;
            this.nextIndicator = null;
            this.quantityField = null;
            this._consumablesVO = null;
            super.onDispose();
        }

        public function clearColorTransform() : void
        {
            this.iconLoader.transform.colorTransform = COLOR_STATES.NORMAL_COLOR_TRANSFORM;
        }

        public function clearCoolDownTime() : void
        {
            this._isReloading = false;
            this._coolDownTimer.end();
            this.state = InteractiveStates.UP;
        }

        public function hideGlow() : void
        {
        }

        public function onCoolDownComplete() : void
        {
        }

        public function setActivated() : void
        {
        }

        public function setColorTransform(param1:ColorTransform) : void
        {
            if(param1)
            {
                this.iconLoader.transform.colorTransform = param1;
            }
        }

        public function setCoolDownPosAsPercent(param1:Number) : void
        {
            if(param1 < 100)
            {
                this._isSelectedIndicatorVisible = false;
                invalidate(SELECTED_INDICATOR_VISIBILITY);
                this._coolDownTimer.setPositionAsPercent(param1);
            }
            else
            {
                this.setCoolDownTime(0,0,0,false);
            }
        }

        public function setCoolDownTime(param1:Number, param2:Number, param3:Number, param4:Boolean) : void
        {
            var _loc5_:* = NaN;
            this._isAfterCoolDown = false;
            if(param1 >= 0 && param2 != -1)
            {
                this._isSelectedIndicatorVisible = false;
                invalidate(SELECTED_INDICATOR_VISIBILITY);
            }
            if(param1 > 0)
            {
                _loc5_ = param3 / param2;
                this.state = BATTLE_ITEM_STATES.COOLDOWN;
                this._isReloading = param4;
                this._coolDownTimer.start(param1,this,(END_FRAME - START_FRAME) * _loc5_,DEFAULT_TIME_COEF);
            }
            else
            {
                this._isReloading = param4;
                this._coolDownTimer.end();
                if(param1 == 0)
                {
                    this.state = BATTLE_ITEM_STATES.RELOADED;
                    this._isAfterCoolDown = true;
                }
                else
                {
                    this._coolDownTimer.moveToFrame(FIRST_FRAME);
                }
            }
        }

        public function setCurrent(param1:Boolean, param2:Boolean = false) : void
        {
            if(param1 != this._isCurrent || param2)
            {
                this._isCurrent = param1;
                if(this.selectedIndicator)
                {
                    if(param1)
                    {
                        this._isSelectedIndicatorVisible = true;
                        this.selectedIndicator.gotoAndPlay(BATTLE_ITEM_STATES.SHOW);
                    }
                    else
                    {
                        this._isSelectedIndicatorVisible = false;
                        this.selectedIndicator.gotoAndStop(BATTLE_ITEM_STATES.NORMAL);
                        this._isAfterCoolDown = false;
                        this.state = InteractiveStates.UP;
                    }
                    invalidate(SELECTED_INDICATOR_VISIBILITY);
                }
            }
        }

        public function setEmpty(param1:Boolean, param2:Boolean = false) : void
        {
            if(this._isEmpty == param1 && !param2)
            {
                return;
            }
            this._isEmpty = param1;
            if(param1)
            {
                this.icon = this._consumablesVO.noShellIconPath;
                enabled = false;
                this.state = InteractiveStates.EMPTY_UP;
            }
            else
            {
                this.icon = this._consumablesVO.shellIconPath;
                enabled = true;
                this.state = InteractiveStates.UP;
            }
        }

        public function setNext(param1:Boolean, param2:Boolean = false) : void
        {
            if(param1 != this._isNext || param2)
            {
                this._isNext = param1;
                if(this.nextIndicator && !this._isCurrent)
                {
                    if(this._isEmpty || !param1)
                    {
                        this.nextIndicator.visible = false;
                        this.nextIndicator.stop();
                    }
                    else
                    {
                        this.nextIndicator.visible = true;
                        this.nextIndicator.gotoAndPlay(BATTLE_ITEM_STATES.SHOW);
                    }
                }
            }
        }

        public function setQuantity(param1:Number, param2:Boolean = false) : void
        {
            if(this._quantity == param1 && !param2)
            {
                return;
            }
            if(this._quantity == 0 && param1 > 0)
            {
                this.setEmpty(false,param2);
            }
            this._quantity = param1;
            if(this._quantity == 0)
            {
                this.setEmpty(true,param2);
            }
            invalidate(QUANTITY_VALIDATION);
        }

        public function setTimerSnapshot(param1:int, param2:Boolean) : void
        {
        }

        public function showGlow(param1:int) : void
        {
        }

        private function reloadingEnd() : void
        {
            this._isSelectedIndicatorVisible = true;
            invalidate(SELECTED_INDICATOR_VISIBILITY);
            this.selectedIndicator.gotoAndStop(BATTLE_ITEM_STATES.NORMAL);
            this._isAfterCoolDown = false;
        }

        override public function set state(param1:String) : void
        {
            if(!this._isReloading && !this._isAfterCoolDown)
            {
                super.state = param1;
            }
        }

        public function get consumablesVO() : ConsumablesVO
        {
            return this._consumablesVO;
        }

        public function set icon(param1:String) : void
        {
            this.iconLoader.source = param1;
        }

        public function get bindSfKeyCode() : Number
        {
            return this._bindSfKeyCode;
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

        public function set quantity(param1:int) : void
        {
            this.setQuantity(param1);
        }

        public function get reloading() : Boolean
        {
            return this._isReloading;
        }

        public function get coolDownCurrentFrame() : int
        {
            return this._coolDownTimer.currentFrame;
        }

        public function get empty() : Boolean
        {
            return this._isEmpty;
        }

        public function set empty(param1:Boolean) : void
        {
            this.setEmpty(param1);
        }

        public function get showConsumableBorder() : Boolean
        {
            return false;
        }

        public function set showConsumableBorder(param1:Boolean) : void
        {
        }

        public function setStage(param1:int) : void
        {
        }
    }
}
