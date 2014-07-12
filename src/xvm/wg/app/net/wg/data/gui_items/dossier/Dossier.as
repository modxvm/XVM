package net.wg.data.gui_items.dossier
{
   import net.wg.data.gui_items.GUIItem;
   import net.wg.gui.lobby.profile.data.ProfileAchievementVO;
   import net.wg.gui.lobby.profile.pages.technique.data.TechniqueListVehicleVO;
   import net.wg.data.gui_items.ItemsUtils;
   
   public class Dossier extends GUIItem
   {
      
      public function Dossier(param1:uint, param2:*) {
         super(param1,param2);
      }
      
      public static function getAchievementVector(param1:Array) : Array {
         var _loc3_:Object = null;
         var _loc2_:Array = [];
         for each(_loc3_ in param1)
         {
            _loc2_.push(new ProfileAchievementVO(_loc3_));
         }
         return _loc2_;
      }
      
      private static function generateVehiclesList(param1:Array, param2:Boolean = false) : Array {
         var _loc4_:TechniqueListVehicleVO = null;
         var _loc5_:Array = null;
         var _loc6_:Object = null;
         var _loc3_:Array = [];
         for each(_loc6_ in param1)
         {
            _loc4_ = new TechniqueListVehicleVO(_loc6_);
            if(param2)
            {
               if(!_loc4_.isInHangar)
               {
                  continue;
               }
            }
            _loc3_.push(_loc4_);
         }
         return _loc3_;
      }
      
      public function getAchievements(param1:Boolean = true) : Array {
         return this.getAchievement2DimVector(_callMethod("getAchievements",param1) as Array);
      }
      
      public function getAllAchievements() : Array {
         return this.getAchievement2DimVector(_callMethod("getAchievements",null) as Array);
      }
      
      private function getAchievement2DimVector(param1:Array) : Array {
         var _loc2_:Array = [];
         var _loc3_:uint = param1.length;
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_.push(getAchievementVector(param1[_loc4_]));
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function getSignificantAchievements() : Array {
         return getAchievementVector(_callMethod("getSignificantAchievements") as Array);
      }
      
      public function getNearestAchievements() : Array {
         return getAchievementVector(_callMethod("getNearestAchievements") as Array);
      }
      
      public function getGlobalRating() : int {
         return int(_callMethod("getGlobalRating"));
      }
      
      public function getGlobalRatingStr() : String {
         return ItemsUtils.formatIntegerStr(this.getGlobalRating());
      }
      
      public function getMarksOfMastery() : Array {
         return _callMethod("getMarksOfMastery") as Array;
      }
      
      public function getSpecifiedMarksOfMastery(param1:uint) : uint {
         var _loc2_:Array = this.getMarksOfMastery();
         return _loc2_[param1 - 1];
      }
      
      public function getSpecifiedMarksOfMasteryStr(param1:uint) : String {
         return ItemsUtils.formatIntegerStr(this.getSpecifiedMarksOfMastery(param1));
      }
      
      public function getBattlesStats() : Array {
         return _callMethod("getBattlesStats") as Array;
      }
      
      public function getBattlesCount() : uint {
         return uint(_callMethod("getBattlesCount"));
      }
      
      public function getWinsCount() : uint {
         return uint(_callMethod("getWinsCount"));
      }
      
      public function getSurvivedBattlesCount() : uint {
         return uint(_callMethod("getSurvivedBattlesCount"));
      }
      
      public function getXP() : uint {
         return uint(_callMethod("getXP"));
      }
      
      public function getDamageDealt() : uint {
         return uint(_callMethod("getDamageDealt"));
      }
      
      public function getDamageReceived() : uint {
         return uint(_callMethod("getDamageReceived"));
      }
      
      public function getShotsCount() : uint {
         return uint(_callMethod("getShotsCount"));
      }
      
      public function getHitsCount() : uint {
         return uint(_callMethod("getHitsCount"));
      }
      
      public function getFragsCount() : uint {
         return uint(_callMethod("getFragsCount"));
      }
      
      public function getDeathsCount() : uint {
         return uint(_callMethod("getDeathsCount"));
      }
      
      public function getMaxFrags() : Array {
         return _callMethod("getMaxFrags") as Array;
      }
      
      public function getMaxFragsStr() : String {
         return ItemsUtils.formatIntegerStr(this.getMaxFrags()[0]);
      }
      
      public function getMaxFragsVehicleDescr() : * {
         return this.getMaxFrags()[1];
      }
      
      public function getMaxXP() : Array {
         return _callMethod("getMaxXP") as Array;
      }
      
      public function getMaxXPVehicleDescr() : * {
         return this.getMaxXP()[1];
      }
      
      public function getMaxXPStr() : String {
         return ItemsUtils.formatIntegerStr(this.getMaxXP()[0]);
      }
      
      public function getMaxVehicleFrags() : Number {
         return Number(_callMethod("getMaxVehicleFrags"));
      }
      
      public function getMaxVehicleXP() : Number {
         return Number(_callMethod("getMaxVehicleXP"));
      }
      
      public function getSpottedEnemiesCount() : uint {
         return uint(_callMethod("getSpottedEnemiesCount"));
      }
      
      public function getAvgDamage() : Number {
         return Number(_callMethod("getAvgDamage"));
      }
      
      public function getAvgDamageStr() : String {
         return ItemsUtils.formatIntegerStr(this.getAvgDamage());
      }
      
      public function getAvgXP() : Number {
         return Number(_callMethod("getAvgXP"));
      }
      
      public function getAvgXPStr() : String {
         return ItemsUtils.formatIntegerStr(this.getAvgXP());
      }
      
      public function getAvgFrags() : Number {
         return Number(_callMethod("getAvgFrags"));
      }
      
      public function getAvgFragsStr() : String {
         return ItemsUtils.formatFloatStr(this.getAvgFrags());
      }
      
      public function getAvgDamageDealt() : Number {
         return Number(_callMethod("getAvgDamageDealt"));
      }
      
      public function getAvgDamageDealtStr() : String {
         return ItemsUtils.formatIntegerStr(this.getAvgDamageDealt());
      }
      
      public function getAvgDamageReceived() : Number {
         return Number(_callMethod("getAvgDamageReceived"));
      }
      
      public function getAvgEnemiesSpotted() : Number {
         return Number(_callMethod("getAvgEnemiesSpotted"));
      }
      
      public function getAvgEnemiesSpottedStr() : String {
         return ItemsUtils.formatFloatStr(this.getAvgEnemiesSpotted());
      }
      
      public function getHitsEfficiency() : Number {
         return Number(_callMethod("getHitsEfficiency"));
      }
      
      public function getHitsEfficiencyStr() : String {
         return ItemsUtils.floatToPercent(this.getHitsEfficiency());
      }
      
      public function getSurvivalEfficiency() : Number {
         return Number(_callMethod("getSurvivalEfficiency"));
      }
      
      public function getWinsEfficiency() : Number {
         return Number(_callMethod("getWinsEfficiency"));
      }
      
      public function getSurvivalEfficiencyStr() : String {
         return ItemsUtils.floatToPercent(this.getSurvivalEfficiency());
      }
      
      public function getLossesEfficiency() : Number {
         return Number(_callMethod("getLossesEfficiency"));
      }
      
      public function getFragsEfficiency() : Number {
         return Number(_callMethod("getFragsEfficiency"));
      }
      
      public function getFragsEfficiencyStr() : String {
         return ItemsUtils.formatFloatStr(this.getFragsEfficiency());
      }
      
      public function getDamageEfficiency() : Number {
         return Number(_callMethod("getDamageEfficiency"));
      }
      
      public function getDamageEfficiencyStr() : String {
         return ItemsUtils.formatFloatStr(this.getDamageEfficiency());
      }
      
      public function getAvgDamageReceivedStr() : String {
         return ItemsUtils.formatIntegerStr(this.getAvgDamageReceived());
      }
      
      public function getDeathsCountStr() : String {
         return ItemsUtils.formatIntegerStr(this.getDeathsCount());
      }
      
      public function getMaxVehicleFragsStr() : String {
         return ItemsUtils.formatIntegerStr(this.getMaxVehicleFrags());
      }
      
      public function getMaxVehicleXPStr() : String {
         return ItemsUtils.formatIntegerStr(this.getMaxVehicleXP());
      }
      
      public function getBattlesCountStr() : String {
         return ItemsUtils.formatIntegerStr(this.getBattlesCount());
      }
      
      public function getDamageDealtStr() : String {
         return ItemsUtils.formatIntegerStr(this.getDamageDealt());
      }
      
      public function getDamageReceivedStr() : String {
         return ItemsUtils.formatIntegerStr(this.getDamageReceived());
      }
      
      public function getWinsCountStr() : String {
         return ItemsUtils.formatIntegerStr(this.getWinsCount());
      }
      
      public function getFragsCountStr() : String {
         return ItemsUtils.formatIntegerStr(this.getFragsCount());
      }
      
      public function getWinsEfficiencyStr() : String {
         return ItemsUtils.floatToPercent(this.getWinsEfficiency());
      }
      
      public function getVehicles() : Object {
         return _callMethod("getVehicles");
      }
      
      public function getVehiclesCount() : uint {
         var _loc3_:Object = null;
         var _loc1_:Object = this.getVehicles();
         var _loc2_:uint = 0;
         for each(_loc3_ in _loc1_)
         {
            _loc2_++;
         }
         return _loc2_;
      }
      
      public function getVehiclesCountStr() : String {
         return ItemsUtils.formatIntegerStr(this.getVehiclesCount());
      }
      
      private function getTechniqueListVehicles() : Array {
         return _callMethod("getTechniqueListVehicles") as Array;
      }
      
      public function getHangarVehiclesList() : Array {
         return generateVehiclesList(this.getTechniqueListVehicles(),true);
      }
      
      public function getAllVehiclesList() : Array {
         return generateVehiclesList(this.getTechniqueListVehicles());
      }
   }
}
