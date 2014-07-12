package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.data.constants.Errors;
   import flash.events.Event;
   
   public class LobbyHeaderMeta extends BaseDAAPIComponent
   {
      
      public function LobbyHeaderMeta() {
         super();
      }
      
      public var menuItemClick:Function = null;
      
      public var showLobbyMenu:Function = null;
      
      public var showExchangeWindow:Function = null;
      
      public var showExchangeXPWindow:Function = null;
      
      public var showPremiumDialog:Function = null;
      
      public var onPayment:Function = null;
      
      public var getServers:Function = null;
      
      public var relogin:Function = null;
      
      public function menuItemClickS(param1:String) : void {
         App.utils.asserter.assertNotNull(this.menuItemClick,"menuItemClick" + Errors.CANT_NULL);
         this.menuItemClick(param1);
      }
      
      public function showLobbyMenuS() : void {
         App.utils.asserter.assertNotNull(this.showLobbyMenu,"showLobbyMenu" + Errors.CANT_NULL);
         this.showLobbyMenu();
      }
      
      public function showExchangeWindowS(param1:Object) : void {
         App.utils.asserter.assertNotNull(this.showExchangeWindow,"showExchangeWindow" + Errors.CANT_NULL);
         this.showExchangeWindow(param1);
      }
      
      public function showExchangeXPWindowS(param1:Object) : void {
         App.utils.asserter.assertNotNull(this.showExchangeXPWindow,"showExchangeXPWindow" + Errors.CANT_NULL);
         this.showExchangeXPWindow(param1);
      }
      
      public function showPremiumDialogS(param1:Event) : void {
         App.utils.asserter.assertNotNull(this.showPremiumDialog,"showPremiumDialog" + Errors.CANT_NULL);
         this.showPremiumDialog(param1);
      }
      
      public function onPaymentS() : void {
         App.utils.asserter.assertNotNull(this.onPayment,"onPayment" + Errors.CANT_NULL);
         this.onPayment();
      }
      
      public function getServersS() : Array {
         App.utils.asserter.assertNotNull(this.getServers,"getServers" + Errors.CANT_NULL);
         return this.getServers();
      }
      
      public function reloginS(param1:int) : void {
         App.utils.asserter.assertNotNull(this.relogin,"relogin" + Errors.CANT_NULL);
         this.relogin(param1);
      }
   }
}
