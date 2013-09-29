package xvm.hangar.components.Profile
{
    import flash.utils.*;
    import net.wg.gui.lobby.profile.SectionsDataUtil;
    import net.wg.data.*;
    import com.xvm.*;

    public class SectionsDataUtilEx extends SectionsDataUtil
    {
        private static var linkageByAlias:Dictionary;

        public function SectionsDataUtilEx()
        {
            super();
            if (!linkageByAlias)
            {
                linkageByAlias = new flash.utils.Dictionary(true);
                //linkageByAlias[net.wg.data.Aliases.PROFILE_SUMMARY_PAGE] = "ProfileSummaryPage_UI";
                //linkageByAlias[net.wg.data.Aliases.PROFILE_SUMMARY_WINDOW] = "ProfileSummaryWindow_UI";
                //linkageByAlias[net.wg.data.Aliases.PROFILE_AWARDS] = "ProfileAwards_UI";
                //linkageByAlias[net.wg.data.Aliases.PROFILE_STATISTICS] = "ProfileStatistics_UI";
                //linkageByAlias[net.wg.data.Aliases.PROFILE_TECHNIQUE_WINDOW] = "ProfileTechniqueWindow_UI";
                linkageByAlias[Aliases.PROFILE_TECHNIQUE_PAGE] = "UI_ProfileTechniquePage";
            }
            return;
        }

        public override function getLinkageByAlias(alias:String):String
        {
            return linkageByAlias.hasOwnProperty(alias) ? linkageByAlias[alias] : super.getLinkageByAlias(alias);
        }
    }
}
