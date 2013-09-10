package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.gui.lobby.profile.pages.*;
    
    public class ProfileAwardsMeta extends net.wg.gui.lobby.profile.pages.ProfileAchievementsSection
    {
        public function ProfileAwardsMeta()
        {
            super();
            return;
        }

        public function invokeUpdateS():void
        {
            App.utils.asserter.assertNotNull(this.invokeUpdate, "invokeUpdate" + net.wg.data.constants.Errors.CANT_NULL);
            this.invokeUpdate();
            return;
        }

        public var invokeUpdate:Function=null;
    }
}
