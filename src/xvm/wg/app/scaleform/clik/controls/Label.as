package scaleform.clik.controls 
{
    import flash.text.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    import scaleform.clik.utils.*;
    
    public class Label extends scaleform.clik.core.UIComponent
    {
        public function Label()
        {
            super();
            return;
        }

        protected override function preInitialize():void
        {
            if (!this.constraintsDisabled) 
            {
                constraints = new scaleform.clik.utils.Constraints(this, scaleform.clik.constants.ConstrainMode.COUNTER_SCALE);
            }
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            return;
        }

        public override function get enabled():Boolean
        {
            return super.enabled;
        }

        public override function set enabled(arg1:Boolean):void
        {
            if (arg1 == super.enabled) 
            {
                return;
            }
            super.enabled = arg1;
            var loc1:*;
            mouseChildren = loc1 = arg1;
            mouseEnabled = loc1;
            this.setState(this.defaultState);
            return;
        }

        public function get text():String
        {
            return this._text;
        }

        public function set text(arg1:String):void
        {
            if (arg1 == null) 
            {
                arg1 == "";
            }
            this.isHtml = false;
            this._text = arg1;
            invalidateData();
            return;
        }

        public function get htmlText():String
        {
            return this._text;
        }

        public function set htmlText(arg1:String):void
        {
            if (arg1 == null) 
            {
                arg1 == "";
            }
            this.isHtml = true;
            this._text = arg1;
            invalidateData();
            return;
        }

        public function get autoSize():String
        {
            return this._autoSize;
        }

        public function set autoSize(arg1:String):void
        {
            if (arg1 == this._autoSize) 
            {
                return;
            }
            this._autoSize = arg1;
            invalidateData();
            return;
        }

        public function get length():uint
        {
            return this.textField.length;
        }

        public function get defaultState():String
        {
            return this.enabled ? focused ? "focused" : "default" : "disabled";
        }

        public function appendText(arg1:String):void
        {
            this._text = this._text + arg1;
            this.isHtml = false;
            invalidateData();
            return;
        }

        public function appendHtml(arg1:String):void
        {
            this._text = this._text + arg1;
            this.isHtml = true;
            invalidateData();
            return;
        }

        public override function toString():String
        {
            return "[CLIK Label " + name + "]";
        }

        protected override function configUI():void
        {
            super.configUI();
            if (!this.constraintsDisabled) 
            {
                constraints.addElement("textField", this.textField, scaleform.clik.utils.Constraints.ALL);
            }
            focusable = false;
            return;
        }

        protected function calculateWidth():Number
        {
            var loc2:*=null;
            if (constraints == null || this.textField == null) 
            {
                return actualWidth;
            }
            if (!this.constraintsDisabled) 
            {
                loc2 = constraints.getElement("textField");
            }
            var loc1:*=Math.ceil(this.textField.textWidth + loc2.left + loc2.right + 5);
            return loc1;
        }

        protected function alignForAutoSize():void
        {
            var loc1:*=NaN;
            var loc3:*=NaN;
            var loc4:*=NaN;
            if (!initialized || this._autoSize == flash.text.TextFieldAutoSize.NONE || this.textField == null) 
            {
                return;
            }
            loc1 = _width;
            var loc5:*;
            _width = loc5 = this.calculateWidth();
            var loc2:*=loc5;
            loc5 = this._autoSize;
            switch (loc5) 
            {
                case flash.text.TextFieldAutoSize.RIGHT:
                {
                    loc3 = x + loc1;
                    x = loc3 - loc2;
                    break;
                }
                case flash.text.TextFieldAutoSize.CENTER:
                {
                    loc4 = x + loc1 * 0.5;
                    x = loc4 - loc2 * 0.5;
                    break;
                }
            }
            return;
        }

        protected override function draw():void
        {
            if (isInvalid(scaleform.clik.constants.InvalidationType.STATE)) 
            {
                if (this._newFrame) 
                {
                    gotoAndPlay(this._newFrame);
                    this._newFrame = null;
                }
                this.updateAfterStateChange();
                dispatchEvent(new scaleform.clik.events.ComponentEvent(scaleform.clik.events.ComponentEvent.STATE_CHANGE));
                invalidate(scaleform.clik.constants.InvalidationType.SIZE);
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA)) 
            {
                this.updateText();
                if (this.autoSize != flash.text.TextFieldAutoSize.NONE) 
                {
                    this.alignForAutoSize();
                    invalidateSize();
                }
            }
            if (isInvalid(scaleform.clik.constants.InvalidationType.SIZE)) 
            {
                setActualSize(_width, _height);
                if (!this.constraintsDisabled) 
                {
                    constraints.update(_width, _height);
                }
            }
            return;
        }

        protected function updateText():void
        {
            if (!(this._text == null) && !(this.textField == null)) 
            {
                if (this.isHtml) 
                {
                    this.textField.htmlText = this._text;
                }
                else 
                {
                    this.textField.text = this._text;
                }
            }
            return;
        }

        protected function updateAfterStateChange():void
        {
            if (!initialized) 
            {
                return;
            }
            if (!(constraints == null) && !this.constraintsDisabled) 
            {
                constraints.updateElement("textField", this.textField);
            }
            this.updateText();
            dispatchEvent(new scaleform.clik.events.ComponentEvent(scaleform.clik.events.ComponentEvent.STATE_CHANGE));
            return;
        }

        protected function setState(... rest):void
        {
            var loc3:*=null;
            var loc4:*=null;
            if (rest.length == 1) 
            {
                loc3 = rest[0].toString();
                if (!(this.state == loc3) && _labelHash[loc3]) 
                {
                    var loc5:*;
                    this._newFrame = loc5 = loc3;
                    this.state = loc5;
                    invalidateState();
                }
                return;
            }
            var loc1:*=rest.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc4 = rest[loc2].toString();
                if (_labelHash[loc4]) 
                {
                    this._newFrame = loc5 = loc4;
                    this.state = loc5;
                    invalidateState();
                    break;
                }
                ++loc2;
            }
            return;
        }

        public var constraintsDisabled:Boolean=false;

        protected var _text:String;

        protected var _autoSize:String="none";

        protected var isHtml:Boolean;

        protected var state:String="default";

        protected var _newFrame:String;

        public var textField:flash.text.TextField;
    }
}
