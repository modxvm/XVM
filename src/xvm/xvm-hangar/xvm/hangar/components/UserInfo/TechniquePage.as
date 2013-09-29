package xvm.hangar.components.UserInfo
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

    public class TechniquePage extends Sprite
    {
        private var summaryPage:ProfileSummaryPage;
        private var page:ProfileTechniquePage;

        public function TechniquePage(page:ProfileTechniquePage, summaryPage:ProfileSummaryPage):void
        {
            this.summaryPage = summaryPage;
            this.page = page;
            page.checkBoxExistence.selected = Config.config.userInfo.inHangarFilterEnabled;
        }

        // PRIVATE
    }
}
