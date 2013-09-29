/**
 * XVM - user info
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package xvm.hangar.views
{
    import flash.events.*;
    import flash.utils.*;
    import scaleform.clik.events.*;
    import net.wg.gui.lobby.profile.*;
    import net.wg.gui.lobby.profile.pages.summary.*;
    import net.wg.gui.lobby.profile.pages.technique.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.events.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.profile.*;
    import net.wg.gui.lobby.window.*;
    import com.xvm.*;
    import com.xvm.l10n.Locale;
    import xvm.hangar.*;
    import xvm.hangar.components.Profile.*;

    public class Profile extends XvmModBase
    {
        private var summary:ProfileSummary;

        public function Profile(view:IView)
        {
            super(view);
            summary = null;
        }

        public function get tabNavigator():ProfileTabNavigator
        {
            var profile:net.wg.gui.lobby.profile.Profile = view as net.wg.gui.lobby.profile.Profile;
            if (profile != null)
                return profile.tabNavigator;
            var profileWindow:net.wg.gui.lobby.window.ProfileWindow = view as net.wg.gui.lobby.window.ProfileWindow;
            if (profileWindow != null)
                return profileWindow.tabNavigator;
            return null;
        }

        public override function onAfterPopulate(e:LifeCycleEvent):void
        {
            try
            {
                init();
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        // PRIVATE

        private function init():void
        {
            tabNavigator.bar.addEventListener(IndexEvent.INDEX_CHANGE, onTabBarIndexChanged, false, 0, true);
            tabNavigator.viewStack.addEventListener(ViewStackEvent.VIEW_CHANGED, onSectionViewShowed, false, 0, true);
        }

        private function onTabBarIndexChanged(e:IndexEvent):void
        {
            tabNavigator.bar.removeEventListener(IndexEvent.INDEX_CHANGE, onTabBarIndexChanged);
            App.utils.scheduler.envokeInNextFrame(
                function():void { tabNavigator.bar.selectedIndex = Config.config.userInfo.startPage - 1; } );
        }

        private function onSectionViewShowed(e:ViewStackEvent):void
        {
            if (e.view is ProfileSummary)
            {
                summary = e.view as ProfileSummary;
            }
            else if (e.view is ProfileTechniquePage)
            {
                var page:ProfileTechniquePage = e.view as ProfileTechniquePage;
                if (page.getChildByName("xvm_extension") == null)
                {
                    var tp:TechniquePage = new TechniquePage(page, summary);
                    tp.name = "xvm_extension";
                    page.addChild(tp);
                }
            }
            else if (e.view is ProfileTechniqueWindow)
            {
                var window:ProfileTechniqueWindow = e.view as ProfileTechniqueWindow;
                if (window.getChildByName("xvm_extension") == null)
                {
                    var tw:TechniqueWindow = new TechniqueWindow(window, summary);
                    tw.name = "xvm_extension";
                    window.addChild(tw);
                }
            }
        }
    }
}
