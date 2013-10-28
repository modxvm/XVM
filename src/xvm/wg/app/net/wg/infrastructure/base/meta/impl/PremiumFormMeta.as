package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.data.constants.Errors;


   public class PremiumFormMeta extends AbstractWindowView
   {
          
      public function PremiumFormMeta() {
         super();
      }

      public var onPremiumBuy:Function = null;

      public var onPremiumDataRequest:Function = null;

      public function onPremiumBuyS(param1:Number, param2:Number) : void {
         App.utils.asserter.assertNotNull(this.onPremiumBuy,"onPremiumBuy" + Errors.CANT_NULL);
         this.onPremiumBuy(param1,param2);
      }

      public function onPremiumDataRequestS() : void {
         App.utils.asserter.assertNotNull(this.onPremiumDataRequest,"onPremiumDataRequest" + Errors.CANT_NULL);
         this.onPremiumDataRequest();
      }
   }

}