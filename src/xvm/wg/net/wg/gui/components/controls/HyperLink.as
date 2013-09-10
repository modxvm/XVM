package net.wg.gui.components.controls 
{
    import scaleform.clik.controls.*;
    
    public class HyperLink extends scaleform.clik.controls.Button
    {
        public function HyperLink()
        {
            super();
            buttonMode = true;
            return;
        }

        protected override function updateText():void
        {
            if (!(_label == null) && !(textField == null)) 
            {
                textField.text = _label;
                if (this.isUnderline) 
                    textField.htmlText = "<u>" + textField.text + "</u>";
            }
            return;
        }

        public var isUnderline:Boolean=true;
    }
}
