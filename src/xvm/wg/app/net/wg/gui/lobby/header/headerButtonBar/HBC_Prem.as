package net.wg.gui.lobby.header.headerButtonBar
{
    import flash.text.TextField;
    import net.wg.gui.lobby.header.vo.HBC_PremDataVo;
    
    public class HBC_Prem extends HeaderButtonContentItem
    {
        
        public function HBC_Prem()
        {
            super();
            _minScreenPadding.left = 15;
            _minScreenPadding.right = 15;
            _additionalScreenPadding.left = 3;
            _additionalScreenPadding.right = 3;
            _maxFontSize = 14;
        }
        
        public var textField:TextField = null;
        
        public var doItTextField:TextField = null;
        
        private var _premVo:HBC_PremDataVo = null;
        
        override protected function updateSize() : void
        {
            bounds.width = Math.max(this.textField.width,this.doItTextField.width) ^ 0;
            super.updateSize();
        }
        
        override protected function updateData() : void
        {
            if(data)
            {
                this.textField.htmlText = this._premVo.btnLabel;
                this.doItTextField.htmlText = this._premVo.doLabel;
                if(this.isNeedUpdateFont())
                {
                    updateFontSize(this.textField,useFontSize);
                    updateFontSize(this.doItTextField,useFontSize);
                    needUpdateFontSize = false;
                }
                this.textField.width = this.textField.textWidth + TEXT_FIELD_MARGIN;
                this.doItTextField.width = this.doItTextField.textWidth + TEXT_FIELD_MARGIN;
            }
            super.updateData();
        }
        
        override protected function onDispose() : void
        {
            this._premVo = null;
            super.onDispose();
        }
        
        override public function set data(param1:Object) : void
        {
            this._premVo = HBC_PremDataVo(param1);
            super.data = param1;
        }
        
        override protected function isNeedUpdateFont() : Boolean
        {
            return (super.isNeedUpdateFont()) || !(useFontSize == this.textField.getTextFormat().size) || !(useFontSize == this.doItTextField.getTextFormat().size);
        }
    }
}
