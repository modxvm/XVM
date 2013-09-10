package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.gui.lobby.profile.pages.*;
    
    public class ProfileStatisticsMeta extends net.wg.gui.lobby.profile.pages.ProfileSection
    {
        public function ProfileStatisticsMeta()
        {
            super();
            return;
        }

        public function getDataS(arg1:Object):void
        {
            App.utils.asserter.assertNotNull(this.getData, "getData" + net.wg.data.constants.Errors.CANT_NULL);
            this.getData(arg1);
            return;
        }

        public var getData:Function=null;
    }
}
