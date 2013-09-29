package net.wg.gui.components.common.waiting 
{
    import flash.text.*;
    import scaleform.clik.core.*;
    
    public class WaitingMc extends scaleform.clik.core.UIComponent
    {
        public function WaitingMc()
        {
            super();
            return;
        }

        public function setMessage(arg1:String):void
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

        public static const TEXT_INVALID:String="textInv";

        internal var _text:String="";

        public var textField:flash.text.TextField;
    }
}
