package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class WindowViewMeta extends net.wg.infrastructure.base.AbstractView
    {
        public function WindowViewMeta()
        {
            super();
            return;
        }

        public function onWindowCloseS():void
        {
            App.utils.asserter.assertNotNull(this.onWindowClose, "onWindowClose" + net.wg.data.constants.Errors.CANT_NULL);
            this.onWindowClose();
            return;
        }

        public function onWindowMinimizeS():void
        {
            App.utils.asserter.assertNotNull(this.onWindowMinimize, "onWindowMinimize" + net.wg.data.constants.Errors.CANT_NULL);
            this.onWindowMinimize();
            return;
        }

        public var onWindowClose:Function=null;

        public var onWindowMinimize:Function=null;
    }
}
