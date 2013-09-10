package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.constants.*;
    import net.wg.gui.lobby.profile.pages.*;
    
    public class ProfileSummaryMeta extends net.wg.gui.lobby.profile.pages.ProfileAchievementsSection
    {
        public function ProfileSummaryMeta()
        {
            super();
            return;
        }

        public function getPersonalScoreWarningTextS(arg1:Object):String
        {
            App.utils.asserter.assertNotNull(this.getPersonalScoreWarningText, "getPersonalScoreWarningText" + net.wg.data.constants.Errors.CANT_NULL);
            return this.getPersonalScoreWarningText(arg1);
        }

        public function getGlobalRatingS(arg1:String):Number
        {
            App.utils.asserter.assertNotNull(this.getGlobalRating, "getGlobalRating" + net.wg.data.constants.Errors.CANT_NULL);
            return this.getGlobalRating(arg1);
        }

        public var getPersonalScoreWarningText:Function=null;

        public var getGlobalRating:Function=null;
    }
}
