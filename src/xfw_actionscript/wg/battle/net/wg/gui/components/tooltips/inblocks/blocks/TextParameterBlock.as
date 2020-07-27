package net.wg.gui.components.tooltips.inblocks.blocks
{
    import flash.text.TextField;
    import net.wg.gui.components.tooltips.inblocks.data.TextParameterVO;
    import flash.text.TextFieldAutoSize;

    public class TextParameterBlock extends AbstractTextParameterBlock
    {

        public var nameTF:TextField;

        public function TextParameterBlock()
        {
            super();
            this.nameTF.autoSize = TextFieldAutoSize.LEFT;
        }

        override protected function onSetBlockWidth(param1:int) : void
        {
            if(param1 > 0)
            {
                this.nameTF.width = param1 - this.nameTF.x;
            }
        }

        override protected function getDataClass() : Class
        {
            return TextParameterVO;
        }

        override protected function onDispose() : void
        {
            this.nameTF = null;
            super.onDispose();
        }

        override protected function applyParamName() : void
        {
            if(_data.useHtmlName)
            {
                this.nameTF.htmlText = _data.name;
            }
            else
            {
                this.nameTF.text = _data.name;
            }
            if(_data.gap != -1)
            {
                this.nameTF.x = valueTF.width + _data.gap;
            }
            updateTextFieldHeight(this.nameTF);
        }
    }
}
