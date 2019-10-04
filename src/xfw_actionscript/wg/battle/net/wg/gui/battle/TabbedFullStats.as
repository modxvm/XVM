package net.wg.gui.battle
{
    import net.wg.infrastructure.base.meta.impl.TabbedFullStatsMeta;
    import net.wg.infrastructure.base.meta.ITabbedFullStatsMeta;
    import net.wg.gui.components.advanced.ContentTabBar;
    import net.wg.gui.battle.views.questProgress.interfaces.IQuestProgressViewOperationSelector;
    import flash.text.TextField;
    import net.wg.data.VO.daapi.DAAPIQuestStatusVO;
    import net.wg.gui.battle.views.questProgress.interfaces.IQuestProgressView;
    import net.wg.infrastructure.interfaces.IDAAPIDataClass;
    import net.wg.data.constants.Linkages;
    import scaleform.clik.events.IndexEvent;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.lobby.settings.vo.TabsDataVo;
    import net.wg.gui.battle.views.questProgress.events.QuestProgressTabEvent;
    import net.wg.gui.battle.views.questProgress.data.QPProgressTrackingVO;
    import net.wg.gui.battle.views.questProgress.data.QPTrackingDataItemVO;
    import net.wg.gui.battle.views.questProgress.data.QuestProgressPerformVO;
    import net.wg.data.constants.LobbyMetrics;

    public class TabbedFullStats extends TabbedFullStatsMeta implements ITabbedFullStatsMeta
    {

        private static const MIN_TABS_RENDERER_WIDTH:int = 134;

        private static const TABS_Y:int = 141;

        private static const TABS_SMALL_Y:int = 98;

        private static const NO_QUEST_TF_GAP:int = 12;

        private static const TITLE_SMALL_Y_SHIFT:int = 58;

        public var tabs:ContentTabBar = null;

        public var tabQuest:IQuestProgressViewOperationSelector = null;

        public var noQuestTitleTF:TextField = null;

        public var noQuestDescrTF:TextField = null;

        private var _currentMissionName:String = null;

        private var _lastSelectedTabIndex:int = 0;

        private var _questStatusData:DAAPIQuestStatusVO = null;

        private var _hasQuestToPerform:Boolean = false;

        public function TabbedFullStats()
        {
            super();
        }

        override public function getStatsProgressView() : IQuestProgressView
        {
            return this.tabQuest;
        }

        override public function setQuestStatus(param1:IDAAPIDataClass) : void
        {
            this._questStatusData = DAAPIQuestStatusVO(param1);
            if(visible)
            {
                this.updateCurrentTab();
            }
        }

        override public function updateStageSize(param1:Number, param2:Number) : void
        {
            super.updateStageSize(param1,param2);
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.tabs.itemRendererName = Linkages.CONTENT_TAB_RENDERER;
            this.tabs.minRendererWidth = MIN_TABS_RENDERER_WIDTH;
            this.tabs.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabsIndexChangeHandler);
            this.tabs.dataProvider = new DataProvider([new TabsDataVo({"label":INGAME_GUI.STATISTICS_TAB_LINE_UP_HEADER}),new TabsDataVo({"label":INGAME_GUI.STATISTICS_TAB_QUESTS_HEADER})]);
            if(this.tabQuest != null)
            {
                this.tabQuest.addEventListener(QuestProgressTabEvent.QUEST_SELECT,this.onProgressTrackingQuestSelectHandler);
            }
        }

        override protected function onDispose() : void
        {
            if(this.tabQuest != null)
            {
                this.tabQuest.removeEventListener(QuestProgressTabEvent.QUEST_SELECT,this.onProgressTrackingQuestSelectHandler);
                this.tabQuest.dispose();
                this.tabQuest = null;
            }
            this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabsIndexChangeHandler);
            this.tabs.dispose();
            this.tabs = null;
            this.noQuestTitleTF = null;
            this.noQuestDescrTF = null;
            this._questStatusData = null;
            super.onDispose();
        }

        override protected function updateProgressTracking(param1:QPProgressTrackingVO) : void
        {
            var _loc2_:QPTrackingDataItemVO = null;
            if(this.tabQuest != null)
            {
                this.tabQuest.updateProgressTracking(param1);
            }
            for each(_loc2_ in param1.trackingData)
            {
                if(_loc2_.selected)
                {
                    this._currentMissionName = _loc2_.fullMissionName;
                    break;
                }
            }
        }

        override protected function questProgressPerform(param1:QuestProgressPerformVO) : void
        {
            this.noQuestTitleTF.htmlText = param1.noQuestTitle;
            this.noQuestDescrTF.htmlText = param1.noQuestDescr;
            if(this._hasQuestToPerform != param1.hasQuestToPerform)
            {
                this._hasQuestToPerform = param1.hasQuestToPerform;
                this.updateCurrentTab();
            }
        }

        override protected function doUpdateSizeTop(param1:Number, param2:Number) : void
        {
            super.doUpdateSizeTop(param1,param2);
            this.tabs.y = param2 < MIN_HEIGHT?TABS_SMALL_Y:TABS_Y;
        }

        override protected function doUpdateSizeTable(param1:Number, param2:Number) : void
        {
            super.doUpdateSizeTable(param1,param2);
            if(this.tabQuest != null)
            {
                this.tabQuest.y = statsTable.y;
            }
            this.noQuestTitleTF.y = param2 - (this.noQuestTitleTF.height + this.noQuestTitleTF.height + NO_QUEST_TF_GAP) >> 1;
            this.noQuestDescrTF.y = this.noQuestTitleTF.y + this.noQuestTitleTF.height + NO_QUEST_TF_GAP | 0;
        }

        override protected function getTitleY() : int
        {
            var _loc1_:* = height - LobbyMetrics.MIN_STAGE_HEIGHT >> 2;
            return this.tabs.y + TITLE_SMALL_Y_SHIFT + _loc1_;
        }

        override protected function initTitle() : void
        {
        }

        override protected function setTitle() : void
        {
            title.setStatus(statsTable.visible || this._questStatusData == null?emptyStatusVO:this._questStatusData);
            if(statsTable.visible)
            {
                super.setTitle();
            }
            else
            {
                title.setTitle(this._currentMissionName);
            }
        }

        public function as_resetActiveTab() : void
        {
            this.tabs.selectedIndex = this._lastSelectedTabIndex;
        }

        public function as_setActiveTab(param1:Number) : void
        {
            this._lastSelectedTabIndex = this.tabs.selectedIndex;
            this.tabs.selectedIndex = param1;
        }

        private function updateCurrentTab() : void
        {
            statsTable.visible = this.tabs.selectedIndex == 0;
            var _loc1_:Boolean = !statsTable.visible && this._hasQuestToPerform;
            if(this.tabQuest != null)
            {
                this.tabQuest.visible = _loc1_;
            }
            var _loc2_:Boolean = statsTable.visible || _loc1_;
            title.visible = _loc2_;
            if(_loc2_)
            {
                this.setTitle();
            }
            this.noQuestTitleTF.visible = this.noQuestDescrTF.visible = !_loc2_;
        }

        override public function set visible(param1:Boolean) : void
        {
            if(param1 && title.visible)
            {
                title.validateNow();
            }
            super.visible = param1;
        }

        private function onTabsIndexChangeHandler(param1:IndexEvent) : void
        {
            this.updateCurrentTab();
        }

        private function onProgressTrackingQuestSelectHandler(param1:QuestProgressTabEvent) : void
        {
            onSelectQuestS(param1.questID);
        }
    }
}
