package net.wg.gui.lobby.window 
{
    import flash.filters.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.interfaces.*;
    
    public class ExchangeWindow extends net.wg.gui.lobby.window.ExchangeCurrencyWindow
    {
        public function ExchangeWindow()
        {
            super();
            return;
        }

        public override function set window(arg1:net.wg.infrastructure.interfaces.IWindow):void
        {
            super.window = arg1;
            if (arg1) 
            {
                window.title = MENU.EXCHANGE_TITLE;
            }
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            var loc1:*=new flash.filters.DropShadowFilter();
            loc1.blurX = 2;
            loc1.blurY = 2;
            loc1.strength = 1;
            loc1.quality = 2;
            loc1.angle = 90;
            loc1.distance = 1;
            loc1.color = 0;
            this.errorLabel.filters = [loc1];
            onHandPrimaryCurrencyText.filters = net.wg.gui.lobby.window.ExchangeUtils.getGlow(onHandPrimaryCurrencyText.icon);
            onHandSecondaryCurrencyText.filters = net.wg.gui.lobby.window.ExchangeUtils.getGlow(onHandSecondaryCurrencyText.icon);
            resultPrimaryCurrencyText.filters = net.wg.gui.lobby.window.ExchangeUtils.getGlow(resultPrimaryCurrencyText.icon);
            resultSecondaryCurrencyText.filters = net.wg.gui.lobby.window.ExchangeUtils.getGlow(resultSecondaryCurrencyText.icon);
            toExchangePrimaryCurrencyIco.filters = net.wg.gui.lobby.window.ExchangeUtils.getGlow(toExchangePrimaryCurrencyIco.icon);
            toExchangeSecondaryCurrencyIco.filters = net.wg.gui.lobby.window.ExchangeUtils.getGlow(toExchangeSecondaryCurrencyIco.icon);
            var loc2:*=App.colorSchemeMgr.getRGB(net.wg.data.constants.ColorSchemeNames.TEXT_COLOR_GOLD);
            headerMC.rate_part_1.icon = net.wg.gui.components.controls.IconText.GOLD;
            headerMC.rate_part_1.textColor = loc2;
            headerMC.rate_part_1.filters = net.wg.gui.lobby.window.ExchangeUtils.getGlow(net.wg.gui.components.controls.IconText.GOLD);
            headerMC.rate_part_2.icon = net.wg.gui.components.controls.IconText.CREDITS;
            headerMC.rate_part_2.textColor = App.colorSchemeMgr.getRGB(net.wg.data.constants.ColorSchemeNames.TEXT_COLOR_CREDITS);
            headerMC.rate_part_2.filters = net.wg.gui.lobby.window.ExchangeUtils.getGlow(net.wg.gui.components.controls.IconText.CREDITS);
            return;
        }

        protected override function applyResultUpdating():void
        {
            super.applyResultUpdating();
            nsPrimaryCurrency.maximum = totalPrimaryCurrency;
            nsSecondaryCurrency.maximum = totalPrimaryCurrency * actualRate;
            return;
        }

        protected override function applyPrimaryCurrencyChange():void
        {
            super.applyPrimaryCurrencyChange();
            this.errorLabel.visible = totalPrimaryCurrency == 0;
            return;
        }

        public var errorLabel:flash.text.TextField;
    }
}
