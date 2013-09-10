package net.wg.gui.lobby.profile.pages.summary 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.data.constants.*;
    import net.wg.data.gui_items.dossier.*;
    import net.wg.gui.lobby.profile.components.*;
    import net.wg.gui.lobby.profile.data.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import scaleform.clik.core.*;
    
    public class ProfileSummary extends net.wg.infrastructure.base.meta.impl.ProfileSummaryMeta implements net.wg.infrastructure.base.meta.IProfileSummaryMeta
    {
        public function ProfileSummary()
        {
            super();
            addEventListener(flash.events.Event.ADDED_TO_STAGE, this.onAddedToStage, false, 0, true);
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            layoutManager = new net.wg.gui.lobby.profile.data.SectionLayoutManager(525, 740);
            layoutManager.registerComponents(this.tfTotalBattles, this.tfWins, this.tfMarksOfMastery, this.tfMaxDestroyed, this.tfMaxExperience, this.tfHits, this.tfAvgDamage, this.tfAvgExperience, this.tfPersonalScore, this.significantAwards);
            this.lineTextFieldsLayout = new net.wg.gui.lobby.profile.pages.summary.LineTextFieldsLayout(988, 140);
            this.lineTextFieldsLayout.addLeftPair(this.tfTotalBattles, this.tfAvgDamage);
            this.lineTextFieldsLayout.addLeftPair(this.tfWins, this.tfHits);
            this.lineTextFieldsLayout.addRightPair(this.tfAvgExperience, this.tfMaxDestroyed);
            this.lineTextFieldsLayout.addRightPair(this.tfMaxExperience, this.tfMarksOfMastery);
            this.lineTextFieldsLayout.layout();
            return;
        }

        protected override function applyResizing():void
        {
            if (layoutManager) 
            {
                layoutManager.setDimension(currentDimension.x, currentDimension.y);
            }
            this.x = Math.round(currentDimension.x / 2 - _centerOffset);
            return;
        }

        internal function onAddedToStage(arg1:flash.events.Event):void
        {
            validateChildren(this);
            return;
        }

        protected override function updateByDossier(arg1:net.wg.data.gui_items.dossier.AccountDossier):void
        {
            super.updateByDossier(arg1);
            this.tfTotalBattles.text = arg1.getBattlesCountStr();
            this.tfWins.text = arg1.getWinsEfficiencyStr();
            this.tfMarksOfMastery.text = arg1.getSpecifiedMarksOfMasteryStr(net.wg.data.constants.MarksOfMastery.MASTER);
            this.tfMarksOfMastery.totalCount = arg1.getVehiclesCount();
            this.tfMaxDestroyed.text = arg1.getMaxFragsStr();
            this.tfMaxDestroyed.value = arg1.getMaxFragsVehicleDescr();
            this.tfMaxExperience.value = arg1.getMaxXPVehicleDescr();
            this.tfMaxExperience.text = arg1.getMaxXPStr();
            this.tfAvgDamage.text = arg1.getAvgDamageStr();
            this.tfAvgExperience.text = arg1.getAvgXPStr();
            this.tfHits.text = arg1.getHitsEfficiencyStr();
            this.setGlobalRating(getGlobalRatingS(arg1.id));
            this.significantAchievementProvider = arg1.getSignificantAchievements();
            return;
        }

        public function setGlobalRating(arg1:Number):void
        {
            this.tfPersonalScore.text = App.utils.locale.integer(arg1);
            return;
        }

        public override function as_setInitData(arg1:Object):void
        {
            super.as_setInitData(arg1);
            this.applyInitData(new net.wg.gui.lobby.profile.pages.summary.SummaryInitVO(arg1));
            return;
        }

        protected function applyInitData(arg1:net.wg.gui.lobby.profile.pages.summary.SummaryInitVO):void
        {
            var loc1:*=arg1.commonScores;
            this.tfTotalBattles.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_BATTLESCOUNT;
            this.tfWins.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_WINS;
            this.tfMarksOfMastery.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_MARKOFMASTERY;
            this.tfMaxDestroyed.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_MAXDESTROYED;
            this.tfMaxExperience.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_MAXEXP;
            this.tfAvgExperience.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_AVGEXP;
            this.tfHits.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_HITS;
            this.tfAvgDamage.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_AVGDAMAGE;
            applyInitDataToTextField("battles", arg1.commonScores, this.tfTotalBattles);
            applyInitDataToTextField("wins", arg1.commonScores, this.tfWins);
            applyInitDataToTextField("coolSigns", arg1.commonScores, this.tfMarksOfMastery);
            applyInitDataToTextField("maxDestroyed", arg1.commonScores, this.tfMaxDestroyed);
            applyInitDataToTextField("maxExperience", arg1.commonScores, this.tfMaxExperience);
            applyInitDataToTextField("avgExperience", arg1.commonScores, this.tfAvgExperience);
            applyInitDataToTextField("hits", arg1.commonScores, this.tfHits);
            applyInitDataToTextField("avgDamage", arg1.commonScores, this.tfAvgDamage);
            this.tfPersonalScore.description = loc1["personalScore"]["description"];
            this.significantAwards.label = arg1.significantAwardsLabel;
            this.significantAwards.errorText = arg1.significantAwardsErrorText;
            return;
        }

        public function set significantAchievementProvider(arg1:Array):void
        {
            this.significantAwards.dataProvider = arg1;
            return;
        }

        protected override function handleStageChange(arg1:flash.events.Event):void
        {
            if (arg1.type == flash.events.Event.ADDED_TO_STAGE) 
            {
                removeEventListener(flash.events.Event.ADDED_TO_STAGE, this.handleStageChange, false);
                addEventListener(flash.events.Event.RENDER, validateNow, false, 0, true);
                addEventListener(flash.events.Event.ENTER_FRAME, validateNow, false, 0, true);
                if (stage != null) 
                {
                    stage.invalidate();
                }
            }
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            if (this.lineTextFieldsLayout) 
            {
                this.lineTextFieldsLayout.dispose();
                this.lineTextFieldsLayout = null;
            }
            return;
        }

        internal static function validateChildren(arg1:flash.display.DisplayObjectContainer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=0;
            while (loc1 < arg1.numChildren) 
            {
                loc2 = arg1.getChildAt(loc1) as flash.display.DisplayObjectContainer;
                if (loc3 = loc2 as scaleform.clik.core.UIComponent) 
                {
                    loc3.validateNow();
                }
                if (loc2) 
                {
                    validateChildren(loc2);
                }
                ++loc1;
            }
            return;
        }

        public var tfTotalBattles:net.wg.gui.lobby.profile.components.LineDescrIconText;

        public var tfWins:net.wg.gui.lobby.profile.components.LineDescrIconText;

        public var tfMarksOfMastery:net.wg.gui.lobby.profile.components.LditMarksOfMastery;

        public var tfMaxDestroyed:net.wg.gui.lobby.profile.components.LditValued;

        public var tfMaxExperience:net.wg.gui.lobby.profile.components.LditValued;

        public var tfAvgExperience:net.wg.gui.lobby.profile.components.LineDescrIconText;

        public var tfHits:net.wg.gui.lobby.profile.components.LineDescrIconText;

        public var tfAvgDamage:net.wg.gui.lobby.profile.components.LineDescrIconText;

        public var tfPersonalScore:net.wg.gui.lobby.profile.components.PersonalScoreComponent;

        public var significantAwards:net.wg.gui.lobby.profile.pages.summary.AwardsListComponent;

        internal var lineTextFieldsLayout:net.wg.gui.lobby.profile.pages.summary.LineTextFieldsLayout;
    }
}
