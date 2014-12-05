package net.wg.gui.components.common.serverStats
{
    import net.wg.infrastructure.base.meta.impl.ServerStatsMeta;
    import net.wg.infrastructure.base.meta.IServerStatsMeta;
    import net.wg.gui.components.controls.ServerIndicator;
    import net.wg.gui.components.controls.DropdownMenu;
    import flash.text.TextField;
    import scaleform.clik.events.ListEvent;
    import net.wg.gui.components.controls.events.DropdownMenuEvent;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.data.DataProvider;
    
    public class ServerStats extends ServerStatsMeta implements IServerStatsMeta
    {
        
        public function ServerStats()
        {
            this._serversList = [];
            super();
            this.regionDD.checkItemDisabledFunction = checkItemDisabledFunction;
        }
        
        private static var INVALIDATE_SERVER_INFO:String = "serverInfo";
        
        private static var INVALIDATE_SERVERS:String = "invServers";
        
        private static var INV_CSIS_LISTENING:String = "invCsisListening";
        
        private static function checkItemDisabledFunction(param1:ServerVO) : Boolean
        {
            return param1.csisStatus == ServerIndicator.NOT_AVAILABLE;
        }
        
        public var regionDD:DropdownMenu;
        
        public var serverInfo:ServerInfo;
        
        public var textField:TextField;
        
        private var _serverInfoStats:String = null;
        
        private var _serverInfoToolTipType:String = null;
        
        private var _serversList:Array;
        
        private var _startListenCSIS:Boolean = false;
        
        override protected function configUI() : void
        {
            super.configUI();
            this.textField.text = App.utils.locale.makeString(MENU.LOBBY_MENU_SERVERS_TITLE,{"sName":""});
            this.serverInfo.visible = App.globalVarsMgr.isShowServerStatsS();
            this.serverInfo.focusable = false;
            this.serverInfo.relativelyOwner = this.regionDD;
            this.regionDD.visible = !App.globalVarsMgr.isChinaS();
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
            if(isInvalid(INVALIDATE_SERVERS))
            {
                if(App.globalVarsMgr.isChinaS())
                {
                    this.updateOneServer(this._serversList);
                }
                else
                {
                    this.regionDD.removeEventListener(ListEvent.INDEX_CHANGE,this.changeRegion);
                    this.setupServersData(this._serversList);
                    this.regionDD.addEventListener(ListEvent.INDEX_CHANGE,this.changeRegion);
                }
            }
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            if((isCSISUpdateOnRequestS()) && !App.globalVarsMgr.isChinaS())
            {
                this.regionDD.addEventListener(DropdownMenuEvent.SHOW_DROP_DOWN,this.onServersDDClick);
                this.regionDD.addEventListener(DropdownMenuEvent.CLOSE_DROP_DOWN,this.onServersDDClick);
            }
        }
        
        override protected function onDispose() : void
        {
            if(!App.globalVarsMgr.isChinaS())
            {
                this.regionDD.removeEventListener(DropdownMenuEvent.SHOW_DROP_DOWN,this.onServersDDClick);
                this.regionDD.removeEventListener(DropdownMenuEvent.CLOSE_DROP_DOWN,this.onServersDDClick);
                this.regionDD.removeEventListener(ListEvent.INDEX_CHANGE,this.changeRegion);
            }
            this.serverInfo.dispose();
            this.regionDD.dispose();
            this.regionDD = null;
            super.onDispose();
        }
        
        public function as_setPeripheryChanging(param1:Boolean) : void
        {
            if(!param1)
            {
                this._serversList = getServersS();
                if(App.globalVarsMgr.isChinaS())
                {
                    this.updateOneServer(this._serversList);
                }
                else
                {
                    this.regionDD.removeEventListener(ListEvent.INDEX_CHANGE,this.changeRegion);
                    this.setupServersData(this._serversList);
                    this.regionDD.addEventListener(ListEvent.INDEX_CHANGE,this.changeRegion);
                }
            }
        }
        
        private function updateOneServer(param1:Array) : void
        {
            var _loc2_:* = "";
            var _loc3_:Number = 0;
            while(_loc3_ < param1.length)
            {
                if(param1[_loc3_].selected)
                {
                    _loc2_ = param1[_loc3_].label;
                    break;
                }
                _loc3_++;
            }
            this.textField.autoSize = TextFieldAutoSize.CENTER;
            this.textField.htmlText = App.utils.locale.makeString(MENU.LOBBY_MENU_SERVERS_TITLE,{"sName":_loc2_});
        }
        
        public function as_setServersList(param1:Array) : void
        {
            this._serversList = param1;
            invalidate(INVALIDATE_SERVERS);
        }
        
        public function as_disableRoamingDD(param1:Boolean) : void
        {
            this.regionDD.enabled = !param1;
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
        
        private function changeRegion(param1:ListEvent) : void
        {
            reloginS(ServerVO(param1.itemData).id);
        }
        
        private function onServersDDClick(param1:DropdownMenuEvent) : void
        {
            this._startListenCSIS = param1.type == DropdownMenuEvent.SHOW_DROP_DOWN;
            invalidate(INV_CSIS_LISTENING);
        }
        
        private function setupServersData(param1:Array) : void
        {
            var _loc5_:ServerVO = null;
            this.textField.autoSize = TextFieldAutoSize.LEFT;
            var _loc2_:DataProvider = new DataProvider();
            var _loc3_:* = -1;
            var _loc4_:* = 0;
            while(_loc4_ < param1.length)
            {
                _loc5_ = new ServerVO(param1[_loc4_]);
                _loc2_.push(_loc5_);
                if(_loc5_.selected)
                {
                    _loc3_ = _loc4_;
                }
                _loc4_++;
            }
            this.regionDD.dataProvider = _loc2_;
            this.regionDD.selectedIndex = _loc3_;
            this.regionDD.visible = _loc2_.length > 0;
        }
    }
}
