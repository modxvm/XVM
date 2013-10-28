package net.wg.gui.lobby.profile.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.data.gui_items.ItemsUtils;


   public class ProfileCommonInfoVO extends DAAPIDataClass
   {
          
      public function ProfileCommonInfoVO(param1:Object) {
         super(param1);
      }

      public var battlesCount:int = -1;

      public var winsCount:int = -1;

      public var lossesCount:int = -1;

      public var hitsEfficiency:Number = -1;

      public var maxXP:int = -1;

      public var avgXP:int = -1;

      public function getBattlesCountStr() : String {
         return ItemsUtils.formatIntegerStr(this.battlesCount);
      }

      public function getWinsEfficiencyStr() : String {
         var _loc1_:Number = this.winsCount / this.battlesCount;
         _loc1_ = !isNaN(_loc1_)?_loc1_:0;
         return ItemsUtils.floatToPercent(_loc1_);
      }

      public function getHitsEfficiencyStr() : String {
         return ItemsUtils.floatToPercent(this.hitsEfficiency);
      }

      public function getMaxExperienceStr() : String {
         return ItemsUtils.formatIntegerStr(this.maxXP);
      }

      public function getWinsCountStr() : String {
         return ItemsUtils.formatIntegerStr(this.winsCount);
      }

      public function getLossesCountStr() : String {
         return ItemsUtils.formatIntegerStr(this.lossesCount);
      }

      public function getDrawsCountStr() : String {
         return ItemsUtils.formatIntegerStr(this.battlesCount - this.winsCount - this.lossesCount);
      }

      public function getAvgExperienceStr() : String {
         return ItemsUtils.formatIntegerStr(this.avgXP);
      }
   }

}