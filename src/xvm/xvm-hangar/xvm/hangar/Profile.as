/**
 * XVM - user info
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package xvm.hangar
{
    import flash.events.*;
    import flash.utils.*;
    import scaleform.clik.events.*;
    import net.wg.gui.lobby.profile.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.infrastructure.events.*;
    import com.xvm.*;
    import com.xvm.l10n.Locale;

    public class Profile extends XvmModBase
    {
        public function Profile(view:IView)
        {
            super(view);
        }

        public function get page():net.wg.gui.lobby.profile.Profile
        {
            return super.view as net.wg.gui.lobby.profile.Profile;
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

            page.tabNavigator.bar.addEventListener(IndexEvent.INDEX_CHANGE, onTabBarIndexChanged, false, 0, true);
        }

        private function onTabBarIndexChanged(e:IndexEvent):void
        {
            page.tabNavigator.bar.removeEventListener(IndexEvent.INDEX_CHANGE, onTabBarIndexChanged);
            App.utils.scheduler.envokeInNextFrame(
                function():void { page.tabNavigator.bar.selectedIndex = Config.config.userInfo.startPage - 1; } );
        }
    }
}
