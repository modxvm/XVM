package net.wg.gui.messenger.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class BaseChannelWindowMeta extends net.wg.infrastructure.base.AbstractWindowView
    {
        public function BaseChannelWindowMeta()
        {
            super();
            return;
        }

        public function showFAQWindowS():void
        {
            App.utils.asserter.assertNotNull(this.showFAQWindow, "showFAQWindow" + net.wg.data.constants.Errors.CANT_NULL);
            this.showFAQWindow();
            return;
        }

        public function getClientIDS():Number
        {
            App.utils.asserter.assertNotNull(this.getClientID, "getClientID" + net.wg.data.constants.Errors.CANT_NULL);
            return this.getClientID();
        }

        public var showFAQWindow:Function=null;

        public var getClientID:Function=null;
    }
}
