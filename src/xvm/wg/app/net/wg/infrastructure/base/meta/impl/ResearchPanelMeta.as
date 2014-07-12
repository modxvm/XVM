package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.data.constants.Errors;
   
   public class ResearchPanelMeta extends BaseDAAPIComponent
   {
      
      public function ResearchPanelMeta() {
         super();
      }
      
      public var goToResearch:Function = null;
      
      public function goToResearchS() : void {
         App.utils.asserter.assertNotNull(this.goToResearch,"goToResearch" + Errors.CANT_NULL);
         this.goToResearch();
      }
   }
}
