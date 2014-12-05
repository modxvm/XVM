package net.wg.gui.lobby.fortifications.intelligence.impl
{
    import net.wg.infrastructure.base.meta.impl.FortIntelligenceWindowMeta;
    import net.wg.infrastructure.base.meta.IFortIntelligenceWindowMeta;
    import net.wg.gui.components.controls.NormalSortingBtnInfo;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import net.wg.gui.lobby.fortifications.intelligence.IFortIntelFilter;
    import net.wg.gui.components.controls.SortableTable;
    import net.wg.gui.rally.data.ManualSearchDataProvider;
    import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
    import net.wg.infrastructure.events.FocusRequestEvent;
    import flash.events.Event;
    import net.wg.gui.events.SortableTableListEvent;
    import flash.display.InteractiveObject;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.data.DataProvider;
    import net.wg.data.constants.SortingInfo;
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
        
        private static function createTableBtnInfo(param1:String, param2:String, param3:Number, param4:Number, param5:String) : NormalSortingBtnInfo
        {
            var _loc6_:NormalSortingBtnInfo = new NormalSortingBtnInfo();
            _loc6_.label = param1;
            _loc6_.buttonWidth = param3;
            _loc6_.sortOrder = param4;
            _loc6_.toolTip = param5;
            _loc6_.iconId = param2;
            return _loc6_;
        }
        
        public var horSeparator:MovieClip = null;
        
        public var verSeparator:MovieClip = null;
        
        public var statusTextField:TextField = null;
        
        public var intelFilter:IFortIntelFilter = null;
        
        public var intelligenceTable:SortableTable = null;
        
        public var clanDescription:FortIntelligenceClanDescription = null;
        
        private var listDataProvider:ManualSearchDataProvider;
        
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
            var _loc1_:Array = [];
            _loc1_.push(createTableBtnInfo(getLevelColumnIconsS(),"clanLvl",64,0,TOOLTIPS.FORTIFICATION_INTELLIGENCEWINDOW_SORTBTN_LEVEL));
            _loc1_.push(createTableBtnInfo(FORTIFICATIONS.FORTINTELLIGENCE_SORTBTNS_CLANTAG,"clanTag",132,1,TOOLTIPS.FORTIFICATION_INTELLIGENCEWINDOW_SORTBTN_CLANTAG));
            _loc1_.push(createTableBtnInfo(FORTIFICATIONS.FORTINTELLIGENCE_SORTBTNS_DEFENCETIME,"defenceStartTime",203,2,TOOLTIPS.FORTIFICATION_INTELLIGENCEWINDOW_SORTBTN_DEFENCETIME));
            _loc1_.push(createTableBtnInfo(FORTIFICATIONS.FORTINTELLIGENCE_SORTBTNS_BUILDINGS,"avgBuildingLvl",195,3,TOOLTIPS.FORTIFICATION_INTELLIGENCEWINDOW_SORTBTN_BUILDINGS));
            this.intelligenceTable.listDP = this.listDataProvider;
            this.intelligenceTable.headerDP = new DataProvider(_loc1_);
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
