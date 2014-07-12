package net.wg.gui.messenger.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    
    public class ConnectToSecureChannelWindowMeta extends AbstractWindowView
    {
        
        public function ConnectToSecureChannelWindowMeta() {
            super();
        }
        
        public var sendPassword:Function = null;
        
        public var cancelPassword:Function = null;
        
        public function sendPasswordS(param1:String) : void {
            App.utils.asserter.assertNotNull(this.sendPassword,"sendPassword" + Errors.CANT_NULL);
            this.sendPassword(param1);
        }
        
        public function cancelPasswordS() : void {
            App.utils.asserter.assertNotNull(this.cancelPassword,"cancelPassword" + Errors.CANT_NULL);
            this.cancelPassword();
        }
    }
}
