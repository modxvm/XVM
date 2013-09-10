package net.wg.gui.messenger.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class ConnectToSecureChannelWindowMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function ConnectToSecureChannelWindowMeta()
        {
            super();
            return;
        }

        public function sendPasswordS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.sendPassword, "sendPassword" + net.wg.data.constants.Errors.CANT_NULL);
            this.sendPassword(arg1);
            return;
        }

        public function cancelPasswordS():void
        {
            App.utils.asserter.assertNotNull(this.cancelPassword, "cancelPassword" + net.wg.data.constants.Errors.CANT_NULL);
            this.cancelPassword();
            return;
        }

        public var sendPassword:Function=null;

        public var cancelPassword:Function=null;
    }
}
