/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.profile.components
{
    import com.xfw.*;
    import com.xvm.*;
    import net.wg.gui.lobby.profile.pages.technique.*;

    public class TechniquePage extends Technique
    {
        public function TechniquePage(page:ProfileTechniquePage, playerName:String):void
        {
            super(page, playerName, 0);
            page.listComponent.addEventListener(TechniqueListComponent.DATA_CHANGED, initializeInHangarCheckBox);
        }

//        override protected function createFilters():void
//        {
//            super.createFilters();
//
//            filter.visible = false;
//            var pg:ProfileTechniquePage = page as ProfileTechniquePage;
//            filter.x = pg.checkBoxExistence.x - 260;
//            filter.y = pg.checkBoxExistence.y - 20;
//        }

        // PRIVATE

        private function initializeInHangarCheckBox():void
        {
            page.listComponent.removeEventListener(TechniqueListComponent.DATA_CHANGED, initializeInHangarCheckBox);
            if (page.listComponent.visible)
            {
                var pg:ProfileTechniquePage = page as ProfileTechniquePage;
                pg.checkBoxExistence.selected = Config.config.userInfo.inHangarFilterEnabled;
            }
        }
    }
}
