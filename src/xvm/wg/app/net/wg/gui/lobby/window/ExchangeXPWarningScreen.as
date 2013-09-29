package net.wg.gui.lobby.window 
{
    import flash.text.*;
    import scaleform.clik.core.*;
    
    public class ExchangeXPWarningScreen extends scaleform.clik.core.UIComponent
    {
        public function ExchangeXPWarningScreen()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.textField.multiline = true;
            return;
        }

        public function set text(arg1:String):void
        {
            this._text = arg1;
            invalidate(TEXT_INVALID);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(TEXT_INVALID)) 
            {
                this.textField.text = this._text;
            }
            return;
        }

        public static const TEXT_INVALID:String="textInvalid";

        public var textField:flash.text.TextField;

        internal var _text:String="";
    }
}
