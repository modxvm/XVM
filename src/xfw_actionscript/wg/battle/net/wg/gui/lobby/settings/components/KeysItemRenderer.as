package net.wg.gui.lobby.settings.components
{
    import scaleform.clik.controls.ListItemRenderer;
    import flash.display.Sprite;
    import net.wg.gui.components.controls.InfoIcon;
    import net.wg.gui.lobby.settings.components.evnts.KeyInputEvents;
    import net.wg.gui.components.controls.constants.ToolTipShowType;
    import net.wg.data.constants.Values;
    import net.wg.data.constants.KeyProps;
    import scaleform.clik.interfaces.IDataProvider;

    public class KeysItemRenderer extends ListItemRenderer
    {

        private static const INVALID_DATA:String = "invalid_data";

        private static const INVALID_TEXT:String = "invalid_text";

        private static const HEADER_STR:String = "header_";

        private static const UP_STR:String = "up";

        private static const KEY_STR:String = "key";

        public var keyInput:KeyInput;

        public var bg:Sprite;

        public var underline:Sprite;

        public var infoIcon:InfoIcon;

        private var _header:Boolean;

        public function KeysItemRenderer()
        {
            super();
        }

        override public function setData(param1:Object) : void
        {
            super.setData(param1);
            invalidate(INVALID_DATA);
        }

        override public function toString() : String
        {
            return "[WG KeysItemRenderer " + name + "]";
        }

        override protected function onDispose() : void
        {
            data = null;
            if(this.keyInput && this.keyInput.hasEventListener(KeyInputEvents.CHANGE))
            {
                this.keyInput.removeEventListener(KeyInputEvents.CHANGE,this.onKeyChangeHandler);
                this.keyInput.dispose();
            }
            this.keyInput = null;
            this.bg = null;
            this.underline = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            constraintsDisabled = true;
            super.configUI();
            mouseChildren = true;
            this.infoIcon.tooltipType = ToolTipShowType.SPECIAL;
            if(this.keyInput)
            {
                this.keyInput.addEventListener(KeyInputEvents.CHANGE,this.onKeyChangeHandler);
                this.keyInput.mouseEnabled = true;
                this.keyInput.mouseChildren = true;
                this.keyInput.buttonMode = true;
            }
        }

        override protected function draw() : void
        {
            if(data)
            {
                if(isInvalid(INVALID_DATA))
                {
                    this.header = data.header;
                    this.keyInput.visible = !data.header;
                    this.underline.visible = data.showUnderline;
                    this.infoIcon.visible = data.tooltipID != null && data.tooltipID.length > 0;
                    this.infoIcon.tooltip = data.tooltipID;
                    this.label = data.label;
                    if(!this.header)
                    {
                        this.keyInput.keys = data.keysRang;
                        this.keyInput.keyDefault = data.keyDefault;
                        this.keyInput.key = data.key;
                    }
                }
                if(isInvalid(INVALID_TEXT))
                {
                    this.setText();
                }
            }
            super.draw();
        }

        override protected function updateText() : void
        {
            if(this._header)
            {
                super.updateText();
            }
        }

        override protected function getStatePrefixes() : Vector.<String>
        {
            if(this._header)
            {
                return Vector.<String>([HEADER_STR,Values.EMPTY_STR]);
            }
            return _selected?statesSelected:statesDefault;
        }

        public function isSelected() : Boolean
        {
            return this.keyInput.selected;
        }

        private function keyCodeWasUsed(param1:Number) : Object
        {
            if(param1 == KeyProps.KEY_NONE)
            {
                return null;
            }
            var _loc2_:IDataProvider = KeysScrollingList(owner).dataProvider;
            var _loc3_:int = _loc2_.length;
            var _loc4_:uint = 0;
            while(_loc4_ < _loc3_)
            {
                if(!_loc2_[_loc4_].header && _loc4_ != this.index)
                {
                    if(this.keyInput.keyCode == _loc2_[_loc4_].key)
                    {
                        return _loc2_[_loc4_];
                    }
                }
                _loc4_++;
            }
            return null;
        }

        private function setText() : void
        {
            var _loc1_:* = NaN;
            var _loc2_:* = NaN;
            var _loc3_:* = NaN;
            if(_label != null && textField != null)
            {
                _loc1_ = data.additionalDiscr?10:0;
                _loc2_ = this.bg.height - textField.height;
                _loc3_ = textField.height;
                textField.multiline = true;
                textField.wordWrap = true;
                textField.htmlText = _label;
                textField.height = Math.max(textField.textHeight + 5,_loc3_);
                this.bg.height = textField.height + _loc2_ + _loc1_;
                this.height = this.actualHeight | 0;
                this.keyInput.y = this.height - this.keyInput.height >> 1;
                this.underline.y = this.actualHeight - this.underline.height | 0;
                if(this.infoIcon.visible)
                {
                    this.infoIcon.x = textField.x + textField.textWidth + 7;
                }
            }
        }

        override public function get enabled() : Boolean
        {
            return super.enabled;
        }

        override public function set enabled(param1:Boolean) : void
        {
            super.enabled = param1;
            mouseChildren = true;
        }

        override public function get label() : String
        {
            return _label;
        }

        override public function set label(param1:String) : void
        {
            if(_label == param1)
            {
                return;
            }
            _label = param1;
            invalidate(INVALID_TEXT);
        }

        public function get header() : Boolean
        {
            return this._header;
        }

        public function set header(param1:Boolean) : void
        {
            if(param1 == this._header)
            {
                return;
            }
            this._header = param1;
            setState(UP_STR);
        }

        private function onKeyChangeHandler(param1:KeyInputEvents) : void
        {
            var _loc2_:Object = this.keyCodeWasUsed(param1.keyCode);
            if(_loc2_)
            {
                _loc2_.key = KeyProps.KEY_NONE;
            }
            if(data && data.hasOwnProperty(KEY_STR))
            {
                data.key = param1.keyCode;
            }
            dispatchEvent(new KeyInputEvents(KeyInputEvents.CHANGE,param1.keyCode));
        }
    }
}
