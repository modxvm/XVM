package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractView;
    import net.wg.data.constants.Errors;
    
    public class WrapperViewMeta extends AbstractView
    {
        
        public function WrapperViewMeta()
        {
            super();
        }
        
        public var onWindowClose:Function = null;
        
        public function onWindowCloseS() : void
        {
            App.utils.asserter.assertNotNull(this.onWindowClose,"onWindowClose" + Errors.CANT_NULL);
            this.onWindowClose();
        }
    }
}
