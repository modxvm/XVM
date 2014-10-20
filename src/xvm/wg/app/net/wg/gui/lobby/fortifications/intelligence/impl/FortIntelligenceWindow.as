package net.wg.gui.lobby.fortifications.intelligence.impl
{
    import net.wg.infrastructure.base.meta.impl.FortIntelligenceWindowMeta;
    import net.wg.infrastructure.base.meta.IFortIntelligenceWindowMeta;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import net.wg.gui.lobby.fortifications.intelligence.IFortIntelFilter;
    import net.wg.gui.components.controls.SortableTable;
    import net.wg.data.SortableVoDAAPIDataProvider;
    import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
    import net.wg.infrastructure.events.FocusRequestEvent;
    import flash.events.Event;
    import net.wg.gui.events.SortableTableListEvent;
    import flash.display.InteractiveObject;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.components.controls.NormalSortingBtnInfo;
    import scaleform.clik.data.DataProvider;
    import net.wg.data.constants.SortingInfo;
    import net.wg.gui.rally.data.ManualSearchDataProvider;
    import net.wg.gui.lobby.fortifications.data.IntelligenceRendererVO;
    
    public class FortIntelligenceWindow extends FortIntelligenceWindowMeta implements IFortIntelligenceWindowMeta
    {
        
        public function FortIntelligenceWindow()
        {
            super();
            isModal = false;
            isCentered = true;
            this.horSeparator.mouseEnabled = false;
            this.verSeparator.mouseEnabled = false;
            this.updateHeaderPosition();
            this.listDataProvider = new ManualSearchDataProvider(IntelligenceRendererVO);
        }
        
        public var horSeparator:MovieClip = null;
        
        public var verSeparator:MovieClip = null;
        
        public var statusTextField:TextField = null;
        
        public var intelFilter:IFortIntelFilter = null;
        
        public var intelligenceTable:SortableTable = null;
        
        public var clanDescription:FortIntelligenceClanDescription = null;
        
        protected var listDataProvider:SortableVoDAAPIDataProvider;
        
        override public function updateStage(param1:Number, param2:Number) : void
        {
            super.updateStage(param1,param2);
            this.updatePosition();
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            registerComponent(this.intelFilter,FORTIFICATION_ALIASES.FORT_INTEL_FILTER_ALIAS);
            registerComponent(this.clanDescription,FORTIFICATION_ALIASES.FORT_INTELLIGENCE_CLAN_DESCRIPTION);
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.updatePosition();
            window.title = FORTIFICATIONS.FORTINTELLIGENCE_WINDOWTITLE;
            addEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onFocusRequestHandler);
            this.initTable();
            this.statusTextField.visible = false;
            this.listDataProvider.addEventListener(Event.CHANGE,this.handleDataChanged);
            this.intelligenceTable.addEventListener(SortableTableListEvent.LIST_INDEX_CHANGE,this.onSelectClanFort);
        }
        
        override protected function onSetModalFocus(param1:InteractiveObject) : void
        {
            super.onSetModalFocus(param1);
        }
        
        override protected function onDispose() : void
        {
            removeEventListener(FocusRequestEvent.REQUEST_FOCUS,this.onFocusRequestHandler);
            this.listDataProvider.removeEventListener(Event.CHANGE,this.handleDataChanged);
            this.intelligenceTable.removeEventListener(SortableTableListEvent.LIST_INDEX_CHANGE,this.onSelectClanFort);
            this.intelFilter = null;
            this.horSeparator = null;
            this.verSeparator = null;
            this.clanDescription = null;
            this.statusTextField = null;
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.updateHeaderPosition();
                this.updatePosition();
            }
        }
        
        public function as_setData(param1:Array) : void
        {
        }
        
        public function as_setStatusText(param1:String) : void
        {
            this.statusTextField.htmlText = param1;
        }
        
        public function as_getSearchDP() : Object
        {
            return this.listDataProvider;
        }
        
        public function as_setClanFortInfo(param1:Object) : void
        {
            DebugUtils.LOG_DEBUG("some test data",param1);
        }
        
        public function as_getCurrentListIndex() : int
        {
            return this.intelligenceTable.listSelectedIndex;
        }
        
        private function updatePosition() : void
        {
            window.x = Math.floor(App.appWidth - window.width >> 1);
            window.y = Math.floor(App.appHeight - window.height >> 1);
        }
        
        private function updateHeaderPosition() : void
        {
        }
        
        private function viewBlockIsShown() : Boolean
        {
            return false;
        }
        
        private function initTable() : void
        {
            var _loc1_:NormalSortingBtnInfo = null;
            var _loc2_:Array = [];
            _loc1_ = new NormalSortingBtnInfo();
            _loc1_.label = getLevelColumnIconsS();
            _loc1_.buttonWidth = 64;
            _loc1_.sortOrder = 0;
            _loc1_.toolTip = TOOLTIPS.FORTIFICATION_INTELLIGENCEWINDOW_SORTBTN_LEVEL;
            _loc1_.iconId = "clanLvl";
            _loc2_.push(_loc1_);
            _loc1_ = new NormalSortingBtnInfo();
            _loc1_.label = FORTIFICATIONS.FORTINTELLIGENCE_SORTBTNS_CLANTAG;
            _loc1_.buttonWidth = 132;
            _loc1_.toolTip = TOOLTIPS.FORTIFICATION_INTELLIGENCEWINDOW_SORTBTN_CLANTAG;
            _loc1_.iconId = "clanTag";
            _loc1_.sortOrder = 1;
            _loc2_.push(_loc1_);
            _loc1_ = new NormalSortingBtnInfo();
            _loc1_.label = FORTIFICATIONS.FORTINTELLIGENCE_SORTBTNS_DEFENCETIME;
            _loc1_.toolTip = TOOLTIPS.FORTIFICATION_INTELLIGENCEWINDOW_SORTBTN_DEFENCETIME;
            _loc1_.buttonWidth = 203;
            _loc1_.iconId = "defenceStartTime";
            _loc1_.sortOrder = 2;
            _loc2_.push(_loc1_);
            _loc1_ = new NormalSortingBtnInfo();
            _loc1_.label = FORTIFICATIONS.FORTINTELLIGENCE_SORTBTNS_BUILDINGS;
            _loc1_.toolTip = TOOLTIPS.FORTIFICATION_INTELLIGENCEWINDOW_SORTBTN_BUILDINGS;
            _loc1_.buttonWidth = 195;
            _loc1_.iconId = "avgBuildingLvl";
            _loc1_.sortOrder = 3;
            _loc2_.push(_loc1_);
            this.intelligenceTable.listDP = this.listDataProvider;
            this.intelligenceTable.headerDP = new DataProvider(_loc2_);
            this.intelligenceTable.sortByField("clanTag",SortingInfo.ASCENDING_SORT);
        }
        
        private function onFocusRequestHandler(param1:FocusRequestEvent) : void
        {
            assertNotNull(param1.focusContainer.getComponentForFocus(),"intelFilter focus reference");
            if(!this.viewBlockIsShown())
            {
                setFocus(param1.focusContainer.getComponentForFocus());
            }
        }
        
        private function onSelectClanFort(param1:SortableTableListEvent) : void
        {
            requestClanFortInfoS(param1.index);
        }
        
        private function handleDataChanged(param1:Event) : void
        {
            this.intelligenceTable.visible = this.listDataProvider.length > 0;
            this.statusTextField.visible = !this.listDataProvider.length > 0;
        }
        
        public function as_selectByIndex(param1:int) : void
        {
            if(this.intelligenceTable.listSelectedIndex != param1)
            {
                this.intelligenceTable.listSelectedIndex = param1;
            }
        }
    }
}
