package net.wg.gui.battle.random.views.stats.components.fullStats.tableItem
{
    import net.wg.gui.battle.components.BattleUIComponentsHolder;
    import net.wg.gui.battle.components.buttons.interfaces.IClickButtonHandler;
    import net.wg.gui.battle.components.buttons.interfaces.IRollOutButtonHandler;
    import net.wg.gui.battle.views.stats.fullStats.SquadInviteStatusView;
    import net.wg.gui.battle.components.BattleAtlasSprite;
    import net.wg.gui.battle.components.buttons.BattleButton;
    import flash.display.Sprite;
    import net.wg.gui.battle.random.views.stats.components.fullStats.interfaces.ISquadHandler;
    import net.wg.gui.battle.views.stats.SquadTooltip;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.gui.components.dogtag.DogtagComponent;
    import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
    import net.wg.gui.components.dogtag.VO.DogTagVO;
    import flash.events.MouseEvent;
    import net.wg.data.constants.InvalidationType;
    import net.wg.gui.battle.views.stats.constants.SquadInvalidationType;
    import net.wg.gui.battle.views.stats.constants.DynamicSquadState;
    import net.wg.data.constants.generated.BATTLEATLAS;
    import net.wg.data.constants.Linkages;
    import org.idmedia.as3commons.util.StringUtils;

    public class DynamicSquadCtrl extends BattleUIComponentsHolder implements IClickButtonHandler, IRollOutButtonHandler
    {

        private var _squadStatus:SquadInviteStatusView = null;

        private var _squadIcon:BattleAtlasSprite = null;

        private var _squadAcceptBt:BattleButton = null;

        private var _squadAddBt:BattleButton = null;

        private var _noSoundSpr:BattleAtlasSprite = null;

        private var _hitArea:Sprite = null;

        private var _handler:ISquadHandler = null;

        private var _tooltip:SquadTooltip = null;

        private var _activeButton:BattleButton = null;

        private var _state:int = 0;

        private var _squadIndex:int = 0;

        private var _isSquadPersonal:Boolean = false;

        private var _isInviteShown:Boolean = false;

        private var _isInteractive:Boolean = false;

        private var _isMouseOver:Boolean = false;

        private var _isNoSound:Boolean = false;

        private var _isEnemy:Boolean = false;

        private var _sessionID:String = "";

        private var _isCurrentPlayerAnonymized:Boolean = false;

        private var _isCurrentPlayerInClan:Boolean = false;

        private var _currentPlayerFakeName:String = null;

        private var _toolTipString:String = null;

        private var _tooltipMgr:ITooltipMgr = null;

        private var _dogTag:DogtagComponent;

        private var _activePlayerData:DAAPIVehicleInfoVO = null;

        private var _playerData:DAAPIVehicleInfoVO = null;

        private var _dogTagData:DogTagVO;

        public function DynamicSquadCtrl(param1:SquadInviteStatusView, param2:BattleAtlasSprite, param3:BattleButton, param4:BattleButton, param5:Sprite, param6:BattleAtlasSprite = null)
        {
            super();
            this._tooltipMgr = App.toolTipMgr;
            this._state = DynamicSquadState.NONE;
            this._squadStatus = param1;
            this._squadIcon = param2;
            this._squadAcceptBt = param3;
            this._squadAcceptBt.visible = false;
            this._squadAddBt = param4;
            this._squadAddBt.visible = false;
            this._hitArea = param5;
            if(param6)
            {
                this._noSoundSpr = param6;
                this._noSoundSpr.visible = false;
                this._noSoundSpr.imageName = BATTLEATLAS.SQUAD_NO_SOUND;
            }
            this._tooltip = new SquadTooltip();
            this.buildDogTag();
        }

        override protected function onDispose() : void
        {
            this.setMouseEnabled(false);
            this._hitArea.removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
            this._hitArea.removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
            this._hitArea.removeEventListener(MouseEvent.ROLL_OVER,this.dogTagFadeIn);
            this._hitArea.removeEventListener(MouseEvent.ROLL_OUT,this.dogTagFadeOut);
            this._squadStatus = null;
            this._squadIcon = null;
            this._squadAcceptBt = null;
            this._squadAddBt = null;
            this._hitArea = null;
            this._handler = null;
            this._noSoundSpr = null;
            this._tooltip = null;
            this._activeButton = null;
            this._isCurrentPlayerAnonymized = false;
            this._isCurrentPlayerInClan = false;
            this._currentPlayerFakeName = null;
            this._activePlayerData = null;
            this._tooltipMgr = null;
            if(this._dogTag)
            {
                this._dogTag.dispose();
                this._dogTag = null;
            }
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.STATE | SquadInvalidationType.ACTIVE_MOUSE_OVER))
            {
                this.updateStatusIcons();
            }
            if(isInvalid(InvalidationType.STATE | SquadInvalidationType.SQUAD_NO_SOUND) && this._noSoundSpr)
            {
                this._noSoundSpr.visible = this._isNoSound && this._state == DynamicSquadState.IN_SQUAD;
            }
            if(isInvalid(InvalidationType.STATE | SquadInvalidationType.SQUAD_INDEX))
            {
                if((this._state == DynamicSquadState.IN_SQUAD || this._state == DynamicSquadState.INVITE_RECEIVED_FROM_SQUAD) && this._squadIndex > 0)
                {
                    if(this._isSquadPersonal)
                    {
                        this._squadIcon.imageName = BATTLEATLAS.squad_gold(this._squadIndex.toString());
                    }
                    else
                    {
                        this._squadIcon.imageName = BATTLEATLAS.squad_silver(this._squadIndex.toString());
                    }
                    this._squadIcon.visible = true;
                }
                else
                {
                    this._squadIcon.visible = false;
                }
            }
        }

        public function addActionHandler(param1:ISquadHandler) : void
        {
            this._handler = param1;
        }

        public function onButtonClick(param1:Object) : void
        {
            if(param1.name == this._squadAcceptBt.name)
            {
                if(this._handler)
                {
                    this._handler.onAcceptSquad(this);
                }
            }
            else if(param1.name == this._squadAddBt.name)
            {
                if(this._handler)
                {
                    this._handler.onAddToSquad(this);
                }
            }
        }

        public function onButtonRollOut(param1:Object) : void
        {
            if(this._isMouseOver && !this.getIsMouseOver())
            {
                this._isMouseOver = false;
                this.updateTooltip();
                this.updateSquadButtons();
                invalidate(SquadInvalidationType.ACTIVE_MOUSE_OVER);
            }
        }

        public function reset() : void
        {
            this._state = DynamicSquadState.NONE;
            if(this._isInteractive)
            {
                this.setMouseEnabled(false);
            }
            this._isInviteShown = false;
            this._isInteractive = false;
            invalidate(InvalidationType.ALL);
        }

        public function setActivePlayerData(param1:DAAPIVehicleInfoVO) : void
        {
            this._activePlayerData = param1;
        }

        public function setPlayerData(param1:DAAPIVehicleInfoVO) : void
        {
            this._playerData = param1;
        }

        public function setDogTag(param1:DogTagVO) : void
        {
            this.resetDogTag();
            if(param1)
            {
                this._dogTagData = param1;
                this._hitArea.addEventListener(MouseEvent.ROLL_OVER,this.dogTagFadeIn);
                this._hitArea.addEventListener(MouseEvent.ROLL_OUT,this.dogTagFadeOut);
            }
        }

        private function resetDogTag() : void
        {
            this._dogTag.alpha = 0;
            this._dogTagData = null;
            this._hitArea.removeEventListener(MouseEvent.ROLL_OVER,this.dogTagFadeIn);
            this._hitArea.removeEventListener(MouseEvent.ROLL_OUT,this.dogTagFadeOut);
        }

        private function buildDogTag() : void
        {
            this._dogTag = App.utils.classFactory.getComponent(Linkages.DOGTAG,DogtagComponent);
            this._hitArea.parent.addChild(this._dogTag);
            this._dogTag.hideNameAndClan();
            this._dogTag.x = this._dogTag.width >> 2;
            this._dogTag.goToLabel(DogtagComponent.DOGTAG_LABEL_END_FULL);
            this._dogTag.alpha = 0;
        }

        public function setCurrentPlayerAnonymized() : void
        {
            this._isCurrentPlayerAnonymized = true;
        }

        public function setCurrentPlayerFakeName(param1:String) : void
        {
            this._currentPlayerFakeName = param1;
            if(!this._toolTipString)
            {
                this.makeTooltipString();
            }
        }

        public function setIsCurrentPlayerInClan(param1:Boolean) : void
        {
            this._isCurrentPlayerInClan = param1;
            if(!this._toolTipString)
            {
                this.makeTooltipString();
            }
        }

        public function setIsEnemy(param1:Boolean) : void
        {
            this._isEnemy = param1;
        }

        public function setIsInteractive(param1:Boolean) : void
        {
            if(this._isInteractive == param1)
            {
                return;
            }
            this.setMouseEnabled(param1);
            if(!param1)
            {
                this._isMouseOver = param1;
            }
            this._isInteractive = param1;
            this.updateTooltip();
            this.updateSquadButtons();
            invalidate(SquadInvalidationType.ACTIVE_MOUSE_OVER);
        }

        public function setIsInviteShown(param1:Boolean) : void
        {
            if(this._isInviteShown == param1)
            {
                return;
            }
            this._isInviteShown = param1;
            invalidate(SquadInvalidationType.ACTIVE_MOUSE_OVER);
        }

        public function setNoSound(param1:Boolean) : void
        {
            if(this._isNoSound == param1)
            {
                return;
            }
            this._isNoSound = param1;
            invalidate(SquadInvalidationType.SQUAD_NO_SOUND);
        }

        public function setSquadIndex(param1:int, param2:Boolean) : void
        {
            if(this._squadIndex == param1 && this._isSquadPersonal == param2)
            {
                return;
            }
            this._squadIndex = param1;
            this._isSquadPersonal = param2;
            invalidate(SquadInvalidationType.SQUAD_INDEX);
        }

        public function setState(param1:int) : void
        {
            if(this._state == param1)
            {
                return;
            }
            this._state = param1;
            this.updateSquadButtons();
            invalidate(InvalidationType.STATE);
        }

        private function makeTooltipString() : void
        {
            if(StringUtils.isNotEmpty(this._currentPlayerFakeName))
            {
                this._toolTipString = this._isCurrentPlayerInClan?App.utils.locale.makeString(TOOLTIPS.ANONYMIZER_BATTLE_TEAMLIST_CLAN,{"fakeName":this._currentPlayerFakeName}):App.utils.locale.makeString(TOOLTIPS.ANONYMIZER_BATTLE_TEAMLIST_NOCLAN,{"fakeName":this._currentPlayerFakeName});
            }
        }

        private function updateStatusIcons() : void
        {
            var _loc1_:Boolean = this._isMouseOver && this._isInteractive;
            if(_loc1_ && this._state == DynamicSquadState.INVITE_DISABLED)
            {
                this._squadStatus.showInviteDisabled();
                return;
            }
            if(this._isInviteShown)
            {
                if(this._state == DynamicSquadState.INVITE_SENT)
                {
                    this._squadStatus.showInviteSent();
                    return;
                }
                if(!_loc1_ && this._state == DynamicSquadState.INVITE_RECEIVED)
                {
                    this._squadStatus.showInviteReceived();
                    return;
                }
                if(!_loc1_ && this._state == DynamicSquadState.INVITE_RECEIVED_FROM_SQUAD)
                {
                    this._squadStatus.showInviteReceivedFromSquad();
                    return;
                }
            }
            this._squadStatus.hide();
        }

        private function setMouseEnabled(param1:Boolean) : void
        {
            if(param1)
            {
                this._hitArea.addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
                this._hitArea.addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
            }
            else
            {
                this._hitArea.removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
                this._hitArea.removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
            }
        }

        private function getIsMouseOver() : Boolean
        {
            return this._hitArea.mouseX > 0 && this._hitArea.mouseX <= this._hitArea.width && this._hitArea.mouseY > 0 && this._hitArea.mouseY <= this._hitArea.height;
        }

        private function updateTooltip() : void
        {
            if(this._isInteractive && this._isMouseOver && this._activePlayerData)
            {
                if(this._state != DynamicSquadState.NONE)
                {
                    this._tooltip.show(this._state,this._isEnemy,this._activePlayerData.isAnonymized,StringUtils.isNotEmpty(this._activePlayerData.clanAbbrev));
                }
                if(this._state == DynamicSquadState.NONE && this._isCurrentPlayerAnonymized && this._toolTipString)
                {
                    this._tooltipMgr.show(this._toolTipString);
                }
            }
            else if(this._state == DynamicSquadState.NONE && this._isCurrentPlayerAnonymized && this._toolTipString)
            {
                this._tooltipMgr.hide();
            }
            else
            {
                this._tooltip.hide();
            }
        }

        private function updateSquadButtons() : void
        {
            var _loc1_:Boolean = this._isInteractive && this._isMouseOver;
            var _loc2_:Boolean = _loc1_ && this._state == DynamicSquadState.INVITE_AVAILABLE;
            var _loc3_:Boolean = _loc1_ && (this._state == DynamicSquadState.INVITE_RECEIVED || this._state == DynamicSquadState.INVITE_RECEIVED_FROM_SQUAD);
            this.updateButton(this._squadAddBt,_loc2_);
            this.updateButton(this._squadAcceptBt,_loc3_);
        }

        private function updateButton(param1:BattleButton, param2:Boolean) : void
        {
            if(param2)
            {
                if(this._activeButton != param1)
                {
                    this._activeButton = param1;
                    this._activeButton.addRollOutCallBack(this);
                    this._activeButton.addClickCallBack(this);
                    this._handler.onSquadBtVisibleChange(this);
                }
            }
            else if(this._activeButton == param1)
            {
                this._activeButton = null;
                this._handler.onSquadBtVisibleChange(this);
            }
        }

        public function get sessionID() : String
        {
            return this._sessionID;
        }

        public function set sessionID(param1:String) : void
        {
            this._sessionID = param1;
        }

        public function get isAddBtAvailable() : Boolean
        {
            return this._activeButton == this._squadAddBt;
        }

        public function get isAcceptBtAvailable() : Boolean
        {
            return this._activeButton == this._squadAcceptBt;
        }

        private function dogTagFadeIn(param1:MouseEvent) : void
        {
            this._dogTag.setDogTagInfo(this._dogTagData);
            this._dogTag.y = this._hitArea.y + this._dogTag.height >> 1;
            this._dogTag.fadeIn();
        }

        private function dogTagFadeOut(param1:MouseEvent) : void
        {
            this._dogTag.fadeOut();
        }

        private function onMouseRollOverHandler(param1:MouseEvent) : void
        {
            if(this._isMouseOver)
            {
                return;
            }
            this._isMouseOver = true;
            this.updateTooltip();
            this.updateSquadButtons();
            invalidate(SquadInvalidationType.ACTIVE_MOUSE_OVER);
        }

        private function onMouseRollOutHandler(param1:MouseEvent) : void
        {
            if(this.getIsMouseOver())
            {
                return;
            }
            this._isMouseOver = false;
            this.updateTooltip();
            this.updateSquadButtons();
            invalidate(SquadInvalidationType.ACTIVE_MOUSE_OVER);
        }
    }
}
