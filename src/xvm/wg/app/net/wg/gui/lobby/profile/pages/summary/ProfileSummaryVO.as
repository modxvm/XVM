package net.wg.gui.lobby.profile.pages.summary
{
   import net.wg.gui.lobby.profile.data.ProfileDossierInfoVO;
   import net.wg.data.gui_items.ItemsUtils;
   
   public class ProfileSummaryVO extends ProfileDossierInfoVO
   {
      
      public function ProfileSummaryVO(param1:Object) {
         super(param1);
      }
      
      public var avgDamage:Number;
      
      public var maxDestroyed:uint;
      
      public var maxDestroyedByVehicle:String = "";
      
      public var globalRating:uint;
      
      public var significantAchievements:Array;
      
      public var nearestAchievements:Array;
      
      public function getMaxDestroyedStr() : String {
         return ItemsUtils.formatIntegerStr(this.maxDestroyed);
      }
      
      public function getGlobalRatingStr() : String {
         return ItemsUtils.formatIntegerStr(this.globalRating);
      }
      
      public function getAvgDamageStr() : String {
         return ItemsUtils.formatIntegerStr(this.avgDamage);
      }
   }
}
