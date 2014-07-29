package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractView;
    import net.wg.data.constants.Errors;
    
    public class IntroPageMeta extends AbstractView
    {
        
        public function IntroPageMeta()
        {
            super();
        }
        
        public var stopVideo:Function = null;
        
        public var handleError:Function = null;
        
        public function stopVideoS() : void
        {
            App.utils.asserter.assertNotNull(this.stopVideo,"stopVideo" + Errors.CANT_NULL);
            this.stopVideo();
        }
        
        public function handleErrorS(param1:Object) : void
        {
            App.utils.asserter.assertNotNull(this.handleError,"handleError" + Errors.CANT_NULL);
            this.handleError(param1);
        }
    }
}
