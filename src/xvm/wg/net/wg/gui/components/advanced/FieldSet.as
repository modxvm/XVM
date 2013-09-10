package net.wg.gui.components.advanced 
{
    import flash.display.*;
    import flash.geom.*;
    import flash.text.*;
    import scaleform.clik.core.*;
    
    public class FieldSet extends scaleform.clik.core.UIComponent
    {
        public function FieldSet()
        {
            super();
            return;
        }

        protected override function preInitialize():void
        {
            super.preInitialize();
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            return;
        }

        protected override function configUI():void
        {
            this.startScale = new Object();
            this.startScale.sX = this.scaleX;
            this.startScale.sY = this.scaleY;
            setActualScale(1, 1);
            this.bg.scale9Grid = null;
            this.bg.scale9Grid = new flash.geom.Rectangle(32, 12, 155, 176);
            this.bg.scaleX = this.startScale.sX;
            this.bg.scaleY = this.startScale.sY;
            setSize(actualWidth, actualWidth);
            _originalWidth = actualWidth;
            _originalHeight = actualHeight;
            super.configUI();
            invalidateSize();
            return;
        }

        public function get label():String
        {
            return this.textField.text;
        }

        public function set label(arg1:String):void
        {
            this.textField.text = arg1;
            this.textField.autoSize = flash.text.TextFieldAutoSize.LEFT;
            invalidate();
            return;
        }

        public function get showLabel():Boolean
        {
            return this._showLabel;
        }

        public function set showLabel(arg1:Boolean):void
        {
            if (this._showLabel == arg1) 
            {
                return;
            }
            this._showLabel = arg1;
            this.textField.visible = this._showLabel;
            invalidate();
            return;
        }

        public function get margin():Number
        {
            return this._margin;
        }

        public function set margin(arg1:Number):void
        {
            if (this._margin == arg1) 
            {
                return;
            }
            this._margin = arg1;
            invalidate();
            return;
        }

        protected override function draw():void
        {
            if (this.showLabel) 
            {
                this.line.x = this.textField.x + this.textField.textWidth + this.margin;
            }
            else 
            {
                this.line.x = 10;
            }
            this.line.width = this.bg.width - 10 - this.line.x + 1;
            return;
        }

        public override function toString():String
        {
            return "[WG FieldSet " + name + "]";
        }

        public var textField:flash.text.TextField;

        public var bg:flash.display.Sprite;

        public var line:flash.display.Sprite;

        internal var startScale:Object;

        internal var _margin:Number=8;

        internal var _showLabel:Boolean=true;
    }
}
