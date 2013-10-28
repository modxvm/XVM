package net.wg.gui.lobby.profile.pages.summary
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([AwardsListComponent,ProfileSummaryPage,ProfileSummaryWindow,ProfileSummary,SummaryInitVO,SummaryPageInitVO,ProfileSummaryVO,SummaryVO]));
      }
   }

}