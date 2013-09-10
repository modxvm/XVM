package net.wg.gui.lobby.settings.components 
{
    import __AS3__.vec.*;
    import flash.display.*;
    import net.wg.data.constants.*;
    import net.wg.gui.lobby.settings.components.evnts.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.interfaces.*;
    
    public class KeysItemRenderer extends scaleform.clik.controls.ListItemRenderer
    {
        public function KeysItemRenderer()
        {
            super();
            return;
        }

        public override function setData(arg1:Object):void
        {
            super.setData(arg1);
            invalidate(this.INVALID_DATA);
            return;
        }

        public override function dispose():void
        {
            if (data) 
                data = null;
            if (this.keyInput && this.keyInput.hasEventListener(net.wg.gui.lobby.settings.components.evnts.KeyInputEvents.CHANGE)) 
            {
                this.keyInput.removeEventListener(net.wg.gui.lobby.settings.components.evnts.KeyInputEvents.CHANGE, this.onKeyChange);
                this.keyInput.dispose();
            }
            super.dispose();
            return;
        }

        public override function toString():String
        {
            return "[WG KeysItemRenderer " + name + "]";
        }

        public function isSelected():Boolean
        {
            return this.keyInput.selected;
        }

        public override function get enabled():Boolean
        {
            return super.enabled;
        }

        public override function set enabled(arg1:Boolean):void
        {
            var loc1:*=null;
            super.enabled = arg1;
            mouseChildren = true;
            if (super.enabled) 
                loc1 = _focusIndicator == null && (_displayFocus || _focused) ? "over" : "up";
            else 
                loc1 = "disabled";
            setState(loc1);
            return;
        }

        public override function get label():String
        {
            return _label;
        }

        public override function set label(arg1:String):void
        {
            if (_label == arg1) 
                return;
            _label = arg1;
            invalidate(this.INVALID_TEXT);
            return;
        }

        public function get header():Boolean
        {
            return this._header;
        }

        public function set header(arg1:Boolean):void
        {
            if (arg1 == this._header) 
                return;
            this._header = arg1;
            setState("up");
            return;
        }

        protected override function configUI():void
        {
            constraintsDisabled = true;
            super.configUI();
            mouseChildren = true;
            if (this.keyInput) 
            {
                this.keyInput.addEventListener(net.wg.gui.lobby.settings.components.evnts.KeyInputEvents.CHANGE, this.onKeyChange);
                this.keyInput.mouseEnabled = true;
                this.keyInput.mouseChildren = true;
                this.keyInput.buttonMode = true;
            }
            return;
        }

        protected override function draw():void
        {
            if (data) 
            {
                if (isInvalid(this.INVALID_DATA)) 
                {
                    this.header = data.header;
                    this.keyInput.visible = !data.header;
                    this.underline.visible = data.showUnderline;
                    this.label = data.label;
                    if (!this.header) 
                    {
                        this.keyInput.keys = data.keysRang;
                        this.keyInput.keyDefault = data.keyDefault;
                        this.keyInput.key = data.key;
                    }
                }
                if (isInvalid(this.INVALID_TEXT)) 
                    this.setText();
            }
            super.draw();
            return;
        }

        protected override function updateText():void
        {
            if (this._header) 
                super.updateText();
            return;
        }

        protected override function getStatePrefixes():__AS3__.vec.Vector.<String>
        {
            if (this._header) 
                return Vector.<String>(["header_", ""]);
            return _selected ? statesSelected : statesDefault;
        }

        internal function keyCodeWasUsed(arg1:Number):Object
        {
            if (arg1 == net.wg.data.constants.KeysMap.KEY_NONE) 
                return null;
            var loc1:*=net.wg.gui.lobby.settings.components.KeysScrollingList(owner).dataProvider;
            var loc2:*=loc1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                if (!loc1[loc3].header && !(loc3 == this.index)) 
                    if (this.keyInput.keyCode == loc1[loc3].key) 
                        return loc1[loc3];
                ++loc3;
            }
            return null;
        }

        internal function setText():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=NaN;
            if (!(_label == null) && !(textField == null)) 
            {
                loc1 = data.additionalDiscr ? 10 : 0;
                loc2 = this.bg.height - textField.height;
                loc3 = textField.height;
                textField.multiline = true;
                textField.wordWrap = true;
                textField.htmlText = _label;
                textField.height = Math.max(textField.textHeight + 5, loc3);
                this.bg.height = textField.height + loc2 + loc1;
                this.height = this.actualHeight | 0;
                this.keyInput.y = this.height - this.keyInput.height >> 1;
                this.underline.y = this.actualHeight - this.underline.height | 0;
            }
            return;
        }

        internal function onKeyChange(arg1:net.wg.gui.lobby.settings.components.evnts.KeyInputEvents):void
        {
            var loc1:*=this.keyCodeWasUsed(arg1.keyCode);
            if (loc1) 
                loc1.key = net.wg.data.constants.KeysMap.KEY_NONE;
            if (data && data.hasOwnProperty("key")) 
                data.key = arg1.keyCode;
            dispatchEvent(new net.wg.gui.lobby.settings.components.evnts.KeyInputEvents(net.wg.gui.lobby.settings.components.evnts.KeyInputEvents.CHANGE, arg1.keyCode));
            return;
        }

        internal const INVALID_DATA:String="invalid_data";

        internal const INVALID_TEXT:String="invalid_text";

        public var keyInput:net.wg.gui.lobby.settings.components.KeyInput;

        public var bg:flash.display.Sprite;

        public var underline:flash.display.Sprite;

        internal var _header:Boolean;
    }
}
