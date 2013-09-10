package net.wg.gui.tutorial.controls 
{
    import flash.text.*;
    
    public class HintTextItemRenderer extends net.wg.gui.tutorial.controls.HintBaseItemRenderer
    {
        public function HintTextItemRenderer()
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

        protected override function drawData():void
        {
            super.drawData();
            this.textField.htmlText = _data.label;
            setActualSize(width, this.textField.height);
            return;
        }

        public var textField:flash.text.TextField;
    }
}
