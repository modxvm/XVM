package net.wg.gui.tutorial
{
   import net.wg.infrastructure.BaseImporter;
   import net.wg.gui.tutorial.windows.TutorialGreetingDialog;
   import net.wg.gui.tutorial.windows.TutorialQueueDialog;
   import net.wg.gui.tutorial.windows.TutorialBattleNoResultsWindow;
   import net.wg.gui.tutorial.windows.TutorialBattleStatisticWindow;
   import net.wg.gui.tutorial.windows.TutorialVideoDialog;


   public class _Importer extends BaseImporter
   {
          
      public function _Importer() {
         super();
         importClasses(Vector.<Class>([TutorialBattleLoading,TutorialGreetingDialog,TutorialQueueDialog,TutorialBattleNoResultsWindow,TutorialBattleStatisticWindow,TutorialVideoDialog]));
      }
   }

}