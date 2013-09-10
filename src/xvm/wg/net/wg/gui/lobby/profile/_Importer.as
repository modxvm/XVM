package net.wg.gui.lobby.profile 
{
    import __AS3__.vec.*;
    import net.wg.infrastructure.*;
    
    public class _Importer extends net.wg.infrastructure.BaseImporter
    {
        public function _Importer()
        {
            super();
            importClasses(Vector.<Class>([net.wg.gui.lobby.profile.Profile, net.wg.gui.lobby.profile.ProfileConstants, net.wg.gui.lobby.profile.ProfileMenuInfoVO, net.wg.gui.lobby.profile.ProfileTabNavigator, net.wg.gui.lobby.profile.SectionInfo, net.wg.gui.lobby.profile.SectionsDataUtil, net.wg.gui.lobby.profile.SectionViewInfo, net.wg.gui.lobby.profile.UserInfoForm]));
            return;
        }
    }
}
