package net.wg.gui.lobby.profile.pages.summary
{
   import net.wg.infrastructure.base.meta.impl.ProfileSummaryMeta;
   import net.wg.infrastructure.base.meta.IProfileSummaryMeta;
   import net.wg.gui.lobby.profile.data.ProfileAchievementVO;
   import net.wg.gui.components.advanced.LineDescrIconText;
   import net.wg.gui.lobby.profile.components.LditValued;
   import net.wg.gui.lobby.profile.components.LditBattles;
   import net.wg.gui.lobby.profile.components.LditMarksOfMastery;
   import net.wg.gui.lobby.profile.components.PersonalScoreComponent;
   import net.wg.gui.lobby.profile.components.ProfileFooter;
   import net.wg.gui.lobby.profile.data.ProfileUserVO;
   import net.wg.gui.lobby.profile.data.SectionLayoutManager;
   import net.wg.gui.lobby.profile.ProfileConstants;


   public class ProfileSummary extends ProfileSummaryMeta implements IProfileSummaryMeta
   {
          
      public function ProfileSummary() {
         super();
      }

      private static const INIT_DATA_INVALID:String = "idInv";

      protected static function getAchievementVector(param1:Array, param2:Boolean=false) : Array {
         var _loc4_:ProfileAchievementVO = null;
         var _loc5_:Object = null;
         var _loc3_:Array = [];
         for each (_loc5_ in param1)
         {
            _loc4_ = new ProfileAchievementVO(_loc5_);
            if(param2)
            {
               _loc4_.showProgress = false;
            }
            _loc3_.push(_loc4_);
         }
         return _loc3_;
      }

      public var tfWins:LineDescrIconText;

      public var tfAvgExperience:LineDescrIconText;

      public var tfHits:LineDescrIconText;

      public var tfAvgDamage:LineDescrIconText;

      public var tfMaxDestroyed:LditValued;

      public var tfMaxExperience:LditValued;

      public var tfTotalBattles:LditBattles;

      public var tfMarksOfMastery:LditMarksOfMastery;

      public var tfPersonalScore:PersonalScoreComponent;

      public var footer:ProfileFooter;

      private var initData:ProfileUserVO;

      public var significantAwards:AwardsListComponent;

      private var lineTextFieldsLayout:LineTextFieldsLayout;

      override protected function initialize() : void {
         super.initialize();
         this.significantAwards.titleToolTip = PROFILE.PROFILE_SUMMARY_SIGNIFICANTAWARDS_TOOLTIP;
         layoutManager = new SectionLayoutManager(525,740);
         layoutManager.registerComponents(this.footer,this.tfWins,this.tfHits,this.tfAvgExperience,this.tfAvgDamage,this.tfMaxDestroyed,this.tfMaxExperience,this.tfTotalBattles,this.tfMarksOfMastery,this.tfPersonalScore,this.significantAwards);
         this.lineTextFieldsLayout = new LineTextFieldsLayout(ProfileConstants.WINDOW_WIDTH,140);
         this.lineTextFieldsLayout.addLeftPair(this.tfTotalBattles,this.tfHits);
         this.lineTextFieldsLayout.addRightPair(this.tfAvgExperience,this.tfMaxDestroyed);
         this.lineTextFieldsLayout.addLeftPair(this.tfWins,this.tfAvgDamage);
         this.lineTextFieldsLayout.addRightPair(this.tfMaxExperience,this.tfMarksOfMastery);
         this.lineTextFieldsLayout.layout();
      }

      override protected function applyResizing() : void {
         if(layoutManager)
         {
            layoutManager.setDimension(currentDimension.x,currentDimension.y);
         }
         this.footer.width = currentDimension.x;
         this.x = Math.round(currentDimension.x / 2 - _centerOffset);
      }

      override protected function draw() : void {
         if(_baseDisposed)
         {
            return;
         }
         super.draw();
         if((isInvalid(INIT_DATA_INVALID)) && (this.initData))
         {
            this.footer.setUserData(this.initData);
         }
      }

      override protected function applyData(param1:Object) : Object {
         var _loc2_:ProfileSummaryVO = new ProfileSummaryVO(param1);
         if(_loc2_.battlesCount != 0)
         {
            this.tfWins.text = _loc2_.getWinsEfficiencyStr() + "%";
            this.tfWins.enabled = true;
         }
         else
         {
            this.tfWins.enabled = false;
         }
         if(_loc2_.hitsEfficiency != -1)
         {
            this.tfHits.enabled = true;
            this.tfHits.text = _loc2_.getHitsEfficiencyStr() + "%";
         }
         else
         {
            this.tfHits.enabled = false;
         }
         if(_loc2_.avgXP != -1)
         {
            this.tfAvgExperience.enabled = true;
            this.tfAvgExperience.text = _loc2_.getAvgExperienceStr();
         }
         else
         {
            this.tfAvgExperience.enabled = false;
         }
         if(_loc2_.avgDamage != -1)
         {
            this.tfAvgDamage.enabled = true;
            this.tfAvgDamage.text = _loc2_.getAvgDamageStr();
         }
         else
         {
            this.tfAvgDamage.enabled = false;
         }
         this.tfMaxDestroyed.text = _loc2_.getMaxDestroyedStr();
         var _loc3_:String = _loc2_.maxDestroyed > 0?_loc2_.maxDestroyedByVehicle:null;
         this.tfMaxDestroyed.value = _loc3_;
         this.tfMaxExperience.text = _loc2_.getMaxExperienceStr();
         _loc3_ = _loc2_.maxXP > 0?_loc2_.maxXPByVehicle:null;
         this.tfMaxExperience.value = _loc3_;
         this.tfTotalBattles.text = _loc2_.getBattlesCountStr();
         this.tfTotalBattles.setValues(_loc2_.getWinsCountStr(),_loc2_.getLossesCountStr(),_loc2_.getDrawsCountStr());
         this.tfMarksOfMastery.text = _loc2_.getMarksOfMasteryCountStr();
         this.tfMarksOfMastery.totalCount = _loc2_.totalUserVehiclesCount;
         this.tfPersonalScore.text = _loc2_.getGlobalRatingStr();
         this.significantAchievementProvider = getAchievementVector(_loc2_.significantAchievements,true);
         return _loc2_;
      }

      override public function as_setInitData(param1:Object) : void {
         this.applyInitData(new SummaryInitVO(param1));
      }

      protected function applyInitData(param1:SummaryInitVO) : void {
         var _loc2_:Object = param1.commonScores;
         this.tfWins.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_WINS;
         this.tfHits.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_HITS;
         this.tfAvgExperience.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_AVGEXP;
         this.tfAvgDamage.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_AVGDAMAGE;
         this.tfMaxDestroyed.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_MAXDESTROYED;
         this.tfMaxExperience.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_MAXEXP;
         this.tfTotalBattles.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_BATTLESCOUNT;
         this.tfMarksOfMastery.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_MARKOFMASTERY;
         this.tfPersonalScore.description = _loc2_["personalScore"]["description"];
         applyInitDataToTextField("coolSigns",param1.commonScores,this.tfMarksOfMastery);
         applyInitDataToTextField("wins",param1.commonScores,this.tfWins);
         applyInitDataToTextField("hits",param1.commonScores,this.tfHits);
         applyInitDataToTextField("avgExperience",param1.commonScores,this.tfAvgExperience);
         applyInitDataToTextField("avgDamage",param1.commonScores,this.tfAvgDamage);
         applyInitDataToTextField("maxDestroyed",param1.commonScores,this.tfMaxDestroyed);
         applyInitDataToTextField("maxExperience",param1.commonScores,this.tfMaxExperience);
         applyInitDataToTextField("battles",param1.commonScores,this.tfTotalBattles);
         this.significantAwards.label = param1.significantAwardsLabel;
         this.significantAwards.errorText = param1.significantAwardsErrorText;
      }

      public function set significantAchievementProvider(param1:Array) : void {
         this.significantAwards.dataProvider = param1;
      }

      override protected function onDispose() : void {
         this.tfWins.dispose();
         this.tfHits.dispose();
         this.tfAvgExperience.dispose();
         this.tfAvgDamage.dispose();
         this.tfMaxDestroyed.dispose();
         this.tfMaxExperience.dispose();
         this.tfTotalBattles.dispose();
         this.tfMarksOfMastery.dispose();
         this.tfPersonalScore.dispose();
         this.footer.dispose();
         this.initData.dispose();
         this.initData = null;
         this.significantAwards.dispose();
         if(this.lineTextFieldsLayout)
         {
            this.lineTextFieldsLayout.dispose();
            this.lineTextFieldsLayout = null;
         }
         super.onDispose();
      }

      public function as_setUserData(param1:Object) : void {
         this.initData = new ProfileUserVO(param1);
         invalidate(INIT_DATA_INVALID);
      }
   }

}