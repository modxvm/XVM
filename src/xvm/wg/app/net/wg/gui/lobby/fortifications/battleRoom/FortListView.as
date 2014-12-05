package net.wg.gui.lobby.fortifications.battleRoom
{
    import net.wg.infrastructure.base.meta.impl.FortListMeta;
    import net.wg.infrastructure.base.meta.IFortListMeta;
    import net.wg.gui.components.controls.NormalSortingBtnInfo;
    import flash.text.TextField;
    import net.wg.gui.components.controls.DropdownMenu;
    import net.wg.gui.components.controls.InfoIcon;
    import net.wg.data.daapi.base.DAAPIDataProvider;
    import net.wg.gui.rally.interfaces.IRallyVO;
    import net.wg.gui.lobby.fortifications.data.battleRoom.LegionariesSortieVO;
    import net.wg.data.constants.Tooltips;
    import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
    import scaleform.clik.events.ListEvent;
    import flash.events.MouseEvent;
    import net.wg.gui.events.SortableTableListEvent;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.data.DataProvider;
    import net.wg.data.constants.SortingInfo;
    import net.wg.gui.rally.data.ManualSearchDataProvider;
    import net.wg.gui.lobby.fortifications.data.sortie.SortieRenderVO;
    import scaleform.gfx.TextFieldEx;
    
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
            TextFieldEx.setVerticalAlign(this.textMessage,TextFieldEx.VALIGN_CENTER);
            this.textMessage.text = FORTIFICATIONS.SORTIE_LISTVIEW_ABSENTDIVISIONS;
            this.textMessage.visible = false;
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
        
        public var searchResultsTF:TextField;
        
        public var textMessage:TextField = null;
        
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
        
        public function as_setCreationEnabled(param1:Boolean) : void
        {
            createBtn.enabled = param1;
            var _loc2_:int = listDataProvider.length;
            if(_loc2_ > 0)
            {
                this.textMessage.visible = false;
            }
            App.utils.scheduler.scheduleTask(this.showTextMsg,_loc2_ > 0?100:300);
        }
        
        override protected function convertToRallyVO(param1:Object) : IRallyVO
        {
            return new LegionariesSortieVO(param1);
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
            this.textMessage.y = rallyTable.y + (rallyTable.height - this.textMessage.height >> 1) ^ 0;
            this.textMessage.x = rallyTable.x + (rallyTable.width - this.textMessage.width >> 1) ^ 0;
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
            App.utils.scheduler.cancelTask(this.showTextMsg);
            this.textMessage = null;
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
        
        private function showTextMsg() : void
        {
            var _loc1_:* = listDataProvider.length <= 0;
            this.textMessage.visible = _loc1_;
            detailsSection.noRallyScreen.showText(!_loc1_);
        }
        
        private function initListColumns() : void
        {
            var _loc1_:Array = [];
            _loc1_.push(createTableBtnInfo(FORTIFICATIONS.SORTIE_LISTVIEW_LISTCOLUMNS_NAME,"creatorName",141,0,TOOLTIPS.FORTIFICATION_SORTIE_LISTROOM_SORTNAMEBTN));
            _loc1_.push(createTableBtnInfo(FORTIFICATIONS.SORTIE_LISTVIEW_LISTCOLUMNS_DESCR,"description",140,1,TOOLTIPS.FORTIFICATION_SORTIE_LISTROOM_DESCR));
            _loc1_.push(createTableBtnInfo(FORTIFICATIONS.SORTIE_LISTVIEW_LISTCOLUMNS_DIVISION,"division",115,2,TOOLTIPS.FORTIFICATION_SORTIE_LISTROOM_SORTDIVISIONBTN));
            _loc1_.push(createTableBtnInfo(FORTIFICATIONS.SORTIE_LISTVIEW_LISTCOLUMNS_MEMBERSCOUNT,"playersCount",107,3,TOOLTIPS.FORTIFICATION_SORTIE_LISTROOM_SORTSQUADBTN));
            _loc1_.push(createTableBtnInfo(FORTIFICATIONS.SORTIE_LISTVIEW_LISTCOLUMNS_STATUS,"isInBattle",74,4,TOOLTIPS.FORTIFICATION_SORTIE_LISTROOM_STATUS));
            rallyTable.headerDP = new DataProvider(_loc1_);
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
