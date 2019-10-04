package net.wg.gui.lobby.store
{
    import net.wg.infrastructure.base.meta.impl.StoreTableMeta;
    import net.wg.gui.lobby.store.interfaces.IStoreTable;
    import flash.text.TextField;
    import net.wg.gui.lobby.components.InfoMessageComponent;
    import net.wg.data.VO.StoreTableVO;
    import net.wg.utils.IAssertable;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.NullPointerException;
    import net.wg.data.constants.generated.FITTING_TYPES;
    import scaleform.clik.interfaces.IListItemRenderer;

    public class StoreTable extends StoreTableMeta implements IStoreTable
    {

        private static const INVALID_TABLE:String = "invalidTable";

        private static const LINKAGE_STR:String = "linkage";

        private static const INVALID_SELECTED_INDEX:String = "invalidSelectedIndex";

        public var header:TableHeader = null;

        public var list:StoreList = null;

        public var headerTitle:TextField = null;

        public var noItemsInfoCmp:InfoMessageComponent = null;

        private var _tableVO:StoreTableVO = null;

        private var _tableDP:StoreTableDataProvider = null;

        private var _vehicleRendererLinkage:String = null;

        private var _moduleRendererLinkage:String = null;

        private var _asserter:IAssertable;

        private var _isVehicleCompareAvailable:Boolean = false;

        private var _isTradeInAvailable:Boolean = false;

        private var _scrollPosition:int = -1;

        private var _isViewVisible:Boolean = true;

        public function StoreTable()
        {
            this._asserter = App.utils.asserter;
            super();
            this._tableDP = new StoreTableDataProvider();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.list.widthAutoResize = false;
            this.list.dataProvider = this._tableDP;
        }

        override protected function draw() : void
        {
            var _loc1_:* = NaN;
            var _loc2_:* = 0;
            super.draw();
            if(this._tableVO != null && isInvalid(INVALID_TABLE))
            {
                this.updateTable();
                invalidateSize();
            }
            if(this._scrollPosition != -1 && isInvalid(INVALID_SELECTED_INDEX))
            {
                this.list.scrollPosition = this._scrollPosition;
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                _loc1_ = height - this.list.y;
                _loc2_ = Math.floor(_loc1_ / this.list.rowHeight);
                this.list.height = _loc2_ * this.list.rowHeight;
                this.noItemsInfoCmp.x = width - this.noItemsInfoCmp.width >> 1 | 0;
            }
        }

        override protected function onDispose() : void
        {
            this.header.dispose();
            this.header = null;
            this.list.dispose();
            this.list = null;
            this.headerTitle = null;
            this._tableVO = null;
            this._vehicleRendererLinkage = null;
            this._moduleRendererLinkage = null;
            this._asserter = null;
            this._tableDP.cleanUp();
            this._tableDP = null;
            this.noItemsInfoCmp.dispose();
            this.noItemsInfoCmp = null;
            super.onDispose();
        }

        override protected function setData(param1:StoreTableVO) : void
        {
            this._tableVO = param1;
            invalidate(INVALID_TABLE);
        }

        public function as_getTableDataProvider() : Object
        {
            return this._tableDP;
        }

        public function setModuleRendererLinkage(param1:String) : void
        {
            this._asserter.assertNotNull(param1,LINKAGE_STR + Errors.CANT_NULL,NullPointerException);
            this._moduleRendererLinkage = param1;
        }

        public function setVehicleRendererLinkage(param1:String) : void
        {
            this._asserter.assertNotNull(param1,LINKAGE_STR + Errors.CANT_NULL,NullPointerException);
            this._vehicleRendererLinkage = param1;
        }

        public function updateActionAvailable(param1:Boolean) : void
        {
            this.header.headerInfo.enableSale(param1);
        }

        public function updateHeaderCountTitle(param1:String) : void
        {
            this.header.headerInfo.countField.text = param1;
        }

        public function updateTradeInAvailable(param1:Boolean) : void
        {
            this._isTradeInAvailable = param1;
            this.header.headerInfo.enableTradeIn(param1);
        }

        public function updateVehicleCompareAvailable(param1:Boolean) : void
        {
            this._isVehicleCompareAvailable = param1;
            this.header.headerInfo.isCompareNeed(param1);
        }

        private function updateTable() : void
        {
            var _loc1_:String = this._tableVO.type;
            this._asserter.assertNotNull(_loc1_,"_type");
            this._asserter.assertNotNull(this._moduleRendererLinkage,"moduleRendererLinkage" + Errors.CANT_NULL,NullPointerException);
            this._asserter.assertNotNull(this._vehicleRendererLinkage,"vehicleRendererLinkage" + Errors.CANT_NULL,NullPointerException);
            this.list.scrollToIndex(0);
            this.setupRendererType(_loc1_);
            this.setupDataProvider(_loc1_);
            this.noItemsInfoCmp.visible = this._tableVO.showNoItemsInfo;
            this.headerTitle.visible = !this._tableVO.showNoItemsInfo;
            this.header.visible = !this._tableVO.showNoItemsInfo;
            if(this._tableVO.showNoItemsInfo)
            {
                this.noItemsInfoCmp.setData(this._tableVO.noItemsInfo);
            }
        }

        private function setupRendererType(param1:String) : void
        {
            var _loc2_:String = this._moduleRendererLinkage;
            if(param1 == FITTING_TYPES.VEHICLE)
            {
                _loc2_ = this._vehicleRendererLinkage;
            }
            this.header.headerInfo.isCompareNeed(this._isVehicleCompareAvailable && param1 == FITTING_TYPES.VEHICLE);
            this.header.headerInfo.enableTradeIn(this._isTradeInAvailable && param1 == FITTING_TYPES.VEHICLE);
            this.detectRendererHeight(_loc2_);
            var _loc3_:Class = App.utils.classFactory.getClass(_loc2_);
            this._asserter.assertNotNull(_loc3_,Errors.BAD_LINKAGE + _loc2_);
            if(this.list.itemRenderer != _loc3_)
            {
                this.list.itemRendererName = _loc2_;
            }
        }

        private function setupDataProvider(param1:String) : void
        {
            this._tableDP.type = param1;
            refreshStoreTableDataProviderS();
            if(App.instance)
            {
                this.headerTitle.text = App.utils.locale.makeString(MENU.SHOP_TABLE_FIND) + " " + this._tableDP.length.toString();
            }
            else
            {
                this.headerTitle.text = MENU.SHOP_TABLE_FIND + " " + this._tableDP.length.toString();
            }
        }

        private function detectRendererHeight(param1:String) : void
        {
            var _loc2_:IListItemRenderer = null;
            if(App.instance)
            {
                _loc2_ = App.utils.classFactory.getComponent(param1,IListItemRenderer);
                this.list.rowHeight = _loc2_.height;
            }
        }

        public function set scrollPosition(param1:int) : void
        {
            this._scrollPosition = param1;
            invalidate(INVALID_SELECTED_INDEX);
        }

        public function get isViewVisible() : Boolean
        {
            return this._isViewVisible;
        }

        public function set isViewVisible(param1:Boolean) : void
        {
            this._isViewVisible = param1;
            this.list.isViewVisible = param1;
        }
    }
}
