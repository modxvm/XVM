package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class TickerMeta extends net.wg.infrastructure.base.BaseDAAPIComponent
    {
        public function TickerMeta()
        {
            super();
            return;
        }

        public function showBrowserS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.showBrowser, "showBrowser" + net.wg.data.constants.Errors.CANT_NULL);
            this.showBrowser(arg1);
            return;
        }

        public var showBrowser:Function=null;
    }
}
