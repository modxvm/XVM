package net.wg.gui.lobby.profile 
{
    import flash.utils.*;
    import net.wg.data.*;
    
    public class SectionsDataUtil extends Object
    {
        public function SectionsDataUtil()
        {
            this.aliasesByLinkage = new flash.utils.Dictionary(true);
            super();
            if (!linkageByAlias) 
            {
                linkageByAlias = new flash.utils.Dictionary(true);
                linkageByAlias[net.wg.data.Aliases.PROFILE_SUMMARY_PAGE] = "ProfileSummaryPage_UI";
                linkageByAlias[net.wg.data.Aliases.PROFILE_SUMMARY_WINDOW] = "ProfileSummaryWindow_UI";
                linkageByAlias[net.wg.data.Aliases.PROFILE_AWARDS] = "ProfileAwards_UI";
                linkageByAlias[net.wg.data.Aliases.PROFILE_STATISTICS] = "ProfileStatistics_UI";
                linkageByAlias[net.wg.data.Aliases.PROFILE_TECHNIQUE_WINDOW] = "ProfileTechniqueWindow_UI";
                linkageByAlias[net.wg.data.Aliases.PROFILE_TECHNIQUE_PAGE] = "ProfileTechniquePage_UI";
            }
            return;
        }

        public function register(arg1:String):String
        {
            var loc1:*=linkageByAlias[arg1];
            this.aliasesByLinkage[loc1] = arg1;
            return loc1;
        }

        public function getLinkageByAlias(arg1:String):String
        {
            return linkageByAlias[arg1];
        }

        public function getAliasByLinkage(arg1:String):String
        {
            return this.aliasesByLinkage[arg1];
        }

        internal var aliasesByLinkage:flash.utils.Dictionary;

        internal static var linkageByAlias:flash.utils.Dictionary;
    }
}
