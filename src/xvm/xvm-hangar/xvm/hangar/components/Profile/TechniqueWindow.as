package xvm.hangar.components.Profile
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.gui.components.windows.Window;
    import net.wg.gui.lobby.profile.pages.summary.*;
    import net.wg.gui.lobby.profile.pages.technique.*;
    import net.wg.gui.lobby.window.*;
    import com.xvm.*;
    import com.xvm.events.*;
    import com.xvm.io.*;
    import com.xvm.types.cfg.*;
    import xvm.UI.profileSections.UI_TechniqueRenderer;

    public class TechniqueWindow extends Technique
    {
        public function TechniqueWindow(window:ProfileTechniqueWindow):void
        {
            super(window);
        }

        override protected function getPlayerName():String
        {
            return page && page.currentDossier ? page.currentDossier.id : null;
        }

        // PRIVATE
    }
}
