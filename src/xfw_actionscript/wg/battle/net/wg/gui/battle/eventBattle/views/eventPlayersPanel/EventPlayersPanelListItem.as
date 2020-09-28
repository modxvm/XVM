package net.wg.gui.battle.eventBattle.views.eventPlayersPanel
{
    import net.wg.gui.battle.components.stats.playersPanel.list.BasePlayersPanelListItem;
    import net.wg.gui.battle.eventBattle.views.eventPlayersPanel.VO.DAAPIPlayerPanelInfoVO;
    import net.wg.gui.battle.views.stats.constants.DynamicSquadState;
    import net.wg.data.constants.InvitationStatus;
    import net.wg.gui.battle.random.views.stats.components.playersPanel.list.PlayersPanelDynamicSquad;
    import flash.display.MovieClip;
    import net.wg.gui.battle.views.stats.StatsUserProps;
    import flash.events.MouseEvent;
    import net.wg.data.constants.PlayerStatus;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.gui.battle.random.views.stats.components.playersPanel.constants.PlayersPanelInvalidationType;
    import net.wg.data.constants.generated.BATTLEATLAS;

    public class EventPlayersPanelListItem extends BasePlayersPanelListItem
    {

        private static const LIVES_PREFIX:String = "lives_";

        private static const VEHICLE_APLHA_ALIVE:Number = 1;

        private static const VEHICLE_ALPHA_DEAD:Number = 0.5;

        private static const SQUAD_INVALID:uint = 1 << 17;

        public var dynamicSquad:PlayersPanelDynamicSquad = null;

        public var lives:MovieClip = null;

        private var _data:DAAPIPlayerPanelInfoVO = null;

        private var _vehID:uint = 0;

        private var _userProps:StatsUserProps = null;

        private var _playerStatus:uint = 0;

        private var _isSquadPersonal:Boolean = false;

        public function EventPlayersPanelListItem()
        {
            super();
        }

        private static function getState(param1:DAAPIPlayerPanelInfoVO) : int
        {
            var _loc2_:* = false;
            var _loc3_:Boolean = param1.isSquadMan();
            var _loc4_:Boolean = param1.isPlayer;
            if(_loc4_)
            {
                return _loc3_?DynamicSquadState.IN_SQUAD:DynamicSquadState.NONE;
            }
            if(InvitationStatus.isSent(param1.invitationStatus) && !InvitationStatus.isSentInactive(param1.invitationStatus))
            {
                return DynamicSquadState.INVITE_SENT;
            }
            if(InvitationStatus.isReceived(param1.invitationStatus) && !InvitationStatus.isReceivedInactive(param1.invitationStatus) && !_loc2_)
            {
                return _loc3_?DynamicSquadState.INVITE_RECEIVED_FROM_SQUAD:DynamicSquadState.INVITE_RECEIVED;
            }
            if(_loc2_ || InvitationStatus.isForbidden(param1.invitationStatus))
            {
                return _loc3_?DynamicSquadState.IN_SQUAD:DynamicSquadState.INVITE_DISABLED;
            }
            return _loc3_?DynamicSquadState.IN_SQUAD:DynamicSquadState.INVITE_AVAILABLE;
        }

        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
            playerNameCutTF.visible = false;
        }

        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
            this._data = null;
            if(this._userProps)
            {
                this._userProps.dispose();
                this._userProps = null;
            }
            this.dynamicSquad.dispose();
            this.dynamicSquad = null;
            this.lives = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            super.draw();
            if(this._data && this.dynamicSquad && isInvalid(SQUAD_INVALID))
            {
                _loc1_ = getState(this._data);
                this.dynamicSquad.setState(_loc1_);
                this.dynamicSquad.setIsEnemy(this._data.isEnemy);
                this.dynamicSquad.setSessionID(this._data.sessionID);
                this.dynamicSquad.setNoSound(PlayerStatus.isVoipDisabled(this._playerStatus));
                this.dynamicSquad.setCurrentSquad(this._isSquadPersonal,this._data.squadIndex);
            }
        }

        override public function getDynamicSquad() : PlayersPanelDynamicSquad
        {
            return this.dynamicSquad;
        }

        public function setHp(param1:Number) : void
        {
        }

        public function setResurrect(param1:Boolean) : void
        {
        }

        public function setData(param1:DAAPIPlayerPanelInfoVO) : void
        {
            this._data = param1;
            this.updateUserProps(param1);
            this.setLives(param1.countLives);
            setBadge(param1.badgeVO,StringUtils.isNotEmpty(param1.badgeVO.icon));
            setIsAlive(param1.isAlive());
            setIsOffline(!param1.isReady());
            setIsTeamKiller(param1.isTeamKiller());
            setIsSelected(PlayerStatus.isSelected(param1.playerStatus));
            setIsCurrentPlayer(param1.isPlayer);
            this.initVehicleIcon(param1);
            if(this.dynamicSquad)
            {
                invalidate(SQUAD_INVALID);
            }
            setFrags(param1.kills);
            this.setHp(param1.hpCurrent);
            this._vehID = param1.vehID;
        }

        public function setPlayerStatus(param1:int) : void
        {
            if(this._playerStatus == param1)
            {
                return;
            }
            this._playerStatus = param1;
            var _loc2_:Boolean = PlayerStatus.isSquadPersonal(param1);
            if(this._isSquadPersonal != _loc2_)
            {
                this._isSquadPersonal = _loc2_;
                invalidate(PlayersPanelInvalidationType.PLAYER_SCHEME);
            }
            invalidate(SQUAD_INVALID);
        }

        override public function isSquadPersonal() : Boolean
        {
            return this._isSquadPersonal;
        }

        public function setLives(param1:int) : void
        {
            if(this.lives)
            {
                this.lives.gotoAndStop(LIVES_PREFIX + param1);
            }
        }

        public function get vehID() : uint
        {
            return this._vehID;
        }

        private function updateUserProps(param1:DAAPIPlayerPanelInfoVO) : void
        {
            if(!this._userProps)
            {
                this._userProps = new StatsUserProps(param1.playerName,param1.playerFakeName,param1.clanAbbrev,param1.region,0);
            }
            else
            {
                this._userProps.userName = param1.playerName;
                this._userProps.fakeName = param1.playerFakeName;
                this._userProps.clanAbbrev = param1.clanAbbrev;
                this._userProps.region = param1.region;
            }
            if(this._userProps.isChanged)
            {
                this._userProps.applyChanges();
                setPlayerNameProps(this._userProps);
            }
        }

        protected function initVehicleIcon(param1:DAAPIPlayerPanelInfoVO) : void
        {
            this.updateVehicleIcon(param1.isEnemy,param1.isAlive());
        }

        override public function setIsInviteShown(param1:Boolean) : void
        {
            this.dynamicSquad.setIsInviteShown(param1);
        }

        override public function setIsInteractive(param1:Boolean) : void
        {
            this.dynamicSquad.setIsInteractive(param1);
        }

        protected function updateVehicleIcon(param1:Boolean, param2:Boolean) : void
        {
            if(param1)
            {
                setVehicleIcon(param2?BATTLEATLAS.WT_VEHICLE_ICON_QUESTION:BATTLEATLAS.WT_VEHICLE_ICON);
                vehicleIcon.alpha = param2?VEHICLE_APLHA_ALIVE:VEHICLE_ALPHA_DEAD;
            }
        }

        private function onMouseOverHandler(param1:MouseEvent) : void
        {
            if(this.dynamicSquad)
            {
                this.dynamicSquad.onItemOver();
            }
        }

        private function onMouseOutHandler(param1:MouseEvent) : void
        {
            if(this.dynamicSquad)
            {
                this.dynamicSquad.onItemOut();
            }
        }
    }
}
