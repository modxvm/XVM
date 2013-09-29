package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class IntroPageMeta extends net.wg.infrastructure.base.AbstractView
    {
        public function IntroPageMeta()
        {
            super();
            return;
        }

        public function stopVideoS():void
        {
            App.utils.asserter.assertNotNull(this.stopVideo, "stopVideo" + net.wg.data.constants.Errors.CANT_NULL);
            this.stopVideo();
            return;
        }

        public function handleErrorS(arg1:Object):void
        {
            App.utils.asserter.assertNotNull(this.handleError, "handleError" + net.wg.data.constants.Errors.CANT_NULL);
            this.handleError(arg1);
            return;
        }

        public var stopVideo:Function=null;

        public var handleError:Function=null;
    }
}
