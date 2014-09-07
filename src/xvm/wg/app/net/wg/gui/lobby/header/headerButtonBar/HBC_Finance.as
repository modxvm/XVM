package net.wg.gui.lobby.header.headerButtonBar
{
    import net.wg.gui.components.controls.IconText;
    import flash.text.TextField;
    import net.wg.gui.components.controls.WalletResourcesStatus;
    import net.wg.gui.lobby.header.vo.HBC_FinanceVo;
    import net.wg.gui.lobby.header.LobbyHeader;
    import net.wg.data.constants.IconsTypes;
    
    public class HBC_Finance extends HeaderButtonContentItem
    {
        
        public function HBC_Finance()
        {
            super();
            _minScreenPadding.left = 8;
            _minScreenPadding.right = 10;
            _additionalScreenPadding.left = 10;
            _additionalScreenPadding.right = 17;
            _maxFontSize = 14;
        }
        
        public var moneyIconText:IconText = null;
        
        public var doItTextField:TextField = null;
        
        public var wallet:WalletResourcesStatus = null;
        
        private var _financeVo:HBC_FinanceVo = null;
        
        override protected function updateSize() : void
        {
            if(this.moneyIconText.visible)
            {
                bounds.width = Math.max(this.moneyIconText.textField.x + this.moneyIconText.textField.textWidth + TEXT_FIELD_MARGIN,this.doItTextField.x + this.doItTextField.width);
            }
            else
            {
                bounds.width = this.doItTextField.x + this.doItTextField.width;
            }
            super.updateSize();
        }
        
        override protected function updateData() : void
        {
            if(data)
            {
                this.moneyIconText.icon = this._financeVo.iconId;
                this.moneyIconText.text = this._financeVo.money;
                this.moneyIconText.textSize = useFontSize;
                this.moneyIconText.textFieldYOffset = screen == LobbyHeader.MAX_SCREEN?-1:0;
                this.moneyIconText.validateNow();
                this.wallet.icoType = this._financeVo.iconId;
                if(this._financeVo.iconId == IconsTypes.FREE_XP)
                {
                    this.moneyIconText.visible = !this.wallet.updateStatus(App.utils.voMgr.walletStatusVO.freeXpStatus);
                }
                else if(this._financeVo.iconId == IconsTypes.GOLD)
                {
                    this.moneyIconText.visible = !this.wallet.updateStatus(App.utils.voMgr.walletStatusVO.goldStatus);
                }
                else
                {
                    this.wallet.visible = false;
                }
                
                this.doItTextField.text = this._financeVo.btnDoText;
                if(needUpdateFontSize)
                {
                    updateFontSize(this.doItTextField,useFontSize);
                    needUpdateFontSize = false;
                }
                this.doItTextField.width = this.doItTextField.textWidth + TEXT_FIELD_MARGIN;
            }
            super.updateData();
        }
        
        override protected function onDispose() : void
        {
            this._financeVo = null;
            super.onDispose();
        }
        
        override public function set data(param1:Object) : void
        {
            this._financeVo = HBC_FinanceVo(param1);
            super.data = param1;
        }
        
        override protected function isNeedUpdateFont() : Boolean
        {
            return (super.isNeedUpdateFont()) || !(useFontSize == this.doItTextField.getTextFormat().size);
        }
        
        override protected function get leftPadding() : Number
        {
            var _loc1_:Number = 0;
            switch(screen)
            {
                case LobbyHeader.WIDE_SCREEN:
                    _loc1_ = _wideScreenPrc;
                    break;
                case LobbyHeader.MAX_SCREEN:
                    _loc1_ = _maxScreenPrc;
                    break;
            }
            return _minScreenPadding.left + _additionalScreenPadding.left * _loc1_ ^ 0;
        }
        
        override protected function get rightPadding() : Number
        {
            var _loc1_:Number = 0;
            switch(screen)
            {
                case LobbyHeader.WIDE_SCREEN:
                    _loc1_ = _wideScreenPrc;
                    break;
                case LobbyHeader.MAX_SCREEN:
                    _loc1_ = _maxScreenPrc;
                    break;
            }
            return _minScreenPadding.right + _additionalScreenPadding.right * _loc1_ ^ 0;
        }
    }
}
