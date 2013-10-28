package net.wg.gui.lobby.window
{
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.IWindow;
   import flash.filters.DropShadowFilter;
   import net.wg.data.constants.ColorSchemeNames;
   import net.wg.gui.components.controls.IconText;


   public class ExchangeWindow extends ExchangeCurrencyWindow
   {
          
      public function ExchangeWindow() {
         super();
      }

      public var errorLabel:TextField;

      override public function set window(param1:IWindow) : void {
         super.window = param1;
         if(param1)
         {
            window.title = MENU.EXCHANGE_TITLE;
         }
      }

      override protected function configUI() : void {
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
         headerMC.rate_part_1.icon = IconText.GOLD;
         headerMC.rate_part_1.textColor = _loc2_;
         headerMC.rate_part_1.filters = ExchangeUtils.getGlow(IconText.GOLD);
         headerMC.rate_part_2.icon = IconText.CREDITS;
         headerMC.rate_part_2.textColor = App.colorSchemeMgr.getRGB(ColorSchemeNames.TEXT_COLOR_CREDITS);
         headerMC.rate_part_2.filters = ExchangeUtils.getGlow(IconText.CREDITS);
      }

      override protected function applyResultUpdating() : void {
         super.applyResultUpdating();
         nsPrimaryCurrency.maximum = totalPrimaryCurrency;
         nsSecondaryCurrency.maximum = totalPrimaryCurrency * actualRate;
      }

      override protected function applyPrimaryCurrencyChange() : void {
         super.applyPrimaryCurrencyChange();
         this.errorLabel.visible = totalPrimaryCurrency <= 0;
      }
   }

}