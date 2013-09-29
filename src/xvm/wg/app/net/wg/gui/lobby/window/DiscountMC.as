package net.wg.gui.lobby.window 
{
    import flash.text.*;
    import scaleform.clik.core.*;
    
    public class DiscountMC extends scaleform.clik.core.UIComponent
    {
        public function DiscountMC()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.textField.autoSize = flash.text.TextFieldAutoSize.LEFT;
            return;
        }

        public function get text():String
        {
            return this._text;
        }

        public function set text(arg1:String):void
        {
            this._text = arg1;
            this.isTextChanged = true;
            invalidate();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (this.isTextChanged) 
            {
                this.isTextChanged = false;
                this.textField.text = this._text;
            }
            return;
        }

        public var textField:flash.text.TextField;

        internal var _text:String;

        internal var isTextChanged:Boolean;
    }
}
