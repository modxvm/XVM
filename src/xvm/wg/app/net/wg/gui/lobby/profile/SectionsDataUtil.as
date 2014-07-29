package net.wg.gui.lobby.profile
{
    import flash.utils.Dictionary;
    import net.wg.data.Aliases;
    
    public class SectionsDataUtil extends Object
    {
        
        public function SectionsDataUtil()
        {
            this.aliasesByLinkage = new Dictionary(true);
            super();
            if(!this.linkageByAlias)
            {
                this.linkageByAlias = new Dictionary(true);
                this.linkageByAlias[Aliases.PROFILE_SUMMARY_PAGE] = "ProfileSummaryPage_UI";
                this.linkageByAlias[Aliases.PROFILE_SECTION] = "ProfileTest_UI";
                this.linkageByAlias[Aliases.PROFILE_SUMMARY_WINDOW] = "ProfileSummaryWindow_UI";
                this.linkageByAlias[Aliases.PROFILE_AWARDS] = "ProfileAwards_UI";
                this.linkageByAlias[Aliases.PROFILE_STATISTICS] = "ProfileStatistics_UI";
                this.linkageByAlias[Aliases.PROFILE_TECHNIQUE_WINDOW] = "ProfileTechniqueWindow_UI";
                this.linkageByAlias[Aliases.PROFILE_TECHNIQUE_PAGE] = "ProfileTechniquePage_UI";
            }
        }
        
        private var linkageByAlias:Dictionary;
        
        private var aliasesByLinkage:Dictionary;
        
        public function register(param1:String) : String
        {
            var _loc2_:String = this.linkageByAlias[param1];
            this.aliasesByLinkage[_loc2_] = param1;
            return _loc2_;
        }
        
        public function getLinkageByAlias(param1:String) : String
        {
            return this.linkageByAlias[param1];
        }
        
        public function getAliasByLinkage(param1:String) : String
        {
            return this.aliasesByLinkage[param1];
        }
    }
}
