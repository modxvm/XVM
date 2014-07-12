package net.wg.gui.cyberSport.views
{
    import net.wg.infrastructure.base.meta.impl.CyberSportUnitsListMeta;
    import net.wg.infrastructure.base.meta.ICyberSportUnitsListMeta;
    import net.wg.infrastructure.base.meta.IBaseRallyViewMeta;
    import net.wg.gui.cyberSport.controls.NavigationBlock;
    import net.wg.gui.components.advanced.ButtonDnmIcon;
    import flash.text.TextField;
    import net.wg.gui.cyberSport.vo.NavigationBlockVO;
    import net.wg.gui.rally.interfaces.IRallyVO;
    import net.wg.gui.rally.vo.RallyShortVO;
    import net.wg.data.constants.Tooltips;
    import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import net.wg.gui.cyberSport.controls.events.CSComponentEvent;
    import net.wg.gui.components.controls.NormalSortingBtnInfo;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.rally.data.ManualSearchDataProvider;
    import net.wg.gui.cyberSport.vo.CSCommandVO;
    
    public class UnitsListView extends CyberSportUnitsListMeta implements ICyberSportUnitsListMeta, IBaseRallyViewMeta
    {
        
        public function UnitsListView() {
            super();
            listDataProvider = new ManualSearchDataProvider(CSCommandVO);
        }
        
        private static var REFRESH_BUTTON_OFFSET:Number = 14;
        
        public var navigationBlock:NavigationBlock;
        
        public var refreshBtn:ButtonDnmIcon = null;
        
        public var searchResultsTF:TextField;
        
        private var _selectedVehiclesCount:int = 0;
        
        private var navigationConfig:NavigationBlockVO;
        
        public function as_updateNavigationBlock(param1:Object) : void {
            this.navigationConfig = new NavigationBlockVO(param1);
            this.navigationBlock.setup(this.navigationConfig);
        }
        
        public function as_setSelectedVehiclesInfo(param1:String, param2:int) : void {
            this._selectedVehiclesCount = param2;
        }
        
        public function as_setSearchResultText(param1:String) : void {
            this.searchResultsTF.htmlText = param1;
            this.refreshBtn.x = this.searchResultsTF.x + this.searchResultsTF.textWidth + REFRESH_BUTTON_OFFSET;
        }
        
        override protected function convertToRallyVO(param1:Object) : IRallyVO {
            return new RallyShortVO(param1);
        }
        
        override protected function getRallyTooltipLinkage() : String {
            return Tooltips.CYBER_SPORT_TEAM;
        }
        
        override protected function getRallyViewAlias() : String {
            return CYBER_SPORT_ALIASES.UNIT_VIEW_UI;
        }
        
        override protected function configUI() : void {
            super.configUI();
            this.initListColumns();
            this.refreshBtn.addEventListener(ButtonEvent.CLICK,this.onRefreshClick);
            this.refreshBtn.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.refreshBtn.addEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            this.navigationBlock.addEventListener(CSComponentEvent.LOAD_PREVIOUS_REQUEST,this.onLoadPreviousRequest);
            this.navigationBlock.addEventListener(CSComponentEvent.LOAD_NEXT_REQUEST,this.onLoadNextRequest);
            createBtn.label = CYBERSPORT.WINDOW_UNITLISTVIEW_CREATE_BTN;
            titleLbl.text = CYBERSPORT.WINDOW_UNITLISTVIEW_TITLE;
            descrLbl.text = CYBERSPORT.WINDOW_UNITLISTVIEW_DESCRIPTION;
        }
        
        override protected function onPopulate() : void {
            super.onPopulate();
        }
        
        override protected function onDispose() : void {
            this.navigationBlock.removeEventListener(CSComponentEvent.LOAD_PREVIOUS_REQUEST,this.onLoadPreviousRequest);
            this.navigationBlock.removeEventListener(CSComponentEvent.LOAD_NEXT_REQUEST,this.onLoadNextRequest);
            this.refreshBtn.removeEventListener(ButtonEvent.CLICK,this.onRefreshClick);
            this.refreshBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOver);
            this.refreshBtn.removeEventListener(MouseEvent.ROLL_OUT,onControlRollOut);
            super.onDispose();
        }
        
        override protected function coolDownControls(param1:Boolean, param2:int) : void {
            this.refreshBtn.enabled = param1;
            this.navigationBlock.setInCoolDown(!param1);
            super.coolDownControls(param1,param2);
        }
        
        override protected function onControlRollOver(param1:MouseEvent) : void {
            switch(param1.currentTarget)
            {
                case this.refreshBtn:
                    App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_UNITLIST_REFRESH);
                    break;
                case backBtn:
                    App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_UNITLEVEL_BACK);
                    break;
            }
        }
        
        private function onRefreshClick(param1:ButtonEvent) : void {
            refreshTeamsS();
        }
        
        private function onLoadNextRequest(param1:CSComponentEvent) : void {
            loadNextS();
        }
        
        private function onLoadPreviousRequest(param1:CSComponentEvent) : void {
            loadPreviousS();
        }
        
        private function initListColumns() : void {
            var _loc1_:NormalSortingBtnInfo = null;
            var _loc2_:Array = [];
            _loc1_ = new NormalSortingBtnInfo();
            _loc1_.label = CYBERSPORT.WINDOW_UNIT_UNITLISTVIEW_RATING;
            _loc1_.buttonWidth = 105;
            _loc2_.push(_loc1_);
            _loc1_ = new NormalSortingBtnInfo();
            _loc1_.label = CYBERSPORT.WINDOW_UNIT_UNITLISTVIEW_COMMANDER;
            _loc1_.buttonWidth = 150;
            _loc2_.push(_loc1_);
            _loc1_ = new NormalSortingBtnInfo();
            _loc1_.label = CYBERSPORT.WINDOW_UNIT_UNITLISTVIEW_DESCRIPTION;
            _loc1_.buttonWidth = 200;
            _loc2_.push(_loc1_);
            _loc1_ = new NormalSortingBtnInfo();
            _loc1_.label = CYBERSPORT.WINDOW_UNIT_UNITLISTVIEW_PLAYERS;
            _loc1_.buttonWidth = 80;
            _loc2_.push(_loc1_);
            rallyTable.headerDP = new DataProvider(_loc2_);
        }
    }
}
