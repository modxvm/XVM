package net.wg.gui.lobby.battleResults
{
   import scaleform.clik.core.UIComponent;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.gui.events.FinalStatisticEvent;
   import net.wg.data.constants.Tooltips;
   import flash.text.TextField;
   import net.wg.gui.components.controls.ScrollingListEx;
   import flash.display.MovieClip;
   import net.wg.gui.components.advanced.CounterEx;
   import net.wg.gui.lobby.questsWindow.QuestScrollPane;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.lobby.questsWindow.SubtasksList;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.gui.events.QuestEvent;
   import net.wg.utils.ILocale;
   import net.wg.infrastructure.interfaces.IFormattedInt;
   import scaleform.clik.data.DataProvider;


   public class CommonStats extends UIComponent implements IViewStackContent
   {
          
      public function CommonStats() {
         super();
      }

      private static function createQuestsData(param1:Array) : Array {
         var _loc4_:Object = null;
         var _loc2_:Array = [];
         var _loc3_:* = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ =
               {
                  "title":param1[_loc3_].taskType,
                  "questInfo":param1[_loc3_]
               }
            ;
            _loc2_.push(_loc4_);
            _loc3_++;
         }
         return _loc2_;
      }

      private static function onIconRollOver(param1:FinalStatisticEvent) : void {
         var _loc2_:Array = null;
         var _loc3_:Object = null;
         if(param1.data.hoveredKind)
         {
            _loc2_ = [];
            _loc3_ =
               {
                  "type":param1.data.hoveredKind,
                  "disabled":param1.data.isDisabled,
                  "values":null,
                  "discript":null,
                  "value":null,
                  "critDamage":null,
                  "critDestruction":null,
                  "critWound":null
               }
            ;
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

      private static function onIconRollOut(param1:FinalStatisticEvent) : void {
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

      public var creditsCounter:CounterEx;

      public var xpCounter:CounterEx;

      private var creditsCounterNumber:Number = NaN;

      private var xpCounterNumber:Number = NaN;

      public var scrollPane:QuestScrollPane;

      public var subtasksScrollBar:ScrollBar;

      public var questList:SubtasksList;

      public var upperShadow:MovieClip;

      public var lowerShadow:MovieClip;

      public var noProgressTF:TextField;

      override public function dispose() : void {
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
         this.scrollPane.dispose();
         this.subtasksScrollBar.dispose();
         if(this.questList)
         {
            this.questList.dispose();
            this.questList = null;
         }
         super.dispose();
      }

      public function update(param1:Object) : void {
         this.medalsListLeft.invalidateFilters();
         this.medalsListRight.invalidateFilters();
      }

      public function get myParent() : BattleResults {
         return BattleResults(parent.parent.parent);
      }

      override protected function configUI() : void {
         this.width = Math.round(this.width);
         this.height = Math.round(this.height);
         this.upperShadow.mouseEnabled = false;
         this.upperShadow.mouseChildren = false;
         this.lowerShadow.mouseEnabled = false;
         this.lowerShadow.mouseChildren = false;
         super.configUI();
         var _loc1_:Object = this.myParent.data;
         this.effencyTitle.text = BATTLE_RESULTS.COMMON_BATTLEEFFICIENCY_TITLE;
         var _loc2_:Object = _loc1_.personal;
         var _loc3_:Object = _loc1_.common;
         var _loc4_:Array = _loc1_.quests as Array;
         var _loc5_:ILocale = App.utils.locale;
         var _loc6_:IFormattedInt = _loc5_.parseFormattedInteger(_loc2_.creditsStr);
         this.creditsCounter.formattedNumber = _loc5_.cutCharsBeforeNumber(_loc2_.creditsStr);
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
         this.arenaNameLbl.text = _loc3_.arenaStr;
         this.tankSlot.areaIcon.source = _loc3_.arenaIcon;
         this.tankSlot.tankIcon.source = _loc3_.tankIcon;
         this.tankSlot.playerNameLbl.text = _loc3_.playerNameStr;
         this.tankSlot.tankNameLbl.text = _loc3_.vehicleName;
         this.tankSlot.arenaCreateDateLbl.text = _loc3_.arenaCreateTimeStr;
         this.tankSlot.vehicleStateLbl.text = _loc3_.vehicleStateStr;
         this.tankSlot.vehicleStateLbl.textColor = _loc2_.killerID == 0?13224374:8684674;
         this.detailsMc.data = _loc2_;
         this.detailsMc.detailedReportBtn.addEventListener(ButtonEvent.CLICK,this.onDetailsClick);
         this.medalsListLeft.dataProvider = new DataProvider(_loc2_.achievementsLeft);
         this.medalsListRight.dataProvider = new DataProvider(_loc2_.achievementsRight);
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
         this.questList.linkage = "BR_SubtaskComponent_UI";
         this.questList.addEventListener(QuestEvent.SELECT_QUEST,this.showQuest);
         if((_loc4_) && _loc4_.length > 0)
         {
            this.questList.setData(createQuestsData(_loc4_));
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

      override protected function draw() : void {
         this.visible = true;
         this.tankSlot.validateNow();
         this.efficiencyList.validateNow();
         this.detailsMc.validateNow();
         this.medalsListLeft.validateNow();
         this.medalsListRight.validateNow();
         this.creditsCounter.validateNow();
         this.xpCounter.validateNow();
      }

      private function onDetailsClick(param1:ButtonEvent) : void {
         this.myParent.tabs_mc.selectedIndex = 2;
      }

      private function showQuest(param1:QuestEvent) : void {
         this.myParent.showQuestsWindow(param1.questID);
      }
   }

}