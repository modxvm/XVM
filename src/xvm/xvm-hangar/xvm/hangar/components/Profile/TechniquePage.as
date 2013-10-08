package xvm.hangar.components.Profile
{
    import net.wg.gui.lobby.profile.pages.technique.*;
    import com.xvm.*;
    import xvm.*;

    public class TechniquePage extends Technique
    {
        public function TechniquePage(page:ProfileTechniquePage):void
        {
            super(page);

            page.checkBoxExistence.selected = Config.config.userInfo.inHangarFilterEnabled;
        }

        override protected function getPlayerName():String
        {
            return XvmHangar.Globals[XvmHangar.G_NAME];
        }

        override protected function createFilters():void
        {
            super.createFilters();

            var pg:ProfileTechniquePage = page as ProfileTechniquePage;
            filter.visible = true;
            filter.x = pg.checkBoxExistence.x - 260;
            filter.y = pg.checkBoxExistence.y - 20;
        }
    }
}
