package net.wg.gui.lobby.profile.pages.summary
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.profile.data.ProfileAchievementVO;
   
   public class SummaryVO extends DAAPIDataClass
   {
      
      public function SummaryVO(param1:Object) {
         super(param1);
      }
      
      public var significantAwards:Array;
      
      private var _significantAwardsVec:Vector.<ProfileAchievementVO>;
   }
}
