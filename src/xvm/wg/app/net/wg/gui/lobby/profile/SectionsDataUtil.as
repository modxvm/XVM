package net.wg.gui.lobby.profile
{
   import flash.utils.Dictionary;
   import net.wg.data.Aliases;


   public class SectionsDataUtil extends Object
   {
          
      public function SectionsDataUtil() {
         this.aliasesByLinkage = new Dictionary(true);
         super();
         if(!linkageByAlias)
         {
            linkageByAlias = new Dictionary(true);
            linkageByAlias[Aliases.PROFILE_SUMMARY_PAGE] = "ProfileSummaryPage_UI";
            linkageByAlias[Aliases.PROFILE_SUMMARY_WINDOW] = "ProfileSummaryWindow_UI";
            linkageByAlias[Aliases.PROFILE_AWARDS] = "ProfileAwards_UI";
            linkageByAlias[Aliases.PROFILE_STATISTICS] = "ProfileStatistics_UI";
            linkageByAlias[Aliases.PROFILE_TECHNIQUE_WINDOW] = "ProfileTechniqueWindow_UI";
            linkageByAlias[Aliases.PROFILE_TECHNIQUE_PAGE] = "ProfileTechniquePage_UI";
         }
      }

      private static var linkageByAlias:Dictionary;

      private var aliasesByLinkage:Dictionary;

      public function register(param1:String) : String {
         var _loc2_:String = linkageByAlias[param1];
         this.aliasesByLinkage[_loc2_] = param1;
         return _loc2_;
      }

      public function getLinkageByAlias(param1:String) : String {
         return linkageByAlias[param1];
      }

      public function getAliasByLinkage(param1:String) : String {
         return this.aliasesByLinkage[param1];
      }
   }

}