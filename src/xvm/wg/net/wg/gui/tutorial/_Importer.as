package net.wg.gui.tutorial 
{
    import __AS3__.vec.*;
    import net.wg.gui.tutorial.windows.*;
    import net.wg.infrastructure.*;
    
    public class _Importer extends net.wg.infrastructure.BaseImporter
    {
        public function _Importer()
        {
            super();
            importClasses(Vector.<Class>([net.wg.gui.tutorial.TutorialBattleLoading, net.wg.gui.tutorial.windows.TutorialGreetingDialog, net.wg.gui.tutorial.windows.TutorialQueueDialog, net.wg.gui.tutorial.windows.TutorialBattleNoResultsWindow, net.wg.gui.tutorial.windows.TutorialBattleStatisticWindow, net.wg.gui.tutorial.windows.TutorialVideoDialog]));
            return;
        }
    }
}
