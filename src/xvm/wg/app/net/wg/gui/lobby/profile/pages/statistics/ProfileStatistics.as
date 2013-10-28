package net.wg.gui.lobby.profile.pages.statistics
{
   import net.wg.infrastructure.base.meta.impl.ProfileStatisticsMeta;
   import net.wg.infrastructure.base.meta.IProfileStatisticsMeta;
   import flash.text.TextField;
   import net.wg.gui.lobby.profile.ProfileConstants;
   import flash.events.Event;


   public class ProfileStatistics extends ProfileStatisticsMeta implements IProfileStatisticsMeta
   {
          
      public function ProfileStatistics() {
         super();
      }

      public var tfContainer:TfContainer;

      public var detailedStatistics:CommonStatistics;

      public var tfBattles:TextField;

      public var techniqueStatistics:TechniqueStatistics;

      override protected function initialize() : void {
         super.initialize();
         layoutManager = new StatisticsLayoutManager(525,740);
         layoutManager.registerComponents(this.tfContainer,this.detailedStatistics,this.tfBattles,this.techniqueStatistics);
      }

      override protected function configUI() : void {
         super.configUI();
         this.tfBattles.mouseEnabled = false;
      }

      override protected function applyResizing() : void {
         super.applyResizing();
         var _loc1_:Number = Math.min(ProfileConstants.MIN_APP_WIDTH,currentDimension.x);
         this.detailedStatistics.setViewSize(_loc1_,currentDimension.y);
         this.techniqueStatistics.setViewSize(_loc1_,currentDimension.y);
      }

      override public function as_setInitData(param1:Object) : void {
         var _loc2_:StatisticsInitVO = new StatisticsInitVO(param1);
         this.tfBattles.text = _loc2_.battlesOnTech;
         this.techniqueStatistics.setChartsTitles(_loc2_.chartsTitles);
         var _loc3_:Object = _loc2_.commonScores;
         this.tfContainer.tfTotalBattles.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_BATTLESCOUNT;
         this.tfContainer.tfWins.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_WINS;
         this.tfContainer.tfSurvival.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_SURVIVAL;
         this.tfContainer.tfHits.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_HITS;
         this.tfContainer.tfAvgExperience.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_AVGEXP;
         applyInitDataToTextField("battles",_loc3_,this.tfContainer.tfTotalBattles);
         applyInitDataToTextField("wins",_loc3_,this.tfContainer.tfWins);
         applyInitDataToTextField("survival",_loc3_,this.tfContainer.tfSurvival);
         applyInitDataToTextField("hits",_loc3_,this.tfContainer.tfHits);
         applyInitDataToTextField("avgExperience",_loc3_,this.tfContainer.tfAvgExperience);
         applyInitDataToTextField("maxExperience",_loc3_,this.tfContainer.tfMaxExperience);
         applyInitDataToTextField("coolSigns",_loc3_,this.tfContainer.tfMarksOfMastery);
         this.detailedStatistics.setLabels(_loc2_.detailedScores);
      }

      override protected function applyData(param1:Object) : Object {
         this.tfContainer.setDossierData(param1.commonParams);
         this.detailedStatistics.setDossierData(param1.detailedParams);
         this.techniqueStatistics.setDossierData(param1.chartsParams);
         return super.applyData(param1);
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
         if(this.techniqueStatistics)
         {
            this.techniqueStatistics.dispose();
            this.techniqueStatistics = null;
         }
         super.onDispose();
      }
   }

}