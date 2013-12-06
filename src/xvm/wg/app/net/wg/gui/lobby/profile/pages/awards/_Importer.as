package net.wg.gui.lobby.profile.pages.awards
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([AwardsMainContainer,AwardsBlock,StageAwardsBlock,ProfileAwards]));
      }
   }

}