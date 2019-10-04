package net.wg.gui.components.common.serverStats
{
    import net.wg.infrastructure.base.meta.impl.ServerStatsMeta;
    import net.wg.infrastructure.base.meta.IServerStatsMeta;
    import net.wg.gui.components.controls.helpers.ServerCsisState;
    import flash.text.TextField;
    import flash.display.Sprite;
    import scaleform.clik.interfaces.IDataProvider;
    import scaleform.clik.events.ListEvent;
    import net.wg.gui.components.controls.events.DropdownMenuEvent;
    import flash.events.Event;
    import net.wg.data.ListDAAPIDataProvider;

    public class ServerStats extends ServerStatsMeta implements IServerStatsMeta
    {

        private static const INVALIDATE_SERVER_INFO:String = "serverInfo";

        private static const INV_CSIS_LISTENING:String = "invCsisListening";

        private static const INV_REGION_DD:String = "invRegionDD";

        public var regionDD:ServerDropDown;

        public var singleServerField:TextField;

        public var singleServerBackground:Sprite;

        public var serverInfo:ServerInfo;

        public var textField:TextField;

        private var _regionDDDisabed:Boolean = false;

        private var _dataProvider:IDataProvider;

        private var _serverInfoStats:String = null;

        private var _serverInfoToolTipType:String = null;

        private var _startListenCSIS:Boolean = false;

        private var _serverResetMode:Boolean = false;

        private var _currentServerIndex:int = -1;

        private var _isChina:Boolean = false;

        public function ServerStats()
        {
            super();
            this._dataProvider = new ListDAAPIDataProvider(ServerVO);
            this._dataProvider.addEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
            this.regionDD.checkItemDisabledFunction = checkItemDisabledFunction;
            this._isChina = App.globalVarsMgr.isChinaS();
        }

        private static function checkItemDisabledFunction(param1:ServerVO) : Boolean
        {
            return param1.csisStatus == ServerCsisState.NOT_AVAILABLE;
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.serverInfo.visible = App.globalVarsMgr.isShowServerStatsS();
            this.serverInfo.focusable = false;
            this.regionDD.dataProvider = this._dataProvider;
            this.textField.htmlText = App.utils.locale.makeString(MENU.INGAME_MENU_SERVERSTATS_SERVER);
            this.textField.mouseEnabled = false;
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(INVALIDATE_SERVER_INFO))
            {
                this.serverInfo.setValues(this._serverInfoStats,this._serverInfoToolTipType);
            }
            if(isInvalid(INV_CSIS_LISTENING))
            {
                startListenCsisUpdateS(this._startListenCSIS);
            }
            if(isInvalid(INV_REGION_DD))
            {
                this.updaterRegionDD();
            }
        }

        override protected function onPopulate() : void
        {
            super.onPopulate();
            this.regionDD.addEventListener(ListEvent.INDEX_CHANGE,this.onRegionIndexChangeHandler);
            this.regionDD.addEventListener(DropdownMenuEvent.SHOW_DROP_DOWN,this.onRegionShowDropDownHandler);
            this.regionDD.addEventListener(DropdownMenuEvent.CLOSE_DROP_DOWN,this.onRegionCloseDropDownHandler);
        }

        override protected function onDispose() : void
        {
            this.regionDD.removeEventListener(DropdownMenuEvent.SHOW_DROP_DOWN,this.onRegionShowDropDownHandler);
            this.regionDD.removeEventListener(DropdownMenuEvent.CLOSE_DROP_DOWN,this.onRegionCloseDropDownHandler);
            this.regionDD.removeEventListener(ListEvent.INDEX_CHANGE,this.onRegionIndexChangeHandler);
            this._dataProvider.removeEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
            this.serverInfo.dispose();
            this.serverInfo = null;
            this._dataProvider.cleanUp();
            this._dataProvider = null;
            this.regionDD.dispose();
            this.regionDD = null;
            this.textField = null;
            super.onDispose();
        }

        public function as_changePeripheryFailed() : void
        {
            this.updateSelectedServer();
        }

        public function as_disableRoamingDD(param1:Boolean) : void
        {
            this._regionDDDisabed = param1;
            invalidate(INV_REGION_DD);
        }

        public function as_getServersDP() : Object
        {
            return this._dataProvider;
        }

        public function as_setSelectedServerIndex(param1:int) : void
        {
            this._currentServerIndex = param1;
            this.updateSelectedServer();
        }

        public function as_setServerStats(param1:String, param2:String) : void
        {
            this._serverInfoStats = param1;
            this._serverInfoToolTipType = param2;
            invalidate(INVALIDATE_SERVER_INFO);
        }

        public function as_setServerStatsInfo(param1:String) : void
        {
            this.serverInfo.tooltipFullData = param1;
        }

        private function updateSelectedServer() : void
        {
            this._serverResetMode = true;
            this.regionDD.selectedIndex = this._currentServerIndex;
            this._serverResetMode = false;
        }

        private function updaterRegionDD() : void
        {
            var _loc2_:ServerVO = null;
            var _loc1_:Boolean = this._currentServerIndex > -1 && (this._isChina || this._dataProvider.length == 1);
            this.regionDD.enabled = !_loc1_ && !this._regionDDDisabed;
            this.regionDD.visible = !this._isChina;
            this.singleServerField.visible = this._isChina;
            this.singleServerBackground.visible = this._isChina;
            if(this._isChina)
            {
                _loc2_ = ServerVO(this._dataProvider.requestItemAt(this._currentServerIndex));
                this.singleServerField.htmlText = _loc2_.label;
            }
        }

        private function onRegionCloseDropDownHandler(param1:DropdownMenuEvent) : void
        {
            this._startListenCSIS = false;
            invalidate(INV_CSIS_LISTENING);
        }

        private function onRegionShowDropDownHandler(param1:DropdownMenuEvent) : void
        {
            this._startListenCSIS = true;
            invalidate(INV_CSIS_LISTENING);
        }

        private function onDataProviderChangeHandler(param1:Event) : void
        {
            invalidate(INV_REGION_DD);
        }

        private function onRegionIndexChangeHandler(param1:ListEvent) : void
        {
            if(!this._isChina && !this._serverResetMode)
            {
                reloginS(ServerVO(param1.itemData).id);
            }
        }
    }
}
