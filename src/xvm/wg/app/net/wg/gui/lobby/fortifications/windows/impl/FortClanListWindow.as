package net.wg.gui.lobby.fortifications.windows.impl
{
    import net.wg.infrastructure.base.meta.impl.FortClanListWindowMeta;
    import net.wg.infrastructure.base.meta.IFortClanListWindowMeta;
    import scaleform.clik.data.DataProvider;
    import net.wg.infrastructure.interfaces.IImageUrlProperties;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.components.controls.NormalSortingBtnInfo;
    import net.wg.data.constants.SortingInfo;
    import net.wg.gui.components.controls.SortableTable;
    import net.wg.gui.lobby.fortifications.data.FortClanListWindowVO;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.events.SortableTableListEvent;
    import net.wg.gui.lobby.fortifications.data.ClanListRendererVO;
    import scaleform.gfx.MouseEventEx;
    import net.wg.gui.prebattle.invites.PrbSendInviteCIGenerator;
    
    public class FortClanListWindow extends FortClanListWindowMeta implements IFortClanListWindowMeta
    {
        
        public function FortClanListWindow()
        {
            super();
            isModal = false;
            isCentered = true;
            this.table.addEventListener(SortableTableListEvent.RENDERER_CLICK,this.itemClickHandler);
        }
        
        public static var MEMBER_NAME:String = "userName";
        
        public static var ROLE_ID:String = "playerRoleID";
        
        public static var WEEK_MINING:String = "intWeekMining";
        
        public static var TOTAL_MINING:String = "intTotalMining";
        
        private static var IS_SELF:String = "himself";
        
        private static function getHeadersProvider() : DataProvider
        {
            var _loc1_:Array = [];
            var _loc2_:IImageUrlProperties = App.utils.getImageUrlProperties(RES_ICONS.MAPS_ICONS_LIBRARY_FORTIFICATION_NUT,16,16) as IImageUrlProperties;
            var _loc3_:String = App.utils.getHtmlIconTextS(_loc2_);
            _loc1_.push(createTableBtnInfo(FORTIFICATIONS.CLANLISTWINDOW_TABLE_MEMBERNAME,MEMBER_NAME,181,0,TOOLTIPS.FORTIFICATION_FIXEDPLAYERS_NIC,TextFieldAutoSize.LEFT,Array.CASEINSENSITIVE));
            _loc1_.push(createTableBtnInfo(FORTIFICATIONS.CLANLISTWINDOW_TABLE_ROLE,ROLE_ID,203,1,TOOLTIPS.FORTIFICATION_FIXEDPLAYERS_FORTROLE,TextFieldAutoSize.LEFT));
            _loc1_.push(createTableBtnInfo(App.utils.locale.makeString(FORTIFICATIONS.FIXEDPLAYERS_LISTHEADER_FIELDWEEK,{"icon":_loc3_}),WEEK_MINING,137,2,TOOLTIPS.FORTIFICATION_FIXEDPLAYERS_WEEK,TextFieldAutoSize.RIGHT));
            _loc1_.push(createTableBtnInfo(App.utils.locale.makeString(FORTIFICATIONS.FIXEDPLAYERS_LISTHEADER_FIELDALLTIME,{"icon":_loc3_}),TOTAL_MINING,147,3,TOOLTIPS.FORTIFICATION_FIXEDPLAYERS_ALLTIME,TextFieldAutoSize.CENTER));
            return new DataProvider(_loc1_);
        }
        
        private static function createTableBtnInfo(param1:String, param2:String, param3:Number, param4:Number, param5:String, param6:String, param7:Number = 16) : NormalSortingBtnInfo
        {
            var _loc8_:NormalSortingBtnInfo = null;
            _loc8_ = new NormalSortingBtnInfo();
            _loc8_.label = param1;
            _loc8_.buttonWidth = param3;
            _loc8_.sortOrder = param4;
            _loc8_.toolTip = param5;
            _loc8_.iconId = param2;
            _loc8_.textAlign = param6;
            _loc8_.defaultSortDirection = SortingInfo.ASCENDING_SORT;
            _loc8_.dataSortType = param7;
            return _loc8_;
        }
        
        public var table:SortableTable;
        
        private var data:FortClanListWindowVO = null;
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(InvalidationType.DATA)) && (this.data))
            {
                this.table.listDP = new DataProvider(this.data.members);
            }
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            window.title = this.data.windowTitle;
            this.table.headerDP = getHeadersProvider();
            this.table.sortByField(TOTAL_MINING,SortingInfo.DESCENDING_SORT);
            this.table.scrollListToItemByUniqKey(IS_SELF,true);
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
        }
        
        override protected function onDispose() : void
        {
            this.table.removeEventListener(SortableTableListEvent.RENDERER_CLICK,this.itemClickHandler);
            this.table.dispose();
            this.table = null;
            if(this.data)
            {
                this.data.dispose();
                this.data = null;
            }
            super.onDispose();
        }
        
        override protected function setData(param1:FortClanListWindowVO) : void
        {
            this.data = param1;
            invalidateData();
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
    }
}
