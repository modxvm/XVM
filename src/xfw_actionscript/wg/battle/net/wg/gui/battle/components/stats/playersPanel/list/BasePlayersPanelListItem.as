package net.wg.gui.battle.components.stats.playersPanel.list
{
    import net.wg.gui.battle.components.BattleUIComponent;
    import net.wg.gui.battle.components.stats.playersPanel.interfaces.IPlayersPanelListItem;
    import flash.text.TextField;
    import net.wg.gui.battle.components.BattleAtlasSprite;
    import net.wg.gui.battle.views.stats.SpeakAnimation;
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.IUserProps;
    import net.wg.utils.ICommons;
    import flash.events.MouseEvent;
    import scaleform.gfx.TextFieldEx;
    import net.wg.data.constants.generated.BATTLEATLAS;
    import net.wg.gui.battle.random.views.stats.components.playersPanel.constants.PlayersPanelInvalidationType;
    import net.wg.data.constants.Values;
    import net.wg.data.constants.InvalidationType;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.gui.battle.random.views.stats.constants.VehicleActions;
    import net.wg.data.constants.generated.PLAYERS_PANEL_STATE;
    import net.wg.gui.battle.views.stats.constants.PlayerStatusSchemeName;
    import net.wg.infrastructure.interfaces.IColorScheme;

    public class BasePlayersPanelListItem extends BattleUIComponent implements IPlayersPanelListItem
    {

        protected static const ICONS_AREA_WIDTH:int = 63;

        protected static const WIDTH:int = 339;

        protected static const BADGE_OFFSET:int = 5;

        private static const PLAYER_NAME_MARGIN:int = 8;

        private static const VEHICLE_TF_RIGHT_X:int = -WIDTH + ICONS_AREA_WIDTH;

        private static const VEHICLE_TF_LEFT_X:int = WIDTH - ICONS_AREA_WIDTH;

        private static const UNKNOWN_VEHICLE_LEVEL:int = -1;

        private static const BADGE_ICON_AREA_WIDTH:int = 24;

        private static const BADGE_ALPHA:int = 1;

        private static const BADGE_ALPHA_NOT_ACTIVE:Number = 0.7;

        public var fragsTF:TextField = null;

        public var playerNameFullTF:TextField = null;

        public var playerNameCutTF:TextField = null;

        public var vehicleTF:TextField = null;

        public var badgeIcon:BattleAtlasSprite;

        public var icoIGR:BattleAtlasSprite = null;

        public var vehicleLevel:BattleAtlasSprite = null;

        public var vehicleIcon:BattleAtlasSprite = null;

        public var mute:BattleAtlasSprite = null;

        public var speakAnimation:SpeakAnimation = null;

        public var selfBg:BattleAtlasSprite = null;

        public var bg:BattleAtlasSprite = null;

        public var deadBg:BattleAtlasSprite = null;

        public var actionMarker:BattleAtlasSprite = null;

        public var hit:Sprite = null;

        public var disableCommunication:BattleAtlasSprite = null;

        protected var maxPlayerNameWidth:uint = 0;

        private var _holderItemID:int = -1;

        public function get xfw_state():Number
        {
            return _state;
        }

        private var _state:int = -1;

        private var _vehicleName:String = null;

        private var _frags:int = 0;

        private var _isMute:Boolean = false;

        private var _isSpeaking:Boolean = false;

        private var _isAlive:Boolean = true;

        private var _isOffline:Boolean = false;

        private var _isTeamKiller:Boolean = false;

        private var _isIGR:Boolean = false;

        private var _vehicleImage:String = null;

        private var _vehicleLevel:int = 0;

        private var _isSelected:Boolean = false;

        private var _isCurrentPlayer:Boolean = false;

        private var _isRightAligned:Boolean = false;

        private var _isIgnoredTmp:Boolean = false;

        private var _badgeType:String = "";

        private var _hasBadge:Boolean = false;

        private var _userProps:IUserProps = null;

        private var _commons:ICommons = null;

        public function BasePlayersPanelListItem()
        {
            super();
            this._commons = App.utils.commons;
        }

        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
            removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
            this.speakAnimation.dispose();
            this.disableCommunication = null;
            this._userProps = null;
            this.fragsTF = null;
            this.playerNameFullTF = null;
            this.playerNameCutTF = null;
            this.vehicleTF = null;
            this.icoIGR = null;
            this.vehicleLevel = null;
            this.vehicleIcon = null;
            this.mute = null;
            this.speakAnimation = null;
            this.selfBg = null;
            this.bg = null;
            this.deadBg = null;
            this.actionMarker = null;
            this.hit = null;
            this.badgeIcon = null;
            this._commons = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.fragsTF.mouseEnabled = false;
            this.playerNameFullTF.mouseEnabled = false;
            this.playerNameCutTF.mouseEnabled = false;
            this.vehicleTF.mouseEnabled = false;
            this.icoIGR.mouseEnabled = false;
            this.vehicleLevel.mouseEnabled = false;
            this.vehicleLevel.isCentralizeByX = true;
            this.vehicleIcon.mouseEnabled = false;
            this.mute.mouseEnabled = false;
            this.speakAnimation.mouseEnabled = false;
            this.speakAnimation.mouseChildren = false;
            this.actionMarker.mouseEnabled = false;
            this.badgeIcon.mouseEnabled = this.badgeIcon.mouseChildren = false;
            TextFieldEx.setNoTranslate(this.fragsTF,true);
            TextFieldEx.setNoTranslate(this.playerNameFullTF,true);
            TextFieldEx.setNoTranslate(this.playerNameCutTF,true);
            TextFieldEx.setNoTranslate(this.vehicleTF,true);
            hitArea = this.hit;
            addEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
            addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
            this.icoIGR.visible = false;
            this.icoIGR.imageName = BATTLEATLAS.ICO_IGR;
            this.mute.visible = false;
            this.mute.imageName = this._isRightAligned?BATTLEATLAS.RIGHT_STATS_MUTE:BATTLEATLAS.LEFT_STATS_MUTE;
            if(this.disableCommunication)
            {
                this.disableCommunication.visible = false;
                this.disableCommunication.imageName = BATTLEATLAS.ICON_TOXIC_CHAT_OFF;
            }
            this.bg.imageName = BATTLEATLAS.PLAYERS_PANEL_BG;
            this.selfBg.visible = false;
            this.selfBg.imageName = BATTLEATLAS.PLAYERS_PANEL_SELF_BG;
            this.deadBg.visible = false;
            this.deadBg.imageName = BATTLEATLAS.PLAYERS_PANEL_DEAD_BG;
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(PlayersPanelInvalidationType.BADGE_CHANGED))
            {
                this.badgeIcon.imageName = this._badgeType;
                this.badgeIcon.visible = this._hasBadge;
            }
            if(isInvalid(PlayersPanelInvalidationType.VEHILCE_NAME))
            {
                this._commons.truncateTextFieldText(this.vehicleTF,this._vehicleName);
            }
            if(isInvalid(PlayersPanelInvalidationType.FRAGS))
            {
                this.fragsTF.text = this._frags?this._frags.toString():Values.EMPTY_STR;
            }
            if(isInvalid(PlayersPanelInvalidationType.MUTE))
            {
                this.mute.visible = this._isMute;
                if(this._isSpeaking)
                {
                    if(this._isMute)
                    {
                        this.speakAnimation.reset();
                    }
                    else
                    {
                        this.speakAnimation.speaking = true;
                    }
                }
                if(this.disableCommunication)
                {
                    this.disableCommunication.visible = this._isIgnoredTmp;
                }
            }
            if(isInvalid(PlayersPanelInvalidationType.IS_SPEAKING))
            {
                if(!this._isMute)
                {
                    this.speakAnimation.speaking = this._isSpeaking;
                }
            }
            if(isInvalid(PlayersPanelInvalidationType.SELECTED))
            {
                this.selfBg.visible = this._isSelected;
            }
            if(isInvalid(PlayersPanelInvalidationType.ALIVE))
            {
                this.bg.visible = this._isAlive;
                this.deadBg.visible = !this._isAlive;
            }
            if(isInvalid(PlayersPanelInvalidationType.PLAYER_SCHEME))
            {
                this.badgeIcon.alpha = this._isOffline || !this._isAlive?BADGE_ALPHA_NOT_ACTIVE:BADGE_ALPHA;
                this.updateColors();
            }
            if(isInvalid(PlayersPanelInvalidationType.IGR_CHANGED))
            {
                this.icoIGR.visible = this._isIGR;
            }
            if(isInvalid(InvalidationType.STATE))
            {
                this.applyState();
            }
        }

        public function getPlayerNameFullWidth() : uint
        {
            return (this.playerNameFullTF.textWidth | 0) + PLAYER_NAME_MARGIN;
        }

        public function isIgnoredTmp(param1:Boolean) : void
        {
            if(this._isIgnoredTmp == param1 || this.disableCommunication == null)
            {
                return;
            }
            this._isIgnoredTmp = param1;
            invalidate(PlayersPanelInvalidationType.MUTE);
        }

        public function isSquadPersonal() : Boolean
        {
            return false;
        }

        public function setBadge(param1:String) : void
        {
            if(this._badgeType == param1)
            {
                return;
            }
            this._badgeType = param1;
            this._hasBadge = StringUtils.isNotEmpty(param1);
            invalidate(PlayersPanelInvalidationType.BADGE_CHANGED);
        }

        public function setFrags(param1:int) : void
        {
            if(this._frags == param1)
            {
                return;
            }
            this._frags = param1;
            invalidate(PlayersPanelInvalidationType.FRAGS);
        }

        public function setIsAlive(param1:Boolean) : void
        {
            if(this._isAlive == param1)
            {
                return;
            }
            this._isAlive = param1;
            invalidate(PlayersPanelInvalidationType.ALIVE | PlayersPanelInvalidationType.PLAYER_SCHEME);
        }

        public function setIsCurrentPlayer(param1:Boolean) : void
        {
            if(this._isCurrentPlayer == param1)
            {
                return;
            }
            this._isCurrentPlayer = param1;
            invalidate(PlayersPanelInvalidationType.PLAYER_SCHEME);
        }

        public function setIsIGR(param1:Boolean) : void
        {
            if(this._isIGR == param1)
            {
                return;
            }
            this._isIGR = param1;
            invalidate(PlayersPanelInvalidationType.IGR_CHANGED);
        }

        public function setIsInteractive(param1:Boolean) : void
        {
        }

        public function setIsInviteShown(param1:Boolean) : void
        {
        }

        public function setIsMute(param1:Boolean) : void
        {
            if(this._isMute == param1)
            {
                return;
            }
            this._isMute = param1;
            invalidate(PlayersPanelInvalidationType.MUTE);
        }

        public function setIsOffline(param1:Boolean) : void
        {
            if(this._isOffline == param1)
            {
                return;
            }
            this._isOffline = param1;
            invalidate(PlayersPanelInvalidationType.PLAYER_SCHEME);
        }

        public function setIsRightAligned(param1:Boolean) : void
        {
            if(this._isRightAligned == param1)
            {
                return;
            }
            this._isRightAligned = param1;
            this.initializeRightAligned(param1);
            invalidateState();
        }

        public function setIsSelected(param1:Boolean) : void
        {
            if(this._isSelected == param1)
            {
                return;
            }
            this._isSelected = param1;
            invalidate(PlayersPanelInvalidationType.SELECTED);
        }

        public function setIsSpeaking(param1:Boolean) : void
        {
            if(this._isSpeaking == param1)
            {
                return;
            }
            this._isSpeaking = param1;
            invalidate(PlayersPanelInvalidationType.IS_SPEAKING);
        }

        public function setIsTeamKiller(param1:Boolean) : void
        {
            if(this._isTeamKiller == param1)
            {
                return;
            }
            this._isTeamKiller = param1;
            invalidate(PlayersPanelInvalidationType.PLAYER_SCHEME);
        }

        public function setPlayerNameFullWidth(param1:uint) : void
        {
            var param1:uint = Math.min(this.maxPlayerNameWidth,param1);
            if(this.playerNameFullTF.width == param1)
            {
                return;
            }
            this.playerNameFullTF.width = param1;
            if(this._userProps)
            {
                this._commons.truncateTextFieldText(this.playerNameCutTF,this._userProps.userName);
                this._commons.formatPlayerName(this.playerNameFullTF,this._userProps);
            }
            this.updatePositions();
        }

        public function setPlayerNameProps(param1:IUserProps) : void
        {
            this._userProps = param1;
            this._commons.truncateTextFieldText(this.playerNameCutTF,param1.userName);
            this._commons.formatPlayerName(this.playerNameFullTF,param1);
        }

        public function setState(param1:uint) : void
        {
            if(this._state == param1)
            {
                return;
            }
            this._state = param1;
            this.applyState();
        }

        public function setVehicleAction(param1:uint) : void
        {
            this.actionMarker.imageName = BATTLEATLAS.getVehicleActionMarker(VehicleActions.getActionName(param1));
            this.actionMarker.visible = true;
        }

        public function setVehicleIcon(param1:String) : void
        {
            if(this._vehicleImage == param1)
            {
                return;
            }
            this._vehicleImage = param1;
            this.vehicleIcon.setImageNames(param1,BATTLEATLAS.UNKNOWN);
        }

        public function setVehicleLevel(param1:int) : void
        {
            if(this._vehicleLevel == param1 || param1 == UNKNOWN_VEHICLE_LEVEL)
            {
                return;
            }
            this._vehicleLevel = param1;
            this.vehicleLevel.isCentralizeByX = true;
            this.vehicleLevel.imageName = BATTLEATLAS.level(this._vehicleLevel.toString());
        }

        public function setVehicleLevelVisible(param1:Boolean) : void
        {
            this.vehicleLevel.visible = param1;
        }

        public function setVehicleName(param1:String) : void
        {
            if(this._vehicleName == param1)
            {
                return;
            }
            this._vehicleName = param1;
            invalidate(PlayersPanelInvalidationType.VEHILCE_NAME);
        }

        public function updateColorBlind() : void
        {
            invalidate(PlayersPanelInvalidationType.PLAYER_SCHEME);
        }

        protected function initializeRightAligned(param1:Boolean) : void
        {
        }

        protected function updatePositionsLeft() : void
        {
        }

        protected function updatePositionsRight() : void
        {
        }

        private function updatePositions() : void
        {
            var _loc1_:* = 0;
            if(this._isRightAligned)
            {
                switch(this._state)
                {
                    case PLAYERS_PANEL_STATE.FULL:
                        if(this.vehicleTF.x != VEHICLE_TF_RIGHT_X)
                        {
                            this.vehicleTF.x = VEHICLE_TF_RIGHT_X;
                        }
                        _loc1_ = this.vehicleTF.x + this.vehicleTF.width;
                        if(this.playerNameFullTF.x != _loc1_)
                        {
                            this.playerNameFullTF.x = _loc1_;
                        }
                        _loc1_ = this.playerNameFullTF.x + this.playerNameFullTF.width + BADGE_OFFSET;
                        if(this.badgeIcon.x != _loc1_)
                        {
                            this.badgeIcon.x = _loc1_;
                        }
                        _loc1_ = this.badgeIcon.x + BADGE_ICON_AREA_WIDTH;
                        if(this.fragsTF.x != _loc1_)
                        {
                            this.fragsTF.x = _loc1_;
                        }
                        break;
                    case PLAYERS_PANEL_STATE.FULL_NO_BADGES:
                        if(this.vehicleTF.x != VEHICLE_TF_RIGHT_X)
                        {
                            this.vehicleTF.x = VEHICLE_TF_RIGHT_X;
                        }
                        _loc1_ = this.vehicleTF.x + this.vehicleTF.width;
                        if(this.playerNameFullTF.x != _loc1_)
                        {
                            this.playerNameFullTF.x = _loc1_;
                        }
                        _loc1_ = this.playerNameFullTF.x + this.playerNameFullTF.width;
                        if(this.fragsTF.x != _loc1_)
                        {
                            this.fragsTF.x = _loc1_;
                        }
                        break;
                    case PLAYERS_PANEL_STATE.LONG:
                        if(this.vehicleTF.x != VEHICLE_TF_RIGHT_X)
                        {
                            this.vehicleTF.x = VEHICLE_TF_RIGHT_X;
                        }
                        _loc1_ = this.vehicleTF.x + this.vehicleTF.width + BADGE_OFFSET;
                        if(this.badgeIcon.x != _loc1_)
                        {
                            this.badgeIcon.x = _loc1_;
                        }
                        _loc1_ = this.badgeIcon.x + BADGE_ICON_AREA_WIDTH;
                        if(this.fragsTF.x != _loc1_)
                        {
                            this.fragsTF.x = _loc1_;
                        }
                        break;
                    case PLAYERS_PANEL_STATE.LONG_NO_BADGES:
                        if(this.vehicleTF.x != VEHICLE_TF_RIGHT_X)
                        {
                            this.vehicleTF.x = VEHICLE_TF_RIGHT_X;
                        }
                        _loc1_ = this.vehicleTF.x + this.vehicleTF.width;
                        if(this.fragsTF.x != _loc1_)
                        {
                            this.fragsTF.x = _loc1_;
                        }
                        break;
                    case PLAYERS_PANEL_STATE.MEDIUM:
                        if(this.playerNameCutTF.x != VEHICLE_TF_RIGHT_X)
                        {
                            this.playerNameCutTF.x = VEHICLE_TF_RIGHT_X;
                        }
                        _loc1_ = this.playerNameCutTF.x + this.playerNameCutTF.width + BADGE_OFFSET;
                        if(this.badgeIcon.x != _loc1_)
                        {
                            this.badgeIcon.x = _loc1_;
                        }
                        _loc1_ = this.badgeIcon.x + BADGE_ICON_AREA_WIDTH;
                        if(this.fragsTF.x != _loc1_)
                        {
                            this.fragsTF.x = _loc1_;
                        }
                        break;
                    case PLAYERS_PANEL_STATE.MEDIUM_NO_BADGES:
                        if(this.playerNameCutTF.x != VEHICLE_TF_RIGHT_X)
                        {
                            this.playerNameCutTF.x = VEHICLE_TF_RIGHT_X;
                        }
                        _loc1_ = this.playerNameCutTF.x + this.playerNameCutTF.width;
                        if(this.fragsTF.x != _loc1_)
                        {
                            this.fragsTF.x = _loc1_;
                        }
                        break;
                    case PLAYERS_PANEL_STATE.SHORT:
                        if(this.badgeIcon.x != VEHICLE_TF_RIGHT_X)
                        {
                            this.badgeIcon.x = VEHICLE_TF_RIGHT_X;
                        }
                        _loc1_ = this.badgeIcon.x + BADGE_ICON_AREA_WIDTH + BADGE_OFFSET;
                        if(this.fragsTF.x != _loc1_)
                        {
                            this.fragsTF.x = _loc1_;
                        }
                        break;
                    case PLAYERS_PANEL_STATE.SHORT_NO_BADGES:
                        if(this.fragsTF.x != VEHICLE_TF_RIGHT_X)
                        {
                            this.fragsTF.x = VEHICLE_TF_RIGHT_X;
                        }
                        break;
                }
                this.updatePositionsRight();
            }
            else
            {
                switch(this._state)
                {
                    case PLAYERS_PANEL_STATE.FULL:
                        _loc1_ = VEHICLE_TF_LEFT_X - this.vehicleTF.width;
                        if(this.vehicleTF.x != _loc1_)
                        {
                            this.vehicleTF.x = _loc1_;
                        }
                        _loc1_ = this.vehicleTF.x - this.playerNameFullTF.width;
                        if(this.playerNameFullTF.x != _loc1_)
                        {
                            this.playerNameFullTF.x = _loc1_;
                        }
                        _loc1_ = this.playerNameFullTF.x - (BADGE_ICON_AREA_WIDTH + BADGE_OFFSET);
                        if(this.badgeIcon.x != _loc1_)
                        {
                            this.badgeIcon.x = _loc1_;
                        }
                        _loc1_ = this.badgeIcon.x - this.fragsTF.width;
                        if(this.fragsTF.x != _loc1_)
                        {
                            this.fragsTF.x = _loc1_;
                        }
                        break;
                    case PLAYERS_PANEL_STATE.FULL_NO_BADGES:
                        _loc1_ = VEHICLE_TF_LEFT_X - this.vehicleTF.width;
                        if(this.vehicleTF.x != _loc1_)
                        {
                            this.vehicleTF.x = _loc1_;
                        }
                        _loc1_ = this.vehicleTF.x - this.playerNameFullTF.width;
                        if(this.playerNameFullTF.x != _loc1_)
                        {
                            this.playerNameFullTF.x = _loc1_;
                        }
                        _loc1_ = this.playerNameFullTF.x - this.fragsTF.width;
                        if(this.fragsTF.x != _loc1_)
                        {
                            this.fragsTF.x = _loc1_;
                        }
                        break;
                    case PLAYERS_PANEL_STATE.LONG:
                        _loc1_ = VEHICLE_TF_LEFT_X - this.vehicleTF.width;
                        if(this.vehicleTF.x != _loc1_)
                        {
                            this.vehicleTF.x = _loc1_;
                        }
                        _loc1_ = this.vehicleTF.x - (BADGE_ICON_AREA_WIDTH + BADGE_OFFSET);
                        if(this.badgeIcon.x != _loc1_)
                        {
                            this.badgeIcon.x = _loc1_;
                        }
                        _loc1_ = this.badgeIcon.x - this.fragsTF.width;
                        if(this.fragsTF.x != _loc1_)
                        {
                            this.fragsTF.x = _loc1_;
                        }
                        break;
                    case PLAYERS_PANEL_STATE.LONG_NO_BADGES:
                        _loc1_ = VEHICLE_TF_LEFT_X - this.vehicleTF.width;
                        if(this.vehicleTF.x != _loc1_)
                        {
                            this.vehicleTF.x = _loc1_;
                        }
                        _loc1_ = this.vehicleTF.x - this.fragsTF.width;
                        if(this.fragsTF.x != _loc1_)
                        {
                            this.fragsTF.x = _loc1_;
                        }
                        break;
                    case PLAYERS_PANEL_STATE.MEDIUM:
                        _loc1_ = VEHICLE_TF_LEFT_X - this.playerNameCutTF.width;
                        if(this.playerNameCutTF.x != _loc1_)
                        {
                            this.playerNameCutTF.x = _loc1_;
                        }
                        _loc1_ = this.playerNameCutTF.x - (BADGE_ICON_AREA_WIDTH + BADGE_OFFSET);
                        if(this.badgeIcon.x != _loc1_)
                        {
                            this.badgeIcon.x = _loc1_;
                        }
                        _loc1_ = this.badgeIcon.x - this.fragsTF.width;
                        if(this.fragsTF.x != _loc1_)
                        {
                            this.fragsTF.x = _loc1_;
                        }
                        break;
                    case PLAYERS_PANEL_STATE.MEDIUM_NO_BADGES:
                        _loc1_ = VEHICLE_TF_LEFT_X - this.playerNameCutTF.width;
                        if(this.playerNameCutTF.x != _loc1_)
                        {
                            this.playerNameCutTF.x = _loc1_;
                        }
                        _loc1_ = this.playerNameCutTF.x - this.fragsTF.width;
                        if(this.fragsTF.x != _loc1_)
                        {
                            this.fragsTF.x = _loc1_;
                        }
                        break;
                    case PLAYERS_PANEL_STATE.SHORT:
                        _loc1_ = VEHICLE_TF_LEFT_X - BADGE_ICON_AREA_WIDTH;
                        if(this.badgeIcon.x != _loc1_)
                        {
                            this.badgeIcon.x = _loc1_;
                        }
                        _loc1_ = this.badgeIcon.x - this.fragsTF.width;
                        if(this.fragsTF.x != _loc1_)
                        {
                            this.fragsTF.x = _loc1_;
                        }
                        break;
                    case PLAYERS_PANEL_STATE.SHORT_NO_BADGES:
                        _loc1_ = VEHICLE_TF_LEFT_X - this.fragsTF.width;
                        if(this.fragsTF.x != _loc1_)
                        {
                            this.fragsTF.x = _loc1_;
                        }
                        break;
                }
                this.updatePositionsLeft();
            }
        }

        private function applyState() : void
        {
            switch(this._state)
            {
                case PLAYERS_PANEL_STATE.FULL_NO_BADGES:
                case PLAYERS_PANEL_STATE.FULL:
                    if(!this.vehicleTF.visible)
                    {
                        this.vehicleTF.visible = true;
                    }
                    this.badgeIcon.visible = this._state != PLAYERS_PANEL_STATE.FULL_NO_BADGES;
                    if(!this.playerNameFullTF.visible)
                    {
                        this.playerNameFullTF.visible = true;
                    }
                    if(this.playerNameCutTF.visible)
                    {
                        this.playerNameCutTF.visible = false;
                    }
                    break;
                case PLAYERS_PANEL_STATE.LONG_NO_BADGES:
                case PLAYERS_PANEL_STATE.LONG:
                    if(!this.vehicleTF.visible)
                    {
                        this.vehicleTF.visible = true;
                    }
                    this.badgeIcon.visible = this._state != PLAYERS_PANEL_STATE.LONG_NO_BADGES;
                    if(this.playerNameFullTF.visible)
                    {
                        this.playerNameFullTF.visible = false;
                    }
                    if(this.playerNameCutTF.visible)
                    {
                        this.playerNameCutTF.visible = false;
                    }
                    break;
                case PLAYERS_PANEL_STATE.MEDIUM_NO_BADGES:
                case PLAYERS_PANEL_STATE.MEDIUM:
                    if(this.vehicleTF.visible)
                    {
                        this.vehicleTF.visible = false;
                    }
                    this.badgeIcon.visible = this._state != PLAYERS_PANEL_STATE.MEDIUM_NO_BADGES;
                    if(this.playerNameFullTF.visible)
                    {
                        this.playerNameFullTF.visible = false;
                    }
                    if(!this.playerNameCutTF.visible)
                    {
                        this.playerNameCutTF.visible = true;
                    }
                    break;
                case PLAYERS_PANEL_STATE.SHORT_NO_BADGES:
                case PLAYERS_PANEL_STATE.SHORT:
                    if(this.vehicleTF.visible)
                    {
                        this.vehicleTF.visible = false;
                    }
                    this.badgeIcon.visible = this._state != PLAYERS_PANEL_STATE.SHORT_NO_BADGES;
                    if(this.playerNameFullTF.visible)
                    {
                        this.playerNameFullTF.visible = false;
                    }
                    if(this.playerNameCutTF.visible)
                    {
                        this.playerNameCutTF.visible = false;
                    }
                    break;
                case PLAYERS_PANEL_STATE.HIDDEN:
                    visible = false;
                    return;
            }
            visible = true;
            this.updatePositions();
        }

        private function updateColors() : void
        {
            var _loc3_:uint = 0;
            var _loc1_:String = PlayerStatusSchemeName.getSchemeNameForVehicle(this._isCurrentPlayer,this.isSquadPersonal(),this._isTeamKiller,!this._isAlive,this._isOffline);
            var _loc2_:IColorScheme = App.colorSchemeMgr.getScheme(_loc1_);
            if(_loc2_)
            {
                this.vehicleIcon.transform.colorTransform = _loc2_.colorTransform;
            }
            _loc1_ = PlayerStatusSchemeName.getSchemeForVehicleLevel(!this._isAlive);
            _loc2_ = App.colorSchemeMgr.getScheme(_loc1_);
            if(_loc2_)
            {
                this.vehicleLevel.transform.colorTransform = _loc2_.colorTransform;
            }
            _loc1_ = PlayerStatusSchemeName.getSchemeNameForPlayer(this._isCurrentPlayer,this.isSquadPersonal(),this._isTeamKiller,!this._isAlive,this._isOffline);
            _loc2_ = App.colorSchemeMgr.getScheme(_loc1_);
            if(_loc2_)
            {
                _loc3_ = _loc2_.rgb;
                if(this.fragsTF.textColor != _loc3_)
                {
                    this.fragsTF.textColor = _loc3_;
                }
                if(this.playerNameFullTF.textColor != _loc3_)
                {
                    this.playerNameFullTF.textColor = _loc3_;
                }
                if(this.playerNameCutTF.textColor != _loc3_)
                {
                    this.playerNameCutTF.textColor = _loc3_;
                }
                if(this.vehicleTF.textColor != _loc3_)
                {
                    this.vehicleTF.textColor = _loc3_;
                }
            }
        }

        public function get holderItemID() : uint
        {
            return this._holderItemID;
        }

        public function set holderItemID(param1:uint) : void
        {
            this._holderItemID = param1;
        }

        protected function onMouseOver(param1:MouseEvent) : void
        {
        }

        protected function onMouseOut(param1:MouseEvent) : void
        {
        }

        protected function onMouseClick(param1:MouseEvent) : void
        {
        }

        private function onMouseOverHandler(param1:MouseEvent) : void
        {
            this.onMouseOver(param1);
        }

        private function onMouseOutHandler(param1:MouseEvent) : void
        {
            this.onMouseOut(param1);
        }

        private function onMouseClickHandler(param1:MouseEvent) : void
        {
            this.onMouseClick(param1);
        }
    }
}
