package net.wg.gui.lobby.retrainCrewWindow
{
   import net.wg.data.constants.Currencies;
   
   public class SelPriceInfo extends Object
   {
      
      public function SelPriceInfo(param1:String, param2:Number) {
         super();
         this.currency = param1;
         this.price = param2;
         this.isGold = param1 == Currencies.GOLD;
      }
      
      public var currency:String;
      
      public var price:Number;
      
      public var isGold:Boolean;
   }
}
