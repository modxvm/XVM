package net.wg.gui.lobby.window
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.components.controls.SoundButtonEx;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import flash.text.TextFieldAutoSize;
   import net.wg.utils.ILocale;
   
   public class ExchangeVcoinWarningMC extends UIComponent
   {
      
      public function ExchangeVcoinWarningMC() {
         super();
      }
      
      private static const BTN_OFFSET:int = 13;
      
      public var buyVcoinBtn:SoundButtonEx;
      
      public var textField:TextField;
      
      public var bg:MovieClip;
      
      private var _contentPadding:int = 20;
      
      override protected function configUI() : void {
         super.configUI();
         this.textField.autoSize = TextFieldAutoSize.LEFT;
         this.textField.wordWrap = true;
         this.textField.multiline = true;
         var _loc1_:ILocale = App.utils.locale;
         this.buyVcoinBtn.label = _loc1_.makeString(MENU.EXCHANGEVCOIN_BUYVCOINBTNNAME);
      }
      
      public function set minTransactValue(param1:Number) : void {
         var _loc2_:ILocale = App.utils.locale;
         this.textField.text = _loc2_.makeString(MENU.EXCHANGEVCOIN_VCOINISTIGHT,{"minval":param1.toString()});
         this.buyVcoinBtn.y = Math.round(this.textField.y + this.textField.textHeight + BTN_OFFSET);
         this.bg.height = Math.round(this.buyVcoinBtn.y + this._contentPadding * 2);
      }
      
      public function get contentPadding() : int {
         return this._contentPadding;
      }
   }
}
