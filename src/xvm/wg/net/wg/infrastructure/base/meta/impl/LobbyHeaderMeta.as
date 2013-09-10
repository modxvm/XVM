package net.wg.infrastructure.base.meta.impl 
{
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class LobbyHeaderMeta extends net.wg.infrastructure.base.BaseDAAPIComponent
    {
        public function LobbyHeaderMeta()
        {
            super();
            return;
        }

        public function menuItemClickS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.menuItemClick, "menuItemClick" + net.wg.data.constants.Errors.CANT_NULL);
            this.menuItemClick(arg1);
            return;
        }

        public function showLobbyMenuS():void
        {
            App.utils.asserter.assertNotNull(this.showLobbyMenu, "showLobbyMenu" + net.wg.data.constants.Errors.CANT_NULL);
            this.showLobbyMenu();
            return;
        }

        public function showExchangeWindowS(arg1:Object):void
        {
            App.utils.asserter.assertNotNull(this.showExchangeWindow, "showExchangeWindow" + net.wg.data.constants.Errors.CANT_NULL);
            this.showExchangeWindow(arg1);
            return;
        }

        public function showExchangeXPWindowS(arg1:Object):void
        {
            App.utils.asserter.assertNotNull(this.showExchangeXPWindow, "showExchangeXPWindow" + net.wg.data.constants.Errors.CANT_NULL);
            this.showExchangeXPWindow(arg1);
            return;
        }

        public function showPremiumDialogS(arg1:flash.events.Event):void
        {
            App.utils.asserter.assertNotNull(this.showPremiumDialog, "showPremiumDialog" + net.wg.data.constants.Errors.CANT_NULL);
            this.showPremiumDialog(arg1);
            return;
        }

        public function onPaymentS():void
        {
            App.utils.asserter.assertNotNull(this.onPayment, "onPayment" + net.wg.data.constants.Errors.CANT_NULL);
            this.onPayment();
            return;
        }

        public var menuItemClick:Function=null;

        public var showLobbyMenu:Function=null;

        public var showExchangeWindow:Function=null;

        public var showExchangeXPWindow:Function=null;

        public var showPremiumDialog:Function=null;

        public var onPayment:Function=null;
    }
}
