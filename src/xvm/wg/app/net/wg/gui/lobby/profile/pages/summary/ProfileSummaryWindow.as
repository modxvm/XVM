package net.wg.gui.lobby.profile.pages.summary
{


   public class ProfileSummaryWindow extends ProfileSummary
   {
          
      public function ProfileSummaryWindow() {
         super();
      }

      override protected function applyResizing() : void {
         super.applyResizing();
         footer.y = Math.round(currentDimension.y - footer.height);
      }

      override protected function onDispose() : void {
         super.onDispose();
      }
   }

}