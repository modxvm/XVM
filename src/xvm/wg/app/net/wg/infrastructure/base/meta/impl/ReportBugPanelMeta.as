package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.data.constants.Errors;
    
    public class ReportBugPanelMeta extends BaseDAAPIComponent
    {
        
        public function ReportBugPanelMeta()
        {
            super();
        }
        
        public var reportBug:Function = null;
        
        public function reportBugS() : void
        {
            App.utils.asserter.assertNotNull(this.reportBug,"reportBug" + Errors.CANT_NULL);
            this.reportBug();
        }
    }
}
