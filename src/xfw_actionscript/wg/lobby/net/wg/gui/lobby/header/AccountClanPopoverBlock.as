package net.wg.gui.lobby.header
{
    import flash.text.TextField;
    import net.wg.gui.interfaces.IButtonIconLoader;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.header.vo.AccountClanPopoverBlockVO;
    import net.wg.gui.lobby.header.events.AccountPopoverEvent;

    public class AccountClanPopoverBlock extends AccountPopoverBlockBase implements IAccountClanPopOverBlock
    {

        private static const ADDITIONAL_TF_PADDING:int = 2;

        private static const ADDITIONAL_BLOCK_HEIGHT:int = 17;

        private static const TEXTFIELD_POSITION_Y:int = 57;

        private static const INVITE_BTN_Y:int = 44;

        public var clanResearchTF:TextField = null;

        public var requestInviteBtn:IButtonIconLoader = null;

        public var searchClansBtn:IButtonIconLoader = null;

        public var clanInviteTF:TextField = null;

        public var inviteBtn:IButtonIconLoader = null;

        private var _clansResearchBtnYposition:int = -1;

        private var _isSearchClanBtnVisible:Boolean = true;

        private var _clanName:String = null;

        public function AccountClanPopoverBlock()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            textFieldPosition.y = TEXTFIELD_POSITION_Y;
            this.requestInviteBtn.mouseEnabledOnDisabled = true;
            this.requestInviteBtn.addEventListener(ButtonEvent.CLICK,this.onRequestInviteBtnClickHandler);
            this.searchClansBtn.mouseEnabledOnDisabled = true;
            this.searchClansBtn.addEventListener(ButtonEvent.CLICK,this.onSearchClansBtnClickHandler);
            textFieldName.addEventListener(MouseEvent.ROLL_OVER,this.onTextFieldNameRollOverHandler);
            textFieldName.addEventListener(MouseEvent.ROLL_OUT,this.onTextFieldNameRollOutHandler);
            this.inviteBtn.addEventListener(ButtonEvent.PRESS,this.onInviteBtnPressHandler);
            this.inviteBtn.mouseEnabledOnDisabled = true;
            this.inviteBtn.visible = false;
            this.clanInviteTF.text = MENU.HEADER_ACCOUNT_POPOVER_CLAN_CLANINVITE;
            this.clanInviteTF.visible = false;
            this.inviteBtn.y = INVITE_BTN_Y;
            this.clanInviteTF.y = INVITE_BTN_Y + ADDITIONAL_TF_PADDING;
        }

        override protected function onDispose() : void
        {
            this.clanResearchTF = null;
            this.clanInviteTF = null;
            this.requestInviteBtn.removeEventListener(ButtonEvent.CLICK,this.onRequestInviteBtnClickHandler);
            this.requestInviteBtn.dispose();
            this.requestInviteBtn = null;
            this.inviteBtn.removeEventListener(ButtonEvent.PRESS,this.onInviteBtnPressHandler);
            this.inviteBtn.dispose();
            this.inviteBtn = null;
            this.searchClansBtn.removeEventListener(ButtonEvent.CLICK,this.onSearchClansBtnClickHandler);
            this.searchClansBtn.dispose();
            this.searchClansBtn = null;
            textFieldName.removeEventListener(MouseEvent.ROLL_OVER,this.onTextFieldNameRollOverHandler);
            textFieldName.removeEventListener(MouseEvent.ROLL_OUT,this.onTextFieldNameRollOutHandler);
            super.onDispose();
        }

        override protected function updateSize() : void
        {
            this.searchClansBtn.y = this._clansResearchBtnYposition;
            this.clanResearchTF.y = this.searchClansBtn.y + ADDITIONAL_TF_PADDING;
            this.requestInviteBtn.y = doActionBtn.y;
            if(this._isSearchClanBtnVisible)
            {
                this.height = this.searchClansBtn.y + this.searchClansBtn.actualHeight - ADDITIONAL_BLOCK_HEIGHT ^ 0;
            }
            else
            {
                this.height = this.requestInviteBtn.y + this.requestInviteBtn.actualHeight - ADDITIONAL_BLOCK_HEIGHT ^ 0;
            }
        }

        override protected function setTextFieldNameText(param1:String) : void
        {
            commons.truncateTextFieldText(textFieldName,param1);
            this._clanName = param1;
        }

        override protected function applyData() : void
        {
            var _loc1_:AccountClanPopoverBlockVO = null;
            super.applyData();
            _loc1_ = AccountClanPopoverBlockVO(data);
            this._clansResearchBtnYposition = _loc1_.clansResearchBtnYposition;
            this._isSearchClanBtnVisible = _loc1_.isSearchClanBtnVisible;
            this.clanResearchTF.visible = this._isSearchClanBtnVisible;
            this.searchClansBtn.visible = this._isSearchClanBtnVisible;
            var _loc2_:Boolean = _loc1_.requestInviteBtnVisible;
            this.requestInviteBtn.visible = _loc2_;
            if(_loc2_)
            {
                this.requestInviteBtn.enabled = _loc1_.requestInviteBtnEnabled;
                this.requestInviteBtn.iconSource = _loc1_.requestInviteBtnIcon;
                this.requestInviteBtn.tooltip = _loc1_.requestInviteBtnTooltip;
            }
            this.searchClansBtn.enabled = _loc1_.isSearchClanBtnEnabled;
            this.searchClansBtn.tooltip = _loc1_.searchClanTooltip;
            this.searchClansBtn.iconSource = _loc1_.clanResearchIcon;
            this.clanResearchTF.text = _loc1_.clanResearchTFText;
            textFieldName.mouseEnabled = textFieldName.text != this._clanName;
            var _loc3_:Boolean = _loc1_.isInClan;
            this.clanInviteTF.visible = this.inviteBtn.visible = !_loc3_;
            if(!_loc3_)
            {
                this.inviteBtn.iconSource = _loc1_.inviteBtnIcon;
                this.inviteBtn.tooltip = _loc1_.inviteBtnTooltip;
                this.inviteBtn.enabled = _loc1_.inviteBtnEnabled;
            }
        }

        private function onRequestInviteBtnClickHandler(param1:ButtonEvent) : void
        {
            dispatchAccountPopoverEvent(AccountPopoverEvent.OPEN_REQUEST_INVITE);
        }

        private function onSearchClansBtnClickHandler(param1:ButtonEvent) : void
        {
            dispatchAccountPopoverEvent(AccountPopoverEvent.OPEN_CLAN_RESEARCH);
        }

        private function onTextFieldNameRollOverHandler(param1:MouseEvent) : void
        {
            if(this._clanName)
            {
                App.toolTipMgr.show(this._clanName);
            }
        }

        private function onTextFieldNameRollOutHandler(param1:MouseEvent) : void
        {
            App.toolTipMgr.hide();
        }

        private function onInviteBtnPressHandler(param1:ButtonEvent) : void
        {
            dispatchAccountPopoverEvent(AccountPopoverEvent.OPEN_INVITE);
        }
    }
}
