package net.wg.gui.lobby.profile.pages.summary
{
   import net.wg.data.gui_items.dossier.Dossier;


   public class ProfileSummaryPage extends ProfileSummary
   {
          
      public function ProfileSummaryPage() {
         super();
      }

      public var nearestAwards:AwardsListComponent;

      override protected function initialize() : void {
         super.initialize();
         layoutManager.registerComponents(this.nearestAwards);
         layoutManager.registerComponents(footer);
      }

      override public function as_setInitData(param1:Object) : void {
         this.applyInitData(new SummaryPageInitVO(param1));
      }

      override protected function applyInitData(param1:SummaryInitVO) : void {
         super.applyInitData(param1);
         var _loc2_:SummaryPageInitVO = SummaryPageInitVO(param1);
         this.nearestAwards.label = _loc2_.nextAwardsLabel;
         this.nearestAwards.errorText = _loc2_.nextAwardsErrorText;
      }

      override protected function applyData(param1:Object) : Object {
         var _loc2_:ProfileSummaryVO = ProfileSummaryVO(super.applyData(param1));
         this.nearestAwards.dataProvider = Dossier.getAchievementVector(_loc2_.nearestAchievements);
         return param1;
      }
   }

}