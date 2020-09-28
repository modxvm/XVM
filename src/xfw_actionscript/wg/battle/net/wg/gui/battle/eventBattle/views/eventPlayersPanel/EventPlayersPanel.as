package net.wg.gui.battle.eventBattle.views.eventPlayersPanel
{
    import net.wg.infrastructure.base.meta.impl.EventPlayersPanelMeta;
    import net.wg.infrastructure.base.meta.IEventPlayersPanelMeta;
    import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;
    import net.wg.gui.battle.eventBattle.views.eventPlayersPanel.VO.DAAPIPlayerPanelInfoVO;
    import net.wg.gui.battle.components.containers.inject.GFInjectBattleComponent;
    import flash.utils.Dictionary;
    import flash.display.Sprite;
    import net.wg.utils.IClassFactory;
    import net.wg.gui.battle.random.views.stats.events.DynamicSquadEvent;
    import flash.events.Event;
    import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
    import net.wg.gui.battle.eventBattle.views.eventPlayersPanel.VO.DAAPIEventPlayersPanelVO;
    import net.wg.infrastructure.interfaces.IDAAPIDataClass;
    import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
    import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
    import net.wg.data.VO.daapi.DAAPIPlayerStatusVO;
    import net.wg.data.constants.PersonalStatus;

    public class EventPlayersPanel extends EventPlayersPanelMeta implements IEventPlayersPanelMeta, IBattleComponentDataController
    {

        private static const LIST_PLAYERS_ITEM_LEFT_LINKAGE:String = "EventPlayersPanelListItemLeftUI";

        private static const LIST_PLAYERS_ITEM_RIGHT_LINKAGE:String = "EventPlayersPanelListItemRightUI";

        private static const PROGRESS_WIDGET_BG_LEFT_LINKAGE:String = "ProgressBarWidgetBgLeftUI";

        private static const PROGRESS_WIDGET_BG_RIGHT_LINKAGE:String = "ProgressBarWidgetBgRightUI";

        private static const LIST_ITEM_HEIGHT:int = 25;

        private static const TEAMS_OFFSET:int = 80;

        private static const PROGRESS_WIDGET_WIDTH:int = 368;

        private static const PROGRESS_WIDGET_HEIGHT:int = 60;

        public var progressWidget:GFInjectBattleComponent = null;

        private var _leftTeam:Vector.<EventPlayersPanelListItem> = null;

        private var _rightTeam:Vector.<EventPlayersPanelListItem> = null;

        private var _itemByVehicleID:Dictionary;

        private var _playerRendererContainer:Sprite = null;

        private var _classFactory:IClassFactory;

        private var _isBossTeamLeft:Boolean = true;

        private var _isProgressWidgetInited:Boolean = false;

        private var _personalStatus:uint = 0;

        public function EventPlayersPanel()
        {
            this._itemByVehicleID = new Dictionary();
            this._classFactory = App.utils.classFactory;
            super();
            this._leftTeam = new Vector.<EventPlayersPanelListItem>();
            this._rightTeam = new Vector.<EventPlayersPanelListItem>();
            this._playerRendererContainer = new Sprite();
            this._playerRendererContainer.y = TEAMS_OFFSET;
            addChild(this._playerRendererContainer);
        }

        private static function getLinkage(param1:DAAPIPlayerPanelInfoVO, param2:Boolean) : String
        {
            return param2?LIST_PLAYERS_ITEM_RIGHT_LINKAGE:LIST_PLAYERS_ITEM_LEFT_LINKAGE;
        }

        override protected function configUI() : void
        {
            addEventListener(DynamicSquadEvent.ACCEPT,this.onDynamicSquadAcceptHandler);
            addEventListener(DynamicSquadEvent.ADD,this.onDynamicSquadAddHandler);
            this.progressWidget.addEventListener(Event.RESIZE,this.updateWTProgressPosition);
            this.updateWTProgressPosition();
            super.configUI();
        }

        override protected function onPopulate() : void
        {
            this.registerFlashComponent(this.progressWidget,BATTLE_VIEW_ALIASES.WT_EVENT_HUNTERS_PROGRESS_WIDGET);
            super.onPopulate();
        }

        override protected function setPlayersPanelData(param1:DAAPIEventPlayersPanelVO) : void
        {
            var _loc2_:Sprite = null;
            this._isBossTeamLeft = param1.leftTeam.length && param1.leftTeam[0].isBoss;
            if(!this._isBossTeamLeft)
            {
                this.updateTeam(param1.leftTeam,this._leftTeam,false);
            }
            else
            {
                this.updateTeam(param1.rightTeam,this._rightTeam,true);
            }
            if(!this._isProgressWidgetInited)
            {
                this._isProgressWidgetInited = true;
                _loc2_ = this._classFactory.getComponent(this._isBossTeamLeft?PROGRESS_WIDGET_BG_RIGHT_LINKAGE:PROGRESS_WIDGET_BG_LEFT_LINKAGE,Sprite);
                this.progressWidget.addChildAt(_loc2_,0);
            }
            this.updateWTProgressPosition();
        }

        override protected function onDispose() : void
        {
            removeEventListener(DynamicSquadEvent.ACCEPT,this.onDynamicSquadAcceptHandler);
            removeEventListener(DynamicSquadEvent.ADD,this.onDynamicSquadAddHandler);
            this._classFactory = null;
            this.progressWidget.removeEventListener(Event.RESIZE,this.updateWTProgressPosition);
            this.progressWidget = null;
            this.clearPlayerRendererContainer();
            this.clearPlayersPanelListItems();
            App.utils.data.cleanupDynamicObject(this._itemByVehicleID);
            this._itemByVehicleID = null;
            super.onDispose();
        }

        override protected function setPlayerPanelInfo(param1:DAAPIPlayerPanelInfoVO) : void
        {
            var _loc2_:EventPlayersPanelListItem = this.getItemByVehID(param1.vehID);
            if(_loc2_)
            {
                _loc2_.setData(param1);
            }
        }

        public function addVehiclesInfo(param1:IDAAPIDataClass) : void
        {
        }

        public function as_setPlayerDead(param1:int) : void
        {
            var _loc2_:EventPlayersPanelListItem = this.getItemByVehID(param1);
            if(_loc2_)
            {
                _loc2_.setIsAlive(false);
            }
        }

        public function as_setPlayerLives(param1:int, param2:int) : void
        {
            var _loc3_:EventPlayersPanelListItem = this.getItemByVehID(param1);
            if(_loc3_)
            {
                _loc3_.setLives(param2);
            }
        }

        public function as_setPlayerPanelCountPoints(param1:int, param2:int) : void
        {
        }

        public function as_setPlayerPanelHp(param1:int, param2:Number) : void
        {
            var _loc3_:EventPlayersPanelListItem = this.getItemByVehID(param1);
            if(_loc3_)
            {
                _loc3_.setHp(param2);
            }
        }

        public function as_setPlayerResurrect(param1:int, param2:Boolean) : void
        {
            var _loc3_:EventPlayersPanelListItem = this.getItemByVehID(param1);
            if(_loc3_)
            {
                _loc3_.setResurrect(param2);
            }
        }

        public function resetFrags() : void
        {
        }

        public function setArenaInfo(param1:IDAAPIDataClass) : void
        {
        }

        public function setFrags(param1:IDAAPIDataClass) : void
        {
        }

        public function setPersonalStatus(param1:uint) : void
        {
            this._personalStatus = param1;
            this.applyPersonalStatus();
        }

        public function setQuestStatus(param1:IDAAPIDataClass) : void
        {
        }

        public function setUserTags(param1:IDAAPIDataClass) : void
        {
        }

        public function setVehiclesData(param1:IDAAPIDataClass) : void
        {
            var _loc3_:DAAPIVehicleInfoVO = null;
            var _loc4_:EventPlayersPanelListItem = null;
            var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
            for each(_loc3_ in _loc2_.leftVehicleInfos)
            {
                _loc4_ = this.getItemByVehID(_loc3_.vehicleID);
                if(_loc4_)
                {
                    _loc4_.setPlayerStatus(_loc3_.playerStatus);
                }
            }
        }

        public function updateInvitationsStatuses(param1:IDAAPIDataClass) : void
        {
        }

        public function updatePersonalStatus(param1:uint, param2:uint) : void
        {
            if(param1 > 0)
            {
                this._personalStatus = this._personalStatus | param1;
            }
            if(param2 > 0)
            {
                this._personalStatus = this._personalStatus & ~param2;
            }
            this.applyPersonalStatus();
        }

        public function updatePlayerStatus(param1:IDAAPIDataClass) : void
        {
            var _loc2_:DAAPIPlayerStatusVO = DAAPIPlayerStatusVO(param1);
            var _loc3_:EventPlayersPanelListItem = this.getItemByVehID(_loc2_.vehicleID);
            if(_loc3_)
            {
                _loc3_.setPlayerStatus(_loc2_.status);
            }
        }

        public function updateStage(param1:Number, param2:Number) : void
        {
            var _loc3_:EventPlayersPanelListItem = null;
            for each(_loc3_ in this._rightTeam)
            {
                _loc3_.x = param1;
            }
        }

        public function updateTriggeredChatCommands(param1:IDAAPIDataClass) : void
        {
        }

        public function updateUserTags(param1:IDAAPIDataClass) : void
        {
        }

        public function updateVehicleStatus(param1:IDAAPIDataClass) : void
        {
        }

        public function updateVehiclesData(param1:IDAAPIDataClass) : void
        {
            var _loc3_:DAAPIVehicleInfoVO = null;
            var _loc4_:EventPlayersPanelListItem = null;
            var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
            for each(_loc3_ in _loc2_.leftVehicleInfos)
            {
                _loc4_ = this.getItemByVehID(_loc3_.vehicleID);
                if(_loc4_)
                {
                    _loc4_.setPlayerStatus(_loc3_.playerStatus);
                }
            }
        }

        public function updateVehiclesStat(param1:IDAAPIDataClass) : void
        {
        }

        private function updateTeam(param1:Vector.<DAAPIPlayerPanelInfoVO>, param2:Vector.<EventPlayersPanelListItem>, param3:Boolean) : void
        {
            var _loc7_:DAAPIPlayerPanelInfoVO = null;
            var _loc8_:EventPlayersPanelListItem = null;
            var _loc4_:* = param2.length > 0;
            var _loc5_:uint = param1.length;
            var _loc6_:* = 0;
            while(_loc6_ < _loc5_)
            {
                _loc7_ = param1[_loc6_];
                if(!_loc7_.isBoss)
                {
                    if(!_loc4_)
                    {
                        _loc8_ = this.createRenderer(_loc7_,param3,_loc6_ * LIST_ITEM_HEIGHT);
                        this._playerRendererContainer.addChild(_loc8_);
                        param2.push(_loc8_);
                    }
                    else
                    {
                        _loc8_ = param2[_loc6_];
                    }
                    this._itemByVehicleID[_loc7_.vehID] = _loc8_;
                    _loc8_.setData(_loc7_);
                }
                _loc6_++;
            }
        }

        private function createRenderer(param1:DAAPIPlayerPanelInfoVO, param2:Boolean, param3:int) : EventPlayersPanelListItem
        {
            var _loc4_:EventPlayersPanelListItem = null;
            _loc4_ = this._classFactory.getComponent(getLinkage(param1,param2),EventPlayersPanelListItem);
            _loc4_.y = param3;
            _loc4_.x = param2?App.appWidth:0;
            return _loc4_;
        }

        private function clearPlayerRendererContainer() : void
        {
            var _loc1_:* = 0;
            if(this._playerRendererContainer)
            {
                _loc1_ = this._playerRendererContainer.numChildren;
                while(--_loc1_ >= 0)
                {
                    this._playerRendererContainer.removeChildAt(0);
                }
                removeChild(this._playerRendererContainer);
                this._playerRendererContainer = null;
            }
        }

        private function clearPlayersPanelListItems() : void
        {
            var _loc1_:EventPlayersPanelListItem = null;
            if(this._leftTeam)
            {
                for each(_loc1_ in this._leftTeam)
                {
                    _loc1_.dispose();
                }
                this._leftTeam.length = 0;
                this._leftTeam = null;
            }
            if(this._rightTeam)
            {
                for each(_loc1_ in this._rightTeam)
                {
                    _loc1_.dispose();
                }
                this._rightTeam.length = 0;
                this._rightTeam = null;
            }
        }

        private function applyPersonalStatus() : void
        {
            var _loc3_:EventPlayersPanelListItem = null;
            var _loc1_:Boolean = PersonalStatus.isShowAllyInvites(this._personalStatus);
            var _loc2_:* = !PersonalStatus.isSquadRestrictions(this._personalStatus);
            for each(_loc3_ in this._leftTeam)
            {
                _loc3_.setIsInviteShown(_loc1_);
                _loc3_.setIsInteractive(_loc2_);
            }
        }

        private function getItemByVehID(param1:uint) : EventPlayersPanelListItem
        {
            return this._itemByVehicleID[param1];
        }

        public function get panelHeight() : int
        {
            return this._playerRendererContainer.y + this._playerRendererContainer.height;
        }

        private function updateWTProgressPosition(param1:Event = null) : void
        {
            this.progressWidget.setSize(PROGRESS_WIDGET_WIDTH,PROGRESS_WIDGET_HEIGHT);
            this.progressWidget.x = !this._isBossTeamLeft?0:App.appWidth - PROGRESS_WIDGET_WIDTH;
        }

        private function onDynamicSquadAcceptHandler(param1:DynamicSquadEvent) : void
        {
            acceptSquadS(param1.sessionID);
        }

        private function onDynamicSquadAddHandler(param1:DynamicSquadEvent) : void
        {
            addToSquadS(param1.sessionID);
        }
    }
}
