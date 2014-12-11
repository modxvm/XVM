package net.wg.gui.lobby.quests.views
{
    import net.wg.infrastructure.base.meta.impl.QuestsTileChainsViewMeta;
    import net.wg.infrastructure.base.meta.IQuestsTileChainsViewMeta;
    import net.wg.infrastructure.interfaces.IViewStackContent;
    import net.wg.infrastructure.interfaces.IFocusChainContainer;
    import net.wg.gui.lobby.quests.components.QuestsTileChainsViewHeader;
    import net.wg.gui.lobby.quests.components.QuestsTileChainsViewFilters;
    import net.wg.gui.components.controls.ScrollingListEx;
    import net.wg.gui.components.controls.ScrollBar;
    import flash.text.TextField;
    import net.wg.gui.components.advanced.ViewStack;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.quests.data.questsTileChains.QuestsTileChainsViewVO;
    import net.wg.gui.lobby.quests.data.ChainProgressVO;
    import net.wg.gui.lobby.quests.data.questsTileChains.QuestTaskDetailsVO;
    import flash.display.InteractiveObject;
    import net.wg.gui.lobby.quests.data.questsTileChains.QuestTileVO;
    import net.wg.gui.lobby.quests.data.questsTileChains.QuestChainVO;
    import net.wg.gui.lobby.quests.data.questsTileChains.QuestTaskVO;
    import net.wg.gui.lobby.quests.data.questsTileChains.QuestTaskListRendererVO;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.lobby.quests.events.QuestsTileChainViewFiltersEvent;
    import net.wg.gui.events.ListEventEx;
    import net.wg.data.constants.Linkages;
    import net.wg.infrastructure.events.FocusChainChangeEvent;
    import net.wg.gui.events.ViewStackEvent;
    import net.wg.gui.lobby.quests.events.ChainProgressEvent;
    import net.wg.gui.lobby.quests.events.QuestTaskDetailsViewEvent;
    import net.wg.gui.lobby.quests.events.QuestsTileChainViewHeaderEvent;
    
    public class QuestsTileChainsView extends QuestsTileChainsViewMeta implements IQuestsTileChainsViewMeta, IViewStackContent, IFocusChainContainer
    {
        
        public function QuestsTileChainsView()
        {
            super();
            this.taskFilters.addEventListener(QuestsTileChainViewFiltersEvent.FILTERS_CHANGED,this.onFiltersChanged);
            this.taskDetailsViewStack.addEventListener(ViewStackEvent.NEED_UPDATE,this.onViewNeedUpdate);
            this.tasksScrollingList.addEventListener(ListEventEx.ITEM_CLICK,this.onListItemSelected);
            this.header.addEventListener(QuestsTileChainViewHeaderEvent.BACK_BUTTON_PRESS,this.onBack);
        }
        
        public var header:QuestsTileChainsViewHeader;
        
        public var taskFilters:QuestsTileChainsViewFilters;
        
        public var tasksScrollingList:ScrollingListEx;
        
        public var tasksScrollBar:ScrollBar;
        
        public var itemTitleTf:TextField;
        
        public var taskDetailsViewStack:ViewStack;
        
        public var filtersHeaderDelimiter:MovieClip;
        
        public var filtersListDelimiter:MovieClip;
        
        public var detailsDelimiter:MovieClip;
        
        public var noTasksLabel:TextField;
        
        public var delimiterHitArea:MovieClip;
        
        private var _headerData:QuestsTileChainsViewVO;
        
        private var _chainsProgressModel:ChainProgressVO = null;
        
        private var _taskDetailsModel:QuestTaskDetailsVO = null;
        
        private var _isUpdateTileDataScheduled:Boolean = false;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.filtersHeaderDelimiter.hitArea = this.delimiterHitArea;
            this.filtersListDelimiter.hitArea = this.delimiterHitArea;
            this.detailsDelimiter.hitArea = this.delimiterHitArea;
        }
        
        public function canShowAutomatically() : Boolean
        {
            return true;
        }
        
        public function update(param1:Object) : void
        {
        }
        
        public function getComponentForFocus() : InteractiveObject
        {
            return this;
        }
        
        override protected function setHeaderData(param1:QuestsTileChainsViewVO) : void
        {
            if(this._headerData != null)
            {
                this._headerData.dispose();
            }
            this._headerData = param1;
            this.header.setData(this._headerData.header);
            this.taskFilters.setData(this._headerData.filters);
            this.noTasksLabel.htmlText = this._headerData.noTasksText;
        }
        
        override protected function updateTileData(param1:QuestTileVO) : void
        {
            if(param1 != null)
            {
                this.updateTileView(param1);
            }
        }
        
        private function updateTileView(param1:QuestTileVO) : void
        {
            var _loc5_:QuestChainVO = null;
            var _loc6_:QuestTaskVO = null;
            if(this.tasksScrollingList.canCleanDataProvider)
            {
                this.tasksScrollingList.dataProvider.cleanUp();
            }
            var _loc2_:Array = [];
            var _loc3_:QuestTaskListRendererVO = new QuestTaskListRendererVO(QuestTaskListRendererVO.STATISTICS,param1.statistics,param1.statistics.tooltip);
            _loc2_.push(_loc3_);
            var _loc4_:Boolean = param1.hasTasks();
            if(_loc4_)
            {
                for each(_loc5_ in param1.chains)
                {
                    if(_loc5_.tasks.length > 0)
                    {
                        _loc2_.push(new QuestTaskListRendererVO(QuestTaskListRendererVO.CHAIN,_loc5_));
                        for each(_loc6_ in _loc5_.tasks)
                        {
                            _loc2_.push(new QuestTaskListRendererVO(QuestTaskListRendererVO.TASK,_loc6_,_loc6_.tooltip));
                        }
                    }
                }
            }
            else
            {
                this.taskDetailsViewStack.visible = false;
            }
            this.tasksScrollingList.dataProvider = new DataProvider(_loc2_);
            this.noTasksLabel.visible = !_loc4_;
        }
        
        public function as_setSelectedTask(param1:Number) : void
        {
            var _loc2_:QuestTaskListRendererVO = null;
            _loc2_ = null;
            var _loc3_:* = 0;
            while(_loc3_ < this.tasksScrollingList.dataProvider.length)
            {
                _loc2_ = this.tasksScrollingList.dataProvider.requestItemAt(_loc3_) as QuestTaskListRendererVO;
                App.utils.asserter.assertNotNull(_loc2_,"item must be QuestTaskListRendererVO");
                if(_loc2_.type == QuestTaskListRendererVO.TASK)
                {
                    if(_loc2_.taskData.id == param1)
                    {
                        this.tasksScrollingList.selectedIndex = _loc3_;
                        this.showDetails(_loc2_);
                        return;
                    }
                }
                _loc3_++;
            }
            this.scheduleUpdateTileData();
        }
        
        private function scheduleUpdateTileData() : void
        {
            if(!this._isUpdateTileDataScheduled)
            {
                App.utils.scheduler.envokeInNextFrame(this.requestTileData);
                this._isUpdateTileDataScheduled = true;
            }
        }
        
        private function requestTileData() : void
        {
            this._isUpdateTileDataScheduled = false;
            var _loc1_:Boolean = this.taskFilters.hideCompletedTasks.selected;
            var _loc2_:int = this.taskFilters.selectedVehicleType;
            var _loc3_:String = this.taskFilters.selectedTaskType;
            App.utils.asserter.assertNotNull(_loc3_,"Selected taskType can not be null!");
            getTileDataS(_loc2_,_loc3_,_loc1_);
        }
        
        private function onFiltersChanged(param1:QuestsTileChainViewFiltersEvent) : void
        {
            this.scheduleUpdateTileData();
        }
        
        private function showDetails(param1:QuestTaskListRendererVO) : void
        {
            if(param1.type == QuestTaskListRendererVO.STATISTICS)
            {
                getChainProgressS();
            }
            else if(param1.type == QuestTaskListRendererVO.TASK)
            {
                getTaskDetailsS(param1.taskData.id);
            }
            else
            {
                App.utils.asserter.assert(false,"View type " + param1.type + " is not supported");
            }
            
        }
        
        private function onListItemSelected(param1:ListEventEx) : void
        {
            var _loc2_:QuestTaskListRendererVO = param1.itemData as QuestTaskListRendererVO;
            App.utils.asserter.assertNotNull(_loc2_,"Cant recognize item data type");
            this.showDetails(_loc2_);
        }
        
        override protected function updateChainProgress(param1:ChainProgressVO) : void
        {
            this.taskDetailsViewStack.visible = true;
            this.tasksScrollingList.selectedIndex = 0;
            if(this._chainsProgressModel != param1)
            {
                this._chainsProgressModel = param1;
            }
            if(this.taskDetailsViewStack.currentLinkage != Linkages.QUESTS_CHAIN_PROGRESS_VIEW)
            {
                this.taskDetailsViewStack.show(Linkages.QUESTS_CHAIN_PROGRESS_VIEW);
            }
            IViewStackContent(this.taskDetailsViewStack.currentView).update(this._chainsProgressModel);
        }
        
        override protected function updateTaskDetails(param1:QuestTaskDetailsVO) : void
        {
            this.taskDetailsViewStack.visible = true;
            if(this._taskDetailsModel != param1)
            {
                this._taskDetailsModel = param1;
            }
            if(this.taskDetailsViewStack.currentLinkage != Linkages.QUEST_TASK_DETAILS_VIEW)
            {
                this.taskDetailsViewStack.show(Linkages.QUEST_TASK_DETAILS_VIEW);
                dispatchEvent(new FocusChainChangeEvent(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE));
            }
            IViewStackContent(this.taskDetailsViewStack.currentView).update(this._taskDetailsModel);
        }
        
        private function onViewNeedUpdate(param1:ViewStackEvent) : void
        {
            if(param1.linkage == Linkages.QUESTS_CHAIN_PROGRESS_VIEW)
            {
                param1.view.update(this._chainsProgressModel);
                addEventListener(ChainProgressEvent.SHOW_VEHICLE_INFO,this.onShowVehicleInfoHandler);
                addEventListener(ChainProgressEvent.SHOW_VEHICLE_IN_HANGAR,this.onShowVehicleInHangarHandler);
                removeEventListener(QuestTaskDetailsViewEvent.SELECT_TASK,this.onSelectTaskHandler);
                removeEventListener(QuestTaskDetailsViewEvent.CANCEL_TASK,this.onCancelTaskHandler);
            }
            else if(param1.linkage == Linkages.QUEST_TASK_DETAILS_VIEW)
            {
                param1.view.update(this._taskDetailsModel);
                addEventListener(QuestTaskDetailsViewEvent.SELECT_TASK,this.onSelectTaskHandler);
                addEventListener(QuestTaskDetailsViewEvent.CANCEL_TASK,this.onCancelTaskHandler);
                removeEventListener(ChainProgressEvent.SHOW_VEHICLE_INFO,this.onShowVehicleInfoHandler);
                removeEventListener(ChainProgressEvent.SHOW_VEHICLE_IN_HANGAR,this.onShowVehicleInHangarHandler);
            }
            else
            {
                App.utils.asserter.assert(false,param1.linkage + " is not supported!");
                removeEventListener(ChainProgressEvent.SHOW_VEHICLE_INFO,this.onShowVehicleInfoHandler);
                removeEventListener(ChainProgressEvent.SHOW_VEHICLE_IN_HANGAR,this.onShowVehicleInHangarHandler);
            }
            
        }
        
        private function onBack(param1:QuestsTileChainViewHeaderEvent) : void
        {
            gotoBackS();
        }
        
        override protected function onDispose() : void
        {
            this.taskFilters.removeEventListener(QuestsTileChainViewFiltersEvent.FILTERS_CHANGED,this.onFiltersChanged);
            this.tasksScrollingList.removeEventListener(ListEventEx.ITEM_CLICK,this.onListItemSelected);
            this.taskDetailsViewStack.removeEventListener(ViewStackEvent.NEED_UPDATE,this.onViewNeedUpdate);
            this.header.removeEventListener(QuestsTileChainViewHeaderEvent.BACK_BUTTON_PRESS,this.onBack);
            removeEventListener(ChainProgressEvent.SHOW_VEHICLE_INFO,this.onShowVehicleInfoHandler);
            removeEventListener(ChainProgressEvent.SHOW_VEHICLE_IN_HANGAR,this.onShowVehicleInHangarHandler);
            removeEventListener(QuestTaskDetailsViewEvent.SELECT_TASK,this.onSelectTaskHandler);
            removeEventListener(QuestTaskDetailsViewEvent.CANCEL_TASK,this.onCancelTaskHandler);
            this.header.dispose();
            this.taskFilters.dispose();
            this.tasksScrollingList.dispose();
            this.tasksScrollBar.dispose();
            this.taskDetailsViewStack.dispose();
            this.filtersHeaderDelimiter.hitArea = null;
            this.filtersListDelimiter.hitArea = null;
            this.detailsDelimiter.hitArea = null;
            this.header = null;
            this.taskFilters = null;
            this.tasksScrollingList = null;
            this.tasksScrollBar = null;
            this.itemTitleTf = null;
            this.taskDetailsViewStack = null;
            this.filtersHeaderDelimiter = null;
            this.filtersListDelimiter = null;
            this.detailsDelimiter = null;
            this.noTasksLabel = null;
            this.delimiterHitArea = null;
            if(this._headerData != null)
            {
                this._headerData.dispose();
                this._headerData = null;
            }
            if(this._chainsProgressModel)
            {
                this._chainsProgressModel.dispose();
                this._chainsProgressModel = null;
            }
            if(this._taskDetailsModel)
            {
                this._taskDetailsModel.dispose();
                this._taskDetailsModel = null;
            }
            super.onDispose();
        }
        
        private function onShowVehicleInfoHandler(param1:ChainProgressEvent) : void
        {
            showAwardVehicleInfoS(param1.awardVehicleID);
        }
        
        private function onShowVehicleInHangarHandler(param1:ChainProgressEvent) : void
        {
            showAwardVehicleInHangarS(param1.awardVehicleID);
        }
        
        public function getFocusChain() : Array
        {
            var _loc1_:Array = [this.header.backBtn];
            _loc1_ = _loc1_.concat(this.taskFilters.getFocusChain());
            _loc1_.push(this.tasksScrollingList);
            if(this.taskDetailsViewStack.currentView is IFocusChainContainer)
            {
                _loc1_ = _loc1_.concat(IFocusChainContainer(this.taskDetailsViewStack.currentView).getFocusChain());
            }
            return _loc1_;
        }
        
        private function onSelectTaskHandler(param1:QuestTaskDetailsViewEvent) : void
        {
            selectTaskS(param1.taskID);
        }
        
        private function onCancelTaskHandler(param1:QuestTaskDetailsViewEvent) : void
        {
            refuseTaskS(param1.taskID);
        }
    }
}
