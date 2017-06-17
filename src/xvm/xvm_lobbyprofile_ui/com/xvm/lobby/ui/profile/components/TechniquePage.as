/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.lobby.ui.profile.components
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.lobby.ui.profile.*;
    import net.wg.gui.lobby.profile.pages.technique.*;

    public class TechniquePage extends Technique
    {
        public function TechniquePage(page:ProfileTechniquePage, playerName:String):void
        {
            super(page, playerName, 0);
            page.listComponent.addEventListener(TechniqueListComponent.DATA_CHANGED, initializeInHangarCheckBox, false, 0, true);
        }

        // PRIVATE

        private function initializeInHangarCheckBox():void
        {
            page.listComponent.removeEventListener(TechniqueListComponent.DATA_CHANGED, initializeInHangarCheckBox);
            if ((page as UI_ProfileTechniquePage).baseDisposed)
                return;
            if (page.listComponent.visible)
            {
                var pg:ProfileTechniquePage = page as ProfileTechniquePage;
                pg.checkBoxExistence.selected = Config.config.userInfo.inHangarFilterEnabled;
                pg.setIsInHangarSelectedS(pg.checkBoxExistence.selected);
            }
        }
    }
}
