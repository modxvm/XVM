package net.wg.gui.lobby.profile.pages.statistics 
{
    import flash.events.*;
    import flash.text.*;
    import net.wg.data.gui_items.dossier.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.profile.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class ProfileStatistics extends net.wg.infrastructure.base.meta.impl.ProfileStatisticsMeta implements net.wg.infrastructure.base.meta.IProfileStatisticsMeta
    {
        public function ProfileStatistics()
        {
            super();
            var loc1:*;
            this.dropdownMenu.visible = loc1 = false;
            this.ddMenuLabel.visible = loc1;
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            layoutManager = new net.wg.gui.lobby.profile.pages.statistics.StatisticsLayoutManager(525, 740);
            layoutManager.registerComponents(this.tfContainer, this.detailedStatistics, this.tfBattles, this.techniqueStatistics);
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            this.ddMenuLabel.autoSize = flash.text.TextFieldAutoSize.RIGHT;
            if (App.utils) 
            {
                this.ddMenuLabel.text = App.utils.locale.makeString(PROFILE.SECTION_STATISTICS_DROPDOWN_TYPELABEL);
            }
            this.dropdownMenu.addEventListener(scaleform.clik.events.ListEvent.INDEX_CHANGE, this.menuIndexChangeHandler, false, 0, true);
            return;
        }

        internal function menuIndexChangeHandler(arg1:scaleform.clik.events.ListEvent=null):void
        {
            return;
        }

        protected override function applyResizing():void
        {
            super.applyResizing();
            var loc1:*=Math.min(net.wg.gui.lobby.profile.ProfileConstants.MIN_APP_WIDTH, currentDimension.x);
            this.detailedStatistics.setViewSize(loc1, currentDimension.y);
            this.techniqueStatistics.setViewSize(loc1, currentDimension.y);
            return;
        }

        public override function as_setInitData(arg1:Object):void
        {
            var loc6:*=null;
            var loc1:*=new net.wg.gui.lobby.profile.pages.statistics.StatisticsInitVO(arg1);
            this.tfBattles.text = loc1.battlesOnTech;
            this.techniqueStatistics.setChartsTitles(loc1.chartsTitles);
            var loc2:*=loc1.commonScores;
            this.tfContainer.tfTotalBattles.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_BATTLESCOUNT;
            this.tfContainer.tfWins.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_WINS;
            this.tfContainer.tfSurvival.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_SURVIVAL;
            this.tfContainer.tfHits.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_HITS;
            this.tfContainer.tfAvgExperience.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_AVGEXP;
            this.tfContainer.tfMaxExperience.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_MAXEXP;
            this.tfContainer.tfMarksOfMastery.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_MARKOFMASTERY;
            applyInitDataToTextField("battles", loc2, this.tfContainer.tfTotalBattles);
            applyInitDataToTextField("wins", loc2, this.tfContainer.tfWins);
            applyInitDataToTextField("survival", loc2, this.tfContainer.tfSurvival);
            applyInitDataToTextField("hits", loc2, this.tfContainer.tfHits);
            applyInitDataToTextField("avgExperience", loc2, this.tfContainer.tfAvgExperience);
            applyInitDataToTextField("maxExperience", loc2, this.tfContainer.tfMaxExperience);
            applyInitDataToTextField("coolSigns", loc2, this.tfContainer.tfMarksOfMastery);
            this.detailedStatistics.setLabels(loc1.detailedScores);
            var loc3:*=[];
            var loc4:*;
            var loc5:*=(loc4 = loc1.mainDropDownMenu).length;
            var loc7:*=0;
            while (loc7 < loc5) 
            {
                loc6 = loc4[loc7];
                loc3.push({"label":App.utils.locale.makeString(loc6), "key":loc6});
                ++loc7;
            }
            this.dropdownMenu.dataProvider = new scaleform.clik.data.DataProvider(loc3);
            this.dropdownMenu.selectedIndex = 0;
            this.dropdownMenu.validateNow();
            return;
        }

        protected override function updateByDossier(arg1:net.wg.data.gui_items.dossier.AccountDossier):void
        {
            super.updateByDossier(arg1);
            this.tfContainer.setDossierData(arg1);
            this.detailedStatistics.setDossierData(arg1);
            this.techniqueStatistics.setDossierData(arg1);
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
            if (this.techniqueStatistics) 
            {
                this.techniqueStatistics.dispose();
                this.techniqueStatistics = null;
            }
            super.onDispose();
            return;
        }

        public var tfContainer:net.wg.gui.lobby.profile.pages.statistics.TfContainer;

        public var dropdownMenu:net.wg.gui.components.controls.DropdownMenu;

        public var detailedStatistics:net.wg.gui.lobby.profile.pages.statistics.CommonStatistics;

        public var tfBattles:flash.text.TextField;

        public var ddMenuLabel:flash.text.TextField;

        public var techniqueStatistics:net.wg.gui.lobby.profile.pages.statistics.TechniqueStatistics;
    }
}
