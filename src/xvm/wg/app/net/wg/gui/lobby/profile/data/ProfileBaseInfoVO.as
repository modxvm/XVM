package net.wg.gui.lobby.profile.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.data.gui_items.ItemsUtils;
   
   public class ProfileBaseInfoVO extends DAAPIDataClass
   {
      
      public function ProfileBaseInfoVO(param1:Object) {
         super(param1);
      }
      
      public var battlesCount:int = -1;
      
      public var winsCount:int = -1;
      
      public var lossesCount:int = -1;
      
      public function getBattlesCountStr() : String {
         return ItemsUtils.formatIntegerStr(this.battlesCount);
      }
      
      public function getWinsEfficiencyStr() : String {
         var _loc1_:Number = this.winsCount / this.battlesCount;
         _loc1_ = !isNaN(_loc1_)?_loc1_:0;
         return ItemsUtils.floatToPercent(_loc1_);
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
   }
}
