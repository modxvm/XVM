package net.wg.gui.lobby.header.vo
{
    public class AccountClanPopoverBlockVO extends AccountPopoverBlockVO
    {

        public var clansResearchBtnYposition:int = -1;

        public var clanResearchIcon:String = "";

        public var clanResearchTFText:String = "";

        public var isSearchClanBtnVisible:Boolean = true;

        public var isSearchClanBtnEnabled:Boolean = false;

        public var searchClanTooltip:String = "";

        public var inviteBtnIcon:String = "";

        public var inviteBtnTooltip:String = "";

        public var inviteBtnEnabled:Boolean = false;

        public var requestInviteBtnIcon:String = "";

        public var requestInviteBtnTooltip:String = "";

        public var requestInviteBtnVisible:Boolean = true;

        public var requestInviteBtnEnabled:Boolean = false;

        public var isClanFeaturesEnabled:Boolean = true;

        public var isInClan:Boolean = true;

        public function AccountClanPopoverBlockVO(param1:Object)
        {
            super(param1);
        }
    }
}
