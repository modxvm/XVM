package net.wg.gui.messenger.meta.impl
{
    import net.wg.infrastructure.base.AbstractWindowView;
    import net.wg.data.constants.Errors;
    
    public class BaseChannelWindowMeta extends AbstractWindowView
    {
        
        public function BaseChannelWindowMeta()
        {
            super();
        }
        
        public var showFAQWindow:Function = null;
        
        public var getClientID:Function = null;
        
        public function showFAQWindowS() : void
        {
            App.utils.asserter.assertNotNull(this.showFAQWindow,"showFAQWindow" + Errors.CANT_NULL);
            this.showFAQWindow();
        }
        
        public function getClientIDS() : Number
        {
            App.utils.asserter.assertNotNull(this.getClientID,"getClientID" + Errors.CANT_NULL);
            return this.getClientID();
        }
    }
}
