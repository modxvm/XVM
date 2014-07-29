package net.wg.gui.lobby.window
{
    import flash.text.TextField;
    import net.wg.infrastructure.interfaces.IWindow;
    import scaleform.clik.utils.Padding;
    import flash.filters.DropShadowFilter;
    import net.wg.data.constants.ColorSchemeNames;
    import net.wg.data.constants.IconsTypes;
    
    public class ExchangeWindow extends ExchangeCurrencyWindow
    {
        
        public function ExchangeWindow()
        {
            super();
        }
        
        public var errorLabel:TextField;
        
        override public function setWindow(param1:IWindow) : void
        {
            var _loc2_:Padding = null;
            super.setWindow(param1);
            if(param1)
            {
                window.title = MENU.EXCHANGE_TITLE;
                _loc2_ = new Padding();
                _loc2_.top = 33;
                _loc2_.right = 11;
                _loc2_.bottom = cancelBtn.height + 20;
                _loc2_.left = 10;
                window.formBgPadding = _loc2_;
            }
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            var _loc1_:DropShadowFilter = new DropShadowFilter();
            _loc1_.blurX = 2;
            _loc1_.blurY = 2;
            _loc1_.strength = 1;
            _loc1_.quality = 2;
            _loc1_.angle = 90;
            _loc1_.distance = 1;
            _loc1_.color = 0;
            this.errorLabel.filters = [_loc1_];
            onHandPrimaryCurrencyText.filters = ExchangeUtils.getGlow(onHandPrimaryCurrencyText.icon);
            onHandSecondaryCurrencyText.filters = ExchangeUtils.getGlow(onHandSecondaryCurrencyText.icon);
            resultPrimaryCurrencyText.filters = ExchangeUtils.getGlow(resultPrimaryCurrencyText.icon);
            resultSecondaryCurrencyText.filters = ExchangeUtils.getGlow(resultSecondaryCurrencyText.icon);
            toExchangePrimaryCurrencyIco.filters = ExchangeUtils.getGlow(toExchangePrimaryCurrencyIco.icon);
            toExchangeSecondaryCurrencyIco.filters = ExchangeUtils.getGlow(toExchangeSecondaryCurrencyIco.icon);
            var _loc2_:Number = App.colorSchemeMgr.getRGB(ColorSchemeNames.TEXT_COLOR_GOLD);
            headerMC.rateFrom.icon = IconsTypes.GOLD;
            headerMC.rateFrom.textColor = _loc2_;
            headerMC.rateFrom.filters = ExchangeUtils.getGlow(IconsTypes.GOLD);
            headerMC.rateTo.icon = IconsTypes.CREDITS;
            headerMC.rateTo.textColor = App.colorSchemeMgr.getRGB(ColorSchemeNames.TEXT_COLOR_CREDITS);
            headerMC.rateTo.filters = ExchangeUtils.getGlow(IconsTypes.CREDITS);
        }
        
        override protected function applyResultUpdating() : void
        {
            super.applyResultUpdating();
            nsPrimaryCurrency.maximum = totalPrimaryCurrency;
            nsSecondaryCurrency.maximum = totalPrimaryCurrency * actualRate;
        }
        
        override protected function applyPrimaryCurrencyChange() : void
        {
            super.applyPrimaryCurrencyChange();
            this.errorLabel.visible = totalPrimaryCurrency <= 0;
        }
    }
}
