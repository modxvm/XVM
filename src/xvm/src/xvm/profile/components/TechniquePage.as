package xvm.profile.components
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.dossier.*;
    import net.wg.gui.lobby.profile.pages.technique.*;

    public class TechniquePage extends Technique
    {
        public function TechniquePage(page:ProfileTechniquePage, playerName:String):void
        {
            super(page, playerName);

            _playerId = 0;
            Dossier.loadAccountDossier(this, dossierLoaded, PROFILE.PROFILE_DROPDOWN_LABELS_ALL);

            page.listComponent.addEventListener(TechniqueListComponent.DATA_CHANGED, initializeInHangarCheckBox);
        }

        private function dossierLoaded(dossier:AccountDossier):void
        {
            // TODO
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
