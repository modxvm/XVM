package net.wg.gui.components.controls 
{
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;
    import scaleform.clik.controls.*;
    
    public class TextFieldShort extends scaleform.clik.controls.ListItemRenderer
    {
        public function TextFieldShort()
        {
            this.shadowColorList = {"White":{"color":16777215, "strange":0.4, "quality":3, "angle":90}, "Black":{"color":0, "strange":1, "quality":2, "angle":270}};
            super();
            this._textFormat = textField.getTextFormat();
            return;
        }

        public function get textAlign():String
        {
            return this._textAlign;
        }

        public function set textAlign(arg1:String):void
        {
            if (this._textAlign == arg1) 
            {
                return;
            }
            this._textAlign = arg1;
            invalidateData();
            return;
        }

        public function get textColor():Number
        {
            return this._textColor;
        }

        public function set textColor(arg1:Number):void
        {
            if (this._textColor == arg1) 
            {
                return;
            }
            this._textColor = arg1;
            invalidateData();
            return;
        }

        public function get shadowColor():String
        {
            return this._shadowColor;
        }

        public function set shadowColor(arg1:String):void
        {
            if (this._shadowColor == arg1) 
            {
                return;
            }
            this._shadowColor = arg1;
            invalidateData();
            return;
        }

        public function get toolTip():String
        {
            return this._toolTip;
        }

        public function set toolTip(arg1:String):void
        {
            if (this._toolTip == arg1) 
            {
                return;
            }
            this._toolTip = App.utils.locale.makeString(arg1);
            return;
        }

        public function get altToolTip():String
        {
            return this._altToolTip;
        }

        public function set altToolTip(arg1:String):void
        {
            if (this._altToolTip == arg1) 
            {
                return;
            }
            this._altToolTip = App.utils.locale.makeString(arg1);
            return;
        }

        public override function toString():String
        {
            return "[WG TextFieldShort " + name;
        }

        public function get showToolTip():Boolean
        {
            return this._showToolTip;
        }

        public function set showToolTip(arg1:Boolean):void
        {
            this._showToolTip = arg1;
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            return;
        }

        public override function dispose():void
        {
            super.dispose();
            return;
        }

        protected override function handleMouseRollOver(arg1:flash.events.MouseEvent):void
        {
            super.handleMouseRollOver(arg1);
            if (this._showToolTip) 
            {
                if (this._altToolTip) 
                {
                    App.toolTipMgr.show(this._altToolTip);
                }
                else if (this._toolTip) 
                {
                    App.toolTipMgr.show(this._toolTip);
                }
            }
            return;
        }

        protected override function handleMouseRollOut(arg1:flash.events.MouseEvent):void
        {
            super.handleMouseRollOut(arg1);
            App.toolTipMgr.hide();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=null;
            var loc2:*=NaN;
            super.draw();
            if (textField) 
            {
                textField.wordWrap = true;
                textField.selectable = false;
                textField.text = _label;
                this._textFormat.size = this._textSize;
                this._textFormat.font = this._textFont;
                this._textFormat.align = this._textAlign;
                textField.setTextFormat(this._textFormat);
                if (textField.getLineLength(0) < textField.text.length) 
                {
                    loc2 = textField.getLineLength(0);
                    if (loc2 < 3) 
                    {
                        loc2 = textField.getLineLength(1);
                    }
                    textField.text = textField.text.substring(0, loc2 - 2) + "..";
                    textField.setTextFormat(this._textFormat);
                }
                textField.textColor = this._textColor;
                loc1 = this.getDropShadowFilter(this._shadowColor);
                textField.filters = [loc1];
                this._toolTip = _label;
            }
            return;
        }

        internal function getDropShadowFilter(arg1:String):flash.filters.DropShadowFilter
        {
            var loc1:*=new flash.filters.DropShadowFilter();
            loc1.color = this.shadowColorList[arg1].color;
            loc1.angle = this.shadowColorList[arg1].angle;
            loc1.alpha = 1;
            loc1.blurX = 0;
            loc1.blurY = 0;
            loc1.distance = 1;
            loc1.strength = this.shadowColorList[arg1].strange;
            loc1.inner = false;
            loc1.knockout = false;
            loc1.quality = int(this.shadowColorList[arg1].quality);
            return loc1;
        }

        public function get textFont():String
        {
            return this._textFont;
        }

        public function set textFont(arg1:String):void
        {
            if (this._textFont == arg1) 
            {
                return;
            }
            this._textFont = arg1;
            invalidateData();
            return;
        }

        public function get useHtml():Boolean
        {
            return this._useHtml;
        }

        public function set useHtml(arg1:Boolean):void
        {
            if (this._useHtml == arg1) 
            {
                return;
            }
            this._useHtml = arg1;
            invalidateData();
            return;
        }

        public function get textSize():Number
        {
            return this._textSize;
        }

        public function set textSize(arg1:Number):void
        {
            if (this._textSize == arg1) 
            {
                return;
            }
            this._textSize = arg1;
            invalidateData();
            return;
        }

        internal var _textFormat:flash.text.TextFormat;

        internal var _textFont:String;

        internal var _useHtml:Boolean;

        internal var _textSize:Number=12;

        internal var _textAlign:String;

        internal var _textColor:Number=16777215;

        internal var _shadowColor:String="Black";

        internal var _showToolTip:Boolean=true;

        internal var shadowColorList:Object;

        protected var _toolTip:String="";

        internal var _altToolTip:String="";
    }
}
