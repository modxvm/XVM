package net.wg.gui.lobby.profile.pages.summary
{
   import net.wg.infrastructure.base.meta.impl.ProfileSummaryMeta;
   import net.wg.infrastructure.base.meta.IProfileSummaryMeta;
   import flash.display.DisplayObjectContainer;
   import scaleform.clik.core.UIComponent;
   import net.wg.gui.lobby.profile.components.LditBattles;
   import net.wg.gui.lobby.profile.components.LineDescrIconText;
   import net.wg.gui.lobby.profile.components.LditMarksOfMastery;
   import net.wg.gui.lobby.profile.components.LditValued;
   import net.wg.gui.lobby.profile.components.PersonalScoreComponent;
   import net.wg.gui.lobby.profile.components.ProfileFooter;
   import net.wg.gui.lobby.profile.data.ProfileUserVO;
   import net.wg.gui.lobby.profile.data.SectionLayoutManager;
   import flash.events.Event;
   import net.wg.data.gui_items.dossier.Dossier;


   public class ProfileSummary extends ProfileSummaryMeta implements IProfileSummaryMeta
   {
          
      public function ProfileSummary() {
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage,false,0,true);
      }

      private static const INIT_DATA_INVALID:String = "idInv";

      private static function validateChildren(param1:DisplayObjectContainer) : void {
         var _loc3_:DisplayObjectContainer = null;
         var _loc4_:UIComponent = null;
         var _loc2_:* = 0;
         while(_loc2_ < param1.numChildren)
         {
            _loc3_ = param1.getChildAt(_loc2_) as DisplayObjectContainer;
            _loc4_ = _loc3_ as UIComponent;
            if(_loc4_)
            {
               _loc4_.validateNow();
            }
            if(_loc3_)
            {
               validateChildren(_loc3_);
            }
            _loc2_++;
         }
      }

      public var tfTotalBattles:LditBattles;

      public var tfWins:LineDescrIconText;

      public var tfMarksOfMastery:LditMarksOfMastery;

      public var tfMaxDestroyed:LditValued;

      public var tfMaxExperience:LditValued;

      public var tfAvgExperience:LineDescrIconText;

      public var tfHits:LineDescrIconText;

      public var tfAvgDamage:LineDescrIconText;

      public var tfPersonalScore:PersonalScoreComponent;

      public var footer:ProfileFooter;

      private var initData:ProfileUserVO;

      public var significantAwards:AwardsListComponent;

      private var lineTextFieldsLayout:LineTextFieldsLayout;

      override protected function initialize() : void {
         super.initialize();
         layoutManager = new SectionLayoutManager(525,740);
         layoutManager.registerComponents(this.tfTotalBattles,this.tfWins,this.tfMarksOfMastery,this.tfMaxDestroyed,this.tfMaxExperience,this.tfHits,this.tfAvgDamage,this.tfAvgExperience,this.tfPersonalScore,this.significantAwards,this.footer);
         this.lineTextFieldsLayout = new LineTextFieldsLayout(988,140);
         this.lineTextFieldsLayout.addLeftPair(this.tfTotalBattles,this.tfAvgDamage);
         this.lineTextFieldsLayout.addLeftPair(this.tfWins,this.tfHits);
         this.lineTextFieldsLayout.addRightPair(this.tfAvgExperience,this.tfMaxDestroyed);
         this.lineTextFieldsLayout.addRightPair(this.tfMaxExperience,this.tfMarksOfMastery);
         this.lineTextFieldsLayout.layout();
      }

      override protected function applyResizing() : void {
         if(layoutManager)
         {
            layoutManager.setDimension(currentDimension.x,currentDimension.y);
         }
         this.x = Math.round(currentDimension.x / 2 - _centerOffset);
      }

      override protected function draw() : void {
         super.draw();
         if((isInvalid(INIT_DATA_INVALID)) && (this.initData))
         {
            this.footer.setUserData(this.initData);
         }
      }

      private function onAddedToStage(param1:Event) : void {
         validateChildren(this);
      }

      override protected function applyData(param1:Object) : Object {
         var _loc2_:ProfileSummaryVO = new ProfileSummaryVO(param1);
         this.tfTotalBattles.text = _loc2_.getBattlesCountStr();
         this.tfTotalBattles.setValues(_loc2_.getWinsCountStr(),_loc2_.getLossesCountStr(),_loc2_.getDrawsCountStr());
         this.tfWins.text = _loc2_.getWinsEfficiencyStr() + "%";
         this.tfMarksOfMastery.text = _loc2_.getMarksOfMasteryCountStr();
         this.tfMarksOfMastery.totalCount = _loc2_.totalUserVehiclesCount;
         this.tfMaxDestroyed.text = _loc2_.getMaxDestroyedStr();
         var _loc3_:String = _loc2_.maxDestroyed > 0?_loc2_.maxDestroyedByVehicle:null;
         this.tfMaxDestroyed.value = _loc3_;
         this.tfMaxExperience.text = _loc2_.getMaxExperienceStr();
         _loc3_ = _loc2_.maxXP > 0?_loc2_.maxXPByVehicle:null;
         this.tfMaxExperience.value = _loc3_;
         this.tfAvgDamage.text = _loc2_.getAvgDamageStr();
         this.tfAvgExperience.text = _loc2_.getAvgExperienceStr();
         this.tfHits.text = _loc2_.getHitsEfficiencyStr() + "%";
         this.tfPersonalScore.text = _loc2_.getGlobalRatingStr();
         this.significantAchievementProvider = Dossier.getAchievementVector(_loc2_.significantAchievements);
         return _loc2_;
      }

      override public function as_setInitData(param1:Object) : void {
         super.as_setInitData(param1);
         this.applyInitData(new SummaryInitVO(param1));
      }

      protected function applyInitData(param1:SummaryInitVO) : void {
         var _loc2_:Object = param1.commonScores;
         this.tfTotalBattles.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_BATTLESCOUNT;
         this.tfWins.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_WINS;
         this.tfMarksOfMastery.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_MARKOFMASTERY;
         this.tfMaxDestroyed.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_MAXDESTROYED;
         this.tfMaxExperience.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_MAXEXP;
         this.tfAvgExperience.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_AVGEXP;
         this.tfHits.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_HITS;
         this.tfAvgDamage.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_AVGDAMAGE;
         applyInitDataToTextField("battles",param1.commonScores,this.tfTotalBattles);
         applyInitDataToTextField("wins",param1.commonScores,this.tfWins);
         applyInitDataToTextField("coolSigns",param1.commonScores,this.tfMarksOfMastery);
         applyInitDataToTextField("maxDestroyed",param1.commonScores,this.tfMaxDestroyed);
         applyInitDataToTextField("maxExperience",param1.commonScores,this.tfMaxExperience);
         applyInitDataToTextField("avgExperience",param1.commonScores,this.tfAvgExperience);
         applyInitDataToTextField("hits",param1.commonScores,this.tfHits);
         applyInitDataToTextField("avgDamage",param1.commonScores,this.tfAvgDamage);
         this.tfPersonalScore.description = _loc2_["personalScore"]["description"];
         this.significantAwards.label = param1.significantAwardsLabel;
         this.significantAwards.errorText = param1.significantAwardsErrorText;
      }

      public function set significantAchievementProvider(param1:Array) : void {
         this.significantAwards.dataProvider = param1;
      }

      override protected function handleStageChange(param1:Event) : void {
         if(param1.type == Event.ADDED_TO_STAGE)
         {
            removeEventListener(Event.ADDED_TO_STAGE,this.handleStageChange,false);
            addEventListener(Event.RENDER,validateNow,false,0,true);
            addEventListener(Event.ENTER_FRAME,validateNow,false,0,true);
            if(stage != null)
            {
               stage.invalidate();
            }
         }
      }

      override protected function onDispose() : void {
         super.onDispose();
         if(this.lineTextFieldsLayout)
         {
            this.lineTextFieldsLayout.dispose();
            this.lineTextFieldsLayout = null;
         }
      }

      public function as_setUserData(param1:Object) : void {
         this.initData = new ProfileUserVO(param1);
         invalidate(INIT_DATA_INVALID);
      }
   }

}