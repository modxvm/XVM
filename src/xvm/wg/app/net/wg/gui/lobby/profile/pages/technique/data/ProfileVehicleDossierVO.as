package net.wg.gui.lobby.profile.pages.technique.data
{
   import net.wg.gui.lobby.profile.data.ProfileCommonInfoVO;
   import net.wg.gui.lobby.profile.data.ProfileAchievementVO;
   import net.wg.data.gui_items.ItemsUtils;


   public class ProfileVehicleDossierVO extends ProfileCommonInfoVO
   {
          
      public function ProfileVehicleDossierVO(param1:Object) {
         super(param1);
      }

      public var lossesEfficiency:Number = -1;

      public var survivalEfficiency:Number = -1;

      public var maxVehicleFrags:int = -1;

      public var fragsCount:int = -1;

      public var deathsCount:int = -1;

      public var fragsEfficiency:Number = -1;

      public var damageDealt:int = -1;

      public var damageReceived:int = -1;

      public var damageEfficiency:Number = -1;

      public var avgFrags:Number = -1;

      public var avgEnemiesSpotted:Number = -1;

      public var avgDamageDealt:int = -1;

      public var avgDamageReceived:int = -1;

      public var achievements:Array;

      private var _achievementsVOs:Array;

      override protected function onDataWrite(param1:String, param2:Object) : Boolean {
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:ProfileAchievementVO = null;
         var _loc6_:uint = 0;
         var _loc7_:Array = null;
         var _loc8_:Array = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:* = 0;
         if(param1 == "achievements" && (param2))
         {
            _loc3_ = param2 as Array;
            _loc4_ = _loc3_.length;
            this._achievementsVOs = [];
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc7_ = [];
               _loc8_ = _loc3_[_loc6_];
               _loc9_ = 0;
               _loc10_ = _loc8_.length;
               _loc11_ = 0;
               while(_loc11_ < _loc10_)
               {
                  _loc5_ = new ProfileAchievementVO(_loc8_[_loc11_]);
                  _loc7_.push(_loc5_);
                  _loc11_++;
               }
               this._achievementsVOs.push(_loc7_);
               _loc6_++;
            }
            return false;
         }
         return this.hasOwnProperty(param1);
      }

      public function get achievementsVOs() : Array {
         return this._achievementsVOs;
      }

      public function getMaxVehicleFragsStr() : String {
         return ItemsUtils.formatIntegerStr(this.maxVehicleFrags);
      }

      public function getLossesEfficiencyStr() : String {
         return ItemsUtils.floatToPercent(this.lossesEfficiency);
      }

      public function getSurvivalEfficiencyStr() : String {
         return ItemsUtils.floatToPercent(this.survivalEfficiency);
      }

      public function getFragsCountStr() : String {
         return ItemsUtils.formatIntegerStr(this.fragsCount);
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

      public function getAvgEnemiesSpottedStr() : String {
         return ItemsUtils.formatFloatStr(this.avgEnemiesSpotted);
      }

      public function getAvgDamageDealtStr() : String {
         return ItemsUtils.formatIntegerStr(this.avgDamageDealt);
      }

      public function getAvgDamageReceivedStr() : String {
         return ItemsUtils.formatIntegerStr(this.avgDamageReceived);
      }
   }

}