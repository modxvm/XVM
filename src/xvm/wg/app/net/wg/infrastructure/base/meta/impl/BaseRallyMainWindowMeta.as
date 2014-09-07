package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.rally.AbstractRallyWindow;
    import net.wg.data.constants.Errors;
    
    public class BaseRallyMainWindowMeta extends AbstractRallyWindow
    {
        
        public function BaseRallyMainWindowMeta()
        {
            super();
        }
        
        public var onBackClick:Function = null;
        
        public var getClientID:Function = null;
        
        public function onBackClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onBackClick,"onBackClick" + Errors.CANT_NULL);
            this.onBackClick();
        }
        
        public function getClientIDS() : Number
        {
            App.utils.asserter.assertNotNull(this.getClientID,"getClientID" + Errors.CANT_NULL);
            return this.getClientID();
        }
    }
}
