package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.data.constants.Errors;
    
    public class TickerMeta extends BaseDAAPIComponent
    {
        
        public function TickerMeta()
        {
            super();
        }
        
        public var showBrowser:Function = null;
        
        public function showBrowserS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.showBrowser,"showBrowser" + Errors.CANT_NULL);
            this.showBrowser(param1);
        }
    }
}
