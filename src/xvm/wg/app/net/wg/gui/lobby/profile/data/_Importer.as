package net.wg.gui.lobby.profile.data
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([ProfileAchievementVO,LayoutItemInfo,ProfileCommonInfoVO,ProfileDossierInfoVO,SectionLayoutManager]));
      }
   }

}