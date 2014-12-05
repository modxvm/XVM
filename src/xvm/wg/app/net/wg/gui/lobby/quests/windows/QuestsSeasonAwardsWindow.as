package net.wg.gui.lobby.quests.windows
{
    import net.wg.infrastructure.base.meta.impl.QuestsSeasonAwardsWindowMeta;
    import net.wg.infrastructure.base.meta.IQuestsSeasonAwardsWindowMeta;
    import net.wg.gui.components.controls.ScrollPane;
    import net.wg.gui.components.controls.ScrollBar;
    import net.wg.gui.lobby.quests.components.SeasonAwardsBlocksContainer;
    import net.wg.gui.lobby.quests.data.seasonAwards.SeasonAwardsVO;
    import flash.geom.Rectangle;
    import net.wg.gui.components.controls.events.ScrollPaneEvent;
    import flash.events.Event;
    import net.wg.gui.lobby.quests.data.seasonAwards.BaseSeasonAwardVO;
    import net.wg.gui.lobby.quests.components.SeasonAward;
    import flash.display.DisplayObject;
    import flash.display.InteractiveObject;
    import net.wg.gui.lobby.quests.components.VehicleSeasonAward;
    import net.wg.data.constants.Linkages;
    import net.wg.gui.lobby.quests.components.IconTitleDescSeasonAward;
    import net.wg.data.constants.generated.QUESTS_SEASON_AWARDS_TYPES;
    
    public class QuestsSeasonAwardsWindow extends QuestsSeasonAwardsWindowMeta implements IQuestsSeasonAwardsWindowMeta
    {
        
        public function QuestsSeasonAwardsWindow()
        {
            super();
        }
        
        private static var SCROLL_PANE_STEP_FACTOR:int = 20;
        
        public var scrollPane:ScrollPane;
        
        public var scrollBar:ScrollBar;
        
        public var blocksContainer:SeasonAwardsBlocksContainer;
        
        private var _data:SeasonAwardsVO;
        
        private var _tabItems:Array;
        
        private var _bounds:Rectangle;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.scrollPane.scrollStepFactor = SCROLL_PANE_STEP_FACTOR;
            this.scrollPane.setSize(width,height);
            this.scrollPane.target = this.blocksContainer;
            this.scrollPane.addEventListener(ScrollPaneEvent.POSITION_CHANGED,this.onScrollPanePositionChanged);
            this.blocksContainer.addEventListener(Event.RESIZE,this.onContainerResize);
            this._bounds = new Rectangle(0.0,0.0,width,height);
        }
        
        private function onScrollPanePositionChanged(param1:ScrollPaneEvent) : void
        {
            this.updateTabIndexes();
        }
        
        private function onContainerResize(param1:Event) : void
        {
            this.scrollPane.invalidateSize();
            this.updateTabIndexes();
        }
        
        override protected function setData(param1:SeasonAwardsVO) : void
        {
            var _loc2_:BaseSeasonAwardVO = null;
            var _loc3_:SeasonAward = null;
            this._data = param1;
            if(this._data != null)
            {
                window.title = this._data.windowTitle;
                this.blocksContainer.setBasicAwardsBlockTitle(this._data.basicAwardsTitle);
                this.blocksContainer.setExtraAwardsBlockTitle(this._data.extraAwardsTitle);
                for each(_loc2_ in this._data.basicAwards)
                {
                    _loc3_ = this.createAwardItem(_loc2_);
                    this.blocksContainer.addBasicAward(_loc3_);
                }
                for each(_loc2_ in this._data.extraAwards)
                {
                    _loc3_ = this.createAwardItem(_loc2_);
                    this.blocksContainer.addExtraAward(_loc3_);
                }
                this._tabItems = this.blocksContainer.getTabIndexItems();
            }
        }
        
        private function resetTabIndexes(param1:Array) : void
        {
            var _loc2_:DisplayObject = null;
            for each(_loc2_ in param1)
            {
                InteractiveObject(_loc2_).tabIndex = -1;
            }
        }
        
        private function cutUnvisibleControls(param1:Array) : Array
        {
            var _loc3_:DisplayObject = null;
            var _loc4_:Rectangle = null;
            var _loc2_:Array = new Array();
            for each(_loc3_ in param1)
            {
                _loc4_ = _loc3_.getBounds(this);
                if(this._bounds.containsRect(_loc4_))
                {
                    _loc2_.push(_loc3_);
                }
            }
            return _loc2_;
        }
        
        private function updateTabIndexes() : void
        {
            var _loc1_:Array = null;
            if(this._tabItems != null)
            {
                this.resetTabIndexes(this._tabItems);
                _loc1_ = [window.getCloseBtn()];
                _loc1_ = _loc1_.concat(this.cutUnvisibleControls(this._tabItems));
                App.utils.commons.initTabIndex(_loc1_);
            }
        }
        
        private function createAwardItem(param1:BaseSeasonAwardVO) : SeasonAward
        {
            var _loc2_:SeasonAward = null;
            var _loc3_:VehicleSeasonAward = null;
            switch(param1.type)
            {
                case QUESTS_SEASON_AWARDS_TYPES.VEHICLE:
                    _loc3_ = App.utils.classFactory.getComponent(Linkages.VEHICLE_SEASON_AWARD,VehicleSeasonAward);
                    _loc3_.buttonAboutCallback = showVehicleInfoS;
                    _loc2_ = _loc3_;
                    break;
                case QUESTS_SEASON_AWARDS_TYPES.FEMALE_TANKMAN:
                    _loc2_ = App.utils.classFactory.getComponent(Linkages.FEMALE_TANKMAN_SEASON_AWARD,IconTitleDescSeasonAward);
                    break;
                case QUESTS_SEASON_AWARDS_TYPES.COMMENDATION_LISTS:
                    _loc2_ = App.utils.classFactory.getComponent(Linkages.COMMENDATION_LISTS_SEASON_AWARD,IconTitleDescSeasonAward);
                    break;
            }
            App.utils.asserter.assertNotNull(_loc2_,"Can\'t create item for type of basic award : " + param1.type);
            _loc2_.setData(param1);
            return _loc2_;
        }
        
        override protected function onDispose() : void
        {
            this.blocksContainer.removeEventListener(Event.RESIZE,this.onContainerResize);
            if(this.scrollPane.target != this.blocksContainer)
            {
                this.blocksContainer.dispose();
            }
            this.blocksContainer = null;
            this.scrollPane.removeEventListener(ScrollPaneEvent.POSITION_CHANGED,this.onScrollPanePositionChanged);
            this.scrollPane.dispose();
            this.scrollPane = null;
            this.scrollBar.dispose();
            this.scrollBar = null;
            if(this._data != null)
            {
                this._data.dispose();
                this._data = null;
            }
            if(this._tabItems != null)
            {
                this._tabItems.splice(0);
                this._tabItems = null;
            }
            this._bounds = null;
            super.onDispose();
        }
    }
}
