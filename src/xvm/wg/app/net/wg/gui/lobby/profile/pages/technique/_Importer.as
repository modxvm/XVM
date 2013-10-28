package net.wg.gui.lobby.profile.pages.technique
{
   import net.wg.infrastructure.BaseImporter;
   import net.wg.gui.lobby.profile.pages.technique.data.SortingSettingVO;
   import net.wg.gui.lobby.profile.pages.technique.data.TechniqueListVehicleVO;
   import net.wg.gui.lobby.profile.pages.technique.data.ProfileVehicleDossierVO;
   import net.wg.gui.lobby.profile.pages.technique.data.TechniqueStatisticVO;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([ProfileSortingBtnInfo,ProfileTechniqueEmptyScreen,ProfileSortingButton,ProfileTechniquePage,ProfileTechniqueWindow,ProfileTechnique,SortingSettingVO,TechniqueListVehicleVO,TechniqueRenderer,TechniqueStatisticTab,TechniqueAchievementsBlock,TechniqueAchievementTab,TechniqueStackComponent,TechniqueListComponent,AchievementSmall,ProfileVehicleDossierVO,TechniqueStatisticVO]));
      }
   }

}