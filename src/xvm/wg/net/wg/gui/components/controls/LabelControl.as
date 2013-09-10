package net.wg.gui.components.controls 
{
    import flash.text.*;
    import scaleform.clik.controls.*;
    
    public class LabelControl extends scaleform.clik.controls.Label
    {
        public function LabelControl()
        {
            super();
            return;
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

        public function get textAlign():String
        {
            return this._textAlign;
        }

        protected override function updateText():void
        {
            var loc1:*=null;
            super.updateText();
            if (!(_text == null) && !(textField == null)) 
            {
                loc1 = textField.getTextFormat();
                loc1.align = this._textAlign;
                textField.setTextFormat(loc1);
            }
            return;
        }

        protected var _textAlign:String="none";
    }
}
