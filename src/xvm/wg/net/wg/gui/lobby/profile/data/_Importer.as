package net.wg.gui.lobby.profile.data 
{
    import __AS3__.vec.*;
    import net.wg.infrastructure.*;
    
    public class _Importer extends net.wg.infrastructure.BaseImporter
    {
        public function _Importer()
        {
            super();
            importClasses(Vector.<Class>([net.wg.gui.lobby.profile.data.ProfileAchievementVO, net.wg.gui.lobby.profile.data.LayoutItemInfo, net.wg.gui.lobby.profile.data.SectionLayoutManager]));
            return;
        }
    }
}
