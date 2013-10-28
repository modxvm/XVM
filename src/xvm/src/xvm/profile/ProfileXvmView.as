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
    import net.wg.gui.components.windows.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.profile.*;
    import net.wg.gui.lobby.profile.pages.technique.*;
    import net.wg.gui.lobby.window.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.events.*;
    import xvm.profile.components.*;

    public class ProfileXvmView extends XvmViewBase
    {
        public function ProfileXvmView(view:IView)
        {
            super(view);
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
            //tabNavigator.bar.addEventListener(IndexEvent.INDEX_CHANGE, onTabBarIndexChanged, false, 0, true);
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
            var playerName:String;
            if (e.view is ProfileTechniquePage)
            {
                var page:ProfileTechniquePage = e.view as ProfileTechniquePage;
                if (page.getChildByName("xvm_extension") == null)
                {
                    playerName = Globals[Globals.NAME];
                    var tp:TechniquePage = new TechniquePage(page, playerName);
                    tp.name = "xvm_extension";
                    page.addChild(tp);
                }
            }
            else if (e.view is ProfileTechniqueWindow)
            {
                var window:ProfileTechniqueWindow = e.view as ProfileTechniqueWindow;
                if (window.getChildByName("xvm_extension") == null)
                {
                    playerName = WGUtils.GetPlayerName(((view as ProfileWindow).window as Window).title);
                    var tw:TechniqueWindow = new TechniqueWindow(window, playerName);
                    tw.name = "xvm_extension";
                    window.addChild(tw);
                }
            }
        }
    }
}
