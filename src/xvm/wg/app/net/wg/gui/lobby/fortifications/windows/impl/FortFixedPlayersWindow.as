package net.wg.gui.lobby.fortifications.windows.impl
{
    import net.wg.infrastructure.base.meta.impl.FortFixedPlayersWindowMeta;
    import net.wg.infrastructure.base.meta.IFortFixedPlayersWindowMeta;
    import scaleform.clik.data.DataProvider;
    import net.wg.infrastructure.interfaces.IImageUrlProperties;
    import net.wg.gui.components.controls.NormalSortingBtnInfo;
    import net.wg.data.constants.SortingInfo;
    import flash.text.TextFieldAutoSize;
    import flash.events.MouseEvent;
    import net.wg.gui.components.controls.SortableTable;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.gui.components.controls.SoundButtonEx;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.fortifications.data.FortFixedPlayersVO;
    import net.wg.data.constants.generated.EVENT_LOG_CONSTANTS;
    import net.wg.gui.events.SortableTableListEvent;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.data.constants.Values;
    import flash.display.InteractiveObject;
    import net.wg.gui.lobby.fortifications.data.ClanListRendererVO;
    import scaleform.gfx.MouseEventEx;
    import net.wg.gui.prebattle.invites.PrbSendInviteCIGenerator;
    
    public class FortFixedPlayersWindow extends FortFixedPlayersWindowMeta implements IFortFixedPlayersWindowMeta
    {
        
        public function FortFixedPlayersWindow()
        {
            super();
            this.assignPlayer.UIID = 86;
            UIID = 87;
            this.playerIsAssigned.visible = false;
            this.playerIsAssigned.mouseEnabled = false;
            isModal = false;
            isCentered = true;
            this.toolTipArea.addEventListener(MouseEvent.ROLL_OVER,this.onRollOverToolTipAreaHandler);
            this.toolTipArea.addEventListener(MouseEvent.ROLL_OUT,onRollOutToolTipAreaHandler);
            this.playersList.addEventListener(SortableTableListEvent.RENDERER_CLICK,this.itemClickHandler);
        }
        
        public static var MEMBER_NAME:String = "userName";
        
        public static var ROLE:String = "playerRole";
        
        public static var WEEK_MINING:String = "intWeekMining";
        
        public static var TOTAL_MINING:String = "intTotalMining";
        
        private static var UPDATE_TABLE:String = "updateTable";
        
        private static function getHeadersProvider() : DataProvider
        {
            var _loc1_:Array = [];
            var _loc2_:IImageUrlProperties = App.utils.getImageUrlProperties(RES_ICONS.MAPS_ICONS_LIBRARY_FORTIFICATION_NUT,16,16) as IImageUrlProperties;
            var _loc3_:String = App.utils.getHtmlIconTextS(_loc2_);
            var _loc4_:NormalSortingBtnInfo = new NormalSortingBtnInfo();
            _loc4_.iconId = MEMBER_NAME;
            _loc4_.label = FORTIFICATIONS.CLANLISTWINDOW_TABLE_MEMBERNAME;
            _loc4_.buttonWidth = 140;
            _loc4_.defaultSortDirection = SortingInfo.ASCENDING_SORT;
            _loc4_.sortOrder = 0;
            _loc4_.textAlign = TextFieldAutoSize.LEFT;
            _loc4_.toolTip = TOOLTIPS.FORTIFICATION_FIXEDPLAYERS_NIC;
            _loc4_.dataSortType = Array.CASEINSENSITIVE;
            _loc1_.push(_loc4_);
            var _loc5_:NormalSortingBtnInfo = new NormalSortingBtnInfo();
            _loc5_.iconId = ROLE;
            _loc5_.label = FORTIFICATIONS.CLANLISTWINDOW_TABLE_ROLE;
            _loc5_.buttonWidth = 199;
            _loc5_.defaultSortDirection = SortingInfo.ASCENDING_SORT;
            _loc5_.sortOrder = 1;
            _loc5_.textAlign = TextFieldAutoSize.LEFT;
            _loc5_.toolTip = TOOLTIPS.FORTIFICATION_FIXEDPLAYERS_FORTROLE;
            _loc5_.dataSortType = Array.CASEINSENSITIVE;
            _loc1_.push(_loc5_);
            var _loc6_:NormalSortingBtnInfo = new NormalSortingBtnInfo();
            _loc6_.iconId = WEEK_MINING;
            _loc6_.label = App.utils.locale.makeString(FORTIFICATIONS.FIXEDPLAYERS_LISTHEADER_FIELDWEEK,{"icon":_loc3_});
            _loc6_.buttonWidth = 103;
            _loc6_.defaultSortDirection = SortingInfo.ASCENDING_SORT;
            _loc6_.textAlign = TextFieldAutoSize.RIGHT;
            _loc6_.toolTip = TOOLTIPS.FORTIFICATION_FIXEDPLAYERS_WEEK;
            _loc6_.sortOrder = 2;
            _loc1_.push(_loc6_);
            var _loc7_:NormalSortingBtnInfo = new NormalSortingBtnInfo();
            _loc7_.iconId = TOTAL_MINING;
            _loc7_.label = App.utils.locale.makeString(FORTIFICATIONS.FIXEDPLAYERS_LISTHEADER_FIELDALLTIME,{"icon":_loc3_});
            _loc7_.buttonWidth = 113;
            _loc7_.defaultSortDirection = SortingInfo.ASCENDING_SORT;
            _loc7_.textAlign = TextFieldAutoSize.RIGHT;
            _loc7_.toolTip = TOOLTIPS.FORTIFICATION_FIXEDPLAYERS_ALLTIME;
            _loc7_.sortOrder = 3;
            _loc1_.push(_loc7_);
            return new DataProvider(_loc1_);
        }
        
        private static function onRollOutToolTipAreaHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }
        
        public var playersList:SortableTable = null;
        
        public var infoIcon:UILoaderAlt = null;
        
        public var soldierIcon:UILoaderAlt = null;
        
        public var assignPlayer:SoundButtonEx = null;
        
        public var playersCounts:TextField = null;
        
        public var playerIsAssigned:TextField = null;
        
        public var toolTipArea:MovieClip = null;
        
        private var model:FortFixedPlayersVO = null;
        
        override protected function onClosingApproved() : void
        {
            App.eventLogManager.logUIElement(this,EVENT_LOG_CONSTANTS.EVENT_TYPE_ON_WINDOW_CLOSE,this.model.buildingId);
        }
        
        public function as_setWindowTitle(param1:String) : void
        {
            window.title = param1;
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
        }
        
        override protected function onDispose() : void
        {
            this.playersList.removeEventListener(SortableTableListEvent.RENDERER_CLICK,this.itemClickHandler);
            this.playersList.dispose();
            this.playersList = null;
            this.toolTipArea.removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverToolTipAreaHandler);
            this.toolTipArea.removeEventListener(MouseEvent.ROLL_OUT,onRollOutToolTipAreaHandler);
            this.toolTipArea = null;
            this.assignPlayer.removeEventListener(ButtonEvent.CLICK,this.onClickBtnHandler);
            this.assignPlayer.dispose();
            this.assignPlayer = null;
            this.infoIcon.dispose();
            this.infoIcon = null;
            this.soldierIcon.dispose();
            this.soldierIcon = null;
            super.onDispose();
        }
        
        override protected function setData(param1:FortFixedPlayersVO) : void
        {
            this.model = param1;
            window.title = this.model.windowTitle;
            this.assignPlayer.label = this.model.buttonLbl;
            this.assignPlayer.enabled = this.model.isEnableBtn;
            this.assignPlayer.visible = this.model.isVisibleBtn;
            if(!this.model.isVisibleBtn && !(this.model.playerIsAssigned == Values.EMPTY_STR))
            {
                this.playerIsAssigned.visible = true;
                this.playerIsAssigned.htmlText = this.model.playerIsAssigned;
            }
            else
            {
                this.playerIsAssigned.visible = false;
            }
            if(this.assignPlayer.visible)
            {
                this.assignPlayer.tooltip = this.model.btnTooltipData;
                if(this.assignPlayer.enabled)
                {
                    this.assignPlayer.addEventListener(ButtonEvent.CLICK,this.onClickBtnHandler);
                    setFocus(this.assignPlayer);
                }
                this.assignPlayer.buttonMode = this.model.isEnableBtn;
                this.assignPlayer.useHandCursor = this.model.isEnableBtn;
            }
            this.playersCounts.htmlText = this.model.countLabel;
            invalidate(UPDATE_TABLE);
        }
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(UPDATE_TABLE)) && (this.model))
            {
                this.updateTableList();
            }
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.playersList.headerDP = getHeadersProvider();
            this.playersList.uniqKeyForAutoSelect = "intTotalMining";
            this.soldierIcon.source = RES_ICONS.MAPS_ICONS_BUTTONS_FOOTHOLD;
        }
        
        private function updateTableList() : void
        {
            this.playersList.listDP = new DataProvider(this.model.rosters);
            this.playersList.sortByField("intTotalMining",SortingInfo.DESCENDING_SORT);
            this.playersList.scrollListToItemByUniqKey("himself",true);
        }
        
        override protected function onSetModalFocus(param1:InteractiveObject) : void
        {
            super.onSetModalFocus(param1);
            if(this.assignPlayer.visible)
            {
                setFocus(this.assignPlayer);
            }
            else
            {
                setFocus(window.getCloseBtn());
            }
        }
        
        private function itemClickHandler(param1:SortableTableListEvent) : void
        {
            var _loc2_:ClanListRendererVO = null;
            if(param1.buttonIdx == MouseEventEx.RIGHT_BUTTON)
            {
                _loc2_ = param1.itemData as ClanListRendererVO;
                App.contextMenuMgr.showUserContextMenu(this,_loc2_,new PrbSendInviteCIGenerator());
            }
            else
            {
                App.contextMenuMgr.hide();
            }
        }
        
        private function onClickBtnHandler(param1:ButtonEvent) : void
        {
            App.eventLogManager.logUIEvent(param1,this.model.buildingId);
            assignToBuildingS();
        }
        
        private function onRollOverToolTipAreaHandler(param1:MouseEvent) : void
        {
            App.eventLogManager.logSubSystem(EVENT_LOG_CONSTANTS.SST_TOOLTIP,EVENT_LOG_CONSTANTS.EVENT_TYPE_ON_WINDOW_OPEN,0,this.model.buildingId);
            App.toolTipMgr.showComplex(this.model.generalTooltipData);
        }
    }
}
