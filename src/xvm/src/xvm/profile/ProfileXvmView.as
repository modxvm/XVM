/**
 * XVM - user info
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package xvm.profile
{
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.misc.*;
    import com.xvm.utils.*;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.gui.components.windows.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.profile.*;
    import net.wg.gui.lobby.profile.components.*;
    import net.wg.gui.lobby.profile.data.SectionLayoutManager;
    import net.wg.gui.lobby.profile.pages.awards.ProfileAwards;
    import net.wg.gui.lobby.profile.pages.summary.*;
    import net.wg.gui.lobby.profile.pages.technique.*;
    import net.wg.gui.lobby.window.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.events.*;
    import xvm.profile.components.*;

    public class ProfileXvmView extends XvmViewBase
    {
        private const WINDOW_EXTRA_WIDTH:int = 70;
        private const WINDOW_EXTRA_HEIGHT:int = 35;

        private var summaryPage:ProfileSummary;
        private var _summaryPageInitialized:Boolean;

        public function ProfileXvmView(view:IView)
        {
            super(view);
            _summaryPageInitialized = false;
        }

        public function get tabNavigator():ProfileTabNavigator
        {
            var profile:Profile = view as Profile;
            if (profile != null)
                return profile.tabNavigator;
            var profileWindow:ProfileWindow = view as ProfileWindow;
            if (profileWindow != null)
                return profileWindow.tabNavigator;
            return null;
        }

        public override function onBeforePopulate(e:LifeCycleEvent):void
        {
            var pw:ProfileWindow = view as ProfileWindow;
            if (pw != null)
            {
                var xw:int = Config.config.hangar.showExtraDataInProfile ? WINDOW_EXTRA_WIDTH : 0;
                pw.setActualSize(pw.width + xw, pw.height + WINDOW_EXTRA_HEIGHT);
                pw.tabNavigator.width += xw;
                pw.btnAddToFriends.y += WINDOW_EXTRA_HEIGHT;
                pw.btnAddToIgnore.y += WINDOW_EXTRA_HEIGHT;
                pw.btnCreatePrivateChannel.y += WINDOW_EXTRA_HEIGHT;
                pw.background.height += WINDOW_EXTRA_HEIGHT;
                pw.background.width += WINDOW_EXTRA_WIDTH;
            }
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            init();
        }

        // PRIVATE

        private function init():void
        {
            //Logger.addObject(tabNavigator.bar.dataProvider, 2);
            tabNavigator.viewStack.addEventListener(ViewStackEvent.VIEW_CHANGED, onSectionViewShowed);
        }

        private function onSectionViewShowed(e:ViewStackEvent):void
        {
            //Logger.addObject("onSectionViewShowed: " + e.view);

            var profileWindow:ProfileWindow = view as ProfileWindow;

            if (e.view is ProfileSummary)
            {
                summaryPage = e.view as ProfileSummary;
                if (!_summaryPageInitialized)
                {
                    _summaryPageInitialized = true;

                    App.utils.scheduler.envokeInNextFrame(initializeStartPage);
                }
                return;
            }

            var page:ProfileTechniquePage = e.view as ProfileTechniquePage;
            if (page != null)
            {
                if (page.getChildByName("xvm_extension") == null)
                {
                    page.listComponent.techniqueList.rowHeight = 32;

                    var tp:TechniquePage = new TechniquePage(page, summaryPage, Globals[Globals.NAME]);
                    page.addChild(tp);
                }
                return;
            }

            var window:ProfileTechniqueWindow = e.view as ProfileTechniqueWindow;
            if (window != null)
            {
                if (window.getChildByName("xvm_extension") == null)
                {
                    window.listComponent.techniqueList.rowHeight = 32;

                    // get player name from window title
                    var playerName:String = WGUtils.GetPlayerName((profileWindow.window as Window).title);

                    // get player id from the view name.
                    var playerId:int = parseInt(view.as_name.replace("window_", ""));

                    var tw:TechniqueWindow = new TechniqueWindow(window, summaryPage, playerName, playerId);
                    window.addChild(tw);
                }
                return;
            }
        }

        // start page workaround

        public function initializeStartPage():void
        {
            if (!summaryPage)
                return;

            var index:int = Config.config.userInfo.startPage - 1;
            if (index > 0)
                tabNavigator.bar.selectedIndex = index;
        }
    }
}
