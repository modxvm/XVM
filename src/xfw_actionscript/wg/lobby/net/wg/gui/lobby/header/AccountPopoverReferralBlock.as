package net.wg.gui.lobby.header
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.components.assets.interfaces.ISeparatorAsset;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.data.constants.Linkages;
    import net.wg.gui.lobby.header.vo.AccountPopoverReferralBlockVO;
    import flash.events.Event;
    import net.wg.gui.lobby.header.events.AccountPopoverEvent;

    public class AccountPopoverReferralBlock extends UIComponentEx
    {

        private static const MORE_BTN_X_OFFSET:int = 9;

        public var separator:ISeparatorAsset = null;

        public var invitedTF:TextField = null;

        public var moreInfoTF:TextField = null;

        public var moreInfoLinkBtn:SoundButtonEx = null;

        public function AccountPopoverReferralBlock()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.moreInfoLinkBtn.addEventListener(ButtonEvent.CLICK,this.onInfoLinkClickHandler);
            this.separator.setCenterAsset(Linkages.TOOLTIP_SEPARATOR_UI);
        }

        override protected function onDispose() : void
        {
            this.invitedTF = null;
            this.moreInfoTF = null;
            this.separator.dispose();
            this.separator = null;
            this.moreInfoLinkBtn.removeEventListener(ButtonEvent.CLICK,this.onInfoLinkClickHandler);
            this.moreInfoLinkBtn.dispose();
            this.moreInfoLinkBtn = null;
            super.onDispose();
        }

        public function setData(param1:AccountPopoverReferralBlockVO) : void
        {
            this.invitedTF.htmlText = param1.invitedText;
            this.moreInfoTF.htmlText = param1.moreInfoText;
            this.moreInfoLinkBtn.enabled = param1.isLinkBtnEnabled;
            App.utils.commons.moveDsiplObjToEndOfText(this.moreInfoLinkBtn,this.moreInfoTF,MORE_BTN_X_OFFSET,0);
            dispatchEvent(new Event(Event.RESIZE));
        }

        private function onInfoLinkClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new AccountPopoverEvent(AccountPopoverEvent.OPEN_REFERRAL_MANAGEMENT));
        }
    }
}
