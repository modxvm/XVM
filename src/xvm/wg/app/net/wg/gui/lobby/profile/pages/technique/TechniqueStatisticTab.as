package net.wg.gui.lobby.profile.pages.technique
{
   import net.wg.gui.lobby.profile.components.ResizableContent;
   import flash.text.TextField;
   import net.wg.gui.lobby.profile.components.ProfileDashLineTextItem;
   import net.wg.gui.lobby.profile.pages.technique.data.ProfileVehicleDossierVO;
   import net.wg.gui.utils.ExcludeTweenManager;
   import __AS3__.vec.Vector;
   import fl.transitions.easing.Strong;
   import scaleform.clik.motion.Tween;


   public class TechniqueStatisticTab extends ResizableContent
   {
          
      public function TechniqueStatisticTab() {
         this.tweenManager = new ExcludeTweenManager();
         super();
         this.alpha = 0;
      }

      public static const DEFAULT_DASHLINETEXT_WIDTH:uint = 350;

      public static const DEFAULT_COLOR:int = 16643278;

      public static const PERCENT_SIGN_GAP:uint = 1;

      private static var ANIM_SPEED:Number = 500;

      public var efficiencyTF:TextField;

      public var avgResultsTF:TextField;

      public var battlesDL:ProfileDashLineTextItem;

      public var winsDL:ProfileDashLineTextItem;

      public var defeatsDL:ProfileDashLineTextItem;

      public var surviveDL:ProfileDashLineTextItem;

      public var accuracyDL:ProfileDashLineTextItem;

      public var maxExpDL:ProfileDashLineTextItem;

      public var maxKillDL:ProfileDashLineTextItem;

      public var totalKillDL:ProfileDashLineTextItem;

      public var totalDeadDL:ProfileDashLineTextItem;

      public var killRatioDL:ProfileDashLineTextItem;

      public var dealtDmgDL:ProfileDashLineTextItem;

      public var receivedDmgDL:ProfileDashLineTextItem;

      public var dmgRatioDL:ProfileDashLineTextItem;

      public var avgExpDL:ProfileDashLineTextItem;

      public var avgKillsDL:ProfileDashLineTextItem;

      public var avgDetectedDL:ProfileDashLineTextItem;

      public var avgDmgDealtDL:ProfileDashLineTextItem;

      public var avgDmgReceivedDL:ProfileDashLineTextItem;

      public var avgScoutingDmgDL:ProfileDashLineTextItem;

      public var winsPercentSign:TextField;

      public var defeatsPercentSign:TextField;

      public var survivePercentSign:TextField;

      public var accuracyPercentSign:TextField;

      private var _data:ProfileVehicleDossierVO;

      private var isDataInitialized:Boolean;

      private var tweenManager:ExcludeTweenManager;

      override protected function configUI() : void {
         var _loc2_:ProfileDashLineTextItem = null;
         super.configUI();
         var _loc1_:Vector.<ProfileDashLineTextItem> = Vector.<ProfileDashLineTextItem>([this.battlesDL,this.maxExpDL,this.maxKillDL,this.totalKillDL,this.totalDeadDL,this.killRatioDL,this.dealtDmgDL,this.receivedDmgDL,this.dmgRatioDL,this.winsDL,this.defeatsDL,this.surviveDL,this.accuracyDL,this.avgExpDL,this.avgKillsDL,this.avgDetectedDL,this.avgDmgDealtDL,this.avgDmgReceivedDL,this.avgScoutingDmgDL]);
         for each (_loc2_ in _loc1_)
         {
            _loc2_.width = 350;
         }
         this.winsPercentSign.x = this.defeatsPercentSign.x = this.survivePercentSign.x = this.accuracyPercentSign.x = DEFAULT_DASHLINETEXT_WIDTH + this.battlesDL.x + PERCENT_SIGN_GAP;
         this.setupLabels();
         this.avgScoutingDmgDL.visible = false;
      }

      private function setupLabels() : void {
         this.efficiencyTF.text = PROFILE.SECTION_TECHNIQUE_STATISTICS_EFFENCY;
         this.avgResultsTF.text = PROFILE.SECTION_TECHNIQUE_STATISTICS_AVGSTATS;
         this.battlesDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_TOTALBATTLES;
         this.winsDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_TOTALWINS;
         this.defeatsDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_TOTALDEFEATS;
         this.surviveDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_SURVIVAL;
         this.accuracyDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_ACCURACY;
         this.maxExpDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_MAXEXPERIENCE;
         this.maxKillDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_MAXDESTROYEDVEHICLES;
         this.totalKillDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_KILLED;
         this.totalDeadDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_DESTROYED;
         this.killRatioDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_DESTRUCTIONCOEFFICIENT;
         this.dealtDmgDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_DEALOUTDAMAGE;
         this.receivedDmgDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_RECEIVEDDAMAGE;
         this.dmgRatioDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_DAMAGECOEFFICIENT;
         this.avgExpDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_AVGEXPERIENCE;
         this.avgKillsDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_AVGDESTROYEDVEHICLES;
         this.avgDetectedDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_AVGDETECTEDENEMIES;
         this.avgDmgDealtDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_AVGDAMAGE;
         this.avgDmgReceivedDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_AVGRECEIVEDDAMAGE;
         this.avgScoutingDmgDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_AVGSCOUTINGDAMAGE;
      }

      override public function update(param1:Object) : void {
         var _loc3_:* = NaN;
         var _loc2_:ProfileVehicleDossierVO = ProfileVehicleDossierVO(param1);
         if(this._data != _loc2_)
         {
            this._data = _loc2_;
            if(_loc2_)
            {
               if(!this.isDataInitialized)
               {
                  this.isDataInitialized = true;
                  this.tweenManager.registerAndLaunch(ANIM_SPEED,this,{"alpha":1},
                     {
                        "ease":Strong.easeOut,
                        "onComplete":this.onTweenComplete
                     }
                  );
               }
               this.battlesDL.receiveAndSetValue(_loc2_.battlesCount,DEFAULT_COLOR,_loc2_.getBattlesCountStr);
               this.winsDL.receiveAndSetValue(_loc2_.winsCount,DEFAULT_COLOR,_loc2_.getWinsEfficiencyStr);
               this.defeatsDL.receiveAndSetValue(_loc2_.lossesEfficiency,DEFAULT_COLOR,_loc2_.getLossesEfficiencyStr);
               this.surviveDL.receiveAndSetValue(_loc2_.survivalEfficiency,DEFAULT_COLOR,_loc2_.getSurvivalEfficiencyStr);
               this.accuracyDL.receiveAndSetValue(_loc2_.hitsEfficiency,DEFAULT_COLOR,_loc2_.getHitsEfficiencyStr);
               this.maxExpDL.receiveAndSetValue(_loc2_.maxXP,DEFAULT_COLOR,_loc2_.getMaxExperienceStr);
               this.maxKillDL.receiveAndSetValue(_loc2_.maxVehicleFrags,DEFAULT_COLOR,_loc2_.getMaxVehicleFragsStr);
               this.totalKillDL.receiveAndSetValue(_loc2_.fragsCount,DEFAULT_COLOR,_loc2_.getFragsCountStr);
               this.totalDeadDL.receiveAndSetValue(_loc2_.deathsCount,DEFAULT_COLOR,_loc2_.getDeathsCountStr);
               _loc3_ = _loc2_.fragsEfficiency > 0?_loc2_.fragsEfficiency:-1;
               this.killRatioDL.receiveAndSetValue(_loc3_,13348216,_loc2_.getFragsEfficiencyStr);
               this.dealtDmgDL.receiveAndSetValue(_loc2_.damageDealt,DEFAULT_COLOR,_loc2_.getDamageDealtStr);
               this.receivedDmgDL.receiveAndSetValue(_loc2_.damageReceived,DEFAULT_COLOR,_loc2_.getDamageReceivedStr);
               this.dmgRatioDL.receiveAndSetValue(_loc2_.damageEfficiency > 0?_loc2_.damageEfficiency:-1,13348216,_loc2_.getDamageEfficiencyStr);
               this.avgExpDL.receiveAndSetValue(_loc2_.avgXP,DEFAULT_COLOR,_loc2_.getAvgExperienceStr);
               this.avgKillsDL.receiveAndSetValue(_loc2_.avgFrags,DEFAULT_COLOR,_loc2_.getAvgFragsStr);
               this.avgDetectedDL.receiveAndSetValue(_loc2_.avgEnemiesSpotted,DEFAULT_COLOR,_loc2_.getAvgEnemiesSpottedStr);
               this.avgDmgDealtDL.receiveAndSetValue(_loc2_.avgDamageDealt,DEFAULT_COLOR,_loc2_.getAvgDamageDealtStr);
               this.avgDmgReceivedDL.receiveAndSetValue(_loc2_.avgDamageReceived,DEFAULT_COLOR,_loc2_.getAvgDamageReceivedStr);
               this.avgScoutingDmgDL.value = "Will be implemented...";
            }
         }
      }

      private function onTweenComplete(param1:Tween) : void {
         this.tweenManager.unregister(param1);
      }

      override public function dispose() : void {
         this.tweenManager.dispose();
         this.tweenManager = null;
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
         this.battlesDL.dispose();
         this.winsDL.dispose();
         this.defeatsDL.dispose();
         this.surviveDL.dispose();
         this.accuracyDL.dispose();
         this.maxExpDL.dispose();
         this.maxKillDL.dispose();
         this.totalKillDL.dispose();
         this.totalDeadDL.dispose();
         this.killRatioDL.dispose();
         this.dealtDmgDL.dispose();
         this.receivedDmgDL.dispose();
         this.dmgRatioDL.dispose();
         this.avgExpDL.dispose();
         this.avgKillsDL.dispose();
         this.avgDetectedDL.dispose();
         this.avgDmgDealtDL.dispose();
         this.avgDmgReceivedDL.dispose();
         this.avgScoutingDmgDL.dispose();
         super.dispose();
      }
   }

}