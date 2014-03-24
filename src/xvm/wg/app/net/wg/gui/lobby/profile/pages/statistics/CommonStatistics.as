package net.wg.gui.lobby.profile.pages.statistics
{
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.lobby.profile.components.ProfileDashLineTextItem;
   import net.wg.gui.lobby.profile.pages.statistics.body.ProfileStatisticsDetailedVO;


   public class CommonStatistics extends UIComponent
   {
          
      public function CommonStatistics() {
         super();
      }

      private static const TF_BLOCK2_WIDTH:int = 544;

      private static const TF_BLOCK1_WIDTH:int = 338;

      private static const DEFAULT_COLOR:uint = 16777215;

      private static const SIDES_PADDING:int = 30;

      private static const CENTER_PADDING:int = 50;

      private static function applyLabelsText(param1:String, param2:Object, param3:ProfileDashLineTextItem) : void {
         param3.label = param2[param1];
      }

      public var ltKilled:ProfileDashLineTextItem;

      public var ltDestroyed:ProfileDashLineTextItem;

      public var ltDestructionCoefficient:ProfileDashLineTextItem;

      public var ltDealOutDamage:ProfileDashLineTextItem;

      public var ltReceivedDamage:ProfileDashLineTextItem;

      public var ltDamageCoefficient:ProfileDashLineTextItem;

      public var ltAvgDestroyedVehicles:ProfileDashLineTextItem;

      public var ltMaxDestroyedVehicles:ProfileDashLineTextItem;

      public var ltAvgDamage:ProfileDashLineTextItem;

      public var ltAvgReceivedDamage:ProfileDashLineTextItem;

      public var ltAvgDetectedEnemies:ProfileDashLineTextItem;

      public var hit:UIComponent;

      override protected function configUI() : void {
         super.configUI();
         this.ltKilled.width = this.ltDestroyed.width = this.ltDestructionCoefficient.width = this.ltDealOutDamage.width = this.ltReceivedDamage.width = this.ltDamageCoefficient.width = TF_BLOCK1_WIDTH;
         this.ltAvgDestroyedVehicles.width = this.ltMaxDestroyedVehicles.width = this.ltAvgDamage.width = this.ltAvgReceivedDamage.width = this.ltAvgDetectedEnemies.width = TF_BLOCK2_WIDTH;
         this.ltDestructionCoefficient.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_DESTROYCOEFF;
         this.ltDamageCoefficient.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_DAMAGECOEFF;
         hitArea = this.hit;
      }

      public function setLabels(param1:Object) : void {
         applyLabelsText("killed",param1,this.ltKilled);
         applyLabelsText("destroyed",param1,this.ltDestroyed);
         applyLabelsText("destructionCoefficient",param1,this.ltDestructionCoefficient);
         applyLabelsText("dealOutDamage",param1,this.ltDealOutDamage);
         applyLabelsText("receivedDamage",param1,this.ltReceivedDamage);
         applyLabelsText("damageCoefficient",param1,this.ltDamageCoefficient);
         applyLabelsText("avgDestroyedVehicles",param1,this.ltAvgDestroyedVehicles);
         applyLabelsText("maxDestroyedVehicles",param1,this.ltMaxDestroyedVehicles);
         applyLabelsText("avgDamage",param1,this.ltAvgDamage);
         applyLabelsText("avgReceivedDamage",param1,this.ltAvgReceivedDamage);
         applyLabelsText("avgDetectedEnemies",param1,this.ltAvgDetectedEnemies);
      }

      public function setDossierData(param1:Object) : void {
         var _loc2_:ProfileStatisticsDetailedVO = new ProfileStatisticsDetailedVO(param1);
         this.ltKilled.receiveAndSetValue(_loc2_.fragsCount,DEFAULT_COLOR,_loc2_.getFragsCountStr);
         this.ltDestroyed.receiveAndSetValue(_loc2_.deathsCount,DEFAULT_COLOR,_loc2_.getDeathsCountStr);
         var _loc3_:Number = _loc2_.fragsEfficiency > 0?_loc2_.fragsEfficiency:-1;
         this.ltDestructionCoefficient.receiveAndSetValue(_loc3_,13348216,_loc2_.getFragsEfficiencyStr);
         this.ltDealOutDamage.receiveAndSetValue(_loc2_.damageDealt,DEFAULT_COLOR,_loc2_.getDamageDealtStr);
         this.ltReceivedDamage.receiveAndSetValue(_loc2_.damageReceived,DEFAULT_COLOR,_loc2_.getDamageReceivedStr);
         _loc3_ = _loc2_.damageEfficiency > 0?_loc2_.damageEfficiency:-1;
         this.ltDamageCoefficient.receiveAndSetValue(_loc3_,13348216,_loc2_.getDamageEfficiencyStr);
         this.ltAvgDestroyedVehicles.receiveAndSetValue(_loc2_.avgFrags,DEFAULT_COLOR,_loc2_.getAvgFragsStr);
         this.ltMaxDestroyedVehicles.receiveAndSetValue(_loc2_.maxFrags,DEFAULT_COLOR,_loc2_.getMaxFragsStr);
         this.ltAvgDamage.receiveAndSetValue(_loc2_.avgDamageDealt,DEFAULT_COLOR,_loc2_.getAvgDamageDealtStr);
         this.ltAvgReceivedDamage.receiveAndSetValue(_loc2_.avgDamageReceived,DEFAULT_COLOR,_loc2_.getAvgDamageReceivedStr);
         this.ltAvgDetectedEnemies.receiveAndSetValue(_loc2_.avgEnemiesSpotted,DEFAULT_COLOR,_loc2_.getAvgEnemiesSpottedStr);
      }

      public function setViewSize(param1:Number, param2:Number) : void {
         this.ltKilled.x = this.ltDestroyed.x = this.ltDestructionCoefficient.x = this.ltDealOutDamage.x = this.ltReceivedDamage.x = this.ltDamageCoefficient.x = SIDES_PADDING;
         this.ltAvgDestroyedVehicles.x = this.ltMaxDestroyedVehicles.x = this.ltAvgDamage.x = this.ltAvgReceivedDamage.x = this.ltAvgDetectedEnemies.x = param1 - TF_BLOCK2_WIDTH - SIDES_PADDING;
      }
   }

}