package net.wg.gui.lobby.techtree.controls
{
   import net.wg.infrastructure.BaseImporter;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([ActionButton,ExperienceInformation,ExperienceLabel,LevelDelimiter,LevelsContainer,NameAndXpField,NationButton,NationsButtonBar,NodeComponent,PremiumDescription,PremiumLayout,ResearchTitleBar,ReturnToTTButton,TypeAndLevelField,XPIcon]));
      }
   }

}