package xvm.hangar.components.Profile
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.gui.lobby.profile.pages.summary.*;
    import net.wg.gui.lobby.profile.pages.technique.*;
    import com.xvm.*;
    import com.xvm.events.*;
    import com.xvm.io.*;
    import com.xvm.types.cfg.*;
    import xvm.UI.profileSections.UI_TechniqueRenderer;

    public class TechniquePage extends Technique
    {
        public function TechniquePage(page:ProfileTechniquePage):void
        {
            super(page);

            page.checkBoxExistence.selected = Config.config.userInfo.inHangarFilterEnabled;
        }

        override protected function getPlayerName():String
        {
            //return page.currentDossier.id; // id is null for own account
            return ""; // TODO
        }

        override protected function createControls():void
        {
            super.createControls();
        }

        // PRIVATE
    }
}
