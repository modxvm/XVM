package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    import net.wg.infrastructure.interfaces.*;
    
    public class LoaderManagerMeta extends net.wg.infrastructure.base.BaseDAAPIModule
    {
        public function LoaderManagerMeta()
        {
            super();
            return;
        }

        public function viewLoadedS(arg1:String, arg2:net.wg.infrastructure.interfaces.IView):void
        {
            App.utils.asserter.assertNotNull(this.viewLoaded, "viewLoaded" + net.wg.data.constants.Errors.CANT_NULL);
            this.viewLoaded(arg1, arg2);
            return;
        }

        public function viewLoadErrorS(arg1:String, arg2:String, arg3:String):void
        {
            App.utils.asserter.assertNotNull(this.viewLoadError, "viewLoadError" + net.wg.data.constants.Errors.CANT_NULL);
            this.viewLoadError(arg1, arg2, arg3);
            return;
        }

        public function viewInitializationErrorS(arg1:String, arg2:Object, arg3:String):void
        {
            App.utils.asserter.assertNotNull(this.viewInitializationError, "viewInitializationError" + net.wg.data.constants.Errors.CANT_NULL);
            this.viewInitializationError(arg1, arg2, arg3);
            return;
        }

        public var viewLoaded:Function=null;

        public var viewLoadError:Function=null;

        public var viewInitializationError:Function=null;
    }
}
