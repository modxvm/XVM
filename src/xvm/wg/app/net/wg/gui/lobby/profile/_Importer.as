package net.wg.gui.lobby.profile
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([Profile,ProfileConstants,ProfileMenuInfoVO,ProfileTabNavigator,SectionInfo,SectionsDataUtil,SectionViewInfo,UserInfoForm]));
      }
   }

}