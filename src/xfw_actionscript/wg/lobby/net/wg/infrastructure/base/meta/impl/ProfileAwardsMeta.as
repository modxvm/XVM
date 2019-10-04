package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.lobby.profile.pages.ProfileAchievementsSection;
    import net.wg.data.constants.Errors;

    public class ProfileAwardsMeta extends ProfileAchievementsSection
    {

        public var setFilter:Function;

        public function ProfileAwardsMeta()
        {
            super();
        }

        public function setFilterS(param1:Object) : void
        {
            App.utils.asserter.assertNotNull(this.setFilter,"setFilter" + Errors.CANT_NULL);
            this.setFilter(param1);
        }
    }
}
