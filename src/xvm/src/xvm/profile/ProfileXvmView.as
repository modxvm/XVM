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
    import flash.display.MovieClip;
    import flash.events.*;
    import flash.utils.*;
    import net.wg.gui.components.windows.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.profile.*;
    import net.wg.gui.lobby.profile.components.*;
    import net.wg.gui.lobby.profile.pages.awards.*;
    import net.wg.gui.lobby.profile.pages.summary.*;
    import net.wg.gui.lobby.profile.pages.technique.*;
    import net.wg.gui.lobby.window.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.data.DataProvider;
    import scaleform.clik.events.*;
    import xvm.profile.components.*;

    public class ProfileXvmView extends XvmViewBase
    {
        private var awardsPage:ProfileAwards;
        private var summaryPage:ProfileSummary;
        private var _startPageInitialized:Boolean;

        public function ProfileXvmView(view:IView)
        {
            super(view);
            _startPageInitialized = false;
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

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            init();
        }

        // PRIVATE

        private function init():void
        {
            //Logger.addObject(tabNavigator.bar.dataProvider, 2);
            tabNavigator.viewStack.addEventListener(ViewStackEvent.VIEW_CHANGED, onSectionViewShowed, false, 0, true);
        }

        private function onSectionViewShowed(e:ViewStackEvent):void
        {
            //Logger.addObject("onSectionViewShowed: " + e.view);

            if (e.view is ProfileAwards)
            {
                awardsPage = e.view as ProfileAwards;
                initializeStartPage();
                return;
            }

            if (e.view is ProfileSummary)
            {
                summaryPage = e.view as ProfileSummary;
                initializeStartPage();
                return;
            }

            if (e.view is ProfileTechniquePage)
            {
                var page:ProfileTechniquePage = e.view as ProfileTechniquePage;
                if (page.getChildByName("xvm_extension") == null)
                {
                    var tp:TechniquePage = new TechniquePage(page, Globals[Globals.NAME]);
                    page.addChild(tp);
                }
                return;
            }

            if (e.view is ProfileTechniqueWindow)
            {
                var window:ProfileTechniqueWindow = e.view as ProfileTechniqueWindow;
                if (window.getChildByName("xvm_extension") == null)
                {
                    // get player name from window title
                    var playerName:String = WGUtils.GetPlayerName(((view as ProfileWindow).window as Window).title);

                    // get player id from the view name.
                    var playerId:int = parseInt(view.as_name.replace("window_", ""));

                    var tw:TechniqueWindow = new TechniqueWindow(window, playerName, playerId);
                    window.addChild(tw);
                }
                return;
            }
        }

        // start page workaround

        public function initializeStartPage():void
        {
            if (_startPageInitialized)
                return;

            if (!summaryPage || !awardsPage)
                return;

            // Wait for awards page data loaded
            var amc:AwardsMainContainer = AwardsMainContainer(awardsPage.mainScrollPane.target);
            if (amc.blockBattleHeroes.textField.text == "T1")
            {
                setTimeout(initializeStartPage, 1); // Start page have strange behavior when using App.utils.scheduler.envokeInNextFrame()
                return;
            }

            // Wait for summary page data loaded
            if ((summaryPage.footer as UserDateFooter).textDates.htmlText == "")
            {
                setTimeout(initializeStartPage, 1); // Start page have strange behavior when using App.utils.scheduler.envokeInNextFrame()
                return;
            }

            //Logger.addObject(summaryPage);

            _startPageInitialized = true;
            var index:int = Config.config.userInfo.startPage - 1;
            if (index <= 0)
                return;

            tabNavigator.bar.selectedIndex = index;
        }
    }
}
