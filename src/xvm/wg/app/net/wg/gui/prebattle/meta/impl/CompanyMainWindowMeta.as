package net.wg.gui.prebattle.meta.impl
{
    import net.wg.gui.rally.AbstractRallyWindow;
    import net.wg.data.constants.Errors;
    
    public class CompanyMainWindowMeta extends AbstractRallyWindow
    {
        
        public function CompanyMainWindowMeta()
        {
            super();
        }
        
        public var getCompanyName:Function = null;
        
        public var showFAQWindow:Function = null;
        
        public function getCompanyNameS() : String
        {
            App.utils.asserter.assertNotNull(this.getCompanyName,"getCompanyName" + Errors.CANT_NULL);
            return this.getCompanyName();
        }
        
        public function showFAQWindowS() : void
        {
            App.utils.asserter.assertNotNull(this.showFAQWindow,"showFAQWindow" + Errors.CANT_NULL);
            this.showFAQWindow();
        }
    }
}
