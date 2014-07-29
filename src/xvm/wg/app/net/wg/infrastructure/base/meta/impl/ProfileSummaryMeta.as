package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.lobby.profile.pages.ProfileAchievementsSection;
    import net.wg.data.constants.Errors;
    
    public class ProfileSummaryMeta extends ProfileAchievementsSection
    {
        
        public function ProfileSummaryMeta()
        {
            super();
        }
        
        public var getPersonalScoreWarningText:Function = null;
        
        public var getGlobalRating:Function = null;
        
        public function getPersonalScoreWarningTextS(param1:Object) : String
        {
            App.utils.asserter.assertNotNull(this.getPersonalScoreWarningText,"getPersonalScoreWarningText" + Errors.CANT_NULL);
            return this.getPersonalScoreWarningText(param1);
        }
        
        public function getGlobalRatingS(param1:String) : Number
        {
            App.utils.asserter.assertNotNull(this.getGlobalRating,"getGlobalRating" + Errors.CANT_NULL);
            return this.getGlobalRating(param1);
        }
    }
}
