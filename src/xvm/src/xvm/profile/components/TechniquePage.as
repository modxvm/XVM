package xvm.profile.components
{
    import com.xvm.*;
    import flash.utils.*;
    import net.wg.data.gui_items.dossier.*;
    import net.wg.gui.lobby.profile.pages.summary.*;
    import net.wg.gui.lobby.profile.pages.technique.*;
    import net.wg.infrastructure.events.*;

    public class TechniquePage extends Technique
    {
        public function TechniquePage(page:ProfileTechniquePage, summary:ProfileSummary, playerName:String):void
        {
            super(page, summary, playerName);

            _accountDossier = new AccountDossier(null);

            page.listComponent.addEventListener(TechniqueListComponent.DATA_CHANGED, initializeInHangarCheckBox);
        }

        private function initializeInHangarCheckBox():void
        {
            page.listComponent.removeEventListener(TechniqueListComponent.DATA_CHANGED, initializeInHangarCheckBox);
            if (page.listComponent.visible)
            {
                var pg:ProfileTechniquePage = page as ProfileTechniquePage;
                pg.checkBoxExistence.selected = Config.config.userInfo.inHangarFilterEnabled;
            }
        }

        override protected function createFilters():void
        {
            super.createFilters();

            filter.visible = false;
            var pg:ProfileTechniquePage = page as ProfileTechniquePage;
            filter.x = pg.checkBoxExistence.x - 260;
            filter.y = pg.checkBoxExistence.y - 20;
        }
    }
}
