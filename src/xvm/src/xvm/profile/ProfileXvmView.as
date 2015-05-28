/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.profile
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import net.wg.data.*;
    import net.wg.gui.events.ViewStackEvent;
    import net.wg.gui.lobby.profile.*;
    import net.wg.gui.lobby.window.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class ProfileXvmView extends XvmViewBase
    {
        private static const _name:String = "xvm_profile";
        private static const _ui_name:String = _name + "_ui.swf";
        private static const _preloads:Array = [];// "profileStatistics.swf", "profileTechnique.swf" ];

        private static var _ui_swf_loaded:Boolean = false;

        public function ProfileXvmView(view:IView)
        {
            //Logger.add("ProfileXvmView");
            super(view);

            if (!_ui_swf_loaded)
            {
                _ui_swf_loaded = true;
                Xfw.load_ui_swf(_name, _ui_name, _preloads);
            }
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
            tabNavigator.xfw_sectionsDataUtil.addEntity(Aliases.PROFILE_TECHNIQUE_PAGE, "xvm.profile_ui::UI_ProfileTechniquePage");
            tabNavigator.xfw_sectionsDataUtil.addEntity(Aliases.PROFILE_TECHNIQUE_WINDOW, "xvm.profile_ui::UI_ProfileTechniqueWindow");
        }
    }
}
