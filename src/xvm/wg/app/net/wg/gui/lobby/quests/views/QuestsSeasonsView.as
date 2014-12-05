package net.wg.gui.lobby.quests.views
{
    import net.wg.infrastructure.base.meta.impl.QuestsSeasonsViewMeta;
    import net.wg.infrastructure.base.meta.IQuestsSeasonsViewMeta;
    import net.wg.infrastructure.interfaces.IViewStackContent;
    import net.wg.gui.components.controls.ResizableScrollPane;
    import net.wg.gui.lobby.quests.components.SeasonsListView;
    import net.wg.gui.lobby.quests.components.SlotsPanel;
    import flash.display.MovieClip;
    import flash.display.InteractiveObject;
    import net.wg.gui.lobby.quests.data.SeasonVO;
    import net.wg.gui.lobby.quests.data.QuestSlotVO;
    import net.wg.data.constants.Linkages;
    import net.wg.gui.lobby.quests.events.PersonalQuestEvent;
    
    public class QuestsSeasonsView extends QuestsSeasonsViewMeta implements IQuestsSeasonsViewMeta, IViewStackContent
    {
        
        public function QuestsSeasonsView()
        {
            super();
            this.separator.mouseChildren = this.separator.mouseEnabled = false;
        }
        
        private static var PANE_WIDTH:Number = 1012;
        
        private static var PANE_HEIGHT:Number = 448;
        
        private static var SCROLL_STEP_FACTOR:Number = 10;
        
        private static var SCROLL_BAR_MARGIN:Number = 10;
        
        public var scrollPane:ResizableScrollPane;
        
        public var seasonsList:SeasonsListView;
        
        public var slotsPanel:SlotsPanel;
        
        public var separator:MovieClip;
        
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
        
        public function as_setSeasonsData(param1:Array) : void
        {
            var _loc2_:SeasonVO = null;
            var _loc3_:Array = [];
            var _loc4_:* = 0;
            while(_loc4_ < param1.length)
            {
                _loc2_ = new SeasonVO(param1[_loc4_]);
                _loc3_.push(_loc2_);
                _loc4_++;
            }
            this.seasonsList.dataProvider = _loc3_;
        }
        
        public function as_setSlotsData(param1:Array) : void
        {
            var _loc2_:QuestSlotVO = null;
            var _loc3_:Array = [];
            var _loc4_:* = 0;
            while(_loc4_ < param1.length)
            {
                _loc2_ = new QuestSlotVO(param1[_loc4_]);
                _loc3_.push(_loc2_);
                _loc4_++;
            }
            this.slotsPanel.dataProvider = _loc3_;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.scrollPane.scrollStepFactor = SCROLL_STEP_FACTOR;
            this.scrollPane.scrollBarMargin = SCROLL_BAR_MARGIN;
            this.scrollPane.scrollBar = Linkages.SCROLL_BAR;
            this.scrollPane.setSize(PANE_WIDTH,PANE_HEIGHT);
            this.seasonsList = this.scrollPane.target as SeasonsListView;
            addEventListener(PersonalQuestEvent.SHOW_SEASON_AWARDS,this.showSeasonAwardsHandler);
            addEventListener(PersonalQuestEvent.TILE_CLICK,this.tileClickHandler);
            addEventListener(PersonalQuestEvent.SLOT_CLICK,this.slotClickHandler);
        }
        
        override protected function onDispose() : void
        {
            removeEventListener(PersonalQuestEvent.SHOW_SEASON_AWARDS,this.showSeasonAwardsHandler);
            removeEventListener(PersonalQuestEvent.TILE_CLICK,this.tileClickHandler);
            removeEventListener(PersonalQuestEvent.SLOT_CLICK,this.slotClickHandler);
            this.seasonsList = null;
            this.separator = null;
            this.scrollPane.dispose();
            this.scrollPane = null;
            this.slotsPanel.dispose();
            this.slotsPanel = null;
            super.onDispose();
        }
        
        private function slotClickHandler(param1:PersonalQuestEvent) : void
        {
            onSlotClickS(param1.data);
        }
        
        private function tileClickHandler(param1:PersonalQuestEvent) : void
        {
            onTileClickS(param1.data);
        }
        
        private function showSeasonAwardsHandler(param1:PersonalQuestEvent) : void
        {
            onShowAwardsClickS(param1.data);
        }
    }
}
