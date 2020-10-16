/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.profile
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
	import net.wg.gui.lobby.profile.LinkageUtils;
    import net.wg.data.*;
    import net.wg.data.constants.*;
    import net.wg.gui.lobby.profile.*;
    import net.wg.gui.lobby.window.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class ProfileXvmView extends XvmViewBase
    {
        public function ProfileXvmView(view:IView)
        {
            Logger.add("ProfileXvmView");
            super(view);
            XfwComponent.tryLoadUISWF("xvm_lobby", "xvm_lobbyprofile_ui.swf");
        }

        public function get tabNavigator():ProfileTabNavigator
        {
            var profile:Profile = view as Profile;
            if (profile)
                return profile.tabNavigator;
            var profileWindow:ProfileWindow = view as ProfileWindow;
            if (profileWindow)
                return profileWindow.tabNavigator;
            return null;
        }

        override public function onBeforePopulate(e:LifeCycleEvent):void
        {
            super.onBeforePopulate(e);

			var sectionsDataUtil:LinkageUtils = XfwUtils.getPrivateField(tabNavigator, 'xfw_sectionsDataUtil');
            sectionsDataUtil.addEntity(Aliases.PROFILE_TECHNIQUE_PAGE, "com.xvm.lobby.ui.profile::UI_ProfileTechniquePage");
            sectionsDataUtil.addEntity(Aliases.PROFILE_TECHNIQUE_WINDOW, "com.xvm.lobby.ui.profile::UI_ProfileTechniqueWindow");
            if (Config.networkServicesSettings.statAwards)
            {
				//HACK: access to const field
				var linkagesAsterisk:* = Linkages;
                linkagesAsterisk.TECHNIQUE_STATISTIC_TAB = "com.xvm.lobby.ui.profile::UI_TechniqueStatisticTab";
            }
        }
    }
}
