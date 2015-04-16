/**
 * XVM - user info
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.profile
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import flash.utils.*;
    import net.wg.data.*;
    import net.wg.gui.lobby.profile.*;
    import net.wg.gui.lobby.window.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    import xvm.profile.UI.*;

    public class ProfileXvmView extends XvmViewBase
    {
        public function ProfileXvmView(view:IView)
        {
            //Logger.add("ProfileXvmView");
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

        override public function onBeforePopulate(e:LifeCycleEvent):void
        {
            tabNavigator.xfw_sectionsDataUtil.addEntity(Aliases.PROFILE_TECHNIQUE_PAGE, getQualifiedClassName(UI_ProfileTechniquePage));
            tabNavigator.xfw_sectionsDataUtil.addEntity(Aliases.PROFILE_TECHNIQUE_WINDOW, getQualifiedClassName(UI_ProfileTechniqueWindow));
            tabNavigator.addEventListener(LifeCycleEvent.ON_AFTER_POPULATE, initializeStartPage);
        }

        override public function onBeforeDispose(e:LifeCycleEvent):void
        {
            tabNavigator.removeEventListener(LifeCycleEvent.ON_AFTER_POPULATE, initializeStartPage);
        }

        // PRIVATE

        private function initializeStartPage(depth:int = 0):void
        {
            //Logger.add("initializeStartPage: " + depth);

            try
            {
                if (depth > 10)
                {
                    Logger.add("WARNING: profile start page initialization timeout");
                    return;
                }

                if (tabNavigator.xfw_initData == null)
                {
                    var $this:ProfileXvmView = this;
                    setTimeout(function():void { $this.initializeStartPage(depth + 1); }, 1);
                    return;
                }

                // initialize start page
                var alias:String = tabNavigator.xfw_initData.selectedAlias;
                if (alias == Aliases.PROFILE_SUMMARY_PAGE || alias == "")
                {
                    var index:int = Config.config.userInfo.startPage - 1;
                    if (index > 0 && index < tabNavigator.xfw_initData.sectionsData.length)
                        tabNavigator.bar.selectedIndex = index;
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
