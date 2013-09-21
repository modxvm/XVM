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
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.events.*;
    import net.wg.gui.lobby.profile.*;
    import net.wg.gui.lobby.window.*;
    import com.xvm.*;
    import com.xvm.l10n.Locale;
    import xvm.hangar.*;

    public class Profile extends XvmModBase
    {
        public function Profile(view:IView)
        {
            super(view);
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
                //Logger.add("onAfterPopulate: " + view.as_alias);
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
            //page.tabNavigator.viewStack.

            tabNavigator.bar.addEventListener(IndexEvent.INDEX_CHANGE, onTabBarIndexChanged, false, 0, true);
        }

        private function onTabBarIndexChanged(e:IndexEvent):void
        {
            tabNavigator.bar.removeEventListener(IndexEvent.INDEX_CHANGE, onTabBarIndexChanged);
            App.utils.scheduler.envokeInNextFrame(
                function():void { tabNavigator.bar.selectedIndex = Config.config.userInfo.startPage - 1; } );
        }
    }
}
