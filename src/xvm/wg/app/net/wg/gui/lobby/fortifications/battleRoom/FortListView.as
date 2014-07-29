package net.wg.gui.lobby.fortifications.battleRoom
{
    import net.wg.infrastructure.base.meta.impl.FortListMeta;
    import net.wg.infrastructure.base.meta.IFortListMeta;
    import flash.text.TextField;
    import net.wg.gui.components.controls.DropdownMenu;
    import net.wg.gui.components.controls.InfoIcon;
    import net.wg.data.daapi.base.DAAPIDataProvider;
    import net.wg.gui.rally.interfaces.IRallyVO;
    import net.wg.gui.rally.vo.RallyShortVO;
    import net.wg.data.constants.Tooltips;
    import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
    import scaleform.clik.events.ListEvent;
    import flash.events.MouseEvent;
    import net.wg.gui.events.SortableTableListEvent;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.components.controls.NormalSortingBtnInfo;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.data.DataProvider;
    import net.wg.data.constants.SortingInfo;
    import net.wg.gui.rally.data.ManualSearchDataProvider;
    import net.wg.gui.lobby.fortifications.data.sortie.SortieRenderVO;
    
    public class FortListView extends FortListMeta implements IFortListMeta
    {
        
        public function FortListView()
        {
            super();
            backBtn.UIID = 31;
            createBtn.UIID = 32;
            this.filterDivision.UIID = 50;
            listDataProvider = new ManualSearchDataProvider(SortieRenderVO);
            this.divisionsDP = new DAAPIDataProvider();
        }
        
        public var searchResultsTF:TextField;
        
        public var filterTF:TextField;
        
        public var filterDivision:DropdownMenu;
        
        public var filterInfo:InfoIcon;
        
        private var divisionsDP:DAAPIDataProvider = null;
        
        private var filterIndexChanging:Boolean = false;
        
        public function as_getDivisionsDP() : Object
        {
            return this.divisionsDP;
        }
        
        public function as_setSelectedDivision(param1:int) : void
        {
            this.filterIndexChanging = true;
            this.filterDivision.selectedIndex = param1;
            this.filterIndexChanging = false;
        }
        
        public function as_setDetails(param1:Object) : void
        {
            if(param1 == null)
            {
                return;
            }
            detailsSection.setData(this.convertToRallyVO(param1));
        }
        
        public function as_setCreationEnabled(param1:Boolean) : void
        {
            createBtn.enabled = param1;
        }
        
        override protected function convertToRallyVO(param1:Object) : IRallyVO
        {
            return new RallyShortVO(param1);
        }
        
        override protected function getRallyTooltipLinkage() : String
        {
            return Tooltips.CYBER_SPORT_TEAM;
        }
        
        override protected function getRallyViewAlias() : String
        {
            return FORTIFICATION_ALIASES.FORT_BATTLE_ROOM_VIEW_UI;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.initListColumns();
            createBtn.label = FORTIFICATIONS.SORTIE_LISTVIEW_CREATE;
            titleLbl.text = FORTIFICATIONS.SORTIE_LISTVIEW_TITLE;
            descrLbl.htmlText = FORTIFICATIONS.SORTIE_LISTVIEW_DESCRIPTION;
            this.searchResultsTF.text = FORTIFICATIONS.SORTIE_LISTVIEW_LISTTITLE;
            this.filterTF.text = FORTIFICATIONS.SORTIE_LISTVIEW_FILTER;
            this.filterDivision.dataProvider = this.divisionsDP;
            this.filterDivision.addEventListener(ListEvent.INDEX_CHANGE,this.onFilterChange);
            if(this.filterInfo)
            {
                this.filterInfo.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
                this.filterInfo.addEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            }
        }
        
        override protected function onDispose() : void
        {
            this.filterDivision.removeEventListener(ListEvent.INDEX_CHANGE,this.onFilterChange);
            if(this.filterInfo)
            {
                this.filterInfo.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
                this.filterInfo.removeEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            }
            this.divisionsDP = null;
            super.onDispose();
        }
        
        override protected function coolDownControls(param1:Boolean, param2:int) : void
        {
            super.coolDownControls(param1,param2);
        }
        
        override protected function onItemRollOver(param1:SortableTableListEvent) : void
        {
            App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_SORTIE_LISTROOM_RENDERERINFO);
        }
        
        override protected function onBackClickHandler(param1:ButtonEvent) : void
        {
            super.onBackClickHandler(param1);
            App.eventLogManager.logUIEvent(param1,0);
        }
        
        override protected function onCreateClick(param1:ButtonEvent) : void
        {
            super.onCreateClick(param1);
            App.eventLogManager.logUIEvent(param1,0);
        }
        
        override protected function onControlRollOver(param1:MouseEvent) : void
        {
            switch(param1.currentTarget)
            {
                case this.filterInfo:
                    App.toolTipMgr.showSpecial(Tooltips.SORTIE_DIVISION,null);
                    break;
                case backBtn:
                    App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_LISTROOM_BACK);
                    break;
                case createBtn:
                    App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_LISTROOM_CREATEBTN);
                    break;
            }
        }
        
        private function initListColumns() : void
        {
            var _loc1_:NormalSortingBtnInfo = null;
            var _loc2_:Array = [];
            _loc1_ = new NormalSortingBtnInfo();
            _loc1_.label = FORTIFICATIONS.SORTIE_LISTVIEW_LISTCOLUMNS_NAME;
            _loc1_.buttonWidth = 332;
            _loc1_.textAlign = TextFieldAutoSize.LEFT;
            _loc1_.iconId = "creatorName";
            _loc2_.push(_loc1_);
            _loc1_ = new NormalSortingBtnInfo();
            _loc1_.label = FORTIFICATIONS.SORTIE_LISTVIEW_LISTCOLUMNS_DIVISION;
            _loc1_.buttonWidth = 115;
            _loc1_.iconId = "description";
            _loc2_.push(_loc1_);
            _loc1_ = new NormalSortingBtnInfo();
            _loc1_.label = FORTIFICATIONS.SORTIE_LISTVIEW_LISTCOLUMNS_MEMBERSCOUNT;
            _loc1_.buttonWidth = 130;
            _loc1_.iconId = "playersCount";
            _loc2_.push(_loc1_);
            rallyTable.headerDP = new DataProvider(_loc2_);
            rallyTable.sortByField("creatorName",SortingInfo.ASCENDING_SORT);
        }
        
        private function onFilterChange(param1:ListEvent) : void
        {
            if(!this.filterIndexChanging)
            {
                App.eventLogManager.logUIEvent(param1,param1.index);
            }
            changeDivisionIndex(param1.index);
        }
    }
}
