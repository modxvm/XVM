package net.wg.gui.lobby.battleResults
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.infrastructure.interfaces.IViewStackContent;
    import net.wg.gui.events.FinalStatisticEvent;
    import net.wg.data.constants.Tooltips;
    import flash.text.TextField;
    import net.wg.gui.components.controls.ScrollingListEx;
    import flash.display.MovieClip;
    import net.wg.gui.components.advanced.CounterEx;
    import net.wg.gui.components.controls.ResizableScrollPane;
    import net.wg.gui.components.controls.ScrollBar;
    import net.wg.gui.lobby.questsWindow.SubtasksList;
    import flash.display.InteractiveObject;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.events.QuestEvent;
    import net.wg.infrastructure.interfaces.IUserProps;
    import net.wg.infrastructure.interfaces.IFormattedInt;
    import net.wg.utils.ILocale;
    import net.wg.data.VO.UserVO;
    import scaleform.clik.data.DataProvider;
    import net.wg.data.constants.Linkages;
    
    public class CommonStats extends UIComponentEx implements IViewStackContent
    {
        
        public function CommonStats()
        {
            super();
        }
        
        private static var COUNTERS_SCALE:Number = 0.9;
        
        private static var ARENA_ENEMY_CLAN_EMBLEM:String = "arenaEnemyClanEmblem";
        
        private static function onIconRollOver(param1:FinalStatisticEvent) : void
        {
            var _loc2_:Array = null;
            var _loc3_:Object = null;
            if(param1.data.hoveredKind)
            {
                _loc2_ = [];
                _loc3_ = {"type":param1.data.hoveredKind,
                "disabled":param1.data.isDisabled,
                "values":null,
                "discript":null,
                "value":null,
                "critDamage":null,
                "critDestruction":null,
                "critWound":null
            };
            switch(param1.data.hoveredKind)
            {
                case EfficiencyIconRenderer.DAMAGE:
                    _loc3_.values = param1.data.damageDealtVals;
                    _loc3_.discript = param1.data.damageDealtNames;
                    break;
                case EfficiencyIconRenderer.ASSIST:
                    _loc3_.value = param1.data.damageAssisted;
                    _loc3_.values = param1.data.damageAssistedVals;
                    _loc3_.discript = param1.data.damageAssistedNames;
                    break;
                case EfficiencyIconRenderer.CRITS:
                    _loc3_.value = param1.data.critsCount;
                    _loc3_.critDamage = param1.data.criticalDevices;
                    _loc3_.critDestruction = param1.data.destroyedDevices;
                    _loc3_.critWound = param1.data.destroyedTankmen;
                    break;
                case EfficiencyIconRenderer.KILL:
                case EfficiencyIconRenderer.TEAMKILL:
                    _loc3_.value = param1.data.deathReason;
                    break;
            }
            App.toolTipMgr.showSpecial(Tooltips.EFFICIENCY_PARAM,null,param1.data.hoveredKind,_loc3_);
        }
    }
    
    private static function onIconRollOut(param1:FinalStatisticEvent) : void
    {
        App.toolTipMgr.hide();
    }
    
    public var resultLbl:TextField;
    
    public var finishReasonLbl:TextField;
    
    public var arenaNameLbl:TextField;
    
    public var noEfficiencyLbl:TextField;
    
    public var effencyTitle:TextField;
    
    public var tankSlot:TankStatsView;
    
    public var efficiencyList:ScrollingListEx;
    
    public var detailsMc:DetailsBlock;
    
    public var imageSwitcher_mc:MovieClip;
    
    public var medalsListLeft:MedalsList;
    
    public var medalsListRight:MedalsList;
    
    public var xpIcon:MovieClip;
    
    public var creditsIcon:MovieClip;
    
    public var resIcon:MovieClip;
    
    public var creditsCounter:CounterEx;
    
    public var xpCounter:CounterEx;
    
    public var resCounter:CounterEx;
    
    public var scrollPane:ResizableScrollPane;
    
    public var subtasksScrollBar:ScrollBar;
    
    public var questList:SubtasksList;
    
    public var upperShadow:MovieClip;
    
    public var lowerShadow:MovieClip;
    
    public var noProgressTF:TextField;
    
    private var creditsCounterNumber:Number = NaN;
    
    private var xpCounterNumber:Number = NaN;
    
    private var resCounterNumber:Number = NaN;
    
    private var originalArenaStr:String = "";
    
    public function update(param1:Object) : void
    {
        this.medalsListLeft.invalidateFilters();
        this.medalsListRight.invalidateFilters();
    }
    
    public function onEmblemLoaded(param1:String, param2:String) : void
    {
        var _loc3_:Object = null;
        if(param1 == ARENA_ENEMY_CLAN_EMBLEM)
        {
            _loc3_ = this.myParent.data;
            this.arenaNameLbl.htmlText = this.originalArenaStr + param2 + " " + _loc3_.common.clans.enemies.clanAbbrev;
        }
    }
    
    public function getComponentForFocus() : InteractiveObject
    {
        return null;
    }
    
    public function get myParent() : BattleResults
    {
        return BattleResults(parent.parent.parent);
    }
    
    override protected function onDispose() : void
    {
        this.detailsMc.detailedReportBtn.removeEventListener(ButtonEvent.CLICK,this.onDetailsClick);
        this.efficiencyList.removeEventListener(FinalStatisticEvent.EFFENSY_ICON_ROLL_OVER,onIconRollOver);
        this.efficiencyList.removeEventListener(FinalStatisticEvent.EFFENSY_ICON_ROLL_OUT,onIconRollOut);
        this.questList.removeEventListener(QuestEvent.SELECT_QUEST,this.showQuest);
        this.tankSlot.dispose();
        this.efficiencyList.dispose();
        this.detailsMc.dispose();
        this.medalsListLeft.dispose();
        this.medalsListRight.dispose();
        this.creditsCounter.dispose();
        this.xpCounter.dispose();
        this.resCounter.dispose();
        if(this.scrollPane.target == this.questList)
        {
            this.scrollPane.dispose();
        }
        else
        {
            this.scrollPane.dispose();
            if(this.questList)
            {
                this.questList.dispose();
                this.questList = null;
            }
        }
        this.subtasksScrollBar.dispose();
        super.onDispose();
    }
    
    override protected function configUI() : void
    {
        var _loc2_:Object = null;
        var _loc8_:IUserProps = null;
        var _loc9_:* = false;
        var _loc10_:IFormattedInt = null;
        this.width = Math.round(this.width);
        this.height = Math.round(this.height);
        this.upperShadow.mouseEnabled = false;
        this.upperShadow.mouseChildren = false;
        this.lowerShadow.mouseEnabled = false;
        this.lowerShadow.mouseChildren = false;
        super.configUI();
        var _loc1_:Object = this.myParent.data;
        this.effencyTitle.text = BATTLE_RESULTS.COMMON_BATTLEEFFICIENCY_TITLE;
        _loc2_ = _loc1_.personal;
        var _loc3_:Object = _loc1_.common;
        var _loc4_:Array = _loc1_.quests as Array;
        var _loc5_:ILocale = App.utils.locale;
        var _loc6_:IFormattedInt = _loc5_.parseFormattedInteger(_loc2_.creditsStr);
        this.creditsCounter.formattedNumber = _loc2_.creditsStr;
        this.creditsCounter.localizationSymbol = _loc6_.delimiter;
        this.creditsCounter.playAnim = !(this.creditsCounterNumber == _loc6_.value);
        this.creditsCounterNumber = _loc6_.value;
        this.creditsCounter.number = _loc6_.value;
        this.creditsIcon.x = this.creditsCounter.x = Math.round((this.imageSwitcher_mc.width + this.creditsCounter.metricsWidth) / 2) - 17;
        var _loc7_:IFormattedInt = _loc5_.parseFormattedInteger(_loc2_.xpStr);
        this.xpCounter.formattedNumber = _loc5_.cutCharsBeforeNumber(_loc2_.xpStr);
        this.xpCounter.localizationSymbol = _loc7_.delimiter;
        this.xpCounter.playAnim = !(this.xpCounterNumber == _loc7_.value);
        this.xpCounterNumber = _loc7_.value;
        this.xpCounter.number = _loc7_.value;
        this.xpIcon.x = this.xpCounter.x = Math.round((this.imageSwitcher_mc.width + this.xpCounter.metricsWidth) / 2) - 17;
        this.resultLbl.text = _loc3_.resultStr;
        this.finishReasonLbl.text = _loc3_.finishReasonStr;
        this.imageSwitcher_mc.gotoAndStop(_loc3_.resultShortStr);
        this.arenaNameLbl.htmlText = this.originalArenaStr = _loc3_.arenaStr;
        this.tankSlot.areaIcon.source = _loc3_.arenaIcon;
        this.tankSlot.tankIcon.source = _loc3_.tankIcon;
        this.tankSlot.playerNameLbl.userVO = new UserVO({"fullName":_loc3_.playerFullNameStr,
        "userName":_loc3_.playerNameStr,
        "clanAbbrev":_loc3_.clanNameStr,
        "region":_loc3_.regionNameStr
    });
    this.tankSlot.tankNameLbl.text = _loc3_.vehicleName;
    this.tankSlot.arenaCreateDateLbl.text = _loc3_.arenaCreateTimeStr;
    if((_loc2_.isPrematureLeave) || _loc2_.killerID <= 0)
    {
        this.tankSlot.vehicleStateLbl.text = _loc3_.vehicleStateStr;
    }
    else if(_loc2_.killerID > 0)
    {
        _loc8_ = App.utils.commons.getUserProps(_loc3_.killerNameStr,_loc3_.killerClanNameStr,_loc3_.killerRegionNameStr);
        _loc8_.prefix = _loc3_.vehicleStatePrefixStr;
        _loc8_.suffix = _loc3_.vehicleStateSuffixStr;
        _loc9_ = App.utils.commons.formatPlayerName(this.tankSlot.vehicleStateLbl,_loc8_);
        if(_loc9_)
        {
            this.tankSlot.toolTip = _loc3_.vehicleStatePrefixStr + _loc3_.killerFullNameStr + _loc3_.vehicleStateSuffixStr;
        }
    }
    
    this.tankSlot.vehicleStateLbl.textColor = _loc2_.killerID == 0?13224374:8684674;
    if(_loc3_.bonusType == 11)
    {
        this.arenaNameLbl.htmlText = this.arenaNameLbl.htmlText + (" " + _loc1_.common.clans.enemies.clanAbbrev);
        this.myParent.requestClanEmblem(ARENA_ENEMY_CLAN_EMBLEM,_loc1_.common.clans.enemies.clanDBID,this.onEmblemLoaded);
    }
    if(_loc3_.bonusType == 10)
    {
        this.arenaNameLbl.htmlText = this.arenaNameLbl.htmlText + (" " + _loc1_.common.clans.enemies.clanAbbrev);
        this.resCounter.visible = true;
        this.resIcon.visible = true;
        _loc10_ = _loc5_.parseFormattedInteger(_loc2_.fortResourceTotal);
        this.resCounter.formattedNumber = _loc5_.cutCharsBeforeNumber(_loc2_.fortResourceTotal);
        this.resCounter.localizationSymbol = _loc10_.delimiter;
        this.resCounter.playAnim = !(this.resCounterNumber == _loc10_.value);
        this.resCounterNumber = _loc10_.value;
        this.resCounter.number = _loc10_.value;
        this.resCounter.x = Math.round((this.imageSwitcher_mc.width + this.resCounter.metricsWidth) / 2) - 17;
        this.resIcon.x = this.resCounter.x + 8;
        this.resCounter.scaleX = this.resCounter.scaleY = COUNTERS_SCALE;
        this.detailsMc.gotoAndStop("sortie");
        this.creditsCounter.y = this.creditsCounter.y - 10;
        this.creditsCounter.scaleX = this.creditsCounter.scaleY = COUNTERS_SCALE;
        this.creditsIcon.y = this.creditsIcon.y - 15;
        this.xpCounter.y = this.xpCounter.y - 14;
        this.xpCounter.scaleX = this.xpCounter.scaleY = COUNTERS_SCALE;
        this.xpIcon.y = this.xpIcon.y - 16;
        this.myParent.requestClanEmblem(ARENA_ENEMY_CLAN_EMBLEM,_loc1_.common.clans.enemies.clanDBID,this.onEmblemLoaded);
    }
    else
    {
        this.resCounter.visible = false;
        this.resIcon.visible = false;
    }
    this.detailsMc.data = _loc2_;
    this.detailsMc.detailedReportBtn.addEventListener(ButtonEvent.CLICK,this.onDetailsClick);
    this.medalsListLeft.dataProvider = new DataProvider(_loc2_.achievementsLeft);
    this.medalsListRight.dataProvider = new DataProvider(_loc2_.achievementsRight);
    this.efficiencyList.buttonModeEnabled = false;
    this.efficiencyList.addEventListener(FinalStatisticEvent.EFFENSY_ICON_ROLL_OVER,onIconRollOver);
    this.efficiencyList.addEventListener(FinalStatisticEvent.EFFENSY_ICON_ROLL_OUT,onIconRollOut);
    if((_loc2_.details) && _loc2_.details.length > 0)
    {
        this.efficiencyList.labelField = "playerName";
        this.efficiencyList.dataProvider = new DataProvider(_loc2_.details);
        this.noEfficiencyLbl.visible = false;
    }
    else
    {
        this.noEfficiencyLbl.text = BATTLE_RESULTS.COMMON_BATTLEEFFICIENCY_NONE;
        this.noEfficiencyLbl.visible = true;
        this.efficiencyList.visible = false;
    }
    this.questList = SubtasksList(this.scrollPane.target);
    this.questList.linkage = Linkages.BR_SUBTASK_COMPONENT_UI;
    this.questList.addEventListener(QuestEvent.SELECT_QUEST,this.showQuest);
    if((_loc4_) && _loc4_.length > 0)
    {
        this.questList.setData(_loc4_);
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
}

override protected function draw() : void
{
    this.visible = true;
    this.tankSlot.validateNow();
    this.efficiencyList.validateNow();
    this.detailsMc.validateNow();
    this.medalsListLeft.validateNow();
    this.medalsListRight.validateNow();
    this.creditsCounter.validateNow();
    this.xpCounter.validateNow();
    this.resCounter.validateNow();
}

private function onDetailsClick(param1:ButtonEvent) : void
{
    this.myParent.tabs_mc.selectedIndex = 2;
}

private function showQuest(param1:QuestEvent) : void
{
    this.myParent.showEventsWindow(param1.questID);
}

public function canShowAutomatically() : Boolean
{
    return true;
}
}
}
