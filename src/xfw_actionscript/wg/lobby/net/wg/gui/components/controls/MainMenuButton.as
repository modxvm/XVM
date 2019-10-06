package net.wg.gui.components.controls
{
    import flash.text.TextField;
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.utils.ConstrainedElement;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.ComponentState;
    import net.wg.data.Aliases;
    import net.wg.data.constants.SoundTypes;

    public class MainMenuButton extends SoundButtonEx
    {

        public static var SUB_SELECTED:String = "sub_selected_";

        private static var INVALIDATE_ICON:String = "invalidateIcon";

        private static var INVALIDATE_CAPS:String = "invalidateCaps";

        private static var INVALIDATE_PADDING:String = "invalidatePadding";

        private static var INVALIDATE_TEXT_COLOR:String = "invalidateTextColor";

        private static var ICON_PADDING:int = 1;

        public var fxTextField1:TextField;

        public var fxTextField2:TextField;

        public var fx:MovieClip;

        public var icon:Image;

        private var _iconType:String;

        private var _caps:Boolean = true;

        private var _textColorOver:Number;

        private var textColorBeforeBlink:Number;

        private var _externalState:String = "";

        private var _isBlinking:Boolean;

        public function MainMenuButton()
        {
            super();
            constraintsDisabled = true;
            soundType = SoundTypes.MAIN_MENU;
            this.fxTextField2 = this.fx.fxTextField2;
        }

        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.ROLL_OVER,this.onOverHandler);
            removeEventListener(MouseEvent.ROLL_OUT,this.onOutHandler);
            this.fxTextField1 = null;
            this.fxTextField2 = null;
            this.fx = null;
            this.icon.removeEventListener(Event.CHANGE,this.onIconChangeHandler);
            this.icon.dispose();
            this.icon = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.paddingHorizontal = 0;
            this.icon.addEventListener(Event.CHANGE,this.onIconChangeHandler);
            addEventListener(MouseEvent.ROLL_OVER,this.onOverHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.onOutHandler);
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
                    if(_loc1_)
                    {
                        _loc1_ = App.utils.toUpperOrLowerCase(_loc1_,true);
                    }
                    else
                    {
                        _loc1_ = "";
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
                        blurTextField.width = blurTextField.textWidth + 5;
                    }
                    if(this.fxTextField1 != null)
                    {
                        this.fxTextField1.text = _loc1_;
                        this.fxTextField1.width = this.fxTextField1.textWidth + 5;
                    }
                    if(this.fxTextField2 != null)
                    {
                        this.fxTextField2.text = _loc1_;
                        this.fxTextField2.width = this.fxTextField2.textWidth + 5;
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
            var _loc1_:* = NaN;
            var _loc3_:* = NaN;
            var _loc4_:* = NaN;
            if(!initialized || _autoSize == TextFieldAutoSize.NONE || !textField)
            {
                return;
            }
            _loc1_ = _width;
            var _loc2_:Number = _width = this.calculateWidth();
            switch(_autoSize)
            {
                case TextFieldAutoSize.RIGHT:
                    _loc3_ = x + _loc1_;
                    x = _loc3_ - _loc2_;
                    break;
                case TextFieldAutoSize.CENTER:
                    _loc4_ = x + _loc1_ * 0.5;
                    x = _loc4_ - _loc2_ * 0.5;
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
                _loc2_ = constraints.getElement(textField?"textField":"blurTextField");
                _loc3_ = textField?textField:blurTextField;
                _loc1_ = _loc3_.x + _loc3_.textWidth + _loc2_.left + _loc2_.right + 5 + (_paddingHorizontal << 1);
            }
            return _loc1_;
        }

        override protected function draw() : void
        {
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
                this.icon.source = this._iconType;
                this.icon.visible = Boolean(this._iconType);
            }
        }

        override public function get width() : Number
        {
            return this.fxTextField1?this.fxTextField1.x + this.fxTextField1.textWidth + 5 + (_paddingHorizontal << 1):0;
        }

        override protected function getStatePrefixes() : Vector.<String>
        {
            return _selected?statesSelected:this._externalState != ""?Vector.<String>([this._externalState]):statesDefault;
        }

        public function setExternalState(param1:String) : void
        {
            this._externalState = param1;
            setState(state);
        }

        private function checkBrowserEffect() : void
        {
            if(data && data.value == "browser")
            {
                App.utils.scheduler.scheduleTask(this.changeEffectState,1000);
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
                if(isNaN(this.textColorBeforeBlink))
                {
                    this.textColorBeforeBlink = this.fxTextField1.textColor;
                }
                this._isBlinking = !this._isBlinking;
                if(this._isBlinking)
                {
                    this.fxTextField1.textColor = 16563563;
                }
                else
                {
                    this.fxTextField1.textColor = this.textColorBeforeBlink;
                }
                App.utils.scheduler.scheduleTask(this.changeEffectState,1000);
            }
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

        private function onOverHandler(param1:MouseEvent) : void
        {
            if(data && data.value == Aliases.BROWSER)
            {
                App.utils.scheduler.cancelTask(this.changeEffectState);
                filters = null;
            }
        }

        private function onOutHandler(param1:MouseEvent) : void
        {
            this.checkBrowserEffect();
        }

        private function onIconChangeHandler(param1:Event) : void
        {
            invalidateState();
        }
    }
}
