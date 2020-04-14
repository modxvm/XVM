package net.wg.gui.components.controls
{
    import flash.text.TextField;
    import flash.display.MovieClip;
    import net.wg.utils.ICommons;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.data.constants.Values;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.utils.ConstrainedElement;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.ComponentState;
    import net.wg.data.Aliases;
    import net.wg.data.constants.SoundTypes;

    public class MainMenuButton extends SoundButtonEx
    {

        public static var SUB_SELECTED:String = "sub_selected_";

        private static const INVALIDATE_ICON:String = "invalidateIcon";

        private static const INVALIDATE_CAPS:String = "invalidateCaps";

        private static const INVALIDATE_PADDING:String = "invalidatePadding";

        private static const INVALIDATE_TEXT_COLOR:String = "invalidateTextColor";

        private static const INVALIDATE_ACTION_ICON:String = "invalidateActionIcon";

        private static const INVALIDATE_ACTION_ICON_POS:String = "invalidateActionIconPos";

        private static const ICON_PADDING:int = 1;

        private static const TEXTFIELD_NAME:String = "textField";

        private static const BLUR_TEXTFIELD_NAME:String = "blurTextField";

        private static const TEXTFIELD_PADDING:int = 5;

        private static const BROWSER:String = "browser";

        private static const CHANGE_EFFECT_TIME:int = 1000;

        private static const BLINK_TEXT_COLOR:uint = 16563563;

        public var fxTextField1:TextField;

        public var fxTextField2:TextField;

        public var fx:MovieClip;

        public var icon:Image;

        public var actionIcon:Image;

        private var _iconType:String;

        private var _caps:Boolean = true;

        private var _textColorOver:Number;

        private var _textColorBeforeBlink:Number;

        private var _externalState:String = "";

        private var _isBlinking:Boolean;

        private var _actionIconStr:String = "";

        private var _commonsUtils:ICommons = null;

        private var _isTooltipSpecial:Boolean = false;

        private var _tooltipMgr:ITooltipMgr = null;

        public function MainMenuButton()
        {
            super();
            constraintsDisabled = true;
            soundType = SoundTypes.MAIN_MENU;
            this.fxTextField2 = this.fx.fxTextField2;
            this._commonsUtils = App.utils.commons;
            this._tooltipMgr = App.toolTipMgr;
            preventAutosizing = true;
        }

        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this.icon.removeEventListener(Event.CHANGE,this.onIconChangeHandler);
            this.actionIcon.removeEventListener(Event.CHANGE,this.onActionIconChangeHandler);
            this.fxTextField1 = null;
            this.fxTextField2 = null;
            this.fx = null;
            this.icon.dispose();
            this.icon = null;
            this.actionIcon.dispose();
            this.actionIcon = null;
            this._commonsUtils = null;
            this._tooltipMgr = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.paddingHorizontal = 0;
            this.icon.addEventListener(Event.CHANGE,this.onIconChangeHandler);
            this.actionIcon.addEventListener(Event.CHANGE,this.onActionIconChangeHandler);
            addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
            this.checkBrowserEffect();
        }

        override protected function updateText() : void
        {
            var _loc1_:String = null;
            if(hitMc)
            {
                hitMc.width = 1;
            }
            if(this.caps)
            {
                if(_label != null)
                {
                    _loc1_ = App.utils.locale.makeString(_label,{});
                    if(StringUtils.isNotEmpty(_loc1_))
                    {
                        _loc1_ = App.utils.toUpperOrLowerCase(_loc1_,true);
                    }
                    else
                    {
                        _loc1_ = Values.EMPTY_STR;
                    }
                    if(textField != null)
                    {
                        textField.text = _loc1_;
                    }
                    if(textField1 != null)
                    {
                        textField1.text = _loc1_;
                    }
                    if(blurTextField != null)
                    {
                        blurTextField.text = _loc1_;
                        this._commonsUtils.updateTextFieldSize(blurTextField,true,false);
                    }
                    if(this.fxTextField1 != null)
                    {
                        this.fxTextField1.text = _loc1_;
                        this._commonsUtils.updateTextFieldSize(this.fxTextField1,true,false);
                    }
                    if(this.fxTextField2 != null)
                    {
                        this.fxTextField2.text = _loc1_;
                        this._commonsUtils.updateTextFieldSize(this.fxTextField2,true,false);
                    }
                }
            }
            else
            {
                super.updateText();
                if(blurTextField != null)
                {
                    blurTextField.text = _label;
                }
                if(this.fxTextField1 != null)
                {
                    this.fxTextField1.text = _label;
                }
                if(this.fxTextField2 != null)
                {
                    this.fxTextField2.text = _label;
                }
            }
            if(hitMc)
            {
                hitMc.width = this.actualWidth;
            }
            this.width = this.actualWidth;
        }

        override protected function alignForAutoSize() : void
        {
            var _loc1_:* = 0;
            var _loc3_:* = 0;
            var _loc4_:* = 0;
            if(!initialized || _autoSize == TextFieldAutoSize.NONE || !textField)
            {
                return;
            }
            _loc1_ = _width;
            var _loc2_:int = _width = this.calculateWidth();
            switch(_autoSize)
            {
                case TextFieldAutoSize.RIGHT:
                    _loc3_ = x + _loc1_;
                    x = _loc3_ - _loc2_;
                    break;
                case TextFieldAutoSize.CENTER:
                    _loc4_ = x + (_loc1_ >> 1);
                    x = _loc4_ - (_loc2_ >> 1);
                    break;
            }
        }

        override protected function calculateWidth() : Number
        {
            var _loc2_:ConstrainedElement = null;
            var _loc3_:TextField = null;
            var _loc1_:Number = actualWidth;
            if(!constraintsDisabled && initialized)
            {
                _loc2_ = constraints.getElement(textField?TEXTFIELD_NAME:BLUR_TEXTFIELD_NAME);
                _loc3_ = textField?textField:blurTextField;
                _loc1_ = _loc3_.x + _loc3_.textWidth + _loc2_.left + _loc2_.right + TEXTFIELD_PADDING + (_paddingHorizontal << 1);
            }
            return _loc1_;
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = 0;
            super.draw();
            if(this.fxTextField1 && isInvalid(InvalidationType.STATE,INVALIDATE_CAPS,INVALIDATE_PADDING,INVALIDATE_TEXT_COLOR))
            {
                if(this._textColorOver && !selected && state == ComponentState.OVER)
                {
                    this.fxTextField1.textColor = this._textColorOver;
                }
                else if(_textColor && enabled)
                {
                    this.fxTextField1.textColor = _textColor;
                }
                if(this._iconType)
                {
                    this.fxTextField1.x = this.icon.x + this.icon.width + ICON_PADDING;
                    dispatchEvent(new Event(Event.RESIZE));
                }
                else
                {
                    this.fxTextField1.x = 0;
                }
            }
            if(isInvalid(INVALIDATE_ICON))
            {
                this.icon.visible = StringUtils.isNotEmpty(this._iconType);
                this.icon.source = this._iconType;
            }
            if(isInvalid(INVALIDATE_ACTION_ICON))
            {
                this.actionIcon.visible = StringUtils.isNotEmpty(this._actionIconStr);
                this.actionIcon.source = this._actionIconStr;
                invalidate(INVALIDATE_ACTION_ICON_POS);
            }
            if(isInvalid(INVALIDATE_ACTION_ICON_POS))
            {
                _loc1_ = this._iconType?this.icon.x:this.fxTextField1.x;
                _loc2_ = this._iconType?_loc1_ + this.icon.width + ICON_PADDING + this.fxTextField1.width:this.fxTextField1.width;
                this.actionIcon.x = _loc1_ + (_loc2_ - this.actionIcon.width >> 1);
            }
        }

        override protected function getStatePrefixes() : Vector.<String>
        {
            return _selected?statesSelected:this._externalState != Values.EMPTY_STR?Vector.<String>([this._externalState]):statesDefault;
        }

        override protected function showTooltip() : void
        {
            if(this._isTooltipSpecial && _tooltip && this._tooltipMgr)
            {
                this._tooltipMgr.showSpecial(_tooltip,null);
            }
            else
            {
                super.showTooltip();
            }
        }

        public function set isTooltipSpecial(param1:Boolean) : void
        {
            this._isTooltipSpecial = param1;
        }

        public function setExternalState(param1:String) : void
        {
            this._externalState = param1;
            setState(state);
        }

        private function checkBrowserEffect() : void
        {
            if(data && data.value == BROWSER)
            {
                App.utils.scheduler.scheduleTask(this.changeEffectState,CHANGE_EFFECT_TIME);
                selected = false;
            }
        }

        private function changeEffectState() : void
        {
            if(selected || !enabled)
            {
                filters = null;
                this._isBlinking = false;
                return;
            }
            if(this.fxTextField1)
            {
                if(isNaN(this._textColorBeforeBlink))
                {
                    this._textColorBeforeBlink = this.fxTextField1.textColor;
                }
                this._isBlinking = !this._isBlinking;
                if(this._isBlinking)
                {
                    this.fxTextField1.textColor = BLINK_TEXT_COLOR;
                }
                else
                {
                    this.fxTextField1.textColor = this._textColorBeforeBlink;
                }
                App.utils.scheduler.scheduleTask(this.changeEffectState,CHANGE_EFFECT_TIME);
            }
        }

        override public function get width() : Number
        {
            return this.fxTextField1?this.fxTextField1.x + this.fxTextField1.textWidth + TEXTFIELD_PADDING + (_paddingHorizontal << 1):0;
        }

        override public function get paddingHorizontal() : Number
        {
            return _paddingHorizontal;
        }

        override public function set paddingHorizontal(param1:Number) : void
        {
            _paddingHorizontal = param1;
            invalidate(INVALIDATE_PADDING);
        }

        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            if(param1)
            {
                this.checkBrowserEffect();
            }
        }

        public function get caps() : Boolean
        {
            return this._caps;
        }

        public function set caps(param1:Boolean) : void
        {
            if(this._caps == param1)
            {
                return;
            }
            this._caps = param1;
            invalidate(INVALIDATE_CAPS);
        }

        public function get textColorOver() : Number
        {
            return _textColor;
        }

        public function set textColorOver(param1:Number) : void
        {
            if(this._textColorOver == param1)
            {
                return;
            }
            this._textColorOver = param1;
            invalidate(INVALIDATE_TEXT_COLOR);
        }

        public function get iconType() : String
        {
            return this._iconType;
        }

        public function set iconType(param1:String) : void
        {
            if(this._iconType == param1)
            {
                return;
            }
            this._iconType = param1;
            invalidate(INVALIDATE_ICON);
        }

        public function set actionIconStr(param1:String) : void
        {
            if(this._actionIconStr == param1)
            {
                return;
            }
            this._actionIconStr = param1;
            invalidate(INVALIDATE_ACTION_ICON);
        }

        private function onRollOverHandler(param1:MouseEvent) : void
        {
            if(data && data.value == Aliases.BROWSER)
            {
                App.utils.scheduler.cancelTask(this.changeEffectState);
                filters = null;
            }
        }

        private function onRollOutHandler(param1:MouseEvent) : void
        {
            this.checkBrowserEffect();
        }

        private function onIconChangeHandler(param1:Event) : void
        {
            invalidateState();
        }

        private function onActionIconChangeHandler(param1:Event) : void
        {
            invalidate(INVALIDATE_ACTION_ICON_POS);
        }
    }
}
