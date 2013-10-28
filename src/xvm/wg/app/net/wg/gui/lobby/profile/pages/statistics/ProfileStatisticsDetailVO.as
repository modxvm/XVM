package net.wg.gui.lobby.profile.pages.statistics
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.data.gui_items.ItemsUtils;


   public class ProfileStatisticsDetailVO extends DAAPIDataClass
   {
          
      public function ProfileStatisticsDetailVO(param1:Object) {
         super(param1);
      }

      public var fragsCount:int;

      public var deathsCount:int;

      public var fragsEfficiency:Number;

      public var damageDealt:Number;

      public var damageReceived:Number;

      public var damageEfficiency:Number;

      public var avgFrags:Number;

      public var maxFrags:int;

      public var avgDamageDealt:Number;

      public var avgDamageReceived:Number;

      public var avgEnemiesSpotted:Number;

      public function getFragsCountStr() : String {
         return ItemsUtils.formatIntegerStr(this.fragsCount);
      }

      public function getAvgDamageDealtStr() : String {
         return ItemsUtils.formatIntegerStr(this.avgDamageDealt);
      }

      public function getAvgDamageReceivedStr() : String {
         return ItemsUtils.formatIntegerStr(this.avgDamageReceived);
      }

      public function getDeathsCountStr() : String {
         return ItemsUtils.formatIntegerStr(this.deathsCount);
      }

      public function getFragsEfficiencyStr() : String {
         return ItemsUtils.formatFloatStr(this.fragsEfficiency);
      }

      public function getDamageDealtStr() : String {
         return ItemsUtils.formatIntegerStr(this.damageDealt);
      }

      public function getDamageReceivedStr() : String {
         return ItemsUtils.formatIntegerStr(this.damageReceived);
      }

      public function getDamageEfficiencyStr() : String {
         return ItemsUtils.formatFloatStr(this.damageEfficiency);
      }

      public function getAvgFragsStr() : String {
         return ItemsUtils.formatFloatStr(this.avgFrags);
      }

      public function getMaxFragsStr() : String {
         return ItemsUtils.formatFloatStr(this.maxFrags);
      }

      public function getAvgEnemiesSpottedStr() : String {
         return ItemsUtils.formatFloatStr(this.avgEnemiesSpotted);
      }
   }

}