package net.wg.gui.lobby.fortifications.windows.impl
{
    import net.wg.infrastructure.base.meta.impl.FortClanListWindowMeta;
    import net.wg.infrastructure.base.meta.IFortClanListWindowMeta;
    import scaleform.clik.data.DataProvider;
    import net.wg.gui.components.controls.NormalSortingBtnInfo;
    import net.wg.infrastructure.interfaces.IImageUrlProperties;
    import net.wg.data.constants.SortingInfo;
    import flash.text.TextFieldAutoSize;
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
        
        public static var ROLE:String = "playerRole";
        
        public static var WEEK_MINING:String = "intWeekMining";
        
        public static var TOTAL_MINING:String = "intTotalMining";
        
        private static var IS_SELF:String = "himself";
        
        private static function getHeadersProvider() : DataProvider
        {
            var _loc1_:Array = null;
            var _loc4_:NormalSortingBtnInfo = null;
            _loc1_ = [];
            var _loc2_:IImageUrlProperties = App.utils.getImageUrlProperties(RES_ICONS.MAPS_ICONS_LIBRARY_FORTIFICATION_NUT,16,16) as IImageUrlProperties;
            var _loc3_:String = App.utils.getHtmlIconTextS(_loc2_);
            _loc4_ = new NormalSortingBtnInfo();
            _loc4_.iconId = MEMBER_NAME;
            _loc4_.label = FORTIFICATIONS.CLANLISTWINDOW_TABLE_MEMBERNAME;
            _loc4_.buttonWidth = 181;
            _loc4_.defaultSortDirection = SortingInfo.ASCENDING_SORT;
            _loc4_.textAlign = TextFieldAutoSize.LEFT;
            _loc4_.toolTip = TOOLTIPS.FORTIFICATION_FIXEDPLAYERS_NIC;
            _loc4_.sortOrder = 0;
            _loc4_.dataSortType = Array.CASEINSENSITIVE;
            _loc1_.push(_loc4_);
            var _loc5_:NormalSortingBtnInfo = new NormalSortingBtnInfo();
            _loc5_.iconId = ROLE;
            _loc5_.label = FORTIFICATIONS.CLANLISTWINDOW_TABLE_ROLE;
            _loc5_.buttonWidth = 143;
            _loc5_.defaultSortDirection = SortingInfo.ASCENDING_SORT;
            _loc5_.toolTip = TOOLTIPS.FORTIFICATION_FIXEDPLAYERS_FORTROLE;
            _loc5_.textAlign = TextFieldAutoSize.LEFT;
            _loc5_.sortOrder = 1;
            _loc5_.dataSortType = Array.CASEINSENSITIVE;
            _loc1_.push(_loc5_);
            var _loc6_:NormalSortingBtnInfo = new NormalSortingBtnInfo();
            _loc6_.iconId = WEEK_MINING;
            _loc6_.label = App.utils.locale.makeString(FORTIFICATIONS.FIXEDPLAYERS_LISTHEADER_FIELDWEEK,{"icon":_loc3_});
            _loc6_.buttonWidth = 147;
            _loc6_.defaultSortDirection = SortingInfo.ASCENDING_SORT;
            _loc6_.textAlign = TextFieldAutoSize.RIGHT;
            _loc6_.toolTip = TOOLTIPS.FORTIFICATION_FIXEDPLAYERS_WEEK;
            _loc6_.sortOrder = 2;
            _loc1_.push(_loc6_);
            var _loc7_:NormalSortingBtnInfo = new NormalSortingBtnInfo();
            _loc7_.iconId = TOTAL_MINING;
            _loc7_.label = App.utils.locale.makeString(FORTIFICATIONS.FIXEDPLAYERS_LISTHEADER_FIELDALLTIME,{"icon":_loc3_});
            _loc7_.buttonWidth = 147;
            _loc7_.defaultSortDirection = SortingInfo.ASCENDING_SORT;
            _loc7_.textAlign = TextFieldAutoSize.CENTER;
            _loc7_.toolTip = TOOLTIPS.FORTIFICATION_FIXEDPLAYERS_ALLTIME;
            _loc7_.sortOrder = 3;
            _loc1_.push(_loc7_);
            return new DataProvider(_loc1_);
        }
        
        public var table:SortableTable;
        
        private var data:FortClanListWindowVO = null;
        
        override protected function draw() : void
        {
            super.draw();
            if((isInvalid(InvalidationType.DATA)) && (this.data))
            {
                window.title = this.data.windowTitle;
                this.table.listDP = new DataProvider(this.data.members);
                this.table.sortByField(TOTAL_MINING,SortingInfo.DESCENDING_SORT);
                this.table.scrollListToItemByUniqKey(IS_SELF,true);
            }
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.table.headerDP = getHeadersProvider();
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
