package net.wg.gui.lobby.battleResults 
{
    import flash.display.*;
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.advanced.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.questsWindow.*;
    import net.wg.infrastructure.interfaces.*;
    import net.wg.utils.*;
    import scaleform.clik.core.*;
    import scaleform.clik.data.*;
    import scaleform.clik.events.*;
    
    public class CommonStats extends scaleform.clik.core.UIComponent implements net.wg.infrastructure.interfaces.IViewStackContent
    {
        public function CommonStats()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            this.width = Math.round(this.width);
            this.height = Math.round(this.height);
            this.upperShadow.mouseEnabled = false;
            this.upperShadow.mouseChildren = false;
            this.lowerShadow.mouseEnabled = false;
            this.lowerShadow.mouseChildren = false;
            super.configUI();
            var loc1:*=this.myParent.data;
            this.effencyTitle.text = BATTLE_RESULTS.COMMON_BATTLEEFFICIENCY_TITLE;
            var loc2:*=loc1.personal;
            var loc3:*=loc1.common;
            var loc4:*=loc1.quests as Array;
            var loc5:*;
            var loc6:*=(loc5 = App.utils.locale).parseFormattedInteger(loc2.creditsStr);
            this.creditsCounter.formattedNumber = loc2.creditsStr;
            this.creditsCounter.localizationSymbol = loc6.delimiter;
            this.creditsCounter.playAnim = !(this.creditsCounterNumber == loc6.value);
            this.creditsCounterNumber = loc6.value;
            this.creditsCounter.number = loc6.value;
            var loc8:*;
            this.creditsCounter.x = loc8 = Math.round((this.imageSwitcher_mc.width + this.creditsCounter.metricsWidth) / 2) - 17;
            this.creditsIcon.x = loc8;
            var loc7:*=loc5.parseFormattedInteger(loc2.xpStr);
            this.xpCounter.formattedNumber = loc2.xpStr;
            this.xpCounter.localizationSymbol = loc7.delimiter;
            this.xpCounter.playAnim = !(this.xpCounterNumber == loc7.value);
            this.xpCounterNumber = loc7.value;
            this.xpCounter.number = loc7.value;
            this.xpCounter.x = loc8 = Math.round((this.imageSwitcher_mc.width + this.xpCounter.metricsWidth) / 2) - 17;
            this.xpIcon.x = loc8;
            this.resultLbl.text = loc3.resultStr;
            this.finishReasonLbl.text = loc3.finishReasonStr;
            this.imageSwitcher_mc.gotoAndStop(loc3.resultShortStr);
            this.arenaNameLbl.text = loc3.arenaStr;
            this.tankSlot.areaIcon.source = loc3.arenaIcon;
            this.tankSlot.tankIcon.source = loc3.tankIcon;
            this.tankSlot.playerNameLbl.text = loc3.playerNameStr;
            this.tankSlot.tankNameLbl.text = loc3.vehicleName;
            this.tankSlot.arenaCreateDateLbl.text = loc3.arenaCreateTimeStr;
            this.tankSlot.vehicleStateLbl.text = loc3.vehicleStateStr;
            this.tankSlot.vehicleStateLbl.textColor = loc2.killerID != 0 ? 8684674 : 13224374;
            this.detailsMc.data = loc2;
            this.detailsMc.detailedReportBtn.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onDetailsClick);
            this.medalsListLeft.dataProvider = new scaleform.clik.data.DataProvider(loc2.achievementsLeft);
            this.medalsListRight.dataProvider = new scaleform.clik.data.DataProvider(loc2.achievementsRight);
            this.efficiencyList.addEventListener(net.wg.gui.events.FinalStatisticEvent.EFFENSY_ICON_ROLL_OVER, onIconRollOver);
            this.efficiencyList.addEventListener(net.wg.gui.events.FinalStatisticEvent.EFFENSY_ICON_ROLL_OUT, onIconRollOut);
            if (loc2.details && loc2.details.length > 0) 
            {
                this.efficiencyList.labelField = "playerName";
                this.efficiencyList.dataProvider = new scaleform.clik.data.DataProvider(loc2.details);
                this.noEfficiencyLbl.visible = false;
            }
            else 
            {
                this.noEfficiencyLbl.text = BATTLE_RESULTS.COMMON_BATTLEEFFICIENCY_NONE;
                this.noEfficiencyLbl.visible = true;
                this.efficiencyList.visible = false;
            }
            this.questList = net.wg.gui.lobby.questsWindow.SubtasksList(this.scrollPane.target);
            this.questList.linkage = "BR_SubtaskComponent_UI";
            this.questList.addEventListener(net.wg.gui.events.QuestEvent.SELECT_QUEST, this.showQuest);
            if (loc4 && loc4.length > 0) 
            {
                this.questList.setData(createQuestsData(loc4));
                this.noProgressTF.visible = false;
            }
            else 
            {
                this.lowerShadow.visible = false;
                this.upperShadow.visible = false;
                this.questList.visible = false;
                this.subtasksScrollBar.visible = false;
                this.noProgressTF.visible = true;
                this.noProgressTF.text = BATTLE_RESULTS.COMMON_QUESTS_NOPROGRESS;
            }
            return;
        }

        protected override function draw():void
        {
            this.visible = true;
            this.tankSlot.validateNow();
            this.efficiencyList.validateNow();
            this.detailsMc.validateNow();
            this.medalsListLeft.validateNow();
            this.medalsListRight.validateNow();
            this.creditsCounter.validateNow();
            this.xpCounter.validateNow();
            return;
        }

        internal function onDetailsClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            this.myParent.tabs_mc.selectedIndex = 2;
            return;
        }

        internal function showQuest(arg1:net.wg.gui.events.QuestEvent):void
        {
            this.myParent.showQuestsWindow(arg1.questID);
            return;
        }

        internal static function createQuestsData(arg1:Array):Array
        {
            var loc3:*=null;
            var loc1:*=[];
            var loc2:*=0;
            while (loc2 < arg1.length) 
            {
                loc3 = {"title":arg1[loc2].taskType, "questInfo":arg1[loc2]};
                loc1.push(loc3);
                ++loc2;
            }
            return loc1;
        }

        internal static function onIconRollOver(arg1:net.wg.gui.events.FinalStatisticEvent):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (arg1.data.hoveredKind) 
            {
                loc1 = [];
                loc2 = {"type":arg1.data.hoveredKind, "disabled":arg1.data.isDisabled, "values":null, "discript":null, "value":null, "critDamage":null, "critDestruction":null, "critWound":null};
                var loc3:*=arg1.data.hoveredKind;
                switch (loc3) 
                {
                    case net.wg.gui.lobby.battleResults.EfficiencyIconRenderer.DAMAGE:
                        loc2.values = arg1.data.damageDealtVals;
                        loc2.discript = arg1.data.damageDealtNames;
                        break;
                    case net.wg.gui.lobby.battleResults.EfficiencyIconRenderer.ASSIST:
                        loc2.value = arg1.data.damageAssisted;
                        loc2.values = arg1.data.damageAssistedVals;
                        loc2.discript = arg1.data.damageAssistedNames;
                        break;
                    case net.wg.gui.lobby.battleResults.EfficiencyIconRenderer.CRITS:
                        loc2.value = arg1.data.critsCount;
                        loc2.critDamage = arg1.data.criticalDevices;
                        loc2.critDestruction = arg1.data.destroyedDevices;
                        loc2.critWound = arg1.data.destroyedTankmen;
                        break;
                    case net.wg.gui.lobby.battleResults.EfficiencyIconRenderer.KILL:
                    case net.wg.gui.lobby.battleResults.EfficiencyIconRenderer.TEAMKILL:
                        loc2.value = arg1.data.deathReason;
                        break;
                }
                App.toolTipMgr.showSpecial(net.wg.data.constants.Tooltips.EFFICIENCY_PARAM, null, arg1.data.hoveredKind, loc2);
            }
            return;
        }

        internal static function onIconRollOut(arg1:net.wg.gui.events.FinalStatisticEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        public override function dispose():void
        {
            this.detailsMc.detailedReportBtn.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onDetailsClick);
            this.efficiencyList.removeEventListener(net.wg.gui.events.FinalStatisticEvent.EFFENSY_ICON_ROLL_OVER, onIconRollOver);
            this.efficiencyList.removeEventListener(net.wg.gui.events.FinalStatisticEvent.EFFENSY_ICON_ROLL_OUT, onIconRollOut);
            this.questList.removeEventListener(net.wg.gui.events.QuestEvent.SELECT_QUEST, this.showQuest);
            this.tankSlot.dispose();
            this.efficiencyList.dispose();
            this.detailsMc.dispose();
            this.medalsListLeft.dispose();
            this.medalsListRight.dispose();
            this.creditsCounter.dispose();
            this.xpCounter.dispose();
            this.scrollPane.dispose();
            this.subtasksScrollBar.dispose();
            if (this.questList) 
            {
                this.questList.dispose();
                this.questList = null;
            }
            super.dispose();
            return;
        }

        public function update(arg1:Object):void
        {
            this.medalsListLeft.invalidateFilters();
            this.medalsListRight.invalidateFilters();
            return;
        }

        public function get myParent():net.wg.gui.lobby.battleResults.BattleResults
        {
            return net.wg.gui.lobby.battleResults.BattleResults(parent.parent.parent);
        }

        public var resultLbl:flash.text.TextField;

        public var finishReasonLbl:flash.text.TextField;

        public var arenaNameLbl:flash.text.TextField;

        public var noEfficiencyLbl:flash.text.TextField;

        public var effencyTitle:flash.text.TextField;

        public var tankSlot:net.wg.gui.lobby.battleResults.TankStatsView;

        public var efficiencyList:net.wg.gui.components.controls.ScrollingListEx;

        public var detailsMc:net.wg.gui.lobby.battleResults.DetailsBlock;

        public var imageSwitcher_mc:flash.display.MovieClip;

        public var medalsListLeft:net.wg.gui.lobby.battleResults.MedalsList;

        public var medalsListRight:net.wg.gui.lobby.battleResults.MedalsList;

        public var xpIcon:flash.display.MovieClip;

        public var creditsIcon:flash.display.MovieClip;

        public var creditsCounter:net.wg.gui.components.advanced.CounterEx;

        public var xpCounter:net.wg.gui.components.advanced.CounterEx;

        internal var creditsCounterNumber:Number=NaN;

        public var upperShadow:flash.display.MovieClip;

        public var lowerShadow:flash.display.MovieClip;

        public var noProgressTF:flash.text.TextField;

        public var scrollPane:net.wg.gui.lobby.questsWindow.QuestScrollPane;

        public var subtasksScrollBar:net.wg.gui.components.controls.ScrollBar;

        public var questList:net.wg.gui.lobby.questsWindow.SubtasksList;

        internal var xpCounterNumber:Number=NaN;
    }
}
