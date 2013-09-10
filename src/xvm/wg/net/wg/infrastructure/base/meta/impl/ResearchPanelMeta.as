package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    
    public class ResearchPanelMeta extends net.wg.infrastructure.base.BaseDAAPIComponent
    {
        public function ResearchPanelMeta()
        {
            super();
            return;
        }

        public function goToResearchS():void
        {
            App.utils.asserter.assertNotNull(this.goToResearch, "goToResearch" + net.wg.data.constants.Errors.CANT_NULL);
            this.goToResearch();
            return;
        }

        public var goToResearch:Function=null;
    }
}
